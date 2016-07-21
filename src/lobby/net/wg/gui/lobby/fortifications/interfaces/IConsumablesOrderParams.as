package net.wg.gui.lobby.fortifications.interfaces {
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

public interface IConsumablesOrderParams extends IUpdatable, IUIComponentEx {

    function getTFWidth():int;

    function getTFHeight():int;
}
}
