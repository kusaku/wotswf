package net.wg.gui.battle.views.minimap.events {
import flash.events.Event;

public class MinimapEvent extends Event {

    public static const SIZE_CHANGED:String = "minimapSizeChanged";

    public static const VISIBILITY_CHANGED:String = "minimapVisibilityChanged";

    public function MinimapEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }

    override public function clone():Event {
        return new MinimapEvent(type, bubbles, cancelable);
    }
}
}
