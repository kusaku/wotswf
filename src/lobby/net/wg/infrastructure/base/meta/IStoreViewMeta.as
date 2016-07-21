package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IStoreViewMeta extends IEventDispatcher {

    function onCloseS():void;

    function onTabChangeS(param1:String):void;

    function as_showStorePage(param1:String):void;

    function as_init(param1:Object):void;
}
}
