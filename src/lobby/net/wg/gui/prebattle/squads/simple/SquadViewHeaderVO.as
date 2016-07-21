package net.wg.gui.prebattle.squads.simple {
import net.wg.data.daapi.base.DAAPIDataClass;

public class SquadViewHeaderVO extends DAAPIDataClass {

    public var battleTypeName:String = "";

    public var isNew:Boolean = false;

    public var leaveBtnTooltip:String = "";

    public function SquadViewHeaderVO(param1:Object) {
        super(param1);
    }
}
}
