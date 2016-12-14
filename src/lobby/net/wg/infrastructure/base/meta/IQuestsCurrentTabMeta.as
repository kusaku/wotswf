package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IQuestsCurrentTabMeta extends IEventDispatcher {

    function sortS(param1:int, param2:Boolean):void;

    function getSortedTableDataS(param1:Object):Array;

    function getQuestInfoS(param1:String):void;

    function collapseS(param1:String):void;

    function as_showNoData(param1:String):void;

    function as_showWaiting(param1:Boolean):void;

    function as_showNoSelect():void;

    function as_updateQuestInfo(param1:Object):void;

    function as_setSelectedQuest(param1:String):void;
}
}
