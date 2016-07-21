package net.wg.gui.lobby.quests.components {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.ComponentState;
import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.interfaces.INewIndicator;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.quests.data.SeasonTileVO;
import net.wg.gui.lobby.quests.events.PersonalQuestEvent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class QuestTileRenderer extends SoundButtonEx {

    public static const CONTENT_WIDTH:int = 307;

    public static const CONTENT_HEIGHT:int = 192;

    public var image:UILoaderAlt;

    public var imageOver:UILoaderAlt;

    public var newIndicator:INewIndicator;

    public var completedIndicator:UILoaderAlt;

    public var disableIcon:UILoaderAlt;

    public var labelTF:TextField;

    public var progressTF:TextField;

    private var _model:SeasonTileVO;

    private var _animationMode:Boolean = false;

    public function QuestTileRenderer() {
        super();
        visible = false;
        this.newIndicator.visible = false;
        this.completedIndicator.visible = false;
        this.disableIcon.visible = false;
        preventAutosizing = true;
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(ButtonEvent.CLICK, this.onClickHandler);
        mouseEnabledOnDisabled = true;
        focusable = false;
        this.completedIndicator.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMPLETEDINDICATOR;
        this.disableIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_LOCKED;
    }

    override protected function onDispose():void {
        removeEventListener(ButtonEvent.CLICK, this.onClickHandler);
        this._model = null;
        this.image.dispose();
        this.image = null;
        this.imageOver.dispose();
        this.imageOver = null;
        this.disableIcon.dispose();
        this.disableIcon = null;
        this.completedIndicator.dispose();
        this.completedIndicator = null;
        this.newIndicator.dispose();
        this.newIndicator = null;
        this.labelTF = null;
        this.progressTF = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.STATE) && !this._animationMode) {
            if (state == ComponentState.OVER || state == ComponentState.RELEASE) {
                this.imageOver.visible = true;
                this.image.visible = false;
            }
            else {
                this.imageOver.visible = false;
                this.image.visible = true;
            }
        }
        if (isInvalid(InvalidationType.DATA)) {
            visible = this._model != null;
            if (visible) {
                this.updateNewIndicator();
                this.labelTF.htmlText = this._model.label;
                this.progressTF.htmlText = this._model.progress;
                this.completedIndicator.visible = this._model.isCompleted;
            }
        }
    }

    private function updateNewIndicator():void {
        var _loc1_:Boolean = this._model.isNew;
        if (this.newIndicator.visible != _loc1_) {
            this.newIndicator.visible = _loc1_;
            if (_loc1_) {
                this.newIndicator.shine();
            }
        }
    }

    public function get model():SeasonTileVO {
        return this._model;
    }

    public function set model(param1:SeasonTileVO):void {
        this._model = param1;
        enabled = this._model.enabled;
        this.disableIcon.visible = !enabled;
        this._animationMode = StringUtils.isNotEmpty(this._model.animation);
        if (this._animationMode) {
            this.image.source = this._model.animation;
        }
        else {
            this.image.source = this._model.image;
            this.imageOver.source = this._model.imageOver;
        }
        invalidateData();
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        if (this._model != null) {
            App.toolTipMgr.showSpecial(this._model.tooltipType, null, this._model.id);
        }
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        App.toolTipMgr.hide();
    }

    private function onClickHandler(param1:ButtonEvent):void {
        var _loc2_:int = this._model != null ? int(this._model.id) : int(Values.DEFAULT_INT);
        dispatchEvent(new PersonalQuestEvent(PersonalQuestEvent.TILE_CLICK, _loc2_));
    }
}
}
