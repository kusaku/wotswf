package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.quests.data.seasonAwards.QuestsPersonalWelcomeViewVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsPersonalWelcomeViewMeta extends BaseDAAPIComponent {

    public var success:Function;

    private var _questsPersonalWelcomeViewVO:QuestsPersonalWelcomeViewVO;

    public function QuestsPersonalWelcomeViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._questsPersonalWelcomeViewVO) {
            this._questsPersonalWelcomeViewVO.dispose();
            this._questsPersonalWelcomeViewVO = null;
        }
        super.onDispose();
    }

    public function successS():void {
        App.utils.asserter.assertNotNull(this.success, "success" + Errors.CANT_NULL);
        this.success();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:QuestsPersonalWelcomeViewVO = this._questsPersonalWelcomeViewVO;
        this._questsPersonalWelcomeViewVO = new QuestsPersonalWelcomeViewVO(param1);
        this.setData(this._questsPersonalWelcomeViewVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:QuestsPersonalWelcomeViewVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
