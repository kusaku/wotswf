package net.wg.gui.lobby.hangar.tcarousel.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CheckBoxRendererVO extends DAAPIDataClass {

    public var label:String = "";

    public var tooltip:String = "";

    public var enabled:Boolean = true;

    public var selected:Boolean = true;

    public function CheckBoxRendererVO(param1:Object) {
        super(param1);
    }
}
}
