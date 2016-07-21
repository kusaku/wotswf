package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFortIntelligenceWindowMeta extends IEventDispatcher {

    function requestClanFortInfoS(param1:int):void;

    function as_setStatusText(param1:String):void;

    function as_getSearchDP():Object;

    function as_getCurrentListIndex():int;

    function as_selectByIndex(param1:int):void;

    function as_setTableHeader(param1:Object):void;
}
}
