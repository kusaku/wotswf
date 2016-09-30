package net.wg.gui.lobby.questsWindow {
import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;

public class QuestListSelectionNavigator extends AbstractListSelectionNavigator {

    public function QuestListSelectionNavigator() {
        super();
    }

    override protected function isSelectable(param1:int):Boolean {
        return QuestRendererVO(getItemByIndex(param1)).rendererType == QUESTS_ALIASES.RENDERER_TYPE_QUEST;
    }
}
}
