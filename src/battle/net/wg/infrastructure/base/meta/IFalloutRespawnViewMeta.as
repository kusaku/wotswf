package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFalloutRespawnViewMeta extends IEventDispatcher {

    function onVehicleSelectedS(param1:int):void;

    function onPostmortemBtnClickS():void;

    function as_initialize(param1:Object, param2:Array):void;

    function as_updateTimer(param1:String, param2:Array):void;

    function as_update(param1:String, param2:Array):void;

    function as_showGasAttackMode():void;
}
}
