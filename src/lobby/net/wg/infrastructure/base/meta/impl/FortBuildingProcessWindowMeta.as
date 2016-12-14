package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessInfoVO;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortBuildingProcessWindowMeta extends AbstractWindowView {

    public var requestBuildingInfo:Function;

    public var applyBuildingProcess:Function;

    private var _buildingProcessInfoVO:BuildingProcessInfoVO;

    private var _buildingProcessVO:BuildingProcessVO;

    public function FortBuildingProcessWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._buildingProcessInfoVO) {
            this._buildingProcessInfoVO.dispose();
            this._buildingProcessInfoVO = null;
        }
        if (this._buildingProcessVO) {
            this._buildingProcessVO.dispose();
            this._buildingProcessVO = null;
        }
        super.onDispose();
    }

    public function requestBuildingInfoS(param1:String):void {
        App.utils.asserter.assertNotNull(this.requestBuildingInfo, "requestBuildingInfo" + Errors.CANT_NULL);
        this.requestBuildingInfo(param1);
    }

    public function applyBuildingProcessS(param1:String):void {
        App.utils.asserter.assertNotNull(this.applyBuildingProcess, "applyBuildingProcess" + Errors.CANT_NULL);
        this.applyBuildingProcess(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:BuildingProcessVO = this._buildingProcessVO;
        this._buildingProcessVO = new BuildingProcessVO(param1);
        this.setData(this._buildingProcessVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_responseBuildingInfo(param1:Object):void {
        var _loc2_:BuildingProcessInfoVO = this._buildingProcessInfoVO;
        this._buildingProcessInfoVO = new BuildingProcessInfoVO(param1);
        this.responseBuildingInfo(this._buildingProcessInfoVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:BuildingProcessVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function responseBuildingInfo(param1:BuildingProcessInfoVO):void {
        var _loc2_:String = "as_responseBuildingInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
