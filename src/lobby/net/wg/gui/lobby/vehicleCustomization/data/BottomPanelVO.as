package net.wg.gui.lobby.vehicleCustomization.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBuyingPanelVO;

public class BottomPanelVO extends DAAPIDataClass {

    private static const PRICE_PANEL:String = "pricePanel";

    public var newHeaderText:String = "";

    public var buyBtnLabel:String = "";

    private var _pricePanel:CustomizationBuyingPanelVO = null;

    public function BottomPanelVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case PRICE_PANEL:
                this._pricePanel = new CustomizationBuyingPanelVO(param2);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        this._pricePanel.dispose();
        this._pricePanel = null;
        super.onDispose();
    }

    public function get pricePanel():CustomizationBuyingPanelVO {
        return this._pricePanel;
    }
}
}
