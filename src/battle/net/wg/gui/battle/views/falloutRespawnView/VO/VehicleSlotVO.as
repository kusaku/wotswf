package net.wg.gui.battle.views.falloutRespawnView.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VehicleSlotVO extends DAAPIDataClass {

    public var flagIcon:String = "";

    public var vehicleIcon:String = "";

    public var vehicleType:String = "";

    public var vehicleLevel:String = "";

    public var vehicleName:String = "";

    public var vehicleID:int = -1;

    public var isElite:Boolean = false;

    public var isPremium:Boolean = false;

    public function VehicleSlotVO(param1:Object) {
        super(param1);
    }
}
}
