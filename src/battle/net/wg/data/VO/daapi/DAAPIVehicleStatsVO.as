package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIVehicleStatsVO extends DAAPIDataClass {

    public var isEnemy:Boolean = false;

    public var vehicleID:Number = -1;

    public var frags:int = -1;

    public function DAAPIVehicleStatsVO(param1:Object) {
        super(param1);
    }

    public function clone():DAAPIVehicleStatsVO {
        var _loc1_:DAAPIVehicleStatsVO = new DAAPIVehicleStatsVO({});
        _loc1_.isEnemy = this.isEnemy;
        _loc1_.vehicleID = this.vehicleID;
        _loc1_.frags = this.frags;
        return _loc1_;
    }
}
}
