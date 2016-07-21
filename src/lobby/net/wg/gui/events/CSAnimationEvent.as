package net.wg.gui.events {
import flash.events.Event;

public class CSAnimationEvent extends Event {

    public static const ANIMATIONS_LOADED:String = "animationsLoaded";

    public static const ANIMATIONS_LOAD_ERROR:String = "animationsLoadError";

    public static const APPLY_BTN_CLICK:String = "applyBtnClick";

    public function CSAnimationEvent(param1:String) {
        super(param1, true, true);
    }
}
}
