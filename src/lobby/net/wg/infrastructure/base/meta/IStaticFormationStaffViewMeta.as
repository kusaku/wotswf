package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IStaticFormationStaffViewMeta extends IEventDispatcher {

    function showRecriutmentWindowS():void;

    function showInviteWindowS():void;

    function setRecruitmentOpenedS(param1:Boolean):void;

    function removeMeS():void;

    function removeMemberS(param1:Number, param2:String):void;

    function assignOfficerS(param1:Number, param2:String):void;

    function assignPrivateS(param1:Number, param2:String):void;

    function as_setStaticHeaderData(param1:Object):void;

    function as_updateHeaderData(param1:Object):void;

    function as_updateStaffData(param1:Object):void;

    function as_setRecruitmentAvailability(param1:Boolean):void;
}
}
