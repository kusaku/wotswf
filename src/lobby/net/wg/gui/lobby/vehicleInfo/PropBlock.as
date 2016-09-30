package net.wg.gui.lobby.vehicleInfo {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoPropBlockVO;

public class PropBlock extends Sprite implements IVehicleInfoBlock {

    public var propValue:TextField;

    public var propName:TextField;

    public function PropBlock() {
        super();
    }

    public final function dispose():void {
        this.propValue = null;
        this.propName = null;
    }

    public function setData(param1:Object):void {
        var _loc2_:VehicleInfoPropBlockVO = VehicleInfoPropBlockVO(param1);
        this.propValue.text = _loc2_.value;
        this.propName.text = MENU.vehicleinfo_params(_loc2_.name);
    }
}
}
