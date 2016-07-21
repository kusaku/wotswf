package net.wg.gui.lobby.fortifications.data {
public class OrderInfoVO extends BuildingPopoverBaseVO {

    public var infoIconSource:String = "";

    public var infoIconToolTip:String = "";

    public var title:String = "";

    public var description:String = "";

    public var iconSource:String = "";

    public var iconLevel:int = -1;

    public var ordersCount:int = -1;

    public var showAlertIcon:Boolean = true;

    public var alertIconTooltip:String = "";

    public var descriptionLink:Boolean = false;

    public var orderID:int = -1;

    public function OrderInfoVO(param1:Object) {
        super(param1);
    }
}
}
