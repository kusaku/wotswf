package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowTableFilterVO;
import net.wg.gui.lobby.clans.invites.views.ClanInvitesViewWithTable;
import net.wg.infrastructure.exceptions.AbstractException;

public class ClanInvitesWindowAbstractTabViewMeta extends ClanInvitesViewWithTable {

    public var filterBy:Function;

    private var _clanInvitesWindowTableFilterVO:ClanInvitesWindowTableFilterVO;

    public function ClanInvitesWindowAbstractTabViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanInvitesWindowTableFilterVO) {
            this._clanInvitesWindowTableFilterVO.dispose();
            this._clanInvitesWindowTableFilterVO = null;
        }
        super.onDispose();
    }

    public function filterByS(param1:String):void {
        App.utils.asserter.assertNotNull(this.filterBy, "filterBy" + Errors.CANT_NULL);
        this.filterBy(param1);
    }

    public function as_updateFilterState(param1:Object):void {
        if (this._clanInvitesWindowTableFilterVO) {
            this._clanInvitesWindowTableFilterVO.dispose();
        }
        this._clanInvitesWindowTableFilterVO = new ClanInvitesWindowTableFilterVO(param1);
        this.updateFilterState(this._clanInvitesWindowTableFilterVO);
    }

    protected function updateFilterState(param1:ClanInvitesWindowTableFilterVO):void {
        var _loc2_:String = "as_updateFilterState" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
