package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.SoundButton;
import net.wg.gui.lobby.header.vo.QuestsControlBtnVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsControlMeta extends SoundButton {

    public var showQuestsWindow:Function;

    private var _questsControlBtnVO:QuestsControlBtnVO;

    public function QuestsControlMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._questsControlBtnVO) {
            this._questsControlBtnVO.dispose();
            this._questsControlBtnVO = null;
        }
        super.onDispose();
    }

    public function showQuestsWindowS():void {
        App.utils.asserter.assertNotNull(this.showQuestsWindow, "showQuestsWindow" + Errors.CANT_NULL);
        this.showQuestsWindow();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:QuestsControlBtnVO = this._questsControlBtnVO;
        this._questsControlBtnVO = new QuestsControlBtnVO(param1);
        this.setData(this._questsControlBtnVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:QuestsControlBtnVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
