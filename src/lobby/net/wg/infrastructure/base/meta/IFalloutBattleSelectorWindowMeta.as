package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface IFalloutBattleSelectorWindowMeta extends IEventDispatcher {

    function onDominationBtnClickS():void;

    function onMultiteamBtnClickS():void;

    function onSelectCheckBoxAutoSquadS(param1:Boolean):void;

    function getClientIDS():Number;

    function as_setInitData(param1:Object):void;

    function as_setBtnStates(param1:Object):void;

    function as_setTooltips(param1:Object):void;
}
}
