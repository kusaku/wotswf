package net.wg.gui.lobby.vehiclePreview.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VehPreviewBottomPanelVO extends DAAPIDataClass {

    public var isBuyingAvailable:Boolean = true;

    public var buyingLabel:String = "";

    public var modulesLabel:String = "";

    public function VehPreviewBottomPanelVO(param1:Object) {
        super(param1);
    }
}
}
