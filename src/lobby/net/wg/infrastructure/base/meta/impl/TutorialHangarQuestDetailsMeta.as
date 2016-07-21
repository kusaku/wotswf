package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.questsWindow.data.TutorialHangarQuestDetailsVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class TutorialHangarQuestDetailsMeta extends BaseDAAPIComponent {

    public var requestQuestInfo:Function;

    public var showTip:Function;

    public var getSortedTableData:Function;

    private var _tutorialHangarQuestDetailsVO:TutorialHangarQuestDetailsVO;

    public function TutorialHangarQuestDetailsMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._tutorialHangarQuestDetailsVO) {
            this._tutorialHangarQuestDetailsVO.dispose();
            this._tutorialHangarQuestDetailsVO = null;
        }
        super.onDispose();
    }

    public function requestQuestInfoS(param1:String):void {
        App.utils.asserter.assertNotNull(this.requestQuestInfo, "requestQuestInfo" + Errors.CANT_NULL);
        this.requestQuestInfo(param1);
    }

    public function showTipS(param1:String, param2:String):void {
        App.utils.asserter.assertNotNull(this.showTip, "showTip" + Errors.CANT_NULL);
        this.showTip(param1, param2);
    }

    public function getSortedTableDataS(param1:Object):Object {
        App.utils.asserter.assertNotNull(this.getSortedTableData, "getSortedTableData" + Errors.CANT_NULL);
        return this.getSortedTableData(param1);
    }

    public function as_updateQuestInfo(param1:Object):void {
        if (this._tutorialHangarQuestDetailsVO) {
            this._tutorialHangarQuestDetailsVO.dispose();
        }
        this._tutorialHangarQuestDetailsVO = new TutorialHangarQuestDetailsVO(param1);
        this.updateQuestInfo(this._tutorialHangarQuestDetailsVO);
    }

    protected function updateQuestInfo(param1:TutorialHangarQuestDetailsVO):void {
        var _loc2_:String = "as_updateQuestInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
