package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface ISlotsStaticDataMap extends IDisposable {

    function getSlotsStaticData(param1:String):SlotsStaticDataVO;
}
}
