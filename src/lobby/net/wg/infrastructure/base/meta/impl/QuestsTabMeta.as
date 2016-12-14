package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.questsWindow.data.QuestsDataVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsTabMeta extends BaseDAAPIComponent {

    private var _questsDataVO:QuestsDataVO;

    public function QuestsTabMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._questsDataVO) {
            this._questsDataVO.dispose();
            this._questsDataVO = null;
        }
        super.onDispose();
    }

    public final function as_setQuestsData(param1:Object):void {
        var _loc2_:QuestsDataVO = this._questsDataVO;
        this._questsDataVO = new QuestsDataVO(param1);
        this.setQuestsData(this._questsDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setQuestsData(param1:QuestsDataVO):void {
        var _loc2_:String = "as_setQuestsData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
