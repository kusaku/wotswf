package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ITankCarouselMeta extends IEventDispatcher {

    function selectVehicleS(param1:int):void;

    function buyTankS():void;

    function buySlotS():void;

    function setFilterS(param1:int):void;

    function resetFiltersS():void;

    function updateHotFiltersS():void;

    function as_getDataProvider():Object;

    function as_setCarouselFilter(param1:Object):void;

    function as_initCarouselFilter(param1:Object):void;

    function as_showCounter(param1:String, param2:Boolean):void;

    function as_rowCount(param1:int):void;

    function as_hideCounter():void;

    function as_blinkCounter():void;
}
}
