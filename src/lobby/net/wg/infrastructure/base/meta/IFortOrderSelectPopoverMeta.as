package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFortOrderSelectPopoverMeta extends IEventDispatcher {

    function addOrderS(param1:int):void;

    function removeOrderS(param1:int):void;

    function as_setData(param1:Object):void;
}
}
