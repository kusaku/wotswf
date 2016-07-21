package net.wg.gui.lobby.vehiclePreview.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class VehPreviewVehicleInfoPanelVO extends DAAPIDataClass {

    public var name:String = "";

    public var type:String = "";

    public var vDescription:String = "";

    public var earnedXP:Number = 0.0;

    public var isElite:Boolean;

    public var isPremiumIGR:Boolean;

    public var info:String = "";

    public function VehPreviewVehicleInfoPanelVO(param1:Object) {
        super(param1);
    }
}
}
