package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFortPeriodDefenceWindowMeta extends IEventDispatcher {

    function onApplyS(param1:Object):void;

    function onCancelS():void;

    function as_setData(param1:Object):void;

    function as_setInitData(param1:Object):void;
}
}
