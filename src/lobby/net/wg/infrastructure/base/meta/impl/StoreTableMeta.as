package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class StoreTableMeta extends BaseDAAPIComponent {

    public var refreshStoreTableDataProvider:Function;

    public function StoreTableMeta() {
        super();
    }

    public function refreshStoreTableDataProviderS():void {
        App.utils.asserter.assertNotNull(this.refreshStoreTableDataProvider, "refreshStoreTableDataProvider" + Errors.CANT_NULL);
        this.refreshStoreTableDataProvider();
    }
}
}
