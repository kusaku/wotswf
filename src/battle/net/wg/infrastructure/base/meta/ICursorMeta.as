package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ICursorMeta extends IEventDispatcher {

    function as_setCursor(param1:String):void;

    function as_showCursor():void;

    function as_hideCursor():void;
}
}
