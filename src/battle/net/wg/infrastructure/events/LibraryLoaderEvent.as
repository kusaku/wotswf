package net.wg.infrastructure.events {
import flash.display.Loader;
import flash.events.Event;

public class LibraryLoaderEvent extends Event {

    public static const LOADED:String = "libLoaded";

    public static const LOADED_COMPLETED:String = "libsLoadedCompleted";

    public var loader:Loader;

    public var url:String;

    public function LibraryLoaderEvent(param1:String, param2:Loader, param3:String, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this.loader = param2;
        this.url = param3;
    }

    override public function clone():Event {
        return new LibraryLoaderEvent(type, this.loader, this.url, bubbles, cancelable);
    }

    override public function toString():String {
        return formatToString("LibraryLoaderEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}
}
