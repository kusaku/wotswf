package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.vo.DummyVO;
import net.wg.gui.lobby.clans.common.ClanViewWithVariableContent;
import net.wg.infrastructure.exceptions.AbstractException;

public class ClanProfileFortificationViewMeta extends ClanViewWithVariableContent {

    private var _dummyVO:DummyVO;

    public function ClanProfileFortificationViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._dummyVO) {
            this._dummyVO.dispose();
            this._dummyVO = null;
        }
        super.onDispose();
    }

    public function as_showBodyDummy(param1:Object):void {
        if (this._dummyVO) {
            this._dummyVO.dispose();
        }
        this._dummyVO = new DummyVO(param1);
        this.showBodyDummy(this._dummyVO);
    }

    protected function showBodyDummy(param1:DummyVO):void {
        var _loc2_:String = "as_showBodyDummy" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
