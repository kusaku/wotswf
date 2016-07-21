package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.BuildingVO;
import net.wg.gui.lobby.fortifications.data.BuildingsComponentVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortBuildingComponentMeta extends BaseDAAPIComponent {

    public var onTransportingRequest:Function;

    public var requestBuildingProcess:Function;

    public var upgradeVisitedBuilding:Function;

    public var requestBuildingToolTipData:Function;

    private var _buildingsComponentVO:BuildingsComponentVO;

    public function FortBuildingComponentMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._buildingsComponentVO) {
            this._buildingsComponentVO.dispose();
            this._buildingsComponentVO = null;
        }
        super.onDispose();
    }

    public function onTransportingRequestS(param1:String, param2:String):void {
        App.utils.asserter.assertNotNull(this.onTransportingRequest, "onTransportingRequest" + Errors.CANT_NULL);
        this.onTransportingRequest(param1, param2);
    }

    public function requestBuildingProcessS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.requestBuildingProcess, "requestBuildingProcess" + Errors.CANT_NULL);
        this.requestBuildingProcess(param1, param2);
    }

    public function upgradeVisitedBuildingS(param1:String):void {
        App.utils.asserter.assertNotNull(this.upgradeVisitedBuilding, "upgradeVisitedBuilding" + Errors.CANT_NULL);
        this.upgradeVisitedBuilding(param1);
    }

    public function requestBuildingToolTipDataS(param1:String, param2:String):void {
        App.utils.asserter.assertNotNull(this.requestBuildingToolTipData, "requestBuildingToolTipData" + Errors.CANT_NULL);
        this.requestBuildingToolTipData(param1, param2);
    }

    public function as_setData(param1:Object):void {
        if (this._buildingsComponentVO) {
            this._buildingsComponentVO.dispose();
        }
        this._buildingsComponentVO = new BuildingsComponentVO(param1);
        this.setData(this._buildingsComponentVO);
    }

    public function as_setBuildingData(param1:Object):void {
        this.setBuildingData(new BuildingVO(param1));
    }

    protected function setData(param1:BuildingsComponentVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setBuildingData(param1:BuildingVO):void {
        var _loc2_:String = "as_setBuildingData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
