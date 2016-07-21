package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ICustomizationBuyWindowMeta extends IEventDispatcher {

    function buyS():void;

    function selectItemS(param1:uint):void;

    function deselectItemS(param1:uint):void;

    function changePriceItemS(param1:uint, param2:uint):void;

    function as_getPurchaseDP():Object;

    function as_setInitData(param1:Object):void;

    function as_setTotalData(param1:Object):void;
}
}
