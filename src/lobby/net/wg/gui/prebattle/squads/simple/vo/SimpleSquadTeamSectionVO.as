package net.wg.gui.prebattle.squads.simple.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class SimpleSquadTeamSectionVO extends DAAPIDataClass {

    public var infoIconTooltip:String = "";

    public var infoIconTooltipType:String = "simple";

    public var isVisibleInfoIcon:Boolean = false;

    public var headerIconSource:String = "";

    public var isVisibleHeaderIcon:Boolean = false;

    public var headerMessageText:String = "";

    public var isVisibleHeaderMessage:Boolean = false;

    public var icoXPadding:int = 0;

    public var icoYPadding:int = 0;

    public function SimpleSquadTeamSectionVO(param1:Object) {
        super(param1);
    }
}
}
