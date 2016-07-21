package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IProfileSummaryWindowMeta extends IEventDispatcher {

    function openClanStatisticS():void;

    function openClubProfileS(param1:Number):void;

    function as_setClanData(param1:Object):void;

    function as_setClubData(param1:Object):void;

    function as_setClanEmblem(param1:String):void;

    function as_setClubEmblem(param1:String):void;
}
}
