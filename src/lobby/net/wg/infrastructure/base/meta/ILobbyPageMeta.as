package net.wg.infrastructure.base.meta {
import flash.events.IEventDispatcher;

public interface ILobbyPageMeta extends IEventDispatcher {

    function moveSpaceS(param1:Number, param2:Number, param3:Number):void;

    function getSubContainerTypeS():String;

    function notifyCursorOver3dSceneS(param1:Boolean):void;

    function as_showHelpLayout():void;

    function as_closeHelpLayout():void;
}
}
