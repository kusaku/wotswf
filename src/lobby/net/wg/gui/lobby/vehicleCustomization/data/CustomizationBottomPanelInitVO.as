package net.wg.gui.lobby.vehicleCustomization.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBuyingPanelInitVO;

public class CustomizationBottomPanelInitVO extends DAAPIDataClass {

    private static const PRICE_PANEL_VO_FIELD:String = "pricePanelVO";

    public var backBtnLabel:String = "";

    public var backBtnDescription:String = "";

    private var _pricePanelVO:CustomizationBuyingPanelInitVO = null;

    public function CustomizationBottomPanelInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == PRICE_PANEL_VO_FIELD) {
            this._pricePanelVO = new CustomizationBuyingPanelInitVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this._pricePanelVO.dispose();
        this._pricePanelVO = null;
        super.onDispose();
    }

    public function get pricePanelVO():CustomizationBuyingPanelInitVO {
        return this._pricePanelVO;
    }
}
}
