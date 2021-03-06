package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFortOrderPopoverMeta extends IEventDispatcher {

    function requestForCreateOrderS():void;

    function requestForUseOrderS():void;

    function getLeftTimeS():Number;

    function getLeftTimeStrS():String;

    function getLeftTimeTooltipS():String;

    function openQuestS(param1:String):void;

    function openOrderDetailsWindowS():void;

    function as_setInitData(param1:Object):void;

    function as_disableOrder(param1:Boolean):void;
}
}
