package net.wg.gui.lobby.fortifications.intelligence {
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Time;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.RangeSlider;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.popOvers.PopOver;
import net.wg.gui.components.popOvers.PopOverConst;
import net.wg.gui.events.NumericStepperEvent;
import net.wg.gui.lobby.fortifications.data.FortInvalidationType;
import net.wg.gui.lobby.fortifications.data.IntelligenceClanFilterVO;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.base.meta.IFortIntelligenceClanFilterPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortIntelligenceClanFilterPopoverMeta;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.SliderEvent;

public class FortIntelligenceClanFilterPopover extends FortIntelligenceClanFilterPopoverMeta implements IFortIntelligenceClanFilterPopoverMeta {

    private static const CONTENT_DEFAULT_WIDTH:int = 280;

    private static const BOTTOM_PADDING:int = 11;

    private static const ICON_OFFSET:int = -1;

    public var headerTF:TextField = null;

    public var clanLevelTF:TextField = null;

    public var startHourRangeTF:TextField = null;

    public var rangeSlider:RangeSlider = null;

    public var defenseStartNumericStepper:NumericStepper = null;

    public var defenseEndTF:TextField = null;

    public var defaultButton:SoundButtonEx = null;

    public var applyButton:SoundButtonEx = null;

    public var cancelButton:SoundButtonEx = null;

    public var bottomSeparator:Sprite = null;

    public var alertIcon:Sprite = null;

    private var _lastSentData:IntelligenceClanFilterVO = null;

    private var _defaultFilterData:IntelligenceClanFilterVO = null;

    private var _isGlobalDataSet:Boolean = false;

    private var _currentData:IntelligenceClanFilterVO = null;

    private var _isWrongLocalTime:Boolean = false;

    private var _isTwelveHoursFormat:Boolean = false;

    private var _startDefenseMinutes:int = -1;

    private var _yourOwnClanStartDefenseHour:int = -1;

    private var _skipValues:Array = null;

    private var _filterData:IntelligenceClanFilterVO = null;

    private var _warnComponents:Vector.<IEventDispatcher> = null;

    private var _applyButtonNormalTooltip:String = null;

    public function FortIntelligenceClanFilterPopover() {
        super();
    }

    private static function onWarnCmpRollOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private static function cancelButtonClickHandler(param1:ButtonEvent):void {
        App.popoverMgr.hide();
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
        super.initLayout();
    }

    override protected function configUI():void {
        var _loc1_:IEventDispatcher = null;
        super.configUI();
        this.applyButton.mouseEnabledOnDisabled = true;
        this.alertIcon.visible = false;
        this.defenseEndTF.autoSize = TextFieldAutoSize.LEFT;
        this.rangeSlider.addEventListener(SliderEvent.VALUE_CHANGE, this.rangeSliderValueChangeHandler);
        this.cancelButton.addEventListener(ButtonEvent.CLICK, cancelButtonClickHandler);
        this.applyButton.addEventListener(ButtonEvent.CLICK, this.applyButtonButtonClickHandler);
        this.defaultButton.addEventListener(ButtonEvent.CLICK, this.defaultButtonButtonClickHandler);
        this._warnComponents = new <IEventDispatcher>[this.applyButton, this.alertIcon, this.defenseEndTF, this.defenseStartNumericStepper];
        for each(_loc1_ in this._warnComponents) {
            _loc1_.addEventListener(MouseEvent.ROLL_OVER, this.onWarnCmpRollOver);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT, onWarnCmpRollOut);
        }
        this.defenseStartNumericStepper.addEventListener(IndexEvent.INDEX_CHANGE, this.defenseStartNumericStepperChangeHandler);
        this.defenseStartNumericStepper.addEventListener(NumericStepperEvent.CHANGE_COLOR_STATE, this.onStepperColorChangeHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.defenseStartNumericStepper.emptyFieldPattern = "--";
        this.defenseStartNumericStepper.isUseLoop = true;
        this.defenseStartNumericStepper.minimum = 0;
        this.defenseStartNumericStepper.maximum = Time.HOURS_IN_DAY - 1;
        this.defenseStartNumericStepper.isShowZero = true;
        this.defenseStartNumericStepper.skipValues = [];
        this.defenseStartNumericStepper.canManualInput = false;
        this.defenseStartNumericStepper.value = NumericStepper.NAN_VALUE;
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.SIZE)) {
            setSize(CONTENT_DEFAULT_WIDTH > this.width ? Number(CONTENT_DEFAULT_WIDTH) : Number(this.width), this.applyButton.y + this.applyButton.height + BOTTOM_PADDING);
            this.bottomSeparator.width = this.width;
        }
        if (isInvalid(InvalidationType.DATA)) {
            if (this._isGlobalDataSet) {
                this.setValues(this._currentData);
                this._isGlobalDataSet = false;
                assert(this._currentData.isEquals(this.filterData), "FortIntelligenceClanFilterPopover | draw | controls data not equal to set data");
            }
            else if (this.dataWasChangedByControls()) {
                this.disposeCurrentData();
                this._currentData = new IntelligenceClanFilterVO(this.filterData.toHash());
                this.setValues(this._currentData);
            }
        }
        if (isInvalid(FortInvalidationType.INVALID_ENABLING)) {
            this.defaultButton.enabled = !this.isDefaultDataSet();
            this.updateHourDefenceTime();
        }
        super.draw();
    }

    override protected function onDispose():void {
        var _loc1_:IEventDispatcher = null;
        for each(_loc1_ in this._warnComponents) {
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER, this.onWarnCmpRollOver);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT, onWarnCmpRollOut);
        }
        this._warnComponents.splice(0, this._warnComponents.length);
        this._warnComponents = null;
        this.headerTF = null;
        this.clanLevelTF = null;
        this.startHourRangeTF = null;
        this.bottomSeparator = null;
        this.defenseEndTF = null;
        this.alertIcon = null;
        this.rangeSlider.removeEventListener(SliderEvent.VALUE_CHANGE, this.rangeSliderValueChangeHandler);
        this.rangeSlider.dispose();
        this.rangeSlider = null;
        this.defenseStartNumericStepper.removeEventListener(IndexEvent.INDEX_CHANGE, this.defenseStartNumericStepperChangeHandler);
        this.defenseStartNumericStepper.removeEventListener(NumericStepperEvent.CHANGE_COLOR_STATE, this.onStepperColorChangeHandler);
        this.defenseStartNumericStepper.dispose();
        this.defenseStartNumericStepper = null;
        this.defaultButton.removeEventListener(ButtonEvent.CLICK, this.defaultButtonButtonClickHandler);
        this.defaultButton.dispose();
        this.defaultButton = null;
        this.applyButton.removeEventListener(ButtonEvent.CLICK, this.applyButtonButtonClickHandler);
        this.applyButton.dispose();
        this.applyButton = null;
        this.cancelButton.removeEventListener(ButtonEvent.CLICK, cancelButtonClickHandler);
        this.cancelButton.dispose();
        this.cancelButton = null;
        this._defaultFilterData.dispose();
        this._defaultFilterData = null;
        this._skipValues = null;
        this.disposeLastSentData();
        this.disposeFilterData();
        this.disposeCurrentData();
        super.onDispose();
    }

    override protected function setData(param1:IntelligenceClanFilterVO):void {
        this._yourOwnClanStartDefenseHour = param1.yourOwnClanStartDefenseHour;
        this._isWrongLocalTime = param1.isWrongLocalTime;
        this._isTwelveHoursFormat = param1.isTwelveHoursFormat;
        this._startDefenseMinutes = param1.startDefenseMinutes;
        this._skipValues = param1.skipValues;
        if (!this._defaultFilterData) {
            this._defaultFilterData = FortIntelligenceWindowHelper.getInstance().getDefaultFilterData(this._yourOwnClanStartDefenseHour, this._startDefenseMinutes, this._isTwelveHoursFormat, this._isWrongLocalTime);
        }
        assert(param1.maxClanLevel <= this._defaultFilterData.maxClanLevel && param1.maxClanLevel >= param1.minClanLevel, "FortIntelligenceClanFilterPopover | setData | incorrect maxClanLevel");
        assert(param1.minClanLevel <= this._defaultFilterData.maxClanLevel && param1.minClanLevel >= param1.minClanLevel, "FortIntelligenceClanFilterPopover | setData | incorrect minClanLevel");
        assert(param1.minClanLevel <= param1.maxClanLevel, "FortIntelligenceClanFilterPopover | setData | incorrect minClanLevel should be less or equal to maxClanLevel");
        this._currentData = new IntelligenceClanFilterVO(param1.toHash());
        this._isGlobalDataSet = true;
        if (param1.isTwelveHoursFormat) {
            this.defenseStartNumericStepper.labelFunction = App.utils.dateTime.convertToTwelveHourFormat;
        }
        var _loc2_:Array = [];
        if (param1.skipValues != null) {
            _loc2_ = _loc2_.concat(param1.skipValues);
        }
        if (this._yourOwnClanStartDefenseHour != Values.DEFAULT_INT) {
            _loc2_.push(this._yourOwnClanStartDefenseHour);
        }
        this.defenseStartNumericStepper.skipValues = _loc2_;
        if (!this._lastSentData) {
            this._lastSentData = new IntelligenceClanFilterVO(param1.toHash());
        }
        invalidateData();
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this.applyButton);
    }

    public function as_setButtonsText(param1:String, param2:String, param3:String):void {
        this.applyButton.label = param2;
        this.defaultButton.label = param1;
        this.cancelButton.label = param3;
    }

    public function as_setButtonsTooltips(param1:String, param2:String):void {
        this._applyButtonNormalTooltip = param2;
        this.defaultButton.tooltip = param1;
    }

    public function as_setDescriptionsText(param1:String, param2:String, param3:String):void {
        this.headerTF.htmlText = param1;
        this.clanLevelTF.htmlText = param2;
        this.startHourRangeTF.htmlText = param3;
    }

    private function dataWasChangedByControls():Boolean {
        return !this._isGlobalDataSet && !(this._currentData && this._currentData.isEquals(this.filterData));
    }

    private function setValues(param1:IntelligenceClanFilterVO):void {
        this.rangeSlider.leftValue = param1.minClanLevel;
        this.rangeSlider.rightValue = param1.maxClanLevel;
        this.defenseStartNumericStepper.value = param1.startDefenseHour;
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    private function updateHourDefenceTime():void {
        var _loc1_:String = null;
        var _loc2_:* = false;
        var _loc3_:* = false;
        this.defenseEndTF.visible = this._currentData.startDefenseHour != NumericStepper.NAN_VALUE;
        if (this.defenseEndTF.visible) {
            _loc1_ = FortCommonUtils.instance.getDefencePeriodTime(this.defenseStartNumericStepper.value, this._startDefenseMinutes);
            this.defenseEndTF.htmlText = App.textMgr.getTextStyleById(this.defenseStartNumericStepper.getCurrentColorId(), _loc1_);
            _loc2_ = this._skipValues.indexOf(this.defenseStartNumericStepper.value) >= 0;
            _loc3_ = this.defenseStartNumericStepper.value == this._yourOwnClanStartDefenseHour;
            this.alertIcon.visible = _loc2_ || _loc3_;
            App.utils.commons.moveDsiplObjToEndOfText(this.alertIcon, this.defenseEndTF, 0, ICON_OFFSET);
        }
        else {
            this.alertIcon.visible = false;
        }
        this.applyButton.enabled = !this.lastSearchDataSet() && !this.alertIcon.visible;
        this.applyButton.tooltip = !!this.applyButton.enabled ? this._applyButtonNormalTooltip : null;
    }

    private function disposeFilterData():void {
        if (this._filterData) {
            this._filterData.dispose();
            this._filterData = null;
        }
    }

    private function disposeCurrentData():void {
        if (this._currentData) {
            this._currentData.dispose();
            this._currentData = null;
        }
    }

    private function disposeLastSentData():void {
        if (this._lastSentData) {
            this._lastSentData.dispose();
            this._lastSentData = null;
        }
    }

    private function lastSearchDataSet():Boolean {
        return this._lastSentData && this._lastSentData.isEquals(this.filterData);
    }

    private function isDefaultDataSet():Boolean {
        return this.filterData.isEquals(this._defaultFilterData);
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(param1).isCloseBtnVisible = true;
    }

    public function get filterData():IntelligenceClanFilterVO {
        this.disposeFilterData();
        var _loc1_:Object = {};
        _loc1_.minClanLevel = int(this.rangeSlider.leftValue);
        _loc1_.maxClanLevel = int(this.rangeSlider.rightValue);
        _loc1_.startDefenseHour = int(this.defenseStartNumericStepper.value);
        _loc1_.isTwelveHoursFormat = this._isTwelveHoursFormat;
        _loc1_.startDefenseMinutes = this._startDefenseMinutes;
        _loc1_.yourOwnClanStartDefenseHour = !!this._currentData ? this._currentData.yourOwnClanStartDefenseHour : Values.DEFAULT_INT;
        _loc1_.isWrongLocalTime = this._isWrongLocalTime;
        _loc1_.skipValues = this._skipValues;
        this._filterData = new IntelligenceClanFilterVO(_loc1_);
        return this._filterData;
    }

    private function onWarnCmpRollOver(param1:MouseEvent):void {
        var _loc2_:Number = this.defenseStartNumericStepper.value;
        if (this._skipValues && this._skipValues.indexOf(_loc2_) >= 0) {
            App.toolTipMgr.showComplex(FORTIFICATIONS.FORTINTELLIGENCE_CLANFILTERPOPOVER_TOOLTIPLOCKTIME);
        }
        else if (_loc2_ != Values.DEFAULT_INT && _loc2_ == this._yourOwnClanStartDefenseHour) {
            App.toolTipMgr.showComplex(FORTIFICATIONS.FORTINTELLIGENCE_CLANFILTERPOPOVER_TOOLTIPOWNDEFENCETIME);
        }
    }

    private function applyButtonButtonClickHandler(param1:ButtonEvent):void {
        useFilterS(this.filterData, this.isDefaultDataSet());
        App.popoverMgr.hide();
    }

    private function defenseStartNumericStepperChangeHandler(param1:Event):void {
        App.toolTipMgr.hide();
        invalidateData();
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    private function rangeSliderValueChangeHandler(param1:SliderEvent):void {
        invalidateData();
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }

    private function defaultButtonButtonClickHandler(param1:ButtonEvent):void {
        this.setData(this._defaultFilterData);
    }

    private function onStepperColorChangeHandler(param1:NumericStepperEvent):void {
        invalidate(FortInvalidationType.INVALID_ENABLING);
    }
}
}
