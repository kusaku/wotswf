package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ITutorialHangarQuestDetailsMeta extends IEventDispatcher {

    function requestQuestInfoS(param1:String):void;

    function showTipS(param1:String, param2:String):void;

    function getSortedTableDataS(param1:Object):Object;

    function as_updateQuestInfo(param1:Object):void;
}
}
