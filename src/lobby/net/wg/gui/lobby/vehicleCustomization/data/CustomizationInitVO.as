package net.wg.gui.lobby.vehicleCustomization.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBonusPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBuyingPanelInitVO;

public class CustomizationInitVO extends DAAPIDataClass {

    private static const HEADERVO_FIELD:String = "headerVO";

    private static const BUYING_FIELD:String = "buyingPanelInit";

    private static const BONUSPANEL_FIELD:String = "bonusPanelVO";

    private var _headerVO:CustomizationHeaderVO = null;

    private var _buyingPanelInit:CustomizationBuyingPanelInitVO = null;

    private var _bonusPanelVO:CustomizationBonusPanelVO = null;

    public function CustomizationInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case HEADERVO_FIELD:
                this._headerVO = new CustomizationHeaderVO(param2);
                return false;
            case BUYING_FIELD:
                this._buyingPanelInit = new CustomizationBuyingPanelInitVO(param2);
                return false;
            case BONUSPANEL_FIELD:
                this._bonusPanelVO = new CustomizationBonusPanelVO(param2);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        this._headerVO.dispose();
        this._headerVO = null;
        this._bonusPanelVO.dispose();
        this._bonusPanelVO = null;
        this._buyingPanelInit.dispose();
        this._buyingPanelInit = null;
        super.onDispose();
    }

    public function get headerVO():CustomizationHeaderVO {
        return this._headerVO;
    }

    public function get bonusPanelVO():CustomizationBonusPanelVO {
        return this._bonusPanelVO;
    }

    public function get buyingPanelInit():CustomizationBuyingPanelInitVO {
        return this._buyingPanelInit;
    }
}
}
