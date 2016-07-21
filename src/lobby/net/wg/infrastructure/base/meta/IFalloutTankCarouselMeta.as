package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFalloutTankCarouselMeta extends IEventDispatcher {

    function changeVehicleS(param1:int):void;

    function clearSlotS(param1:int):void;

    function shiftSlotS(param1:int):void;

    function as_setMultiselectionInfo(param1:Object):void;

    function as_getMultiselectionDP():Object;
}
}
