package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class OrderSelectPopoverVO extends DAAPIDataClass {

    private static const ORDERS:String = "orders";

    public var orders:Array;

    public function OrderSelectPopoverVO(param1:Object) {
        this.orders = [];
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        var _loc4_:OrderSelectRendererVO = null;
        if (param1 == ORDERS) {
            for each(_loc3_ in param2) {
                _loc4_ = new OrderSelectRendererVO(_loc3_);
                this.orders.push(_loc4_);
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.orders) {
            this.orders.splice(0, this.orders.length);
            this.orders = null;
        }
        super.onDispose();
    }
}
}
