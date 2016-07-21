package net.wg.gui.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VersionMessageVO extends DAAPIDataClass {

    public var message:String = "";

    public var label:String = "";

    public var promoEnabel:Boolean = false;

    public var tooltip:String = "";

    public function VersionMessageVO(param1:Object) {
        super(param1);
    }
}
}
