package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IStaticFormationUnitMeta extends IEventDispatcher {

    function toggleStatusRequestS():void;

    function setRankedModeS(param1:Boolean):void;

    function showTeamCardS():void;

    function as_closeSlot(param1:uint, param2:uint, param3:String):void;

    function as_openSlot(param1:uint, param2:Boolean, param3:String, param4:uint):void;

    function as_setOpened(param1:Boolean, param2:String):void;

    function as_setTotalLabel(param1:Boolean, param2:String, param3:int):void;

    function as_setLegionnairesCount(param1:Boolean, param2:String):void;

    function as_setHeaderData(param1:Object):void;

    function as_setTeamIcon(param1:String):void;
}
}
