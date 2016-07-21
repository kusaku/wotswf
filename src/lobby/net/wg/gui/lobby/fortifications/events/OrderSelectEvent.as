package net.wg.gui.lobby.fortifications.events {
import flash.events.Event;

public class OrderSelectEvent extends Event {

    public static const REMOVE_ORDER:String = "removeOrder";

    public static const ADD_ORDER:String = "addOrder";

    public static const CLOSE_POPOVER:String = "closePopover";

    public var orderID:int = -1;

    public function OrderSelectEvent(param1:String, param2:int = -1) {
        super(param1, true, true);
        this.orderID = param2;
    }
}
}
