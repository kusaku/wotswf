package net.wg.gui.lobby.retrainCrewWindow {
import flash.events.Event;

import net.wg.data.constants.SoundTypes;
import net.wg.gui.components.controls.TankmanTrainigButtonVO;
import net.wg.gui.components.controls.TankmanTrainingSmallButton;
import net.wg.gui.interfaces.ISoundButton;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ButtonGroup;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.interfaces.IDataProvider;

public class RetrainCrewMainButtons extends UIComponent {

    private static const GROUP_NAME:String = "crewRetrainingGroup";

    public var academyBtn:TankmanTrainingSmallButton;

    public var schoolBtn:TankmanTrainingSmallButton;

    public var freeBtn:TankmanTrainingSmallButton;

    private var _btnGroup:ButtonGroup;

    private var _crewInfo:IDataProvider;

    private var _operationData:RetrainCrewOperationVO;

    private var _selectedId:int = 0;

    private var _currentVehicleType:String;

    private var _currentVehicleIntCD:int;

    private var _retrainingButtons:Vector.<TankmanTrainingSmallButton>;

    public function RetrainCrewMainButtons() {
        super();
        this._retrainingButtons = new <TankmanTrainingSmallButton>[this.freeBtn, this.schoolBtn, this.academyBtn];
    }

    override protected function configUI():void {
        var _loc1_:TankmanTrainingSmallButton = null;
        super.configUI();
        this._btnGroup = new ButtonGroup(GROUP_NAME, this);
        this._btnGroup.addButton(this.freeBtn);
        this._btnGroup.addButton(this.schoolBtn);
        this._btnGroup.addButton(this.academyBtn);
        this._btnGroup.addEventListener(Event.CHANGE, this.onBtnGroupChangeHandler, false, 0, true);
        var _loc2_:int = this._retrainingButtons.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_ = this._retrainingButtons[_loc3_];
            _loc1_.retraining = true;
            _loc1_.groupName = GROUP_NAME;
            _loc1_.toggle = true;
            _loc1_.soundType = SoundTypes.RNDR_NORMAL;
            _loc1_.allowDeselect = false;
            _loc3_++;
        }
    }

    override protected function draw():void {
        var _loc1_:uint = 0;
        var _loc2_:int = 0;
        var _loc3_:RetrainTankmanVO = null;
        var _loc4_:uint = 0;
        var _loc5_:int = 0;
        var _loc6_:TankmanTrainingSmallButton = null;
        var _loc7_:TankmanCrewRetrainingSmallButton = null;
        var _loc8_:TankmanTrainigButtonVO = null;
        var _loc9_:int = 0;
        super.draw();
        if (this._operationData && isInvalid(InvalidationType.DATA)) {
            _loc1_ = 0;
            _loc2_ = -1;
            _loc4_ = this._crewInfo.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc3_ = this._crewInfo[_loc5_];
                if (_loc1_ <= _loc3_.roleLevel) {
                    _loc1_ = _loc3_.roleLevel;
                }
                if (_loc2_ > _loc3_.realRoleLevel || _loc2_ < 0) {
                    _loc2_ = _loc3_.realRoleLevel;
                }
                _loc5_++;
            }
            _loc4_ = this._retrainingButtons.length;
            _loc9_ = 0;
            while (_loc9_ < _loc4_) {
                _loc6_ = this._retrainingButtons[_loc9_];
                _loc7_ = _loc6_ as TankmanCrewRetrainingSmallButton;
                if (_loc7_) {
                    _loc7_.crewInfo = this._crewInfo;
                    _loc7_.currentVehicleType = this._currentVehicleType;
                    _loc7_.currentVehicleIntCD = this._currentVehicleIntCD;
                }
                _loc8_ = new TankmanTrainigButtonVO();
                _loc8_.costs = this._operationData.tankmanCost[_loc9_];
                _loc8_.gold = this._operationData.gold;
                _loc8_.credits = this._operationData.credits;
                _loc8_.specializationLevel = _loc1_;
                _loc8_.isNativeVehicle = true;
                _loc8_.isNativeType = false;
                _loc8_.nationID = _loc3_.nationID;
                _loc8_.actionPriceData = this._operationData.actionPrc[_loc9_];
                _loc8_.minGroupSpecializationLevel = _loc2_;
                _loc6_.setData(_loc8_);
                _loc9_++;
            }
            this.autoSelectRetrainingButtons();
            this.onBtnGroupChangeHandler();
        }
    }

    override protected function onDispose():void {
        this._btnGroup.removeEventListener(Event.CHANGE, this.onBtnGroupChangeHandler);
        this._btnGroup.dispose();
        this._btnGroup = null;
        this.academyBtn.dispose();
        this.academyBtn = null;
        this.schoolBtn.dispose();
        this.schoolBtn = null;
        this.freeBtn.dispose();
        this.freeBtn = null;
        this._retrainingButtons.splice(0, this._retrainingButtons.length);
        this._retrainingButtons = null;
        this._crewInfo = null;
        this._operationData = null;
        super.onDispose();
    }

    private function autoSelectRetrainingButtons():void {
        var _loc1_:ISoundButton = null;
        var _loc2_:int = this._retrainingButtons.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc1_ = this._retrainingButtons[_loc3_];
            if (_loc1_.enabled) {
                _loc1_.selected = true;
                return;
            }
            _loc3_++;
        }
    }

    public function get crewInfo():IDataProvider {
        return this._crewInfo;
    }

    public function set crewInfo(param1:IDataProvider):void {
        this._crewInfo = param1;
    }

    public function get operationData():RetrainCrewOperationVO {
        return this._operationData;
    }

    public function set operationData(param1:RetrainCrewOperationVO):void {
        this._operationData = param1;
        invalidateData();
    }

    public function get selectedId():int {
        return this._selectedId;
    }

    public function set currentVehicleType(param1:String):void {
        this._currentVehicleType = param1;
    }

    public function set currentVehicleIntCD(param1:int):void {
        this._currentVehicleIntCD = param1;
    }

    private function onBtnGroupChangeHandler(param1:Event = null):void {
        this._selectedId = this._btnGroup.selectedIndex;
        dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE, false, true, this._selectedId));
    }
}
}
