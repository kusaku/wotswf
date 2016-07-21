package net.wg.gui.lobby.store.inventory {
import net.wg.data.VO.StoreTableData;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;

public class InventoryVehicleListItemRdr extends InventoryListItemRenderer {

    public var vehicleIcon:TankIcon = null;

    public function InventoryVehicleListItemRdr() {
        super();
    }

    override protected function update():void {
        var _loc1_:StoreTableData = null;
        super.update();
        if (data) {
            _loc1_ = StoreTableData(data);
            this.updateVehicleIcon(_loc1_);
        }
    }

    private function updateVehicleIcon(param1:StoreTableData):void {
        getHelper().initVehicleIcon(this.vehicleIcon, param1);
    }
}
}
