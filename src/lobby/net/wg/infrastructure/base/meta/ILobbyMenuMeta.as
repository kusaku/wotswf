package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ILobbyMenuMeta extends IEventDispatcher {

    function settingsClickS():void;

    function cancelClickS():void;

    function refuseTrainingS():void;

    function logoffClickS():void;

    function quitClickS():void;

    function versionInfoClickS():void;

    function onCounterNeedUpdateS():void;

    function as_setVersionMessage(param1:Object):void;

    function as_setSettingsBtnCounter(param1:String):void;

    function as_removeSettingsBtnCounter():void;
}
}
