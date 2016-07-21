package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ITankCarouselFilterPopoverMeta extends IEventDispatcher {

    function changeFilterS(param1:int, param2:int):void;

    function setDefaultFilterS():void;

    function as_setInitData(param1:Object):void;

    function as_setState(param1:Object):void;

    function as_enableDefBtn(param1:Boolean):void;
}
}
