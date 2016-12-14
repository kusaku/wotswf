package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.lobby.christmas.data.ChristmasFiltersVO;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.events.InputEvent;

public interface IChristmasSlots extends IDisposable, IViewStackContent, IFocusChainContainer {

    function getDropActors():Vector.<IChristmasDropActor>;

    function setData(param1:SlotsDataVO):void;

    function setStaticData(param1:SlotsStaticDataVO):void;

    function updateSlot(param1:SlotVO):void;

    function setFilters(param1:ChristmasFiltersVO, param2:ChristmasFiltersVO):void;

    function handleInput(param1:InputEvent):void;
}
}
