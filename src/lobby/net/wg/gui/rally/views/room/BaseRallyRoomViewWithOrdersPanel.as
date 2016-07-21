package net.wg.gui.rally.views.room {
import flash.display.MovieClip;

import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.ORDER_TYPES;
import net.wg.gui.components.controls.events.SlotsPanelEvent;
import net.wg.gui.lobby.fortifications.cmp.orders.impl.OrdersPanel;
import net.wg.infrastructure.exceptions.AbstractException;

public class BaseRallyRoomViewWithOrdersPanel extends BaseRallyRoomViewWithWaiting {

    private static const ORDERS_PANEL_OFFSET:int = 7;

    public var ordersPanel:OrdersPanel = null;

    public var ordersBg:MovieClip = null;

    public function BaseRallyRoomViewWithOrdersPanel() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.ordersPanel.addEventListener(SlotsPanelEvent.ON_DATA_SET, this.onOrdersPanelDataSetHandler);
        this.ordersPanel.addEventListener(SlotsPanelEvent.NEED_REPOSITION, this.onOrdersPanelNeedRepositionHandler);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.registerOrdersPanel();
    }

    override protected function onDispose():void {
        this.ordersPanel.removeEventListener(SlotsPanelEvent.ON_DATA_SET, this.onOrdersPanelDataSetHandler);
        this.ordersPanel.removeEventListener(SlotsPanelEvent.NEED_REPOSITION, this.onOrdersPanelNeedRepositionHandler);
        this.ordersPanel = null;
        this.ordersBg = null;
        super.onDispose();
    }

    protected function registerOrdersPanel():void {
        throw new AbstractException("registerOrdersPanel " + Errors.ABSTRACT_INVOKE);
    }

    private function onOrdersPanelDataSetHandler(param1:SlotsPanelEvent):void {
        this.ordersPanel.redrawSlots(ORDER_TYPES.FORT_ORDER_CONSUMABLES_GROUP, true);
    }

    private function onOrdersPanelNeedRepositionHandler(param1:SlotsPanelEvent):void {
        this.ordersPanel.x = this.width - this.ordersPanel.actualWidth - ORDERS_PANEL_OFFSET ^ 0;
    }
}
}
