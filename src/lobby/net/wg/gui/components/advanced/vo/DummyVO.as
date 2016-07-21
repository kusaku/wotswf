package net.wg.gui.components.advanced.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DummyVO extends DAAPIDataClass {

    public var alignCenter:Boolean = false;

    public var iconSource:String = "";

    public var htmlText:String = "";

    public var btnVisible:Boolean = false;

    public var btnLabel:String = "";

    public var btnTooltip:String = "";

    public function DummyVO(param1:Object) {
        super(param1);
    }
}
}
