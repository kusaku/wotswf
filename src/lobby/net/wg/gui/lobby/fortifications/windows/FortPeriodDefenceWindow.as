package net.wg.gui.lobby.fortifications.windows {
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Time;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.events.NumericStepperEvent;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.fortifications.cmp.main.impl.FortTimeAlertIcon;
import net.wg.gui.lobby.fortifications.data.PeriodDefenceInitVO;
import net.wg.gui.lobby.fortifications.data.PeriodDefenceVO;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.base.meta.IFortPeriodDefenceWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortPeriodDefenceWindowMeta;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.infrastructure.managers.ITooltipMgr;
import net.wg.utils.ICommons;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.utils.Padding;

public class FortPeriodDefenceWindow extends FortPeriodDefenceWindowMeta implements IFortPeriodDefenceWindowMeta {

    private static const PADDING_AFTER_TEXT:int = 5;

    private static const DEFAULT_PADDING_TOP:int = 33;

    private static const DEFAULT_PADDING_BOTTOM:int = 20;

    private static const DEFAULT_PADDING_RIGHT:int = 11;

    private static const DEFAULT_PADDING_LEFT:int = 10;

    private static const INV_INIT_DATA:String = "InvInitData";

    public var headerTF:TextField;

    public var peripheryTF:TextField;

    public var peripheryDescrTF:TextField;

    public var hourDefenceTF:TextField;

    public var hourDefenceTimeTF:TextField;

    public var hourDefenceDescrTF:TextField;

    public var holidayTF:TextField;

    public var holidayDescrTF:TextField;

    public var bgIcon:UILoaderAlt;

    public var peripheryDD:DropdownMenu;

    public var holidayDD:DropdownMenu;

    public var acceptBtn:ISoundButtonEx;

    public var cancelBtn:ISoundButtonEx;

    public var timeStepper:NumericStepper;

    public var timeAlert:FortTimeAlertIcon;

    private var _defenceMinutes:Number = 0;

    private var _isPeripherySelected:Boolean = true;

    private var _isHolidaySelected:Boolean = true;

    private var _isWrongLocalTime:Boolean = false;

    private var _texts:Vector.<IEventDispatcher>;

    private var _data:PeriodDefenceVO;

    private var _initData:PeriodDefenceInitVO;

    private var _tooltipMgr:ITooltipMgr;

    private var _locale:ILocale;

    private var _commons:ICommons;

    public function FortPeriodDefenceWindow() {
        super();
        this._tooltipMgr = App.toolTipMgr;
        this._locale = App.utils.locale;
        this._commons = App.utils.commons;
        isModal = true;
        canDrag = false;
    }

    override public function setWindow(param1:IWindow):void {
        var _loc2_:Padding = null;
        super.setWindow(param1);
        if (window) {
            _loc2_ = new Padding();
            _loc2_.top = DEFAULT_PADDING_TOP;
            _loc2_.bottom = this.cancelBtn.height + DEFAULT_PADDING_BOTTOM;
            _loc2_.right = DEFAULT_PADDING_RIGHT;
            _loc2_.left = DEFAULT_PADDING_LEFT;
            window.formBgPadding = _loc2_;
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.timeAlert.showAlert(false, false, false, false, Values.DEFAULT_INT);
        this._commons.moveDsiplObjToEndOfText(this.timeAlert, this.hourDefenceTimeTF);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.acceptBtn.mouseEnabledOnDisabled = true;
        this._texts = new <IEventDispatcher>[this.peripheryTF, this.peripheryDescrTF, this.holidayTF, this.holidayDescrTF, this.hourDefenceTF, this.hourDefenceDescrTF];
        this.addListeners();
        this.peripheryTF.autoSize = TextFieldAutoSize.LEFT;
        this.holidayTF.autoSize = TextFieldAutoSize.LEFT;
        this.hourDefenceTF.autoSize = TextFieldAutoSize.LEFT;
        this.timeStepper.emptyFieldPattern = "--";
        this.timeStepper.isUseLoop = true;
        this.timeStepper.minimum = 0;
        this.timeStepper.maximum = Time.HOURS_IN_DAY - 1;
        this.timeStepper.isShowZero = true;
        this.timeStepper.skipValues = [];
        this.timeStepper.canManualInput = false;
        this.timeStepper.value = NumericStepper.NAN_VALUE;
    }

    override protected function setInitData(param1:PeriodDefenceInitVO):void {
        this._initData = param1;
        invalidate(INV_INIT_DATA);
    }

    override protected function onDispose():void {
        this.removeListeners();
        this._texts.splice(0, this._texts.length);
        this._texts = null;
        this.bgIcon.dispose();
        this.bgIcon = null;
        this.acceptBtn.dispose();
        this.acceptBtn = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.timeStepper.dispose();
        this.timeStepper = null;
        this.timeAlert.dispose();
        this.timeAlert = null;
        this.peripheryDD.dispose();
        this.peripheryDD = null;
        this.holidayDD.dispose();
        this.holidayDD = null;
        this.headerTF = null;
        this.peripheryTF = null;
        this.peripheryDescrTF = null;
        this.hourDefenceTF = null;
        this.hourDefenceTimeTF = null;
        this.hourDefenceDescrTF = null;
        this.holidayTF = null;
        this.holidayDescrTF = null;
        this._tooltipMgr.hide();
        this._tooltipMgr = null;
        this._locale = null;
        this._commons = null;
        this._data = null;
        this._initData = null;
        super.onDispose();
    }

    override protected function setData(param1:PeriodDefenceVO):void {
        this._data = param1;
        invalidateData();
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.peripheryDD);
    }

    override protected function draw():void {
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            this._tooltipMgr.hide();
            this.setPeripheryData(this._data.peripheryData, this._data.peripherySelectedID);
            this.setHolidayData(this._data.holidayData, this._data.holidaySelectedID);
            this.setHourPeriodDefense();
        }
        if (this._initData && isInvalid(INV_INIT_DATA)) {
            this.setTextsInFields();
            invalidateState();
        }
        if (isInvalid(InvalidationType.STATE)) {
            this.checkAcceptBtnState();
        }
    }

    private function removeDefaultDataDropDown(param1:int, param2:DropdownMenu):void {
        var _loc3_:IDataProvider = param2.dataProvider;
        var _loc4_:int = _loc3_.indexOf(this._locale.makeString(FORTIFICATIONS.PERIODDEFENCEWINDOW_DROPDOWNBTN_NOTSELECTED));
        if (param1 != 0 && _loc4_ != -1) {
            DataProvider(_loc3_).splice(_loc4_, 1);
            param2.rowCount = param2.rowCount - 1;
            param2.selectedIndex = param2.selectedIndex - 1;
        }
    }

    private function setDataInDropDown(param1:DropdownMenu, param2:Array, param3:int):void {
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc6_:* = null;
        if (param3 == -1) {
            param2.unshift(this._locale.makeString(FORTIFICATIONS.PERIODDEFENCEWINDOW_DROPDOWNBTN_NOTSELECTED));
        }
        param1.dataProvider = new DataProvider(param2);
        if (param3 == -1) {
            param1.selectedIndex = 0;
        }
        else {
            _loc4_ = param2.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                if (param2[_loc5_].id == param3) {
                    break;
                }
                _loc5_++;
            }
            _loc6_ = "No such element with id = " + param3 + " in dropDown.dataProvider";
            App.utils.asserter.assert(_loc5_ < _loc4_, _loc6_);
            param1.selectedIndex = _loc5_;
        }
    }

    private function setTextsInFields():void {
        window.title = this._initData.windowLbl;
        this.headerTF.htmlText = this._initData.headerLbl;
        this.peripheryTF.htmlText = this._initData.peripheryLbl;
        this.peripheryDescrTF.htmlText = this._initData.peripheryDescr;
        this.hourDefenceTF.htmlText = this._initData.hourDefenceLbl;
        this.hourDefenceDescrTF.htmlText = this._initData.hourDefenceDescr;
        this.holidayTF.htmlText = this._initData.holidayLbl;
        this.holidayDescrTF.htmlText = this._initData.holidayDescr;
        this.acceptBtn.label = this._initData.acceptBtn;
        this.cancelBtn.label = this._initData.cancelBtn;
        this.cancelBtn.tooltip = this._initData.cancelBtnTooltip;
        this.updatePositions();
    }

    private function updatePositions():void {
        this.peripheryDD.x = this.peripheryTF.x + this.peripheryTF.width + PADDING_AFTER_TEXT;
        this.timeStepper.x = this.hourDefenceTF.x + this.hourDefenceTF.width + PADDING_AFTER_TEXT;
        this.hourDefenceTimeTF.x = this.timeStepper.x + this.timeStepper.width - 1;
        this._commons.moveDsiplObjToEndOfText(this.timeAlert, this.hourDefenceTimeTF);
        this.holidayDD.x = this.holidayTF.x + this.holidayTF.width + PADDING_AFTER_TEXT;
    }

    private function addListeners():void {
        this.timeStepper.addEventListener(IndexEvent.INDEX_CHANGE, this.onTimeStepperIndexChangeHandler);
        this.timeStepper.addEventListener(NumericStepperEvent.CHANGE_COLOR_STATE, this.onTimeStepperChangeColorStateHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.acceptBtn.addEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
        this.holidayDD.addEventListener(ListEvent.INDEX_CHANGE, this.onHolidayDDIndexChangeHandler);
        this.peripheryDD.addEventListener(ListEvent.INDEX_CHANGE, this.onPeripheryDDIndexChangeHandler);
        this.peripheryTF.addEventListener(MouseEvent.ROLL_OVER, this.onPeripheryTFRollOverHandler);
        this.peripheryDescrTF.addEventListener(MouseEvent.ROLL_OVER, this.onPeripheryTFRollOverHandler);
        this.holidayTF.addEventListener(MouseEvent.ROLL_OVER, this.onHolidayTFRollOverHandler);
        this.holidayDescrTF.addEventListener(MouseEvent.ROLL_OVER, this.onHolidayTFRollOverHandler);
        this.hourDefenceTF.addEventListener(MouseEvent.ROLL_OVER, this.onHourDefenceTFRollOverHandler);
        this.hourDefenceDescrTF.addEventListener(MouseEvent.ROLL_OVER, this.onHourDefenceTFRollOverHandler);
        this._commons.addMultipleHandlers(this._texts, MouseEvent.ROLL_OUT, this.onTextsRollOutHandler);
    }

    private function removeListeners():void {
        this.timeStepper.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTimeStepperIndexChangeHandler);
        this.timeStepper.removeEventListener(NumericStepperEvent.CHANGE_COLOR_STATE, this.onTimeStepperChangeColorStateHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelBtnClickHandler);
        this.acceptBtn.removeEventListener(ButtonEvent.CLICK, this.onAcceptBtnClickHandler);
        this.holidayDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onHolidayDDIndexChangeHandler);
        this.peripheryDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onPeripheryDDIndexChangeHandler);
        this.peripheryTF.removeEventListener(MouseEvent.ROLL_OVER, this.onPeripheryTFRollOverHandler);
        this.peripheryDescrTF.removeEventListener(MouseEvent.ROLL_OVER, this.onPeripheryTFRollOverHandler);
        this.holidayTF.removeEventListener(MouseEvent.ROLL_OVER, this.onHolidayTFRollOverHandler);
        this.holidayDescrTF.removeEventListener(MouseEvent.ROLL_OVER, this.onHolidayTFRollOverHandler);
        this.hourDefenceTF.removeEventListener(MouseEvent.ROLL_OVER, this.onHourDefenceTFRollOverHandler);
        this.hourDefenceDescrTF.removeEventListener(MouseEvent.ROLL_OVER, this.onHourDefenceTFRollOverHandler);
        this._commons.removeMultipleHandlers(this._texts, MouseEvent.ROLL_OUT, this.onTextsRollOutHandler);
    }

    private function setPeripheryData(param1:Array, param2:int):void {
        this.setDataInDropDown(this.peripheryDD, param1, param2);
        this._isPeripherySelected = param2 >= 0;
    }

    private function setHolidayData(param1:Array, param2:int):void {
        this.setDataInDropDown(this.holidayDD, param1, param2);
        this._isHolidaySelected = param2 >= 0;
    }

    private function setHourPeriodDefense():void {
        this._isWrongLocalTime = this._data.isWrongLocalTime;
        this._defenceMinutes = this._data.minutes;
        if (this._data.isTwelveHoursFormat) {
            this.timeStepper.labelFunction = App.utils.dateTime.convertToTwelveHourFormat;
        }
        this.timeStepper.skipValues = this._data.skipValues;
        this.timeStepper.value = this._data.hour;
        this.timeAlert.memberValues(this._data.skipValues, Values.DEFAULT_INT);
        this.updateHourDefenceTime();
    }

    private function updateHourDefenceTime():void {
        var _loc2_:String = null;
        this.hourDefenceTimeTF.visible = !this.timeStepper.currentValueIsDefault;
        var _loc1_:Boolean = this.hourDefenceTimeTF.visible;
        if (_loc1_) {
            _loc2_ = FortCommonUtils.instance.getDefencePeriodTime(this.timeStepper.value, this._defenceMinutes);
            this.hourDefenceTimeTF.htmlText = App.textMgr.getTextStyleById(this.timeStepper.getCurrentColorId(), _loc2_);
            this.timeAlert.showAlert(_loc1_, this._isWrongLocalTime, false, this.timeStepper.isSkipValue, this.timeStepper.value);
            this._commons.moveDsiplObjToEndOfText(this.timeAlert, this.hourDefenceTimeTF);
        }
    }

    private function checkAcceptBtnState():void {
        var _loc1_:Boolean = this.isAcceptBtnIsEnabled;
        this.acceptBtn.enabled = _loc1_;
        if (this._initData) {
            this.acceptBtn.tooltip = !!_loc1_ ? this._initData.acceptBtnEnabledTooltip : this._initData.acceptBtnDisabledTooltip;
        }
    }

    private function get isAcceptBtnIsEnabled():Boolean {
        return this._isPeripherySelected && this._isHolidaySelected && !this.timeStepper.currentValueIsDefault && !this.timeStepper.isSkipValue;
    }

    private function onHourDefenceTFRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_HOURDEFENCE);
    }

    private function onHolidayTFRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_HOLIDAY);
    }

    private function onPeripheryTFRollOverHandler(param1:MouseEvent):void {
        this._tooltipMgr.showComplex(TOOLTIPS.PERIODDEFENCEWINDOW_TOOLTIP_PERIPHERY);
    }

    private function onTimeStepperIndexChangeHandler(param1:Event):void {
        this.updateHourDefenceTime();
        invalidateState();
    }

    private function onCancelBtnClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onAcceptBtnClickHandler(param1:ButtonEvent):void {
        var _loc4_:IDataProvider = null;
        var _loc5_:IDataProvider = null;
        var _loc2_:int = -1;
        var _loc3_:int = -1;
        if (this.peripheryDD.selectedIndex >= 0) {
            _loc4_ = this.peripheryDD.dataProvider;
            _loc3_ = _loc4_[this.peripheryDD.selectedIndex].id;
        }
        if (this.holidayDD.selectedIndex >= 0) {
            _loc5_ = this.holidayDD.dataProvider;
            _loc2_ = _loc5_[this.holidayDD.selectedIndex].id;
        }
        onApplyS({
            "peripherySelectedID": _loc3_,
            "holidaySelectedID": _loc2_,
            "hour": this.timeStepper.value | 0
        });
    }

    private function onHolidayDDIndexChangeHandler(param1:ListEvent):void {
        if (!this._isHolidaySelected) {
            this._isHolidaySelected = true;
            this.removeDefaultDataDropDown(param1.index, this.holidayDD);
            invalidateState();
        }
    }

    private function onPeripheryDDIndexChangeHandler(param1:ListEvent):void {
        if (!this._isPeripherySelected) {
            this._isPeripherySelected = true;
            this.removeDefaultDataDropDown(param1.index, this.peripheryDD);
            invalidateState();
        }
    }

    private function onTextsRollOutHandler(param1:MouseEvent):void {
        this._tooltipMgr.hide();
    }

    private function onTimeStepperChangeColorStateHandler(param1:NumericStepperEvent):void {
        this.updateHourDefenceTime();
    }
}
}
