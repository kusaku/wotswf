package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CheckBoxIconVO extends DAAPIDataClass {

    public var isSelected:Boolean = false;

    public var icon:String = "";

    public var label:String = "";

    public function CheckBoxIconVO(param1:Object) {
        super(param1);
    }
}
}
