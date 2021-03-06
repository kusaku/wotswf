package net.wg.gui.cyberSport.controls {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.constants.ComponentState;
import net.wg.data.constants.SoundManagerStates;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.cyberSport.controls.data.CSVehicleButtonSelectionVO;
import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.gui.rally.vo.SettingRosterVO;
import net.wg.gui.rally.vo.VehicleVO;
import net.wg.utils.IUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.gfx.MouseEventEx;

public class CSVehicleButton extends SoundButtonEx implements IVehicleButton {

    private static const CUT_RECTANGLE:Rectangle = new Rectangle(0, 2, 70, 20);

    private static const UPDATE_INIT_DATA:String = "updateInitDFata";

    public static const SELECTED_VEHICLE:int = 0;

    public static const CHOOSE_VEHICLE:int = 1;

    public static const COUNT_VEHICLE:int = 2;

    public static const DEFAULT_STATE:int = 3;

    public static const RANGE_ROSTER:int = 4;

    public static const ROSTER_SETTINGS:int = 5;

    public static const ALERT_DATA_TYPE:uint = 1;

    public var cutVehicleIcon:MovieClip;

    public var cutVehicleIconEff:MovieClip;

    public var vehicleNameEff:MovieClip;

    public var vehicleName:MovieClip;

    public var vehicleLevel:CSVehicleButtonLevels;

    public var vehicleType:MovieClip;

    public var vehicleTypeEff:MovieClip;

    public var nationTypeEff:MovieClip;

    public var nationType:MovieClip;

    public var vCountMsg:TextField;

    public var defaultMsg:TextField;

    public var bgAnimationSelectVehicle:MovieClip;

    public var bgAnimationSelectVehicleDef:MovieClip;

    public var chooseVhclAnimEffect:MovieClip;

    public var chooseVhclAnim:MovieClip;

    public var rangeView:RangeViewComponent;

    public var defaultBg:MovieClip;

    public var rangeBg:MovieClip;

    public var btnIconVCount:MovieClip;

    public var gearIcon:MovieClip;

    public var alertIcon:MovieClip;

    public var clickableArea:MovieClip;

    private var _currentViewType:String = "autoSearch";

    private var _showAlertIcon:Boolean = false;

    private var _rangeModel:SettingRosterVO;

    private var _utils:IUtils;

    private var _currentState:int = 3;

    private var _vehicleCount:int = -1;

    private var _vehicleModel:VehicleVO;

    private var _showRangeRosterBg:Boolean = true;

    private var _selectSate:Boolean = false;

    private var _selectedStateText:String = "";

    private var _forceSoundEnable:Boolean = false;

    private var _showCommanderSettings:Boolean = false;

    private var _mouseOverAlert:Boolean = false;

    private var _updatedFlag:Boolean = false;

    private var _clickableAreaEnable:Boolean = true;

    public function CSVehicleButton() {
        super();
    }

    override protected function draw():void {
        if (_newFrame != null && isInvalid(InvalidationType.STATE) && this.vehicleLevel) {
            this.vehicleLevel.setState(_newFrame);
        }
        super.draw();
        if (!this._updatedFlag && isInvalid(UPDATE_INIT_DATA)) {
            if (this._vehicleModel) {
                this.initMedallion();
            }
            else if (this._rangeModel) {
                this.updateRange();
            }
            else {
                this.initVehicleCount();
            }
            this.changeViewState();
            this._updatedFlag = true;
        }
    }

    override protected function configUI():void {
        super.configUI();
        mouseChildren = this._clickableAreaEnable;
        this.updateClickableArea(enabled);
        buttonMode = false;
        this.cutVehicleIcon.mouseEnabled = false;
        this.cutVehicleIconEff.mouseEnabled = false;
        this.vehicleName.mouseEnabled = false;
        this.vehicleNameEff.mouseEnabled = false;
        this.vehicleLevel.mouseEnabled = false;
        this.vehicleType.mouseEnabled = false;
        this.vehicleTypeEff.mouseEnabled = false;
        this.nationType.mouseEnabled = false;
        this.nationTypeEff.mouseEnabled = false;
        this.vCountMsg.mouseEnabled = false;
        this.btnIconVCount.mouseEnabled = false;
        this.gearIcon.mouseEnabled = false;
        this.defaultMsg.mouseEnabled = false;
        this.bgAnimationSelectVehicle.mouseEnabled = false;
        this.bgAnimationSelectVehicleDef.mouseEnabled = false;
        this.chooseVhclAnimEffect.mouseEnabled = false;
        this.chooseVhclAnim.mouseEnabled = false;
        this.rangeView.mouseEnabled = false;
        this.defaultBg.mouseEnabled = false;
        this.rangeBg.mouseEnabled = false;
        this.bgAnimationSelectVehicle.visible = false;
        this.bgAnimationSelectVehicleDef.visible = false;
        this.vehicleLevel.visible = false;
        this._utils = App.utils;
        this.defaultMsg.text = CYBERSPORT.BUTTON_MEDALLION_AVAILABLEQUANTITY;
        App.soundMgr.removeSoundHdlrs(this);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAlertRollOverHandler);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OUT, this.onAlertRollOutHandler);
        this.alertIcon.useHandCursor = false;
        this.alertIcon.mouseEnabled = true;
        this.alertIcon.buttonMode = false;
        this.clickableArea.mouseEnabled = true;
        this.clickableArea.addEventListener(MouseEvent.ROLL_OUT, this.onComponentRollOutHandler);
        this.clickableArea.addEventListener(MouseEvent.ROLL_OVER, this.onComponentRollOverHandler);
    }

    override protected function onDispose():void {
        if (this._rangeModel) {
            this._rangeModel.dispose();
        }
        this.clearData();
        if (this.bgAnimationSelectVehicle) {
            this.bgAnimationSelectVehicle = null;
            this.bgAnimationSelectVehicleDef = null;
        }
        if (this.rangeView) {
            this.rangeView.dispose();
            this.rangeView = null;
        }
        if (this.vehicleLevel) {
            this.vehicleLevel.dispose();
            this.vehicleLevel = null;
        }
        this.cutVehicleIcon = null;
        this.cutVehicleIconEff = null;
        this.vehicleNameEff = null;
        this.vehicleName = null;
        this.vehicleType = null;
        this.vehicleTypeEff = null;
        this.nationTypeEff = null;
        this.nationType = null;
        this.vCountMsg = null;
        this.defaultMsg = null;
        this.bgAnimationSelectVehicle = null;
        this.bgAnimationSelectVehicleDef = null;
        this.chooseVhclAnimEffect = null;
        this.chooseVhclAnim = null;
        this.defaultBg = null;
        this.rangeBg = null;
        this.btnIconVCount = null;
        this.gearIcon = null;
        this._rangeModel = null;
        this._utils = null;
        this._vehicleModel = null;
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAlertRollOverHandler);
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onAlertRollOutHandler);
        this.alertIcon = null;
        this.clickableArea.removeEventListener(MouseEvent.ROLL_OUT, this.onComponentRollOutHandler);
        this.clickableArea.removeEventListener(MouseEvent.ROLL_OVER, this.onComponentRollOverHandler);
        this.clickableArea.removeEventListener(MouseEvent.CLICK, this.onAreaClickHandler);
        this.clickableArea = null;
        super.onDispose();
    }

    override protected function handleRelease(param1:uint = 0):void {
        super.handleRelease(param1);
        setState(focusIndicator == null ? ComponentState.OUT : ComponentState.KB_RELEASE);
        if (!enabled || !this._clickableAreaEnable) {
            return;
        }
        this.clickableArea.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }

    public function getModel():CSVehicleButtonSelectionVO {
        if (this._vehicleModel) {
            return new CSVehicleButtonSelectionVO(this._vehicleModel.intCD);
        }
        if (this._rangeModel) {
            return new CSVehicleButtonSelectionVO(-1, this.getNationRange(), this.getVType(), this.getLevelsRange());
        }
        return null;
    }

    public function reset():void {
        this.selectState(false);
        this.clearData();
        invalidate(UPDATE_INIT_DATA);
    }

    public function selectState(param1:Boolean, param2:String = null):void {
        this._updatedFlag = false;
        this._selectedStateText = param2 == null ? CYBERSPORT.BUTTON_MEDALLION_CHOOSEVEHICLE : param2;
        this._selectSate = param1;
        invalidate(UPDATE_INIT_DATA);
    }

    public function setRangeData(param1:SettingRosterVO):void {
        if (param1 == null) {
            return;
        }
        this.clearData();
        this._rangeModel = param1;
        invalidate(UPDATE_INIT_DATA);
    }

    public function setVehicle(param1:VehicleVO):void {
        this.clearData();
        this._vehicleModel = param1;
        invalidate(UPDATE_INIT_DATA);
    }

    private function clearData():void {
        this._updatedFlag = false;
        this._vehicleModel = null;
        this._rangeModel = null;
        this._vehicleCount = -1;
        this._showCommanderSettings = false;
    }

    private function updateRange():void {
        this._currentState = RANGE_ROSTER;
        this.rangeView.setData(this._rangeModel);
    }

    private function initVehicleCount():void {
        var _loc1_:TextFormat = null;
        if (this._showCommanderSettings) {
            this._currentState = ROSTER_SETTINGS;
        }
        else if (this._selectSate) {
            this.applyChooseVehicle();
        }
        else {
            this._currentState = this.vehicleCount != -1 ? int(COUNT_VEHICLE) : int(DEFAULT_STATE);
            this.vCountMsg.htmlText = this.vehicleCount.toString();
            if (this._vehicleCount == 0) {
                _loc1_ = this.vCountMsg.getTextFormat();
                _loc1_.color = 16711680;
                this.vCountMsg.setTextFormat(_loc1_);
            }
        }
    }

    private function initMedallion():void {
        this._currentState = SELECTED_VEHICLE;
        var _loc1_:String = this._utils.nations.getNationName(this._vehicleModel.nationID);
        this.nationType.gotoAndStop(_loc1_);
        this.nationTypeEff.gotoAndStop(_loc1_);
        this.cutVehicleIcon.vehicleIcon.cutRect = this.cutVehicleIconEff.vehicleIcon.cutRect = CUT_RECTANGLE;
        this.cutVehicleIcon.vehicleIcon.source = this.cutVehicleIconEff.vehicleIcon.source = this._vehicleModel.smallIconPath;
        App.utils.commons.formatPlayerName(this.vehicleName.textField, App.utils.commons.getUserProps(this._vehicleModel.shortUserName));
        this.vehicleNameEff.textField.htmlText = this.vehicleName.textField.htmlText;
        this.vehicleLevel.setData(this._vehicleModel.level);
        this.vehicleType.gotoAndStop(this._vehicleModel.type);
        this.vehicleTypeEff.gotoAndStop(this._vehicleModel.type);
    }

    private function applyChooseVehicle():void {
        this._currentState = CHOOSE_VEHICLE;
        this.chooseVhclAnim.chooseVehicle.text = this._selectedStateText;
        this.chooseVhclAnimEffect.chooseVehicle.text = this._selectedStateText;
    }

    private function changeViewState():void {
        if (enabled) {
            if (this._currentState == COUNT_VEHICLE || this._currentState == DEFAULT_STATE || this._currentState == ROSTER_SETTINGS) {
                this.clickableArea.buttonMode = this._forceSoundEnable;
            }
            else {
                this.clickableArea.buttonMode = true;
            }
            if (this._currentState == ROSTER_SETTINGS) {
                this.clickableArea.hitArea = this.gearIcon;
            }
            else {
                this.clickableArea.hitArea = this.clickableArea;
            }
        }
        this.gearIcon.visible = this._currentState == ROSTER_SETTINGS;
        var _loc1_:Array = [COUNT_VEHICLE, ROSTER_SETTINGS];
        if (!enabled) {
            _loc1_.push(SELECTED_VEHICLE);
        }
        this.defaultBg.visible = _loc1_.indexOf(this._currentState) == -1;
        this.nationType.visible = this.nationTypeEff.visible = this._currentState == SELECTED_VEHICLE;
        this.cutVehicleIcon.visible = this.cutVehicleIconEff.visible = this._currentState == SELECTED_VEHICLE;
        this.vehicleName.visible = this.vehicleNameEff.visible = this._currentState == SELECTED_VEHICLE;
        this.vehicleTypeEff.visible = this.vehicleType.visible = this._currentState == SELECTED_VEHICLE;
        this.vehicleLevel.visible = this._currentState == SELECTED_VEHICLE;
        this.btnIconVCount.visible = this.vCountMsg.visible = this.defaultMsg.visible = this._currentState == COUNT_VEHICLE;
        this.chooseVhclAnim.visible = this.chooseVhclAnimEffect.visible = this.currentState == CHOOSE_VEHICLE;
        this.bgAnimationSelectVehicle.visible = enabled && this.defaultBg.visible;
        this.bgAnimationSelectVehicleDef.visible = enabled && this.defaultBg.visible;
        this.rangeView.visible = this.currentState == RANGE_ROSTER;
        this.rangeBg.visible = !this._showRangeRosterBg && this.currentState == RANGE_ROSTER;
        if (this.currentState == RANGE_ROSTER) {
            this.defaultBg.visible = this._showRangeRosterBg;
            this.bgAnimationSelectVehicle.visible = this._showRangeRosterBg;
            this.bgAnimationSelectVehicleDef.visible = this._showRangeRosterBg;
        }
        this.alertIcon.visible = this._showAlertIcon && this._vehicleModel && !this._vehicleModel.isReadyToFight;
    }

    private function playSounds(param1:String):void {
        param1 = param1 == MouseEvent.ROLL_OVER ? SoundManagerStates.SND_OVER : SoundManagerStates.SND_OUT;
        App.soundMgr.playControlsSnd(param1, soundType, soundId);
    }

    private function dispatchChooseVehicle():void {
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.CHOOSE_VEHICLE, this.getModel()));
    }

    private function getNationRange():Array {
        if (this._rangeModel && this._rangeModel.nationIDRange) {
            return this._rangeModel.nationIDRange.slice();
        }
        return [];
    }

    private function getVType():Array {
        if (this._rangeModel && this._rangeModel.vTypeRange) {
            return this._rangeModel.vTypeRange.slice();
        }
        return [];
    }

    private function getLevelsRange():Array {
        if (this._rangeModel && this._rangeModel.vLevelRange) {
            return this._rangeModel.vLevelRange.slice();
        }
        return [];
    }

    override public function set enabled(param1:Boolean):void {
        super.enabled = param1;
        mouseChildren = true;
        this.updateClickableArea(param1);
    }

    public function get currentViewType():String {
        return this._currentViewType;
    }

    public function set currentViewType(param1:String):void {
        this._currentViewType = param1;
    }

    public function get forceSoundEnable():Boolean {
        return this._forceSoundEnable;
    }

    public function set forceSoundEnable(param1:Boolean):void {
        this._forceSoundEnable = param1;
    }

    public function get showRangeRosterBg():Boolean {
        return this._showRangeRosterBg;
    }

    public function set showRangeRosterBg(param1:Boolean):void {
        this._showRangeRosterBg = param1;
        this.rangeBg.visible = !param1;
    }

    public function get vehicleCount():int {
        return this._vehicleCount;
    }

    public function set vehicleCount(param1:int):void {
        this.clearData();
        this._vehicleCount = param1;
        invalidate(UPDATE_INIT_DATA);
    }

    public function get showCommanderSettings():Boolean {
        return this._showCommanderSettings;
    }

    public function set showCommanderSettings(param1:Boolean):void {
        this.clearData();
        this._showCommanderSettings = param1;
        invalidate(UPDATE_INIT_DATA);
    }

    public function set clickableAreaEnable(param1:Boolean):void {
        this._clickableAreaEnable = param1;
        this.updateClickableArea(enabled);
    }

    private function updateClickableArea(param1:Boolean):void {
        this.clickableArea.buttonMode = this._clickableAreaEnable && param1;
        if (this._clickableAreaEnable && param1) {
            if (!this.clickableArea.hasEventListener(MouseEvent.CLICK)) {
                this.clickableArea.addEventListener(MouseEvent.CLICK, this.onAreaClickHandler);
            }
        }
        else {
            this.clickableArea.removeEventListener(MouseEvent.CLICK, this.onAreaClickHandler);
        }
    }

    public function get currentState():int {
        return this._currentState;
    }

    public function get showAlertIcon():Boolean {
        return this._showAlertIcon;
    }

    public function set showAlertIcon(param1:Boolean):void {
        this._showAlertIcon = param1;
    }

    override protected function handleMousePress(param1:MouseEvent):void {
    }

    override protected function handleMouseRelease(param1:MouseEvent):void {
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
    }

    private function onComponentRollOverHandler(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this.playSounds(param1.type);
        if (!this._mouseOverAlert) {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_BTN_ROLL_OVER));
        }
    }

    private function onComponentRollOutHandler(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this.playSounds(param1.type);
        if (!this._mouseOverAlert) {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_BTN_ROLL_OUT));
        }
    }

    private function onAreaClickHandler(param1:MouseEvent):void {
        var _loc2_:MouseEventEx = param1 as MouseEventEx;
        var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
        if (_loc3_ != MouseEventEx.LEFT_BUTTON) {
            return;
        }
        super.handleMousePress(param1);
        super.handleMouseRelease(param1);
        if (this.currentState == SELECTED_VEHICLE || this.currentState == CHOOSE_VEHICLE) {
            this.dispatchChooseVehicle();
        }
        if (this.currentState != COUNT_VEHICLE && this.currentState != DEFAULT_STATE && this.currentState != ROSTER_SETTINGS || this._forceSoundEnable) {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS, soundType, soundId);
        }
    }

    private function onAlertRollOverHandler(param1:MouseEvent):void {
        this._mouseOverAlert = true;
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_BTN_ROLL_OVER, {
            "type": ALERT_DATA_TYPE,
            "state": this._vehicleModel.state
        }));
    }

    private function onAlertRollOutHandler(param1:MouseEvent):void {
        this._mouseOverAlert = false;
        dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_BTN_ROLL_OUT));
        var _loc2_:Point = new Point(mouseX, mouseY);
        _loc2_ = localToGlobal(_loc2_);
        if (hitTestPoint(_loc2_.x, _loc2_.y)) {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_BTN_ROLL_OVER));
        }
    }
}
}
