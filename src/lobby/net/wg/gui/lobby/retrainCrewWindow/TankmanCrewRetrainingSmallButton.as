package net.wg.gui.lobby.retrainCrewWindow {
import flash.text.TextFormat;

import net.wg.gui.components.controls.TankmanTrainingSmallButton;

import scaleform.clik.interfaces.IDataProvider;

public class TankmanCrewRetrainingSmallButton extends TankmanTrainingSmallButton {

    private static const SMALL_TEXT_VAL:uint = 24;

    private static const BIG_TEXT_VAL:uint = 30;

    private var _crewInfo:IDataProvider;

    private var _currentVehicleType:String;

    private var _currentVehicleIntCD:int;

    public function TankmanCrewRetrainingSmallButton() {
        super();
    }

    override protected function isEnabled():Boolean {
        var _loc1_:Boolean = false;
        var _loc2_:RetrainTankmanVO = null;
        var _loc3_:int = this._crewInfo.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc2_ = this._crewInfo[_loc4_];
            if (_loc2_.nativeVehicleIntCD == this._currentVehicleIntCD) {
                _loc1_ = _loc2_.realRoleLevel < level && _hasMoney;
            }
            else {
                _loc1_ = _hasMoney;
            }
            if (_loc1_) {
                return true;
            }
            _loc4_++;
        }
        return false;
    }

    override protected function onDispose():void {
        this._crewInfo = null;
        super.onDispose();
    }

    private function updateLevelLabel():void {
        var _loc3_:int = 0;
        var _loc4_:RetrainTankmanVO = null;
        var _loc7_:uint = 0;
        var _loc8_:String = null;
        var _loc1_:int = 30000000;
        var _loc2_:int = 0;
        var _loc5_:int = this._crewInfo.length;
        var _loc6_:int = 0;
        while (_loc6_ < _loc5_) {
            _loc4_ = this._crewInfo[_loc6_];
            _loc3_ = calculateCurrentLevel(this._currentVehicleType == _loc4_.nativeVehicleType, _loc4_.roleLevel, _model.baseRoleLoss, _model.classChangeRoleLoss, _model.roleLevel);
            _loc1_ = _loc3_ < _loc1_ ? int(_loc3_) : int(_loc1_);
            _loc2_ = _loc3_ > _loc2_ ? int(_loc3_) : int(_loc2_);
            _loc6_++;
        }
        if (_loc2_ == _loc1_) {
            _loc7_ = BIG_TEXT_VAL;
            _loc8_ = _loc2_.toString();
        }
        else {
            _loc7_ = SMALL_TEXT_VAL;
            _loc8_ = _loc1_.toString() + "-" + _loc2_.toString();
        }
        var _loc9_:TextFormat = levelLabel.getTextFormat();
        _loc9_.size = _loc7_;
        levelLabel.setTextFormat(_loc9_);
        levelLabel.text = _loc8_ + "%";
    }

    override public function set level(param1:Number):void {
        if (_level == param1) {
            return;
        }
        _level = param1;
        this.updateLevelLabel();
    }

    public function set currentVehicleType(param1:String):void {
        this._currentVehicleType = param1;
    }

    public function set crewInfo(param1:IDataProvider):void {
        this._crewInfo = param1;
    }

    public function set currentVehicleIntCD(param1:int):void {
        this._currentVehicleIntCD = param1;
    }
}
}
