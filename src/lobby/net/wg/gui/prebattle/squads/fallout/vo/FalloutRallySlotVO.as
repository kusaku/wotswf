package net.wg.gui.prebattle.squads.fallout.vo {
import net.wg.gui.rally.vo.RallySlotVO;
import net.wg.gui.rally.vo.VehicleVO;

public class FalloutRallySlotVO extends RallySlotVO {

    private static const VEHICLES_NOTIFY_FIELD:String = "vehiclesNotify";

    private var _selectedVehicles:Vector.<VehicleVO> = null;

    private var _vehiclesNotify:Vector.<String> = null;

    public function FalloutRallySlotVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Number = NaN;
        var _loc5_:int = 0;
        if (param1 == VEHICLES_NOTIFY_FIELD) {
            this.clearVehiclesNotifies();
            this._vehiclesNotify = new Vector.<String>();
            App.utils.asserter.assert(param2 is Array, "[FalloutRallySlotVO], value must be as Array");
            _loc3_ = param2 as Array;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                this._vehiclesNotify.push(_loc3_[_loc5_]);
                _loc5_++;
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function writeSelectedVehicle(param1:Object):void {
        this.clearSelectedVehicles();
        this._selectedVehicles = new Vector.<VehicleVO>();
        App.utils.asserter.assert(param1 is Array, "[FalloutRallySlotVO -> writeSelectedVehicle], value must be as Array");
        var _loc2_:Array = param1 as Array;
        var _loc3_:Number = _loc2_.length;
        var _loc4_:int = 0;
        _loc4_ = 0;
        while (_loc4_ < _loc3_) {
            if (_loc2_[_loc4_]) {
                this._selectedVehicles.push(new VehicleVO(_loc2_[_loc4_]));
            }
            else {
                this._selectedVehicles.push(null);
            }
            _loc4_++;
        }
    }

    override protected function onDispose():void {
        this.clearSelectedVehicles();
        this.clearVehiclesNotifies();
        super.onDispose();
    }

    private function clearVehiclesNotifies():void {
        if (this._vehiclesNotify) {
            this._vehiclesNotify.splice(0, this._vehiclesNotify.length);
            this._vehiclesNotify = null;
        }
    }

    private function clearSelectedVehicles():void {
        var _loc1_:VehicleVO = null;
        if (this._selectedVehicles) {
            while (this._selectedVehicles.length) {
                _loc1_ = this._selectedVehicles.pop();
                if (_loc1_) {
                    _loc1_.dispose();
                }
            }
            this._selectedVehicles = null;
        }
    }

    public function get selectedVehicles():Vector.<VehicleVO> {
        return this._selectedVehicles;
    }

    public function get vehiclesNotify():Vector.<String> {
        return this._vehiclesNotify;
    }

    public function set vehiclesNotify(param1:Vector.<String>):void {
        this._vehiclesNotify = param1;
    }
}
}
