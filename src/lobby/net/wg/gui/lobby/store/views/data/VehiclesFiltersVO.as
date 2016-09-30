package net.wg.gui.lobby.store.views.data {
public class VehiclesFiltersVO extends FiltersVO {

    private static const VEHICLE_TYPE_FIELD_NAME:String = "vehicleType";

    public var vehicleType:String = "";

    public function VehiclesFiltersVO(param1:Object) {
        super(param1);
    }

    override protected function onDataRead(param1:String, param2:Object):Boolean {
        if (param1 == VEHICLE_TYPE_FIELD_NAME) {
            param2[param1] = this.vehicleType;
            return false;
        }
        return super.onDataRead(param1, param2);
    }
}
}
