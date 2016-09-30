package net.wg.gui.lobby.store.shop {
import flash.display.InteractiveObject;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.STORE_CONSTANTS;
import net.wg.gui.lobby.store.StoreEvent;
import net.wg.infrastructure.base.meta.IShopMeta;
import net.wg.infrastructure.base.meta.impl.ShopMeta;
import net.wg.infrastructure.interfaces.IViewStackContent;

public class Shop extends ShopMeta implements IShopMeta, IViewStackContent {

    public function Shop() {
        super();
    }

    override protected function getLocalizator():Function {
        return MENU.shop_menu;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        storeTable.addEventListener(StoreEvent.BUY, this.onStoreTableBuyHandler);
    }

    override protected function onDispose():void {
        storeTable.removeEventListener(StoreEvent.BUY, this.onStoreTableBuyHandler);
        super.onDispose();
    }

    override protected function getLinkageFromFittingType(param1:String):String {
        if (param1 == STORE_CONSTANTS.VEHICLE) {
            return Linkages.SHOP_ACCORDION_VEHICLE_VIEW;
        }
        return super.getLinkageFromFittingType(param1);
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return form;
    }

    public function update(param1:Object):void {
    }

    override protected function get moduleItemRendererLinkage():String {
        return Linkages.SHOP_MODULE_ITEM_RENDERER;
    }

    override protected function get vehicleItemRendererLinkage():String {
        return Linkages.SHOP_VEHICLE_ITEM_RENDERER;
    }

    private function onStoreTableBuyHandler(param1:StoreEvent):void {
        buyItemS(param1.itemCD);
        param1.stopImmediatePropagation();
    }
}
}
