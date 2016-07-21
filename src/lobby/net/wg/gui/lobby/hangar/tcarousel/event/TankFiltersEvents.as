package net.wg.gui.lobby.hangar.tcarousel.event {
import flash.events.Event;

public class TankFiltersEvents extends Event {

    public static const FILTER_RESET:String = "refreshFilter";

    public function TankFiltersEvents(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }

    override public function clone():Event {
        return new TankFiltersEvents(type, bubbles, cancelable);
    }
}
}
