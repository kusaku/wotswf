package net.wg.gui.lobby.fortifications.cmp.build {
import net.wg.gui.lobby.fortifications.data.BuildingIndicatorsVO;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IBuildingIndicatorsCmp extends IUIComponentEx {

    function setData(param1:BuildingIndicatorsVO):void;

    function showToolTips(param1:Boolean):void;
}
}
