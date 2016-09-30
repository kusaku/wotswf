package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IHangarHeaderMeta extends IEventDispatcher {

    function showCommonQuestsS():void;

    function showPersonalQuestsS():void;

    function as_setData(param1:Object):void;
}
}
