package net.wg.gui.lobby.battleResults.progressReport {
import net.wg.data.constants.Linkages;
import net.wg.gui.lobby.questsWindow.ISubtaskListLinkageSelector;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ProgressReportLinkageSelector implements ISubtaskListLinkageSelector, IDisposable {

    private static const PERSONAL_QUEST_TYPE:int = 8;

    private var _unlocksCount:int = -1;

    public function ProgressReportLinkageSelector() {
        super();
    }

    public function dispose():void {
    }

    public function getSpecialLinkage(param1:Object, param2:int):String {
        if (param2 < this._unlocksCount) {
            return Linkages.UNLOCK_PROGRESS_LINK;
        }
        if (param1.hasOwnProperty("questType") && param1.questType == PERSONAL_QUEST_TYPE) {
            return Linkages.PERSONAL_QUEST_LINK;
        }
        return null;
    }

    public function setUnlocksCount(param1:int):void {
        this._unlocksCount = param1;
    }
}
}
