package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IResearchViewMeta extends IEventDispatcher {

    function request4UnlockS(param1:Number, param2:Number, param3:Number, param4:Number):void;

    function request4BuyS(param1:Number):void;

    function request4InfoS(param1:Number, param2:Number):void;

    function request4RestoreS(param1:Number):void;

    function showSystemMessageS(param1:String, param2:String):void;

    function as_setNodesStates(param1:Number, param2:Array):void;

    function as_setNext2Unlock(param1:Array):void;

    function as_setVehicleTypeXP(param1:Array):void;

    function as_setInventoryItems(param1:Array):void;

    function as_useXMLDumping():void;

    function as_setNodeVehCompareData(param1:Array):void;
}
}
