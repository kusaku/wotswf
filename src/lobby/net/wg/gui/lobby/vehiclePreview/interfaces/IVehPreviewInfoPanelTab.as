package net.wg.gui.lobby.vehiclePreview.interfaces {
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.IViewStackContent;

public interface IVehPreviewInfoPanelTab extends IViewStackContent, IUIComponentEx {

    function get bottomMargin():int;
}
}
