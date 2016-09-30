package net.wg.gui.lobby.vehicleCompare.data {
import flash.events.Event;
import flash.utils.Dictionary;

import net.wg.data.ListDAAPIDataProvider;

import scaleform.clik.interfaces.IDataProvider;

public class VehCompareDataProvider extends ListDAAPIDataProvider {

    private var _vehParamsDP:IDataProvider;

    public function VehCompareDataProvider(param1:Class) {
        super(param1);
        addEventListener(Event.CHANGE, this.onChangeHandler);
    }

    override public function as_dispose():void {
        removeEventListener(Event.CHANGE, this.onChangeHandler);
        this._vehParamsDP.removeEventListener(Event.CHANGE, this.onVehParamsDPChangeHandler);
        this._vehParamsDP = null;
        super.as_dispose();
    }

    override public function requestItemRange(param1:int, param2:int, param3:Function = null):Array {
        if (isDAAPIInited && !isValid) {
            super.requestItemRange(0, length, this.onRequestItemRangeHandler);
        }
        return super.requestItemRange(param1, param2, param3);
    }

    public function setVehParamsDP(param1:IDataProvider):void {
        this._vehParamsDP = param1;
        this._vehParamsDP.addEventListener(Event.CHANGE, this.onVehParamsDPChangeHandler);
        this.requestItemRange(0, length, this.onRequestItemRangeHandler);
    }

    private function onRequestItemRangeHandler(param1:Array):void {
        var _loc2_:Dictionary = null;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:VehCompareVehicleVO = null;
        if (this._vehParamsDP && this._vehParamsDP.length > 0) {
            _loc2_ = this.createParamsVisibilityDict();
            _loc3_ = param1.length;
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc5_ = VehCompareVehicleVO(param1[_loc4_]);
                this.applyVisibilityToParam(_loc2_, _loc5_);
                _loc5_.removeEventListener(Event.CHANGE, this.onVehParamVOChangeHandler);
                _loc5_.addEventListener(Event.CHANGE, this.onVehParamVOChangeHandler, false, 0, true);
                _loc4_++;
            }
        }
    }

    private function createParamsVisibilityDict():Dictionary {
        var _loc2_:VehCompareParamVO = null;
        var _loc1_:Dictionary = new Dictionary();
        for each(_loc2_ in this._vehParamsDP) {
            _loc1_[_loc2_.paramID] = true;
        }
        return _loc1_;
    }

    private function applyVisibilityToParam(param1:Dictionary, param2:VehCompareVehicleVO):void {
        var _loc3_:VehParamsDataVO = null;
        var _loc4_:Boolean = false;
        for each(_loc3_ in param2.params) {
            _loc4_ = param1[_loc3_.paramID];
            _loc3_.isVisible = _loc4_;
        }
    }

    private function onVehParamVOChangeHandler(param1:Event):void {
        var _loc2_:Dictionary = this.createParamsVisibilityDict();
        this.applyVisibilityToParam(_loc2_, VehCompareVehicleVO(param1.target));
    }

    private function onChangeHandler(param1:Event):void {
        this.requestItemRange(0, length, this.onRequestItemRangeHandler);
    }

    private function onVehParamsDPChangeHandler(param1:Event):void {
        dispatchEvent(new Event(Event.CHANGE));
    }
}
}
