package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortClanStatisticsWindowMeta extends AbstractWindowView {

    private var _clanStatsVO:ClanStatsVO;

    public function FortClanStatisticsWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._clanStatsVO) {
            this._clanStatsVO.dispose();
            this._clanStatsVO = null;
        }
        super.onDispose();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:ClanStatsVO = this._clanStatsVO;
        this._clanStatsVO = new ClanStatsVO(param1);
        this.setData(this._clanStatsVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:ClanStatsVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
