package net.wg.gui.lobby.tankman {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

import net.wg.data.constants.VehicleTypes;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.TankmanTrainigButtonVO;
import net.wg.gui.components.controls.TankmanTrainingSmallButton;
import net.wg.gui.events.PersonalCaseEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.controls.ButtonGroup;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class CrewTankmanRetraining extends UIComponentEx implements IViewStackContent {

    public var btnRetraining:SoundButtonEx;

    public var lightTankBtn:VehicleTypeButton = null;

    public var mediumTankBtn:VehicleTypeButton = null;

    public var heavyTankBtn:VehicleTypeButton = null;

    public var at_spgBtn:VehicleTypeButton = null;

    public var spgBtn:VehicleTypeButton = null;

    public var btnAcademy:TankmanTrainingSmallButton = null;

    public var btnScool:TankmanTrainingSmallButton = null;

    public var btnCourses:TankmanTrainingSmallButton = null;

    public var vehiclesDropdown:DropdownMenu = null;

    public var btnReset:SoundButtonEx = null;

    private var _vehicleGroup:ButtonGroup = null;

    private var _retrainingButtonGroup:ButtonGroup = null;

    private var _currentSelectedVehicleType:String = null;

    private var _currentSelectedInnationID:int = 0;

    private var _currentSelectedCostIndex:int = -1;

    private var _retrainingButtons:Vector.<TankmanTrainingSmallButton> = null;

    private var _vehicleButtons:Vector.<VehicleTypeButton> = null;

    private var _toolTipBindHash:Object;

    private var _model:PersonalCaseRetrainingModel = null;

    private var _needUpdateData:Boolean = false;

    private var _isInitialized:Boolean = false;

    private const UPDATE_DATA:String = "updateData";

    private const RETRAINING_BTNS_GROUP_NAME:String = "retrainingButtonGroup";

    private const VEHICLE_GROUP_NAME:String = "vehicleGroup";

    private const VEHICLE_DD_LABELFIELD:String = "userName";

    private const BTN_LIGHT_TANK:String = "lightTankBtn";

    private const BTN_MEDIUM_TANK:String = "mediumTankBtn";

    private const BTN_HEAVY_TANK:String = "heavyTankBtn";

    private const BTN_AT_SPG:String = "at_spgBtn";

    private const BTN_SPG:String = "spgBtn";

    private const VEHICLE_DD:String = "vehiclesDropdown";

    private const BTN_RESET:String = "btnReset";

    public function CrewTankmanRetraining() {
        this._toolTipBindHash = {};
        super();
    }

    override protected function onDispose():void {
        var _loc1_:VehicleTypeButton = null;
        var _loc2_:TankmanTrainingSmallButton = null;
        this._model = null;
        if (this._vehicleGroup != null) {
            this._vehicleGroup.dispose();
        }
        if (this._vehicleButtons != null) {
            _loc1_ = null;
            while (this._vehicleButtons.length) {
                _loc1_ = this._vehicleButtons.pop();
                _loc1_.removeEventListener(ButtonEvent.CLICK, this.onVehicleTypeButtonClickHandler);
                _loc1_.dispose();
            }
            _loc1_ = null;
            this._vehicleButtons = null;
        }
        if (this._retrainingButtonGroup != null) {
            this._retrainingButtonGroup.removeEventListener(Event.CHANGE, this.onRetrainingButtonGroupChangeHandler);
            this._retrainingButtonGroup.dispose();
        }
        if (this._retrainingButtons != null) {
            _loc2_ = null;
            while (this._retrainingButtons.length) {
                _loc2_ = this._retrainingButtons.pop();
                _loc2_.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onRetrainingButtonDoubleClickHandler);
                _loc2_.dispose();
            }
            _loc2_ = null;
            this._retrainingButtons = null;
        }
        this.btnReset.removeEventListener(ButtonEvent.CLICK, this.onBtnResetClickHandler);
        this.btnReset.dispose();
        this.vehiclesDropdown.removeEventListener(ListEvent.INDEX_CHANGE, this.onVehiclesDropdownIndexChangeHandler);
        this.vehiclesDropdown.dispose();
        this.btnRetraining.removeEventListener(ButtonEvent.CLICK, this.onApplyRetrainingButtonClickHandler);
        this.btnRetraining.dispose();
        this.setToolTipListeners(this.vehiclesDropdown, false);
        this.setToolTipListeners(this.btnReset, false);
        App.utils.data.cleanupDynamicObject(this._toolTipBindHash);
        this._toolTipBindHash = null;
        this.btnRetraining = null;
        this._vehicleGroup = null;
        this.lightTankBtn = null;
        this.mediumTankBtn = null;
        this.heavyTankBtn = null;
        this.at_spgBtn = null;
        this.spgBtn = null;
        this._retrainingButtonGroup = null;
        this.btnAcademy = null;
        this.btnScool = null;
        this.btnCourses = null;
        this.vehiclesDropdown = null;
        this.btnReset = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(this.UPDATE_DATA) && this._needUpdateData) {
            this._needUpdateData = false;
            this.updateViewElements();
        }
    }

    override protected function configUI():void {
        this.vehiclesDropdown.buttonMode = true;
        this.setToolTipListeners(this.vehiclesDropdown);
        this.setToolTipListeners(this.btnReset);
        super.configUI();
        this.btnReset.addEventListener(ButtonEvent.CLICK, this.onBtnResetClickHandler);
        this.vehiclesDropdown.addEventListener(ListEvent.INDEX_CHANGE, this.onVehiclesDropdownIndexChangeHandler);
        this.btnRetraining.addEventListener(ButtonEvent.CLICK, this.onApplyRetrainingButtonClickHandler);
        this._toolTipBindHash[this.BTN_LIGHT_TANK] = TOOLTIPS.PERSONAL_CASE_TRAINING_LIGHT_TANK_BTN;
        this._toolTipBindHash[this.BTN_MEDIUM_TANK] = TOOLTIPS.PERSONAL_CASE_TRAINING_MEDIUM_TANK_BTN;
        this._toolTipBindHash[this.BTN_HEAVY_TANK] = TOOLTIPS.PERSONAL_CASE_TRAINING_HEAVY_TANK_BTN;
        this._toolTipBindHash[this.BTN_AT_SPG] = TOOLTIPS.PERSONAL_CASE_TRAINING_AT_SPG_BTN;
        this._toolTipBindHash[this.BTN_SPG] = TOOLTIPS.PERSONAL_CASE_TRAINING_SPG_BTN;
        this._toolTipBindHash[this.VEHICLE_DD] = TOOLTIPS.PERSONAL_CASE_TRAINING_TANK;
        this._toolTipBindHash[this.BTN_RESET] = TOOLTIPS.PERSONAL_CASE_TRAINING_CURRENT_TANK;
        this._vehicleButtons = new <VehicleTypeButton>[this.lightTankBtn, this.mediumTankBtn, this.heavyTankBtn, this.at_spgBtn, this.spgBtn];
        this._retrainingButtons = new <TankmanTrainingSmallButton>[this.btnCourses, this.btnScool, this.btnAcademy];
        this.initRetrainingButton();
        this.initVehicleTypes();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return null;
    }

    public function update(param1:Object):void {
        if (param1 == null) {
            return;
        }
        this._model = param1 as PersonalCaseRetrainingModel;
        this.btnReset.enabled = this._model.currentVehicle != null;
        this._needUpdateData = true;
        invalidate(this.UPDATE_DATA);
    }

    private function setToolTipListeners(param1:DisplayObject, param2:Boolean = true):void {
        if (param2) {
            param1.addEventListener(MouseEvent.MOUSE_OVER, this.onItemMouseOverHandler);
            param1.addEventListener(MouseEvent.MOUSE_OUT, this.onItemMouseOutHandler);
        }
        else {
            param1.removeEventListener(MouseEvent.MOUSE_OVER, this.onItemMouseOverHandler);
            param1.removeEventListener(MouseEvent.MOUSE_OUT, this.onItemMouseOutHandler);
        }
    }

    private function updateViewElements():void {
        this.enableVehicleTypeButton();
        if (!this._isInitialized) {
            this._currentSelectedInnationID = this._model.nativeVehicle.innationID;
            this.autoSelectVehicleType(this._model.nativeVehicle.type);
            this.autoSelectVehicle(this._currentSelectedVehicleType);
            this._isInitialized = true;
        }
        else {
            this.updateRetrainingButtons();
        }
    }

    private function enableVehicleTypeButton():void {
        this.lightTankBtn.enabled = this._model.lightTanks.length > 0;
        this.mediumTankBtn.enabled = this._model.mediumTanks.length > 0;
        this.heavyTankBtn.enabled = this._model.heavyTanks.length > 0;
        this.at_spgBtn.enabled = this._model.AT_SPG.length > 0;
        this.spgBtn.enabled = this._model.SPG.length > 0;
    }

    private function initRetrainingButton():void {
        this._retrainingButtonGroup = ButtonGroup.getGroup(this.RETRAINING_BTNS_GROUP_NAME, this);
        this._retrainingButtonGroup.addEventListener(Event.CHANGE, this.onRetrainingButtonGroupChangeHandler);
        var _loc1_:Number = this._retrainingButtons.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._retrainingButtons[_loc2_].groupName = this.RETRAINING_BTNS_GROUP_NAME;
            this._retrainingButtons[_loc2_].retraining = true;
            this._retrainingButtons[_loc2_].addEventListener(MouseEvent.DOUBLE_CLICK, this.onRetrainingButtonDoubleClickHandler);
            this._retrainingButtons[_loc2_].allowDeselect = false;
            this._retrainingButtons[_loc2_].doubleClickEnabled = true;
            _loc2_++;
        }
    }

    private function updateRetrainingButtons():void {
        var _loc4_:TankmanTrainigButtonVO = null;
        var _loc1_:* = this._currentSelectedInnationID == this._model.nativeVehicle.innationID;
        var _loc2_:* = this._currentSelectedVehicleType == this._model.nativeVehicle.type;
        var _loc3_:Number = this._retrainingButtons.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = new TankmanTrainigButtonVO();
            _loc4_.costs = this._model.tankmanCost[_loc5_];
            _loc4_.gold = this._model.gold;
            _loc4_.credits = this._model.credits;
            _loc4_.specializationLevel = this._model.specializationLevel;
            _loc4_.isNativeVehicle = _loc1_;
            _loc4_.isNativeType = _loc2_;
            _loc4_.nationID = this._model.nationID;
            _loc4_.actionPriceData = this._model.action[_loc5_];
            _loc4_.minGroupSpecializationLevel = this._model.specializationLevel;
            this._retrainingButtons[_loc5_].setData(_loc4_);
            _loc5_++;
        }
        this.autoSelectRetrainingButtons();
    }

    private function autoSelectRetrainingButtons():void {
        var _loc1_:Number = this._retrainingButtons.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            if (this._retrainingButtons[_loc2_].enabled) {
                this._retrainingButtons[_loc2_].selected = true;
                this._currentSelectedCostIndex = _loc2_;
                this.btnRetraining.enabled = true;
                return;
            }
            _loc2_++;
        }
        this.btnRetraining.enabled = false;
    }

    private function initVehicleTypes():void {
        this._vehicleGroup = ButtonGroup.getGroup(this.VEHICLE_GROUP_NAME, this);
        var _loc1_:Number = this._vehicleButtons.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._vehicleButtons[_loc2_].addEventListener(ButtonEvent.CLICK, this.onVehicleTypeButtonClickHandler);
            this.setToolTipListeners(this._vehicleButtons[_loc2_]);
            this._vehicleButtons[_loc2_].groupName = this.VEHICLE_GROUP_NAME;
            this._vehicleButtons[_loc2_].allowDeselect = false;
            this._vehicleButtons[_loc2_].validateNow();
            _loc2_++;
        }
    }

    private function autoSelectVehicleType(param1:String):void {
        if (this._currentSelectedVehicleType == param1) {
            return;
        }
        this._currentSelectedVehicleType = param1;
        this.selectCurrentVehicleType();
    }

    private function selectCurrentVehicleType():void {
        var _loc1_:Number = this._vehicleButtons.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            if (this._currentSelectedVehicleType == this._vehicleButtons[_loc2_].type) {
                this._vehicleButtons[_loc2_].selected = true;
            }
            _loc2_++;
        }
    }

    private function autoSelectVehicle(param1:String, param2:Boolean = true):void {
        var _loc3_:DataProvider = null;
        var _loc4_:Boolean = false;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        switch (param1) {
            case VehicleTypes.LIGHT_TANK:
                _loc3_ = new DataProvider(this._model.lightTanks);
                break;
            case VehicleTypes.MEDIUM_TANK:
                _loc3_ = new DataProvider(this._model.mediumTanks);
                break;
            case VehicleTypes.HEAVY_TANK:
                _loc3_ = new DataProvider(this._model.heavyTanks);
                break;
            case VehicleTypes.AT_SPG:
                _loc3_ = new DataProvider(this._model.AT_SPG);
                break;
            case VehicleTypes.SPG:
                _loc3_ = new DataProvider(this._model.SPG);
                break;
            default:
                DebugUtils.LOG_DEBUG("ERROR unknown tank type: " + param1);
        }
        this.vehiclesDropdown.labelField = this.VEHICLE_DD_LABELFIELD;
        this.vehiclesDropdown.dataProvider = _loc3_;
        if (param2) {
            _loc4_ = false;
            _loc5_ = this.vehiclesDropdown.dataProvider.length;
            _loc6_ = 0;
            while (_loc6_ < _loc5_) {
                if (this.vehiclesDropdown.dataProvider[_loc6_].innationID == this._currentSelectedInnationID) {
                    this.vehiclesDropdown.selectedIndex = _loc6_;
                    _loc4_ = true;
                    break;
                }
                _loc6_++;
            }
            if (!_loc4_) {
                this.vehiclesDropdown.selectedIndex = 0;
            }
        }
        else {
            this.vehiclesDropdown.selectedIndex = 0;
        }
        this._currentSelectedCostIndex = -1;
        this.checkEnabledResetBtn(this.vehiclesDropdown.dataProvider[this.vehiclesDropdown.selectedIndex].innationID);
        this.vehiclesDropdown.validateNow();
    }

    private function checkEnabledResetBtn(param1:int):void {
        if (this._model.currentVehicle != null) {
            this.btnReset.enabled = param1 != this._model.currentVehicle.innationID;
        }
        this._currentSelectedInnationID = param1;
        this.updateRetrainingButtons();
    }

    private function applayRetraining():void {
        var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.APPLY_RETRAINING);
        var _loc2_:Object = {};
        _loc2_.innaitonID = this._currentSelectedInnationID;
        _loc2_.inventoryID = this._model.tankmanID;
        _loc2_.tankmanCostTypeIndex = this._currentSelectedCostIndex;
        _loc1_.retrainingTankmanData = _loc2_;
        dispatchEvent(_loc1_);
    }

    private function onRetrainingButtonDoubleClickHandler(param1:MouseEvent):void {
        (param1.target as IEventDispatcher).dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
        if (App.utils.commons.isLeftButton(param1)) {
            this.applayRetraining();
        }
    }

    private function onItemMouseOverHandler(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (this._toolTipBindHash[param1.currentTarget.name] != null) {
            _loc2_ = this._toolTipBindHash[param1.currentTarget.name];
        }
        App.toolTipMgr.showComplex(_loc2_);
    }

    private function onItemMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onVehicleTypeButtonClickHandler(param1:ButtonEvent):void {
        var _loc3_:* = false;
        var _loc4_:* = false;
        var _loc2_:String = VehicleTypeButton(param1.currentTarget).type;
        if (this._currentSelectedVehicleType != _loc2_) {
            this._currentSelectedVehicleType = _loc2_;
            _loc3_ = false;
            if (this._model.currentVehicle != null) {
                _loc3_ = this._currentSelectedVehicleType == this._model.currentVehicle.type;
            }
            _loc4_ = this._currentSelectedVehicleType == this._model.nativeVehicle.type;
            this._currentSelectedInnationID = !!_loc3_ ? int(this._model.currentVehicle.innationID) : int(this._model.nativeVehicle.innationID);
            this.selectCurrentVehicleType();
            this.autoSelectVehicle(this._currentSelectedVehicleType, _loc3_ || _loc4_);
        }
    }

    private function onBtnResetClickHandler(param1:ButtonEvent):void {
        this._currentSelectedInnationID = this._model.currentVehicle.innationID;
        this.autoSelectVehicleType(this._model.currentVehicle.type);
        this.autoSelectVehicle(this._model.currentVehicle.type);
    }

    private function onVehiclesDropdownIndexChangeHandler(param1:ListEvent):void {
        this.checkEnabledResetBtn(param1.itemData.innationID);
    }

    private function onRetrainingButtonGroupChangeHandler(param1:Event):void {
        this._currentSelectedCostIndex = this._retrainingButtonGroup.selectedIndex;
    }

    private function onApplyRetrainingButtonClickHandler(param1:ButtonEvent):void {
        this.applayRetraining();
    }
}
}
