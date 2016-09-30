package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.store.StoreComponent;

public class ShopMeta extends StoreComponent {

    public var buyItem:Function;

    public function ShopMeta() {
        super();
    }

    public function buyItemS(param1:String):void {
        App.utils.asserter.assertNotNull(this.buyItem, "buyItem" + Errors.CANT_NULL);
        this.buyItem(param1);
    }
}
}
