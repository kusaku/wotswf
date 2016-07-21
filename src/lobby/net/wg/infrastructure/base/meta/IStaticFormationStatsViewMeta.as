package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IStaticFormationStatsViewMeta extends IEventDispatcher {

    function selectSeasonS(param1:int):void;

    function as_setData(param1:Object):void;

    function as_setStats(param1:Object):void;
}
}
