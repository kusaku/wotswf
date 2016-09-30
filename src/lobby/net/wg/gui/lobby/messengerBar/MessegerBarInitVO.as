package net.wg.gui.lobby.messengerBar {
import net.wg.data.daapi.base.DAAPIDataClass;

public class MessegerBarInitVO extends DAAPIDataClass {

    public var channelsHtmlIcon:String = "";

    public var contactsHtmlIcon:String = "";

    public var contactsTooltip:String = "";

    public var vehicleCompareHtmlIcon:String = "";

    public var vehicleCompareTooltip:String = "";

    public function MessegerBarInitVO(param1:Object) {
        super(param1);
    }
}
}
