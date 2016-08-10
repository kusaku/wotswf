package net.wg.gui.lobby.battleResults.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VehicleStatsVO extends DAAPIDataClass {

    public var tankIcon:String = "";

    public var killerID:int = -1;

    public var isPrematureLeave:Boolean = false;

    public var flag:String = "";

    public var vehicleStateStr:String = "";

    public var vehicleStatePrefixStr:String = "";

    public var vehicleStateSuffixStr:String = "";

    public var killerFullNameStr:String = "";

    public var killerNameStr:String = "";

    public var killerClanNameStr:String = "";

    public var killerRegionNameStr:String = "";

    public function VehicleStatsVO(param1:Object) {
        super(param1);
    }
}
}
