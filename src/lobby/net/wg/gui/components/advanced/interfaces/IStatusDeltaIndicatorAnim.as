package net.wg.gui.components.advanced.interfaces {
import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IStatusDeltaIndicatorAnim extends IUIComponentEx {

    function setData(param1:StatusDeltaIndicatorVO):void;
}
}
