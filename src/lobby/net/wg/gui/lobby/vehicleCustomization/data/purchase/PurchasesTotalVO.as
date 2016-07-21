package net.wg.gui.lobby.vehicleCustomization.data.purchase {
import net.wg.data.daapi.base.DAAPIDataClass;

public class PurchasesTotalVO extends DAAPIDataClass {

    public var gold:String = "";

    public var credits:String = "";

    public var totalLabel:String = "";

    public var notEnoughGoldTooltip:String = "";

    public var notEnoughCreditsTooltip:String = "";

    public var enoughGold:Boolean = false;

    public var enoughCredits:Boolean = false;

    public var buyEnabled:Boolean = false;

    public function PurchasesTotalVO(param1:Object) {
        super(param1);
    }
}
}
