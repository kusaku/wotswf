package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class OrderSelectRendererVO extends DAAPIDataClass {

    public var orderIconSrc:String = "";

    public var headerText:String = "";

    public var descriptionText:String = "";

    public var orderCountText:String = "";

    public var isEnabled:Boolean = true;

    public var isSelected:Boolean = false;

    public var showArsenalIcon:Boolean = true;

    public var returnBtnLabel:String = "";

    public var orderID:int = -1;

    public var orderLevel:int = -1;

    public function OrderSelectRendererVO(param1:Object) {
        super(param1);
    }
}
}
