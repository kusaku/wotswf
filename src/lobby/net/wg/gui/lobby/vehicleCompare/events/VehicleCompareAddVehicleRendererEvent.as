package net.wg.gui.lobby.vehicleCompare.events {
import flash.events.Event;

public class VehicleCompareAddVehicleRendererEvent extends Event {

    public static const RENDERER_CLICK:String = "RendererClick";

    private var _dbID:int = -1;

    public function VehicleCompareAddVehicleRendererEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._dbID = param2;
    }

    public function get dbID():int {
        return this._dbID;
    }
}
}
