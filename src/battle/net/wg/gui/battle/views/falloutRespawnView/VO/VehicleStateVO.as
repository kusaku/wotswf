package net.wg.gui.battle.views.falloutRespawnView.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VehicleStateVO extends DAAPIDataClass {

    public var enabled:Boolean = false;

    public var selected:Boolean = false;

    public var cooldown:String = "";

    public var vehicleID:int = -1;

    public function VehicleStateVO(param1:Object) {
        super(param1);
    }
}
}
