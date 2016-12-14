package net.wg.gui.lobby.fortifications.popovers.impl {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Time;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.popovers.PopOver;
import net.wg.gui.components.popovers.PopOverConst;
import net.wg.gui.events.NumericStepperEvent;
import net.wg.gui.lobby.fortifications.cmp.main.impl.FortTimeAlertIcon;
import net.wg.gui.lobby.fortifications.data.settings.DefenceHourPopoverVO;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.base.meta.IFortSettingsDefenceHourPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortSettingsDefenceHourPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;

public class FortSettingsDefenceHourPopover extends FortSettingsDefenceHourPopoverMeta implements IFortSettingsDefenceHourPopoverMeta {

    private static const DEFAULT_CONTENT_WIDTH:int = 300;

    private static const DEFAULT_PADDING:int = 10;

    public var descriptionTF:TextField = null;

    public var defenceHourTF:TextField = null;

    public var tillHourTF:TextField = null;

    public var timeStepper:NumericStepper = null;

    public var applyBtn:SoundButtonEx = null;

    public var cancelBtn:SoundButtonEx = null;

    public var separatorTop:MovieClip = null;

    public var separatorBottom:MovieClip = null;

    public var timeAlert:FortTimeAlertIcon = null;

    private var currentDefenceHour:int = -1;

    private var _isWrongLocalTime:Boolean = false;

    private var _tillMinutes:int = 0;

    public function FortSettingsDefenceHourPopover() {
        super();
    }

    private static function onApplyBtnRollOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function onCancelBtnClick(param1:ButtonEvent):void {
        App.popoverMgr.hide();
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }

    override protected function configUI():void {
        super.configUI();
        this.applyBtn.mouseEnabledOnDisabled = true;
        App.utils.commons.moveDsiplObjToEndOfText(this.timeAlert, this.tillHourTF);
        this.applyBtn.addEventListener(ButtonEvent.CLICK, this.onApplyBtnClick);
        this.applyBtn.addEventListener(MouseEvent.MOUSE_OVER, this.onApplyBtnRollOver);
        this.applyBtn.addEventListener(MouseEvent.MOUSE_OUT, onApplyBtnRollOut);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, onCancelBtnClick);
        this.timeStepper.addEventListener(IndexEvent.INDEX_CHANGE, this.timeStepperChangeHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.timeStepper.emptyFieldPattern = "--";
        this.timeStepper.isUseLoop = true;
        this.timeStepper.minimum = 0;
        this.timeStepper.maximum = Time.HOURS_IN_DAY - 1;
        this.timeStepper.isShowZero = true;
        this.timeStepper.skipValues = [];
        this.timeStepper.canManualInput = false;
        this.timeStepper.value = NumericStepper.NAN_VALUE;
        this.timeStepper.addEventListener(NumericStepperEvent.CHANGE_COLOR_STATE, this.onStepperColorChangeHandler);
    }

    override protected function onDispose():void {
        this.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onApplyBtnClick);
        this.applyBtn.removeEventListener(MouseEvent.MOUSE_OVER, this.onApplyBtnRollOver);
        this.applyBtn.removeEventListener(MouseEvent.MOUSE_OUT, onApplyBtnRollOut);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, onCancelBtnClick);
        this.timeStepper.removeEventListener(NumericStepperEvent.CHANGE_COLOR_STATE, this.onStepperColorChangeHandler);
        this.timeStepper.removeEventListener(IndexEvent.INDEX_CHANGE, this.timeStepperChangeHandler);
        this.descriptionTF = null;
        this.defenceHourTF = null;
        this.tillHourTF = null;
        this.applyBtn.dispose();
        this.applyBtn = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.separatorTop = null;
        this.separatorBottom = null;
        this.timeStepper.dispose();
        this.timeStepper = null;
        this.timeAlert.dispose();
        this.timeAlert = null;
        super.onDispose();
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.SIZE)) {
            setSize(DEFAULT_CONTENT_WIDTH > this.width ? Number(DEFAULT_CONTENT_WIDTH) : Number(this.width), this.applyBtn.y + this.applyBtn.height + DEFAULT_PADDING);
            this.separatorTop.width = this.width;
            this.separatorBottom.width = this.width;
        }
        super.draw();
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_LEFT;
        super.initLayout();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.timeStepper);
    }

    override protected function setData(param1:DefenceHourPopoverVO):void {
        this._tillMinutes = param1.minutes;
        if (param1.isTwelveHoursFormat) {
            this.timeStepper.labelFunction = App.utils.dateTime.convertToTwelveHourFormat;
        }
        this.timeStepper.skipValues = param1.skipValues;
        this.timeAlert.memberValues(param1.skipValues, Values.DEFAULT_INT);
        this.timeStepper.value = this.currentDefenceHour = param1.hour;
        this.updateHourDefenceTime();
        this.applyBtn.enabled = false;
        this._isWrongLocalTime = param1.isWrongLocalTime;
    }

    private function updateHourDefenceTime():void {
        var _loc1_:String = null;
        this.tillHourTF.visible = !this.timeStepper.currentValueIsDefault;
        if (this.tillHourTF.visible) {
            _loc1_ = FortCommonUtils.instance.getDefencePeriodTime(this.timeStepper.value, this._tillMinutes);
            this.tillHourTF.htmlText = App.textMgr.getTextStyleById(this.timeStepper.getCurrentColorId(), _loc1_);
            this.timeAlert.showAlert(this.tillHourTF.visible, this._isWrongLocalTime, false, this.timeStepper.isSkipValue, this.timeStepper.value);
            App.utils.commons.moveDsiplObjToEndOfText(this.timeAlert, this.tillHourTF);
        }
    }

    override protected function setTexts(param1:DefenceHourPopoverVO):void {
        this.descriptionTF.htmlText = param1.descriptionText;
        this.defenceHourTF.htmlText = param1.defenceHourText;
        this.applyBtn.label = param1.applyBtnLabel;
        this.cancelBtn.label = param1.cancelBtnLabel;
    }

    private function onApplyBtnClick(param1:ButtonEvent):void {
        onApplyS(this.timeStepper.value);
        App.popoverMgr.hide();
    }

    private function onApplyBtnRollOver(param1:MouseEvent):void {
        var _loc2_:String = Values.EMPTY_STR;
        if (this.applyBtn.enabled) {
            _loc2_ = TOOLTIPS.FORTIFICATION_FORTSETTINGSDEFENCEHOURPOPOVER_APPLYBTN_ENABLED;
        }
        else {
            _loc2_ = TOOLTIPS.FORTIFICATION_FORTSETTINGSDEFENCEHOURPOPOVER_APPLYBTN_DISABLED;
        }
        App.toolTipMgr.show(_loc2_);
    }

    private function timeStepperChangeHandler(param1:Event):void {
        this.applyBtn.enabled = this.timeStepper.value != this.currentDefenceHour && !this.timeStepper.isSkipValue;
        this.updateHourDefenceTime();
    }

    private function onStepperColorChangeHandler(param1:NumericStepperEvent):void {
        this.updateHourDefenceTime();
    }
}
}
