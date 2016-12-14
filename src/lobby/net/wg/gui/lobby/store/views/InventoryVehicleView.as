package net.wg.gui.lobby.store.views {
public class InventoryVehicleView extends VehicleView {

    public function InventoryVehicleView() {
        super();
    }

    override protected function get isBrokenChkBxEnabled():Boolean {
        return true;
    }
}
}
