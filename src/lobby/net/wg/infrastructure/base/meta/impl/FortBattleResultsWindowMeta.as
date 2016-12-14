package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.battleResults.BattleResultsVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortBattleResultsWindowMeta extends AbstractWindowView {

    public var getMoreInfo:Function;

    public var getClanEmblem:Function;

    private var _battleResultsVO:BattleResultsVO;

    public function FortBattleResultsWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._battleResultsVO) {
            this._battleResultsVO.dispose();
            this._battleResultsVO = null;
        }
        super.onDispose();
    }

    public function getMoreInfoS(param1:int):void {
        App.utils.asserter.assertNotNull(this.getMoreInfo, "getMoreInfo" + Errors.CANT_NULL);
        this.getMoreInfo(param1);
    }

    public function getClanEmblemS():void {
        App.utils.asserter.assertNotNull(this.getClanEmblem, "getClanEmblem" + Errors.CANT_NULL);
        this.getClanEmblem();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:BattleResultsVO = this._battleResultsVO;
        this._battleResultsVO = new BattleResultsVO(param1);
        this.setData(this._battleResultsVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:BattleResultsVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
