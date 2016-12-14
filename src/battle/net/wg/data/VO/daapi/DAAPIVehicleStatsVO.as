package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIVehicleStatsVO extends DAAPIDataClass {

    public var isEnemy:Boolean = false;

    public var vehicleID:Number = -1;

    public var frags:int = -1;

    public function DAAPIVehicleStatsVO(param1:Object = null) {
        super(param1);
    }
}
}
