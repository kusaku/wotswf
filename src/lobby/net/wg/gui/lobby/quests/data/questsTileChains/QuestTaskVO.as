package net.wg.gui.lobby.quests.data.questsTileChains {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestTaskVO extends DAAPIDataClass {

    public var name:String = "";

    public var stateName:String = "";

    public var stateIconPath:String = "";

    public var arrowIconPath:String = "";

    public var id:Number = -1;

    public var tooltip:String = "";

    public var enabled:Boolean = false;

    public function QuestTaskVO(param1:Object) {
        super(param1);
    }
}
}
