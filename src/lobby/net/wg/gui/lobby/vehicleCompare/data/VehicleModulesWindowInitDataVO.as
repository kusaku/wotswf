package net.wg.gui.lobby.vehicleCompare.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VehicleModulesWindowInitDataVO extends DAAPIDataClass {

    public var windowTitle:String = "";

    public var description:String = "";

    public var resetBtnLabel:String = "";

    public var closeBtnLabel:String = "";

    public var compareBtnLabel:String = "";

    public var resetBtnTooltip:String = "";

    public var closeBtnTooltip:String = "";

    public var compareBtnTooltip:String = "";

    public function VehicleModulesWindowInitDataVO(param1:Object) {
        super(param1);
    }
}
}
