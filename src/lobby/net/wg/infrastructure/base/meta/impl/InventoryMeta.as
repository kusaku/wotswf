package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.StoreTableData;
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.store.StoreComponent;

public class InventoryMeta extends StoreComponent {

    public var sellItem:Function;

    public function InventoryMeta() {
        super();
    }

    public function sellItemS(param1:StoreTableData):void {
        App.utils.asserter.assertNotNull(this.sellItem, "sellItem" + Errors.CANT_NULL);
        this.sellItem(param1);
    }
}
}
