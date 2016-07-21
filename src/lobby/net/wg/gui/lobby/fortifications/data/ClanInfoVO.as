package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ClanInfoVO extends DAAPIDataClass {

    public var id:Number = -1;

    public var name:String = "";

    public var emblem:String = "";

    public function ClanInfoVO(param1:Object) {
        super(param1);
    }
}
}
