package net.wg.gui.lobby.questsWindow.components {
import flash.display.InteractiveObject;

import net.wg.gui.lobby.questsWindow.data.TutorialHangarQuestDetailsVO;
import net.wg.gui.lobby.questsWindow.events.TutorialQuestConditionEvent;

public class TutorialHangarDetailsBlock extends TutorialHangarQuestDetailsBase {

    public var descContainer:TutorialQuestDescriptionContainer;

    public function TutorialHangarDetailsBlock() {
        super();
    }

    override public function getFocusChain():Vector.<InteractiveObject> {
        return this.descContainer.conditionsGroup.getFocusChain();
    }

    override protected function configUI():void {
        super.configUI();
        descScrollPane.target = this.descContainer;
        addEventListener(TutorialQuestConditionEvent.ACTION_BUTTON_PRESSED, this.onConditionActionButtonPressedHandler);
    }

    override protected function onDispose():void {
        removeEventListener(TutorialQuestConditionEvent.ACTION_BUTTON_PRESSED, this.onConditionActionButtonPressedHandler);
        this.descContainer = null;
        super.onDispose();
    }

    override protected function updateQuestInfo(param1:TutorialHangarQuestDetailsVO):void {
        super.updateQuestInfo(param1);
        this.descContainer.setData(param1.description);
        this.descContainer.validateNow();
        layout();
    }

    private function onConditionActionButtonPressedHandler(param1:TutorialQuestConditionEvent):void {
        showTipS(param1.id, param1.additionalType);
    }
}
}
