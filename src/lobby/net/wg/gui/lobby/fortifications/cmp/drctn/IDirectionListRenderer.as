package net.wg.gui.lobby.fortifications.cmp.drctn {
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IDirectionListRenderer extends IUIComponentEx {

    function setData(param1:DirectionVO):void;
}
}
