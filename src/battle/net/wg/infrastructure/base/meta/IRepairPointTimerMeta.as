package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IRepairPointTimerMeta extends IEventDispatcher {

    function as_setState(param1:String):void;

    function as_setTimeInSeconds(param1:int):void;

    function as_setTimeString(param1:String):void;

    function as_useActionScriptTimer(param1:Boolean):void;

    function as_hide():void;
}
}
