package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ICustomizationMainViewMeta extends IEventDispatcher {

    function showBuyWindowS():void;

    function closeWindowS():void;

    function installCustomizationElementS(param1:int):void;

    function goToTaskS(param1:int):void;

    function removeFromShoppingBasketS(param1:int, param2:int, param3:int):void;

    function changeCarouselFilterS():void;

    function setDurationTypeS(param1:int):void;

    function showPurchasedS(param1:Boolean):void;

    function removeSlotS(param1:int, param2:int):void;

    function revertSlotS(param1:int, param2:int):void;

    function showGroupS(param1:int, param2:int):void;

    function backToSelectorGroupS():void;

    function as_showBuyingPanel():void;

    function as_hideBuyingPanel():void;

    function as_setHeaderData(param1:Object):void;

    function as_setBonusPanelData(param1:Object):void;

    function as_setCarouselData(param1:Object):void;

    function as_setCarouselInit(param1:Object):void;

    function as_setCarouselFilterData(param1:Object):void;

    function as_setBottomPanelHeader(param1:Object):void;

    function as_setSlotsPanelData(param1:Object):void;

    function as_showSelectorItem(param1:int):void;

    function as_showSelectorGroup():void;

    function as_updateSlot(param1:Object):void;

    function as_setBottomPanelInitData(param1:Object):void;
}
}
