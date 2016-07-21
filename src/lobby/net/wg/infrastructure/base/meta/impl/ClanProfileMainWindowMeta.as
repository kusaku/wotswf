package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileMainWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class ClanProfileMainWindowMeta extends AbstractWindowView {

    private var _clanProfileMainWindowVO:ClanProfileMainWindowVO;

    public function ClanProfileMainWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanProfileMainWindowVO) {
            this._clanProfileMainWindowVO.dispose();
            this._clanProfileMainWindowVO = null;
        }
        super.onDispose();
    }

    public function as_setData(param1:Object):void {
        if (this._clanProfileMainWindowVO) {
            this._clanProfileMainWindowVO.dispose();
        }
        this._clanProfileMainWindowVO = new ClanProfileMainWindowVO(param1);
        this.setData(this._clanProfileMainWindowVO);
    }

    protected function setData(param1:ClanProfileMainWindowVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
