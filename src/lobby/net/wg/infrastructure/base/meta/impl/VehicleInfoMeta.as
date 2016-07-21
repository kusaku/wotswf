package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class VehicleInfoMeta extends AbstractWindowView {

    public var getVehicleInfo:Function;

    public var onCancelClick:Function;

    public function VehicleInfoMeta() {
        super();
    }

    public function getVehicleInfoS():void {
        App.utils.asserter.assertNotNull(this.getVehicleInfo, "getVehicleInfo" + Errors.CANT_NULL);
        this.getVehicleInfo();
    }

    public function onCancelClickS():void {
        App.utils.asserter.assertNotNull(this.onCancelClick, "onCancelClick" + Errors.CANT_NULL);
        this.onCancelClick();
    }
}
}
