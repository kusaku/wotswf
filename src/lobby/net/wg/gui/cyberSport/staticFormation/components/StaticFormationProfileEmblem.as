package net.wg.gui.cyberSport.staticFormation.components {
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileEmblemVO;
import net.wg.gui.cyberSport.staticFormation.interfaces.ITextClickDelegate;
import net.wg.gui.cyberSport.staticFormation.views.IStaticFormationProfileEmblem;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ICommons;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;

public class StaticFormationProfileEmblem extends UIComponentEx implements IStaticFormationProfileEmblem {

    private static const LINK_GAP:int = -6;

    private static const SEASON_GAP:int = 24;

    private static const DEFAULT_TEAM_NAME_SIZE:int = 260;

    private static const SEASONS_SHIFT:int = -2;

    public var editLink:TextField = null;

    public var formationName:TextField = null;

    public var seasonTF:TextField = null;

    public var formationEmblem:ClanEmblem = null;

    private var textClickDelegate:ITextClickDelegate = null;

    private var _model:StaticFormationProfileEmblemVO = null;

    public function StaticFormationProfileEmblem() {
        super();
        this.editLink.addEventListener(TextEvent.LINK, this.onClickLinkHandler);
        this.editLink.autoSize = TextFieldAutoSize.LEFT;
        this.formationName.addEventListener(MouseEvent.MOUSE_OVER, this.onFormationNameRollOverHandler);
        this.formationName.addEventListener(MouseEvent.MOUSE_OUT, onFormationNameRollOutHandler);
    }

    private static function onFormationNameRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onDispose():void {
        this.textClickDelegate = null;
        this.editLink.removeEventListener(TextEvent.LINK, this.onClickLinkHandler);
        this.editLink = null;
        this.formationName.removeEventListener(MouseEvent.MOUSE_OVER, this.onFormationNameRollOverHandler);
        this.formationName.removeEventListener(MouseEvent.MOUSE_OUT, onFormationNameRollOutHandler);
        this.formationName = null;
        this.formationEmblem.dispose();
        this.formationEmblem = null;
        this.seasonTF = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:Boolean = false;
        var _loc2_:ICommons = null;
        var _loc3_:* = 0;
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._model) {
            this.editLink.visible = this._model.isShowLink;
            this.editLink.htmlText = this._model.editLinkText;
            App.utils.styleSheetManager.setLinkStyle(this.editLink);
            _loc1_ = StringUtils.isNotEmpty(this._model.seasonText);
            this.seasonTF.visible = _loc1_;
            this.seasonTF.htmlText = this._model.seasonText;
            this.formationName.autoSize = !!_loc1_ ? TextFieldAutoSize.NONE : TextFieldAutoSize.LEFT;
            this.formationName.htmlText = this._model.formationNameText;
            _loc2_ = App.utils.commons;
            if (this.seasonTF.visible) {
                _loc2_.updateTextFieldSize(this.seasonTF);
                this.seasonTF.y = height - this.seasonTF.height + SEASONS_SHIFT >> 1;
                this.seasonTF.x = width - this.seasonTF.width >> 1;
                this.formationName.width = Math.min(this.seasonTF.x - this.formationName.x - SEASON_GAP, DEFAULT_TEAM_NAME_SIZE);
                _loc2_.truncateTextFieldText(this.formationName, this._model.formationNameText);
            }
            _loc2_.updateTextFieldSize(this.formationName, !this.seasonTF.visible);
            _loc3_ = this.formationName.height >> 0;
            if (this.editLink.visible) {
                _loc2_.updateTextFieldSize(this.editLink);
                _loc3_ = int(_loc3_ + (this.editLink.height + LINK_GAP >> 0));
            }
            this.formationName.y = height - _loc3_ >> 1;
            this.editLink.y = this.formationName.y + this.formationName.height + LINK_GAP >> 0;
        }
    }

    public function setTextClickDelegate(param1:ITextClickDelegate):void {
        this.textClickDelegate = param1;
    }

    public function update(param1:Object):void {
        this._model = StaticFormationProfileEmblemVO(param1);
        invalidateData();
    }

    public function updateFormationEmblem(param1:String):void {
        if (StringUtils.isNotEmpty(param1)) {
            this.formationEmblem.setImage(param1);
        }
    }

    private function onFormationNameRollOverHandler(param1:MouseEvent):void {
        if (this.formationName.text != this._model.formationNameText) {
            App.toolTipMgr.show(this._model.formationNameText);
        }
    }

    private function onClickLinkHandler(param1:TextEvent):void {
        if (this.textClickDelegate != null) {
            this.textClickDelegate.onTextClick(param1.text);
        }
    }
}
}
