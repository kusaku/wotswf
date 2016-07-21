package net.wg.gui.lobby.battleResults.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class GetPremiumPopoverVO extends DAAPIDataClass {

    public var arenaUniqueID:Number = -1;

    public var creditsDiff:int = -1;

    public var xpDiff:int = -1;

    public function GetPremiumPopoverVO(param1:Object) {
        super(param1);
    }
}
}
