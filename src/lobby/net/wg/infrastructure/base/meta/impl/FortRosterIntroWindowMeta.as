package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.RosterIntroVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortRosterIntroWindowMeta extends AbstractWindowView {

    private var _rosterIntroVO:RosterIntroVO;

    public function FortRosterIntroWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._rosterIntroVO) {
            this._rosterIntroVO.dispose();
            this._rosterIntroVO = null;
        }
        super.onDispose();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:RosterIntroVO = this._rosterIntroVO;
        this._rosterIntroVO = new RosterIntroVO(param1);
        this.setData(this._rosterIntroVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:RosterIntroVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
