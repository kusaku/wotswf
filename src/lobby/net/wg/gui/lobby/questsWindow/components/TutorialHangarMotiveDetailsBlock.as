package net.wg.gui.lobby.questsWindow.components {
import net.wg.gui.lobby.questsWindow.data.TutorialHangarQuestDetailsVO;

public class TutorialHangarMotiveDetailsBlock extends TutorialHangarQuestDetailsBase {

    public var descContainer:TutorialMotiveQuestDescriptionContainer;

    public function TutorialHangarMotiveDetailsBlock() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        descScrollPane.target = this.descContainer;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.descContainer.container.sortingFunction = getSortedTableDataS;
    }

    override protected function onDispose():void {
        this.descContainer = null;
        super.onDispose();
    }

    override protected function updateQuestInfo(param1:TutorialHangarQuestDetailsVO):void {
        super.updateQuestInfo(param1);
        this.descContainer.setData(param1.infoList);
        this.descContainer.validateNow();
        layout();
    }
}
}
