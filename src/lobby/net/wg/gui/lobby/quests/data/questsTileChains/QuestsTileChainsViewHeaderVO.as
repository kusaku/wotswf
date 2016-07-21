package net.wg.gui.lobby.quests.data.questsTileChains {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestsTileChainsViewHeaderVO extends DAAPIDataClass {

    public var tileID:int = -1;

    public var titleText:String = "";

    public var backBtnText:String = "";

    public var backBtnTooltip:String = "";

    public var backgroundImagePath:String = "";

    public var tasksProgressLabel:String = "";

    public var tasksProgressLinkage:String = "";

    public var tooltipType:String = "";

    public function QuestsTileChainsViewHeaderVO(param1:Object) {
        super(param1);
    }
}
}
