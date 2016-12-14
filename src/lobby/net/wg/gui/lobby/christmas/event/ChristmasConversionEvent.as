package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasConversionEvent extends Event {

    public static const CONVERT_ITEMS:String = "convertItems";

    public static const CANCEL_CONVERSION:String = "cancelConversion";

    public static const ANIMATION_COMPLETE:String = "conversionAnimationComplete";

    public function ChristmasConversionEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
