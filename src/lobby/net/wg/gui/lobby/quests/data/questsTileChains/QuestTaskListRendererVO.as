package net.wg.gui.lobby.quests.data.questsTileChains {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class QuestTaskListRendererVO implements IDisposable {

    public static const STATISTICS:int = 0;

    public static const CHAIN:int = 1;

    public static const TASK:int = 2;

    public var type:int;

    public var statData:QuestTileStatisticsVO;

    public var chainData:QuestChainVO;

    public var taskData:QuestTaskVO;

    public var tooltip:String;

    public var enabled:Boolean = false;

    public function QuestTaskListRendererVO(param1:int, param2:Object, param3:String = null) {
        super();
        this.type = param1;
        this.tooltip = param3;
        switch (param1) {
            case QuestTaskListRendererVO.STATISTICS:
                this.statData = param2 as QuestTileStatisticsVO;
                this.enabled = true;
                break;
            case QuestTaskListRendererVO.CHAIN:
                this.chainData = param2 as QuestChainVO;
                this.enabled = this.chainData.enabled;
                break;
            case QuestTaskListRendererVO.TASK:
                this.taskData = param2 as QuestTaskVO;
                this.enabled = this.taskData.enabled;
        }
    }

    public function dispose():void {
        this.statData = null;
        this.chainData = null;
        this.taskData = null;
        this.tooltip = null;
    }
}
}
