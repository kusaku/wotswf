package net.wg.gui.lobby.vehiclePreview.interfaces {
import net.wg.gui.interfaces.IUpdatableComponent;
import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewPriceDataVO;

public interface IVehPreviewBottomPanel extends IUpdatableComponent {

    function updatePrice(param1:VehPreviewPriceDataVO):void;

    function updateBuyButton(param1:Boolean, param2:String):void;

    function updateVehicleStatus(param1:String):void;

    function get modules():IModulesPanel;

    function get buyingPanel():IVehPreviewBuyingPanel;
}
}
