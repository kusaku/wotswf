package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IDestroyTimersPanelMeta extends IEventDispatcher {

    function as_show(param1:int, param2:int):void;

    function as_hide(param1:int):void;

    function as_setTimeInSeconds(param1:int, param2:int, param3:Number):void;

    function as_setTimeSnapshot(param1:int, param2:int, param3:Number):void;

    function as_setSpeed(param1:Number):void;
}
}
