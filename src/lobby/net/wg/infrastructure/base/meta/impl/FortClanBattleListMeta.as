package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleListVO;
import net.wg.gui.rally.views.list.BaseRallyListView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortClanBattleListMeta extends BaseRallyListView {

    private var _clanBattleListVO:ClanBattleListVO;

    public function FortClanBattleListMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanBattleListVO) {
            this._clanBattleListVO.dispose();
            this._clanBattleListVO = null;
        }
        super.onDispose();
    }

    public final function as_setClanBattleData(param1:Object):void {
        var _loc2_:ClanBattleListVO = this._clanBattleListVO;
        this._clanBattleListVO = new ClanBattleListVO(param1);
        this.setClanBattleData(this._clanBattleListVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setClanBattleData(param1:ClanBattleListVO):void {
        var _loc2_:String = "as_setClanBattleData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
