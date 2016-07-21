package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IAbstractViewMeta extends IEventDispatcher {

    function onFocusInS(param1:String):void;

    function as_setupContextHintBuilder(param1:String, param2:Object):void;
}
}
