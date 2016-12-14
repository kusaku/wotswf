package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasAwardRendererEvent extends Event {

    public static const RENDERER_READY:String = "rendererReady";

    public static const SHOW_ANIM_FINISHED:String = "showAnimFinished";

    public function ChristmasAwardRendererEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }

    override public function clone():Event {
        return new ChristmasAwardRendererEvent(type, bubbles, cancelable);
    }

    override public function toString():String {
        return formatToString("ChristmasAwardRendererEvent", "type", "bubbles", "cancelable");
    }
}
}
