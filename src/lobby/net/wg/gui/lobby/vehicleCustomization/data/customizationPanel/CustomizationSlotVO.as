package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationSlotVO extends DAAPIDataClass {

    public var img:String = "";

    public var purchaseTypeIcon:String = "";

    public var bonus:String = "";

    public var spot:uint = 0;

    public var itemID:int = -1;

    public var price:int = -1;

    public var duration:uint = 0;

    public var isInDossier:Boolean = false;

    public var revertBtnVisible:Boolean = false;

    public var slotTooltip:String = "";

    public var removeBtnTooltip:String = "";

    public var revertBtnTooltip:String = "";

    public function CustomizationSlotVO(param1:Object) {
        super(param1);
    }
}
}
