package net.wg.gui.lobby.vehicleCustomization.data.panels {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationTotalBonusPanelVO extends DAAPIDataClass {

    private static const CREW_PANEL_FIELD:String = "crewPanel";

    private static const VISIBILITY_PANEL_FIELD:String = "visibilityPanel";

    private var _crewBonusPanelVO:CustomizationBonusPanelVO = null;

    private var _visibilityBonusPanel:CustomizationBonusPanelVO = null;

    public function CustomizationTotalBonusPanelVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case CREW_PANEL_FIELD:
                this._crewBonusPanelVO = new CustomizationBonusPanelVO(param2);
                return false;
            case VISIBILITY_PANEL_FIELD:
                this._visibilityBonusPanel = new CustomizationBonusPanelVO(param2);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        this._crewBonusPanelVO.dispose();
        this._crewBonusPanelVO = null;
        this._visibilityBonusPanel.dispose();
        this._visibilityBonusPanel = null;
        super.onDispose();
    }

    public function get crewBonusPanelVO():CustomizationBonusPanelVO {
        return this._crewBonusPanelVO;
    }

    public function get visibilityBonusPanel():CustomizationBonusPanelVO {
        return this._visibilityBonusPanel;
    }
}
}
