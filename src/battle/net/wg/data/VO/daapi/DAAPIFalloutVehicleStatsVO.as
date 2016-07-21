package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIFalloutVehicleStatsVO extends DAAPIDataClass {

    public var isEnemy:Boolean = false;

    public var winPoints:int = -1;

    public var vehicleID:Number = -1;

    public var frags:Number = -1;

    public var deaths:Number = -1;

    public var damage:Number = -1;

    public var specialPoints:Number = -1;

    public function DAAPIFalloutVehicleStatsVO(param1:Object) {
        super(param1);
    }
}
}
