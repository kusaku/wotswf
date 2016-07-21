package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.questsWindow.QuestsBaseTab;

public class QuestsCurrentTabMeta extends QuestsBaseTab {

    public var sort:Function;

    public var getSortedTableData:Function;

    public var getQuestInfo:Function;

    public function QuestsCurrentTabMeta() {
        super();
    }

    public function sortS(param1:int, param2:Boolean):void {
        App.utils.asserter.assertNotNull(this.sort, "sort" + Errors.CANT_NULL);
        this.sort(param1, param2);
    }

    public function getSortedTableDataS(param1:Object):Array {
        App.utils.asserter.assertNotNull(this.getSortedTableData, "getSortedTableData" + Errors.CANT_NULL);
        return this.getSortedTableData(param1);
    }

    public function getQuestInfoS(param1:String):void {
        App.utils.asserter.assertNotNull(this.getQuestInfo, "getQuestInfo" + Errors.CANT_NULL);
        this.getQuestInfo(param1);
    }
}
}
