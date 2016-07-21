package net.wg.gui.lobby.fortifications.intelligence {
import net.wg.infrastructure.base.meta.IFortIntelFilterMeta;
import net.wg.infrastructure.interfaces.IDAAPIComponent;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

public interface IFortIntelFilter extends IPopOverCaller, IUIComponentEx, IFocusContainer, IFortIntelFilterMeta, IDAAPIComponent {

}
}
