package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
import net.wg.gui.lobby.modulesPanel.ModulesPanel;
import net.wg.infrastructure.exceptions.AbstractException;

public class AmmunitionPanelMeta extends ModulesPanel {

    public var showTechnicalMaintenance:Function;

    public var showCustomization:Function;

    public var toRentContinue:Function;

    private var _vehicleMessageVO:VehicleMessageVO;

    public function AmmunitionPanelMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._vehicleMessageVO) {
            this._vehicleMessageVO.dispose();
            this._vehicleMessageVO = null;
        }
        super.onDispose();
    }

    public function showTechnicalMaintenanceS():void {
        App.utils.asserter.assertNotNull(this.showTechnicalMaintenance, "showTechnicalMaintenance" + Errors.CANT_NULL);
        this.showTechnicalMaintenance();
    }

    public function showCustomizationS():void {
        App.utils.asserter.assertNotNull(this.showCustomization, "showCustomization" + Errors.CANT_NULL);
        this.showCustomization();
    }

    public function toRentContinueS():void {
        App.utils.asserter.assertNotNull(this.toRentContinue, "toRentContinue" + Errors.CANT_NULL);
        this.toRentContinue();
    }

    public function as_updateVehicleStatus(param1:Object):void {
        if (this._vehicleMessageVO) {
            this._vehicleMessageVO.dispose();
        }
        this._vehicleMessageVO = new VehicleMessageVO(param1);
        this.updateVehicleStatus(this._vehicleMessageVO);
    }

    protected function updateVehicleStatus(param1:VehicleMessageVO):void {
        var _loc2_:String = "as_updateVehicleStatus" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
