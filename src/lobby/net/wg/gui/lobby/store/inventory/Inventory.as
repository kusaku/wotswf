package net.wg.gui.lobby.store.inventory {
import flash.display.InteractiveObject;

import net.wg.data.constants.Linkages;
import net.wg.gui.lobby.store.StoreEvent;
import net.wg.infrastructure.base.meta.IInventoryMeta;
import net.wg.infrastructure.base.meta.impl.InventoryMeta;
import net.wg.infrastructure.interfaces.IViewStackContent;

public class Inventory extends InventoryMeta implements IInventoryMeta, IViewStackContent {

    public function Inventory() {
        super();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        storeTable.addEventListener(StoreEvent.SELL, this.onSellItemHandler);
    }

    override protected function onDispose():void {
        storeTable.removeEventListener(StoreEvent.SELL, this.onSellItemHandler);
        super.onDispose();
    }

    override protected function getLocalizator():Function {
        return MENU.inventory_menu;
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return form;
    }

    public function update(param1:Object):void {
    }

    override protected function get vehicleItemRendererLinkage():String {
        return Linkages.INVENTORY_VEHICLE_ITEM_RENDERER;
    }

    override protected function get moduleItemRendererLinkage():String {
        return Linkages.INVENTORY_MODULE_ITEM_RENDERER;
    }

    private function onSellItemHandler(param1:StoreEvent):void {
        sellItemS(param1.data);
        param1.stopImmediatePropagation();
    }
}
}
