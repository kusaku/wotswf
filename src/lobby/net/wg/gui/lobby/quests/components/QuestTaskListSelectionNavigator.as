package net.wg.gui.lobby.quests.components {
import net.wg.gui.components.controls.AbstractListSelectionNavigator;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskListRendererVO;

public class QuestTaskListSelectionNavigator extends AbstractListSelectionNavigator {

    public function QuestTaskListSelectionNavigator() {
        super();
    }

    override protected function isSelectable(param1:int):Boolean {
        return QuestTaskListRendererVO(getItemByIndex(param1)).type != QuestTaskListRendererVO.CHAIN;
    }
}
}
