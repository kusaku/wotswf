package net.wg.infrastructure.managers.impl.tutorial {
import flash.events.Event;

public class TriggerEvent extends Event {

    public static const TRIGGER_ACTIVATED:String = "triggerActivated";

    public function TriggerEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
