package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IPrebattleTimerMeta extends IEventDispatcher {

    function as_setTimer(param1:int):void;

    function as_setMessage(param1:String):void;

    function as_hideTimer():void;

    function as_hideAll(param1:int):void;

    function as_setWinConditionText(param1:String):void;
}
}
