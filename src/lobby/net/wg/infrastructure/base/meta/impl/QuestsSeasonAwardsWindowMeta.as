package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardsVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class QuestsSeasonAwardsWindowMeta extends AbstractWindowView {

    public var showVehicleInfo:Function;

    private var _seasonAwardsVO:SeasonAwardsVO;

    public function QuestsSeasonAwardsWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._seasonAwardsVO) {
            this._seasonAwardsVO.dispose();
            this._seasonAwardsVO = null;
        }
        super.onDispose();
    }

    public function showVehicleInfoS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.showVehicleInfo, "showVehicleInfo" + Errors.CANT_NULL);
        this.showVehicleInfo(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:SeasonAwardsVO = this._seasonAwardsVO;
        this._seasonAwardsVO = new SeasonAwardsVO(param1);
        this.setData(this._seasonAwardsVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:SeasonAwardsVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
