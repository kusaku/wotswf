package net.wg.gui.lobby.fortifications.data.tankIcon {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortTankIconVO extends DAAPIDataClass {

    public var showAlert:Boolean = true;

    public var valueText:String = "";

    public var tankIconSource:String = "";

    public var lvlIconSource:String = "";

    public var divisionID:Number = -1;

    public function FortTankIconVO(param1:Object) {
        super(param1);
    }
}
}
