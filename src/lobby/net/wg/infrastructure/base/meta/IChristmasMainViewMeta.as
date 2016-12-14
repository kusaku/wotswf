package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IChristmasMainViewMeta extends IEventDispatcher {

    function installItemS(param1:int, param2:int):void;

    function moveItemS(param1:int, param2:int):void;

    function uninstallItemS(param1:int):void;

    function showConversionS():void;

    function switchOffNewItemS(param1:int):void;

    function applyRankFilterS(param1:int):void;

    function applyTypeFilterS(param1:int):void;

    function onChangeTabS(param1:String):void;

    function onEmptyListBtnClickS():void;

    function closeWindowS():void;

    function showRulesS():void;

    function switchCameraS():void;

    function convertItemsS():void;

    function cancelConversionS():void;

    function onConversionAnimationCompleteS():void;

    function as_setStaticData(param1:Object):void;

    function as_setFilters(param1:Object, param2:Object):void;

    function as_setProgress(param1:Object):void;

    function as_selectSlotsTab(param1:int):void;

    function as_showSlotsView(param1:String):void;

    function as_setSlotsData(param1:Object):void;

    function as_updateSlot(param1:Object):void;

    function as_scrollToItem(param1:int):void;

    function as_getDecorationsDP():Object;

    function as_setEmptyListData(param1:Boolean, param2:Object):void;

    function as_updateConversionBtn(param1:Boolean, param2:String):void;
}
}
