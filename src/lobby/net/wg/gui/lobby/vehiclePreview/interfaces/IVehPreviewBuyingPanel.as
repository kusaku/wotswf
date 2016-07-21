package net.wg.gui.lobby.vehiclePreview.interfaces {
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewPriceDataVO;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IVehPreviewBuyingPanel extends IDisposable, IUIComponentEx {

    function updatePrice(param1:VehPreviewPriceDataVO):void;

    function updateBuyButton(param1:Boolean, param2:String):void;

    function get buyBtn():ISoundButtonEx;
}
}
