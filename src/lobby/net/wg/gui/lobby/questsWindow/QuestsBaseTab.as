package net.wg.gui.lobby.questsWindow {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.questsWindow.data.QuestsDataVO;
import net.wg.infrastructure.base.meta.IQuestsTabMeta;
import net.wg.infrastructure.base.meta.impl.QuestsTabMeta;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsBaseTab extends QuestsTabMeta implements IQuestsTabMeta {

    private var _questsArray:Array;

    public function QuestsBaseTab() {
        super();
    }

    override protected function setQuestsData(param1:QuestsDataVO):void {
        this.tryCleanQuestsData();
        if (param1.hasQuests()) {
            this._questsArray = App.utils.data.vectorToArray(param1.quests);
        }
    }

    override protected function onDispose():void {
        this.tryCleanQuestsData();
        super.onDispose();
    }

    public function as_setSelectedQuest(param1:String):void {
        throw new AbstractException("as_setSelectedQuest" + Errors.ABSTRACT_INVOKE);
    }

    private function tryCleanQuestsData():void {
        if (this._questsArray != null) {
            this._questsArray.splice(0, this._questsArray.length);
            this._questsArray = null;
        }
    }

    protected function get questsArray():Array {
        return this._questsArray;
    }
}
}
