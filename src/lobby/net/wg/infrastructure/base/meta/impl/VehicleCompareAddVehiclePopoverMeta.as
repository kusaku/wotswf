package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.ButtonPropertiesVO;
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAddVehiclePopoverVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class VehicleCompareAddVehiclePopoverMeta extends SmartPopOverView {

    public var setVehicleSelected:Function;

    public var applyFilters:Function;

    public var addButtonClicked:Function;

    private var _vehicleCompareAddVehiclePopoverVO:VehicleCompareAddVehiclePopoverVO;

    private var _buttonPropertiesVO:ButtonPropertiesVO;

    public function VehicleCompareAddVehiclePopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._vehicleCompareAddVehiclePopoverVO) {
            this._vehicleCompareAddVehiclePopoverVO.dispose();
            this._vehicleCompareAddVehiclePopoverVO = null;
        }
        if (this._buttonPropertiesVO) {
            this._buttonPropertiesVO.dispose();
            this._buttonPropertiesVO = null;
        }
        super.onDispose();
    }

    public function setVehicleSelectedS(param1:int):void {
        App.utils.asserter.assertNotNull(this.setVehicleSelected, "setVehicleSelected" + Errors.CANT_NULL);
        this.setVehicleSelected(param1);
    }

    public function applyFiltersS(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean):void {
        App.utils.asserter.assertNotNull(this.applyFilters, "applyFilters" + Errors.CANT_NULL);
        this.applyFilters(param1, param2, param3, param4, param5);
    }

    public function addButtonClickedS():void {
        App.utils.asserter.assertNotNull(this.addButtonClicked, "addButtonClicked" + Errors.CANT_NULL);
        this.addButtonClicked();
    }

    public function as_setInitData(param1:Object):void {
        if (this._vehicleCompareAddVehiclePopoverVO) {
            this._vehicleCompareAddVehiclePopoverVO.dispose();
        }
        this._vehicleCompareAddVehiclePopoverVO = new VehicleCompareAddVehiclePopoverVO(param1);
        this.setInitData(this._vehicleCompareAddVehiclePopoverVO);
    }

    public function as_setAddButtonState(param1:Object):void {
        if (this._buttonPropertiesVO) {
            this._buttonPropertiesVO.dispose();
        }
        this._buttonPropertiesVO = new ButtonPropertiesVO(param1);
        this.setAddButtonState(this._buttonPropertiesVO);
    }

    protected function setInitData(param1:VehicleCompareAddVehiclePopoverVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setAddButtonState(param1:ButtonPropertiesVO):void {
        var _loc2_:String = "as_setAddButtonState" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
