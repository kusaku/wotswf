package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ICyberSportUnitsListMeta extends IEventDispatcher {

    function getTeamDataS(param1:int):Object;

    function refreshTeamsS():void;

    function filterVehiclesS():void;

    function setTeamFiltersS(param1:Boolean):void;

    function loadPreviousS():void;

    function loadNextS():void;

    function showRallyProfileS(param1:Number):void;

    function searchTeamsS(param1:String):void;

    function as_setDummy(param1:Object):void;

    function as_setDummyVisible(param1:Boolean):void;

    function as_setSearchResultText(param1:String, param2:String, param3:Object):void;

    function as_setHeader(param1:Object):void;

    function as_updateNavigationBlock(param1:Object):void;

    function as_updateRallyIcon(param1:String):void;
}
}
