package net.wg.gui.lobby.fortifications.data.settings {
import net.wg.data.daapi.base.DAAPIDataClass;

public class PeripheryContainerVO extends DAAPIDataClass {

    public var peripheryTitle:String = "";

    public var peripheryName:String = "";

    public var buttonEnabled:Boolean = true;

    public var buttonToolTip:String = "";

    public var descriptionTooltip:String = "";

    public function PeripheryContainerVO(param1:Object) {
        super(param1);
    }
}
}
