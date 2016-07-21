package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IStaticFormationInvitesAndRequestsMeta extends IEventDispatcher {

    function setDescriptionS(param1:String):void;

    function setShowOnlyInvitesS(param1:Boolean):void;

    function resolvePlayerRequestS(param1:int, param2:Boolean):void;

    function as_getDataProvider():Object;

    function as_setStaticData(param1:Object):void;

    function as_setTeamDescription(param1:String):void;
}
}
