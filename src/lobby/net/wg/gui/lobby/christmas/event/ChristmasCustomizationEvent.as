package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasCustomizationEvent extends Event {

    public static const SHOW_CONVERSION:String = "showConversion";

    public static const EMPTY_LIST_BTN_CLICK:String = "emptyListButtonClick";

    public function ChristmasCustomizationEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
