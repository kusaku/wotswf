package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFittingSelectPopoverMeta extends IEventDispatcher {

    function setVehicleModuleS(param1:Number, param2:Number, param3:Boolean):void;

    function showModuleInfoS(param1:String):void;

    function as_update(param1:Object):void;
}
}
