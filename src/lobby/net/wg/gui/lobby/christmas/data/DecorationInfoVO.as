package net.wg.gui.lobby.christmas.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DecorationInfoVO extends DAAPIDataClass {

    public var slotType:String = "";

    public var decorationId:int = -1;

    public function DecorationInfoVO(param1:Object) {
        super(param1);
    }
}
}
