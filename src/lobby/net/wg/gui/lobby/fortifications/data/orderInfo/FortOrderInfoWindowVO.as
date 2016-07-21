package net.wg.gui.lobby.fortifications.data.orderInfo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortOrderInfoWindowVO extends DAAPIDataClass {

    public var windowTitle:String = "";

    public var panelTitle:String = "";

    public var btnLbl:String = "";

    public var orderDescrTitle:String = "";

    public var orderDescrBody:String = "";

    public function FortOrderInfoWindowVO(param1:Object) {
        super(param1);
    }
}
}
