package net.wg.gui.lobby.battleloading.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class PlayerStatusVO extends DAAPIDataClass {

    public var vehicleID:int = 0;

    public var status:int = 0;

    public function PlayerStatusVO(param1:Object) {
        super(param1);
    }
}
}
