package net.wg.gui.lobby.battlequeue {
import net.wg.data.daapi.base.DAAPIDataClass;

public class BattleQueueTypeInfoVO extends DAAPIDataClass {

    public var iconLabel:String = "";

    public var title:String = "";

    public var description:String = "";

    public var additional:String = "";

    public function BattleQueueTypeInfoVO(param1:Object) {
        super(param1);
    }
}
}
