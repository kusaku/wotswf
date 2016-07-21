package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IStaticFormationLadderViewMeta extends IEventDispatcher {

    function showFormationProfileS(param1:Number):void;

    function updateClubIconsS(param1:Array):void;

    function as_updateHeaderData(param1:Object):void;

    function as_updateLadderData(param1:Object):void;

    function as_setLadderState(param1:Object):void;

    function as_onUpdateClubIcons(param1:Object):void;

    function as_onUpdateClubIcon(param1:Number, param2:String):void;
}
}
