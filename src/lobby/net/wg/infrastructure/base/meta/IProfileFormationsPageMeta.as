package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IProfileFormationsPageMeta extends IEventDispatcher {

    function showFortS():void;

    function searchStaticTeamsS():void;

    function createFortS():void;

    function showTeamS(param1:int):void;

    function onClanLinkNavigateS(param1:String):void;

    function as_setClanInfo(param1:Object):void;

    function as_setClubInfo(param1:Object):void;

    function as_setFortInfo(param1:Object):void;

    function as_setClubHistory(param1:Array):void;

    function as_setClanEmblem(param1:String):void;

    function as_setClubEmblem(param1:String):void;
}
}
