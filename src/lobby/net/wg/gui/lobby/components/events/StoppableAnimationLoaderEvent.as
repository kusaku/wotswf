package net.wg.gui.lobby.components.events {
import flash.events.Event;

public class StoppableAnimationLoaderEvent extends Event {

    public static const ANIMATION_START:String = "animationStart";

    public static const ANIMATION_END:String = "animationEnd";

    public function StoppableAnimationLoaderEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }

    override public function clone():Event {
        return new StoppableAnimationLoaderEvent(type, bubbles, cancelable);
    }
}
}
