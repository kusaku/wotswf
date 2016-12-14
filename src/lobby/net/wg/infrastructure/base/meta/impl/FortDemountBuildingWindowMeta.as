package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.demountBuilding.FortDemountBuildingVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortDemountBuildingWindowMeta extends AbstractWindowView {

    public var applyDemount:Function;

    private var _fortDemountBuildingVO:FortDemountBuildingVO;

    public function FortDemountBuildingWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortDemountBuildingVO) {
            this._fortDemountBuildingVO.dispose();
            this._fortDemountBuildingVO = null;
        }
        super.onDispose();
    }

    public function applyDemountS():void {
        App.utils.asserter.assertNotNull(this.applyDemount, "applyDemount" + Errors.CANT_NULL);
        this.applyDemount();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:FortDemountBuildingVO = this._fortDemountBuildingVO;
        this._fortDemountBuildingVO = new FortDemountBuildingVO(param1);
        this.setData(this._fortDemountBuildingVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:FortDemountBuildingVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
