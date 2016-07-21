package net.wg.gui.lobby.store.shop {
import flash.display.InteractiveObject;

import net.wg.data.constants.Linkages;
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
        storeTable.addEventListener(StoreEvent.BUY, this.onBuyItemHandler);
    }

    override protected function onDispose():void {
        form.storeTable.removeEventListener(StoreEvent.BUY, this.onBuyItemHandler);
        super.onDispose();
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

    private function onBuyItemHandler(param1:StoreEvent):void {
        buyItemS(param1.data);
        param1.stopImmediatePropagation();
    }
}
}
