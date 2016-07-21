package net.wg.gui.lobby.questsWindow {
import flash.display.InteractiveObject;

import net.wg.data.constants.QuestsStates;
import net.wg.gui.lobby.questsWindow.data.QuestsDataVO;
import net.wg.infrastructure.base.meta.impl.QuestsCurrentTabMeta;

public class QuestsCurrentTab extends QuestsCurrentTabMeta implements IQuestsTab {

    private var _questContent:QuestContent;

    public function QuestsCurrentTab() {
        super();
    }

    override public function as_setSelectedQuest(param1:String):void {
        this._questContent.setSelectedQuest(param1);
    }

    override protected function setQuestsData(param1:QuestsDataVO):void {
        super.setQuestsData(param1);
        var _loc2_:Array = questsArray;
        this._questContent.setQuestsData(_loc2_, param1.totalTasks);
        if (!param1.isSortable) {
            this._questContent.sortElementsUnVisible();
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.questContent.daapi = this;
        this.questContent.setNoDataLabel(QUESTS.QUESTS_CURRENT_NODATA);
        this.questContent.questsList.questsState = QuestsStates.CURRENT_STATE;
        this.questContent.validateNow();
    }

    override protected function onDispose():void {
        this._questContent.dispose();
        this._questContent = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.questContent.sortingFunction = getSortedTableDataS;
    }

    public function as_updateQuestInfo(param1:Object):void {
        this._questContent.updateQuestInfo(param1);
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function update(param1:Object):void {
    }

    public function get questContent():QuestContent {
        return this._questContent;
    }

    public function set questContent(param1:QuestContent):void {
        this._questContent = param1;
    }
}
}
