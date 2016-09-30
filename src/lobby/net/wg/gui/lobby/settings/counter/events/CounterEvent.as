package net.wg.gui.lobby.settings.counter.events {
import flash.events.Event;

public class CounterEvent extends Event {

    public static const COUNTER_VISITED:String = "counterVisited";

    public var linkage:String = "";

    public function CounterEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this.linkage = param2;
    }

    override public function clone():Event {
        return new CounterEvent(type, this.linkage, bubbles, cancelable);
    }

    override public function toString():String {
        return formatToString("CounterEvent", "type", "linkage", "bubbles", "cancelable");
    }
}
}
