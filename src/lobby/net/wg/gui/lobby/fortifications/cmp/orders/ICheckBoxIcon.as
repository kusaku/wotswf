package net.wg.gui.lobby.fortifications.cmp.orders {
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

public interface ICheckBoxIcon extends IUpdatable, IUIComponentEx {

    function isSelected():Boolean;

    function isInited():Boolean;
}
}
