package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFortRoomMeta extends IEventDispatcher {

    function showChangeDivisionWindowS():void;

    function as_showLegionariesCount(param1:Boolean, param2:String, param3:String):void;

    function as_showLegionariesToolTip(param1:Boolean):void;

    function as_showOrdersBg(param1:Boolean):void;

    function as_setChangeDivisionButtonEnabled(param1:Boolean):void;
}
}
