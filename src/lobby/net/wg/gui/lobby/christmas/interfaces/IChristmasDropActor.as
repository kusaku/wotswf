package net.wg.gui.lobby.christmas.interfaces {
import flash.events.IEventDispatcher;

import net.wg.infrastructure.interfaces.IInteractiveObject;

public interface IChristmasDropActor extends IEventDispatcher, IInteractiveObject {

    function hideHighlight():void;

    function highlightDropping():void;

    function highlightDropHover():void;

    function get slotType():String;

    function get slotId():int;
}
}
