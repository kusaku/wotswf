package net.wg.gui.lobby.christmas.interfaces {
import flash.events.IEventDispatcher;

import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.infrastructure.interfaces.IDisplayObject;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IChristmasSlot extends IDisplayObject, IDisposable {

    function setData(param1:SlotVO):void;

    function getMouseTarget():IEventDispatcher;

    function get slotId():int;
}
}
