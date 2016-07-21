package net.wg.gui.lobby.fortifications.data.orderInfo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class OrderParamsVO extends DAAPIDataClass {

    public var isShowSeparator:Boolean = false;

    public var orderLevel:String = "";

    public var params:String = "";

    public function OrderParamsVO(param1:Object) {
        super(param1);
    }
}
}
