package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IAccountPopoverMeta extends IEventDispatcher {

    function openBoostersWindowS(param1:String):void;

    function openClanResearchS():void;

    function openRequestWindowS():void;

    function openInviteWindowS():void;

    function openClanStatisticS():void;

    function openCrewStatisticS():void;

    function openReferralManagementS():void;

    function as_setData(param1:Object):void;

    function as_setClanData(param1:Object):void;

    function as_setCrewData(param1:Object):void;

    function as_setClanEmblem(param1:String):void;

    function as_setCrewEmblem(param1:String):void;

    function as_setReferralData(param1:Object):void;
}
}
