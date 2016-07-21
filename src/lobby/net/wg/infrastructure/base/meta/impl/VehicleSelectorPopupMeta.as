package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class VehicleSelectorPopupMeta extends AbstractWindowView {

    public var onFiltersUpdate:Function;

    public var onSelectVehicles:Function;

    public function VehicleSelectorPopupMeta() {
        super();
    }

    public function onFiltersUpdateS(param1:int, param2:String, param3:Boolean, param4:int, param5:Boolean):void {
        App.utils.asserter.assertNotNull(this.onFiltersUpdate, "onFiltersUpdate" + Errors.CANT_NULL);
        this.onFiltersUpdate(param1, param2, param3, param4, param5);
    }

    public function onSelectVehiclesS(param1:Array):void {
        App.utils.asserter.assertNotNull(this.onSelectVehicles, "onSelectVehicles" + Errors.CANT_NULL);
        this.onSelectVehicles(param1);
    }
}
}
