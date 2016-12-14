package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasProgressBarEvent extends Event {

    public static const SHOW_RULES:String = "christmasProgressBarShowRules";

    public function ChristmasProgressBarEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }

    override public function clone():Event {
        return new ChristmasProgressBarEvent(type, bubbles, cancelable);
    }
}
}
