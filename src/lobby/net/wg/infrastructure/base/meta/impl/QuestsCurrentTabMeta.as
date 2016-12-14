package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.questsWindow.QuestsBaseTab;
import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsCurrentTabMeta extends QuestsBaseTab {

    public var sort:Function;

    public var getSortedTableData:Function;

    public var getQuestInfo:Function;

    public var collapse:Function;

    private var _questDataVO:QuestDataVO;

    public function QuestsCurrentTabMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._questDataVO) {
            this._questDataVO.dispose();
            this._questDataVO = null;
        }
        super.onDispose();
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

    public function collapseS(param1:String):void {
        App.utils.asserter.assertNotNull(this.collapse, "collapse" + Errors.CANT_NULL);
        this.collapse(param1);
    }

    public final function as_updateQuestInfo(param1:Object):void {
        var _loc2_:QuestDataVO = this._questDataVO;
        this._questDataVO = !!param1 ? new QuestDataVO(param1) : null;
        this.updateQuestInfo(this._questDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function updateQuestInfo(param1:QuestDataVO):void {
        var _loc2_:String = "as_updateQuestInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
