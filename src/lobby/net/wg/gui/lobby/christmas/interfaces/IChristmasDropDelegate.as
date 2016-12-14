package net.wg.gui.lobby.christmas.interfaces {
import flash.display.InteractiveObject;

import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.interfaces.entity.IDroppable;

public interface IChristmasDropDelegate extends IDroppable, IDisposable {

    function setDropReceivers(param1:Vector.<InteractiveObject>):void;
}
}
