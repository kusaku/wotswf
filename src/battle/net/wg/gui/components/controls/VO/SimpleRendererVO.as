package net.wg.gui.components.controls.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class SimpleRendererVO extends DAAPIDataClass {

    public var value:String = "";

    public var selected:Boolean = false;

    public var tooltip:String = "";

    public function SimpleRendererVO(param1:Object) {
        super(param1);
    }
}
}
