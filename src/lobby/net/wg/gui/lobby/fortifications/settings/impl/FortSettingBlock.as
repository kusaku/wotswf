package net.wg.gui.lobby.fortifications.settings.impl {
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsBlockVO;
import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.ISpriteEx;

import scaleform.clik.events.ButtonEvent;

public class FortSettingBlock extends UIComponentEx implements ISpriteEx {

    public var blockButton:IButtonIconLoader = null;

    public var blockCondition:TextField = null;

    public var alertMessage:TextField = null;

    public var blockDescr:TextField = null;

    private var descriptionTooltip:String = "";

    private var textFieldsForToolTip:Vector.<TextField> = null;

    public function FortSettingBlock() {
        super();
        this.blockButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SETTINGS;
        this.scaleX = this.scaleY = 1;
        this.textFieldsForToolTip = new <TextField>[this.blockCondition, this.blockDescr];
    }

    public function update(param1:Object):void {
        var _loc2_:FortSettingsBlockVO = FortSettingsBlockVO(param1);
        this.blockButton.enabled = _loc2_.blockBtnEnabled;
        if (_loc2_.daysBeforeVacation != Values.DEFAULT_INT) {
            this.blockButton.tooltip = this.getToolTip(_loc2_.daysBeforeVacation);
        }
        else if (_loc2_.blockBtnToolTip != Values.EMPTY_STR) {
            this.blockButton.tooltip = _loc2_.blockBtnToolTip;
        }
        this.blockCondition.htmlText = _loc2_.blockCondition;
        this.alertMessage.autoSize = TextFieldAutoSize.RIGHT;
        this.alertMessage.htmlText = _loc2_.alertMessage;
        this.blockDescr.htmlText = _loc2_.blockDescr;
        this.blockCondition.autoSize = TextFieldAutoSize.LEFT;
        this.descriptionTooltip = _loc2_.descriptionTooltip;
        this.blockDescr.height = this.blockDescr.textHeight + 5;
    }

    override protected function configUI():void {
        super.configUI();
        this.blockButton.mouseEnabledOnDisabled = true;
        this.blockButton.addEventListener(ButtonEvent.CLICK, this.onBlockBtnClickHandler);
        var _loc1_:int = this.textFieldsForToolTip.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this.textFieldsForToolTip[_loc2_].addEventListener(MouseEvent.ROLL_OVER, this.onDescriptionRollOverHandler);
            this.textFieldsForToolTip[_loc2_].addEventListener(MouseEvent.ROLL_OUT, this.onDescriptionRollOutHandler);
            _loc2_++;
        }
    }

    override protected function onDispose():void {
        var _loc1_:int = this.textFieldsForToolTip.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this.textFieldsForToolTip[_loc2_].removeEventListener(MouseEvent.ROLL_OVER, this.onDescriptionRollOverHandler);
            this.textFieldsForToolTip[_loc2_].removeEventListener(MouseEvent.ROLL_OUT, this.onDescriptionRollOutHandler);
            _loc2_++;
        }
        if (this.textFieldsForToolTip) {
            this.textFieldsForToolTip.splice(0, _loc1_);
            this.textFieldsForToolTip = null;
        }
        this.blockButton.removeEventListener(ButtonEvent.CLICK, this.onBlockBtnClickHandler);
        this.blockButton.dispose();
        this.blockButton = null;
        this.blockCondition = null;
        this.alertMessage = null;
        this.blockDescr = null;
        super.onDispose();
    }

    private function getToolTip(param1:int):String {
        var _loc2_:String = App.toolTipMgr.getNewFormatter().addHeader(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_VACATIONBTNDISABLEDNOTPLANNED_HEADER)).addBody(App.utils.locale.makeString(TOOLTIPS.FORTIFICATION_FORTSETTINGSWINDOW_VACATIONBTNDISABLEDNOTPLANNED_BODY, {"days": param1.toString()})).addNote("", false).make();
        return _loc2_;
    }

    private function onBlockBtnClickHandler(param1:ButtonEvent):void {
        var _loc2_:FortSettingsEvent = new FortSettingsEvent(FortSettingsEvent.CLICK_BLOCK_BUTTON);
        _loc2_.blockButtonPoints = this.blockButton as DisplayObject;
        App.utils.asserter.assertNotNull(_loc2_.blockButtonPoints, "blockButtonPoints" + Errors.CANT_NULL);
        dispatchEvent(_loc2_);
    }

    private function onDescriptionRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this.descriptionTooltip);
    }

    private function onDescriptionRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
