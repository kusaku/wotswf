package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IQuestsTabMeta extends IEventDispatcher {

    function as_setQuestsData(param1:Object):void;

    function as_setSelectedQuest(param1:String):void;
}
}
