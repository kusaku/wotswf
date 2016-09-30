package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IVehicleModulesWindowMeta extends IEventDispatcher {

    function onModuleHoverS(param1:Number):void;

    function onModuleClickS(param1:Number):void;

    function onResetBtnBtnClickS():void;

    function onCompareBtnClickS():void;

    function as_setInitData(param1:Object):void;

    function as_setItem(param1:String, param2:Object):void;

    function as_setNodesStates(param1:Array):void;

    function as_setState(param1:String, param2:Boolean):void;

    function as_setAttentionVisible(param1:Boolean):void;
}
}
