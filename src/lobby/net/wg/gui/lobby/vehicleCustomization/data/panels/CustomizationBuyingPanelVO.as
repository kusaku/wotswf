package net.wg.gui.lobby.vehicleCustomization.data.panels {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationBuyingPanelVO extends DAAPIDataClass {

    public var totalPriceCredits:String = "";

    public var totalPriceGold:String = "";

    public var notEnoughGoldTooltip:String = "";

    public var notEnoughCreditsTooltip:String = "";

    public var enoughGold:Boolean = false;

    public var enoughCredits:Boolean = false;

    public function CustomizationBuyingPanelVO(param1:Object) {
        super(param1);
    }
}
}
