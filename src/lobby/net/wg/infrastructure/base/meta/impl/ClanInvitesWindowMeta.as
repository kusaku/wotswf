package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.clans.common.ClanBaseInfoVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowHeaderStateVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class ClanInvitesWindowMeta extends AbstractWindowView {

    public var onInvitesButtonClick:Function;

    private var _clanInvitesWindowHeaderStateVO:ClanInvitesWindowHeaderStateVO;

    private var _clanBaseInfoVO:ClanBaseInfoVO;

    private var _clanInvitesWindowVO:ClanInvitesWindowVO;

    public function ClanInvitesWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanInvitesWindowHeaderStateVO) {
            this._clanInvitesWindowHeaderStateVO.dispose();
            this._clanInvitesWindowHeaderStateVO = null;
        }
        if (this._clanBaseInfoVO) {
            this._clanBaseInfoVO.dispose();
            this._clanBaseInfoVO = null;
        }
        if (this._clanInvitesWindowVO) {
            this._clanInvitesWindowVO.dispose();
            this._clanInvitesWindowVO = null;
        }
        super.onDispose();
    }

    public function onInvitesButtonClickS():void {
        App.utils.asserter.assertNotNull(this.onInvitesButtonClick, "onInvitesButtonClick" + Errors.CANT_NULL);
        this.onInvitesButtonClick();
    }

    public function as_setData(param1:Object):void {
        if (this._clanInvitesWindowVO) {
            this._clanInvitesWindowVO.dispose();
        }
        this._clanInvitesWindowVO = new ClanInvitesWindowVO(param1);
        this.setData(this._clanInvitesWindowVO);
    }

    public function as_setClanInfo(param1:Object):void {
        if (this._clanBaseInfoVO) {
            this._clanBaseInfoVO.dispose();
        }
        this._clanBaseInfoVO = new ClanBaseInfoVO(param1);
        this.setClanInfo(this._clanBaseInfoVO);
    }

    public function as_setHeaderState(param1:Object):void {
        if (this._clanInvitesWindowHeaderStateVO) {
            this._clanInvitesWindowHeaderStateVO.dispose();
        }
        this._clanInvitesWindowHeaderStateVO = new ClanInvitesWindowHeaderStateVO(param1);
        this.setHeaderState(this._clanInvitesWindowHeaderStateVO);
    }

    protected function setData(param1:ClanInvitesWindowVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setClanInfo(param1:ClanBaseInfoVO):void {
        var _loc2_:String = "as_setClanInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setHeaderState(param1:ClanInvitesWindowHeaderStateVO):void {
        var _loc2_:String = "as_setHeaderState" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
