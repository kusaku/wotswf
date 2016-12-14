package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehicleInfo.data.VehCompareButtonDataVO;
import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoDataVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class VehicleInfoMeta extends AbstractWindowView {

    public var getVehicleInfo:Function;

    public var onCancelClick:Function;

    public var addToCompare:Function;

    private var _vehCompareButtonDataVO:VehCompareButtonDataVO;

    private var _vehicleInfoDataVO:VehicleInfoDataVO;

    public function VehicleInfoMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._vehCompareButtonDataVO) {
            this._vehCompareButtonDataVO.dispose();
            this._vehCompareButtonDataVO = null;
        }
        if (this._vehicleInfoDataVO) {
            this._vehicleInfoDataVO.dispose();
            this._vehicleInfoDataVO = null;
        }
        super.onDispose();
    }

    public function getVehicleInfoS():void {
        App.utils.asserter.assertNotNull(this.getVehicleInfo, "getVehicleInfo" + Errors.CANT_NULL);
        this.getVehicleInfo();
    }

    public function onCancelClickS():void {
        App.utils.asserter.assertNotNull(this.onCancelClick, "onCancelClick" + Errors.CANT_NULL);
        this.onCancelClick();
    }

    public function addToCompareS():void {
        App.utils.asserter.assertNotNull(this.addToCompare, "addToCompare" + Errors.CANT_NULL);
        this.addToCompare();
    }

    public final function as_setVehicleInfo(param1:Object):void {
        var _loc2_:VehicleInfoDataVO = this._vehicleInfoDataVO;
        this._vehicleInfoDataVO = new VehicleInfoDataVO(param1);
        this.setVehicleInfo(this._vehicleInfoDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setCompareButtonData(param1:Object):void {
        var _loc2_:VehCompareButtonDataVO = this._vehCompareButtonDataVO;
        this._vehCompareButtonDataVO = new VehCompareButtonDataVO(param1);
        this.setCompareButtonData(this._vehCompareButtonDataVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setVehicleInfo(param1:VehicleInfoDataVO):void {
        var _loc2_:String = "as_setVehicleInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setCompareButtonData(param1:VehCompareButtonDataVO):void {
        var _loc2_:String = "as_setCompareButtonData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
