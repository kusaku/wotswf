package net.wg.gui.lobby.hangar.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class HangarHeaderVO extends DAAPIDataClass {

    public var tankType:String = "";

    public var tankInfo:String = "";

    public var isPremIGR:Boolean;

    public var personalQuestsIcon:String = "";

    public var personalQuestsLabel:String = "";

    public var personalQuestsTooltip:String = "";

    public var personalQuestsEnable:Boolean = true;

    public var commonQuestsIcon:String = "";

    public var commonQuestsLabel:String = "";

    public var commonQuestsTooltip:String = "";

    public var commonQuestsEnable:Boolean = true;

    public var isVisible:Boolean;

    public function HangarHeaderVO(param1:Object) {
        super(param1);
    }
}
}
