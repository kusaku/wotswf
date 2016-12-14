package net.wg.gui.lobby.fortifications.intelligence.impl {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.ui.Keyboard;

import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.InputEvent;

public class FortIntelClanDescriptionHeader extends UIComponentEx implements IFocusContainer {

    private static const DEFAULT_CONTENT_WIDTH:uint = 408;

    private static const DEFAULT_PADDING:uint = 20;

    private static const DEFAULT_TEXT_MARGIN:uint = 6;

    public var battlesField:FortIntelClanDescriptionLIT = null;

    public var winsField:FortIntelClanDescriptionLIT = null;

    public var avgDefresField:FortIntelClanDescriptionLIT = null;

    public var clanTagTF:TextField = null;

    public var clanNameTFShort:TextFieldShort = null;

    public var clanInfoTFShort:TextFieldShort = null;

    public var clanEmblem:ClanEmblem = null;

    public var checkBox:CheckBox = null;

    public var checkBoxIcon:UILoaderAlt = null;

    public var infotipHitArea:MovieClip = null;

    private var _model:ClanDescriptionVO = null;

    public function FortIntelClanDescriptionHeader() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.infotipHitArea.alpha = 0;
        this.checkBox.label = Values.EMPTY_STR;
        this.checkBoxIcon.source = RES_ICONS.MAPS_ICONS_BUTTONS_BOOKMARK;
        this.clanNameTFShort.useHtml = true;
        this.clanNameTFShort.buttonMode = false;
        this.clanInfoTFShort.buttonMode = false;
        this.clanNameTFShort.mouseEnabled = false;
        this.clanInfoTFShort.mouseEnabled = false;
        this.infotipHitArea.addEventListener(MouseEvent.ROLL_OVER, this.onHitAreaRollOverHandler);
        this.infotipHitArea.addEventListener(MouseEvent.ROLL_OUT, this.onHitAreaRollOutHandler);
    }

    override protected function onDispose():void {
        this.infotipHitArea.removeEventListener(MouseEvent.ROLL_OVER, this.onHitAreaRollOverHandler);
        this.infotipHitArea.removeEventListener(MouseEvent.ROLL_OUT, this.onHitAreaRollOutHandler);
        this.removeCheckBoxListeners();
        this.clanTagTF = null;
        this.clanNameTFShort.dispose();
        this.clanNameTFShort = null;
        this.clanInfoTFShort.dispose();
        this.clanInfoTFShort = null;
        this.battlesField.dispose();
        this.battlesField = null;
        this.winsField.dispose();
        this.winsField = null;
        this.avgDefresField.dispose();
        this.avgDefresField = null;
        this.clanEmblem.dispose();
        this.clanEmblem = null;
        this.checkBox.dispose();
        this.checkBox = null;
        this.checkBoxIcon.dispose();
        this.checkBoxIcon = null;
        this.infotipHitArea = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._model != null) {
            this.clanEmblem.setImage(this._model.clanEmblem);
            this.clanTagTF.text = this._model.clanTag;
            this.clanNameTFShort.label = this._model.clanName;
            this.clanInfoTFShort.label = this._model.clanInfo;
            this.clanNameTFShort.x = this.clanTagTF.x + this.clanTagTF.textWidth + DEFAULT_TEXT_MARGIN;
            this.battlesField.model = this._model.clanBattles;
            this.winsField.model = this._model.clanWins;
            this.avgDefresField.model = this._model.clanAvgDefres;
            this.checkBox.visible = this.checkBoxIcon.visible = this._model.canAddToFavorite;
            if (!this._model.canAddToFavorite) {
                this.clanNameTFShort.width = DEFAULT_CONTENT_WIDTH - this.clanNameTFShort.x - DEFAULT_PADDING;
                this.removeCheckBoxListeners();
            }
            else {
                this.checkBox.selected = this._model.isFavorite;
                this.checkBox.enabled = !(!this._model.isFavorite && this._model.numOfFavorites >= this._model.favoritesLimit);
                this.clanNameTFShort.width = this.checkBox.x - this.clanNameTFShort.x - DEFAULT_PADDING;
                this.addCheckBoxListeners();
            }
            this.clanInfoTFShort.width = this.clanNameTFShort.x + this.clanNameTFShort.width - this.clanInfoTFShort.x;
            App.utils.scheduler.scheduleTask(this.calculateHitAreaWidth, 100);
        }
    }

    public function getComponentForFocus():InteractiveObject {
        return this.checkBox;
    }

    private function calculateHitAreaWidth():void {
        if (this.clanNameTFShort.x + this.clanNameTFShort.textField.textWidth >= this.clanInfoTFShort.x + this.clanInfoTFShort.textField.textWidth) {
            this.infotipHitArea.width = this.clanNameTFShort.x + this.clanNameTFShort.textField.textWidth - this.infotipHitArea.x;
        }
        else {
            this.infotipHitArea.width = this.clanInfoTFShort.x + this.clanInfoTFShort.textField.textWidth - this.infotipHitArea.x;
        }
    }

    private function addCheckBoxListeners():void {
        this.checkBox.addEventListener(ButtonEvent.CLICK, this.onCheckBoxClickHandler);
        this.checkBox.addEventListener(MouseEvent.ROLL_OVER, this.onCheckBoxRollOverHandler);
        this.checkBox.addEventListener(MouseEvent.ROLL_OUT, this.onCheckBoxRollOutHandler);
        this.checkBox.addEventListener(InputEvent.INPUT, this.onCheckBoxInputHandler);
    }

    private function removeCheckBoxListeners():void {
        this.checkBox.removeEventListener(ButtonEvent.CLICK, this.onCheckBoxClickHandler);
        this.checkBox.removeEventListener(MouseEvent.ROLL_OVER, this.onCheckBoxRollOverHandler);
        this.checkBox.removeEventListener(MouseEvent.ROLL_OUT, this.onCheckBoxRollOutHandler);
        this.checkBox.removeEventListener(InputEvent.INPUT, this.onCheckBoxInputHandler);
    }

    public function get model():ClanDescriptionVO {
        return this._model;
    }

    public function set model(param1:ClanDescriptionVO):void {
        this._model = param1;
        invalidateData();
    }

    private function onHitAreaRollOverHandler(param1:MouseEvent):void {
        dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.SHOW_CLAN_INFOTIP));
    }

    private function onHitAreaRollOutHandler(param1:MouseEvent):void {
        dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.HIDE_CLAN_INFOTIP));
    }

    private function onCheckBoxClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.CHECKBOX_CLICK));
    }

    private function onCheckBoxRollOverHandler(param1:MouseEvent):void {
        var _loc2_:String = "";
        if (!this.checkBox.selected) {
            if (this.checkBox.enabled) {
                _loc2_ = TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_ADDTOFAVORITE;
            }
            else {
                _loc2_ = TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_MAXFAVORITES;
            }
        }
        else {
            _loc2_ = TOOLTIPS.FORTIFICATION_FORTINTELLIGENCECLANDESCRIPTION_REMOVEFROMFAVORITE;
        }
        App.toolTipMgr.show(_loc2_);
    }

    private function onCheckBoxRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onCheckBoxInputHandler(param1:InputEvent):void {
        if (param1.details.code == Keyboard.DOWN) {
            dispatchEvent(new FortIntelClanDescriptionEvent(FortIntelClanDescriptionEvent.FOCUS_DOWN));
            param1.handled = true;
        }
    }
}
}
