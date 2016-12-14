package net.wg.gui.lobby.christmas.interfaces {
import net.wg.gui.lobby.christmas.data.ProgressBarVO;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

public interface IChristmasProgressBar extends IUIComponentEx, IFocusChainContainer, IFocusContainer {

    function setData(param1:ProgressBarVO):void;
}
}
