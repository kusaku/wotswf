package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class RecruitParametersMeta extends BaseDAAPIComponent {

    public var onNationChanged:Function;

    public var onVehicleClassChanged:Function;

    public var onVehicleChanged:Function;

    public var onTankmanRoleChanged:Function;

    public function RecruitParametersMeta() {
        super();
    }

    public function onNationChangedS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onNationChanged, "onNationChanged" + Errors.CANT_NULL);
        this.onNationChanged(param1);
    }

    public function onVehicleClassChangedS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onVehicleClassChanged, "onVehicleClassChanged" + Errors.CANT_NULL);
        this.onVehicleClassChanged(param1);
    }

    public function onVehicleChangedS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onVehicleChanged, "onVehicleChanged" + Errors.CANT_NULL);
        this.onVehicleChanged(param1);
    }

    public function onTankmanRoleChangedS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onTankmanRoleChanged, "onTankmanRoleChanged" + Errors.CANT_NULL);
        this.onTankmanRoleChanged(param1);
    }
}
}
