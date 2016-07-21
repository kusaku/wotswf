package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IQuestsSeasonsViewMeta extends IEventDispatcher {

    function onShowAwardsClickS():void;

    function onTileClickS(param1:int):void;

    function onSlotClickS(param1:int):void;

    function as_setData(param1:Object):void;

    function as_setSeasonsData(param1:Object):void;

    function as_setSlotsData(param1:Object):void;
}
}
