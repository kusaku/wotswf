package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFlagNotificationMeta extends IEventDispatcher {

    function as_setState(param1:String):void;

    function as_setActive(param1:Boolean):void;
}
}
