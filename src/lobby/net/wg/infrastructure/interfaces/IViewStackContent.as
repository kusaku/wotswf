package net.wg.infrastructure.interfaces {
import net.wg.infrastructure.interfaces.entity.IFocusContainer;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

public interface IViewStackContent extends IUpdatable, IFocusContainer {

    function canShowAutomatically():Boolean;
}
}
