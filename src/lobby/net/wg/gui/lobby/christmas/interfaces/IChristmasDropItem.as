package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.infrastructure.interfaces.entity.IDropItem;

public interface IChristmasDropItem extends IDropItem {

    function get decorationInfo():DecorationInfoVO;

    function get enabled():Boolean;
}
}
