package net.wg.gui.lobby.fortifications.popovers.impl {
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.components.popOvers.PopOverConst;
import net.wg.gui.lobby.fortifications.data.OrderSelectPopoverVO;
import net.wg.gui.lobby.fortifications.events.OrderSelectEvent;
import net.wg.infrastructure.base.meta.IFortOrderSelectPopoverMeta;
import net.wg.infrastructure.base.meta.impl.FortOrderSelectPopoverMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class FortOrderSelectPopover extends FortOrderSelectPopoverMeta implements IFortOrderSelectPopoverMeta {

    public var list:SortableTable = null;

    public function FortOrderSelectPopover() {
        super();
    }

    private static function onClosePopoverHandler(param1:OrderSelectEvent):void {
        App.popoverMgr.hide();
    }

    override protected function setData(param1:OrderSelectPopoverVO):void {
        this.list.height = param1.orders.length * this.list.rowHeight + this.list.headerHeight;
        invalidateSize();
        this.list.listDP = new DataProvider(param1.orders);
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
        super.initLayout();
    }

    override protected function configUI():void {
        super.configUI();
        this.list.addEventListener(OrderSelectEvent.ADD_ORDER, this.onAddOrderHandler);
        this.list.addEventListener(OrderSelectEvent.REMOVE_ORDER, this.onRemoveOrderHandler);
        this.list.addEventListener(OrderSelectEvent.CLOSE_POPOVER, onClosePopoverHandler);
    }

    override protected function onDispose():void {
        this.list.removeEventListener(OrderSelectEvent.ADD_ORDER, this.onAddOrderHandler);
        this.list.removeEventListener(OrderSelectEvent.REMOVE_ORDER, this.onRemoveOrderHandler);
        this.list.removeEventListener(OrderSelectEvent.CLOSE_POPOVER, onClosePopoverHandler);
        this.list.dispose();
        this.list = null;
        super.onDispose();
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.SIZE)) {
            setSize(this.list.width, this.list.height + this.list.headerHeight);
        }
        super.draw();
    }

    private function onAddOrderHandler(param1:OrderSelectEvent):void {
        addOrderS(param1.orderID);
        App.popoverMgr.hide();
    }

    private function onRemoveOrderHandler(param1:OrderSelectEvent):void {
        removeOrderS(param1.orderID);
        App.popoverMgr.hide();
    }
}
}
