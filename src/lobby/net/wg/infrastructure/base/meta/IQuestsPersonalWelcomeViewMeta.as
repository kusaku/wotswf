package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IQuestsPersonalWelcomeViewMeta extends IEventDispatcher {

    function successS():void;

    function as_setData(param1:Object):void;

    function as_showMiniClientInfo(param1:String, param2:String):void;
}
}
