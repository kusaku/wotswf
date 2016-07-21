package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortCurfewTimeVO extends DAAPIDataClass {

    public var startTime:String = "";

    public var endTime:String = "";

    public function FortCurfewTimeVO(param1:Object) {
        super(param1);
    }
}
}
