package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.cyberSport.data.RosterSlotSettingsWindowStaticVO;
import net.wg.gui.cyberSport.vo.RosterLimitsVO;
import net.wg.gui.cyberSport.vo.VehicleSelectorFilterVO;
import net.wg.gui.rally.vo.SettingRosterVO;
import net.wg.gui.rally.vo.VehicleVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class RosterSlotSettingsWindowMeta extends AbstractWindowView {

    public var onFiltersUpdate:Function;

    public var requestVehicleFilters:Function;

    public var submitButtonHandler:Function;

    public var cancelButtonHandler:Function;

    private var _rosterLimitsVO:RosterLimitsVO;

    private var _rosterSlotSettingsWindowStaticVO:RosterSlotSettingsWindowStaticVO;

    private var _vehicleVO:VehicleVO;

    private var _vehicleSelectorFilterVO:VehicleSelectorFilterVO;

    public function RosterSlotSettingsWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._rosterLimitsVO) {
            this._rosterLimitsVO.dispose();
            this._rosterLimitsVO = null;
        }
        if (this._rosterSlotSettingsWindowStaticVO) {
            this._rosterSlotSettingsWindowStaticVO.dispose();
            this._rosterSlotSettingsWindowStaticVO = null;
        }
        if (this._vehicleVO) {
            this._vehicleVO.dispose();
            this._vehicleVO = null;
        }
        if (this._vehicleSelectorFilterVO) {
            this._vehicleSelectorFilterVO.dispose();
            this._vehicleSelectorFilterVO = null;
        }
        super.onDispose();
    }

    public function onFiltersUpdateS(param1:int, param2:String, param3:Boolean, param4:int, param5:Boolean):void {
        App.utils.asserter.assertNotNull(this.onFiltersUpdate, "onFiltersUpdate" + Errors.CANT_NULL);
        this.onFiltersUpdate(param1, param2, param3, param4, param5);
    }

    public function requestVehicleFiltersS():void {
        App.utils.asserter.assertNotNull(this.requestVehicleFilters, "requestVehicleFilters" + Errors.CANT_NULL);
        this.requestVehicleFilters();
    }

    public function submitButtonHandlerS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.submitButtonHandler, "submitButtonHandler" + Errors.CANT_NULL);
        this.submitButtonHandler(param1);
    }

    public function cancelButtonHandlerS():void {
        App.utils.asserter.assertNotNull(this.cancelButtonHandler, "cancelButtonHandler" + Errors.CANT_NULL);
        this.cancelButtonHandler();
    }

    public function as_setVehicleSelection(param1:Object):void {
        if (this._vehicleVO) {
            this._vehicleVO.dispose();
        }
        this._vehicleVO = new VehicleVO(param1);
        this.setVehicleSelection(this._vehicleVO);
    }

    public function as_setRangeSelection(param1:Object):void {
        this.setRangeSelection(new SettingRosterVO(param1));
    }

    public function as_setStaticData(param1:Object):void {
        if (this._rosterSlotSettingsWindowStaticVO) {
            this._rosterSlotSettingsWindowStaticVO.dispose();
        }
        this._rosterSlotSettingsWindowStaticVO = new RosterSlotSettingsWindowStaticVO(param1);
        this.setStaticData(this._rosterSlotSettingsWindowStaticVO);
    }

    public function as_setRosterLimits(param1:Object):void {
        if (this._rosterLimitsVO) {
            this._rosterLimitsVO.dispose();
        }
        this._rosterLimitsVO = new RosterLimitsVO(param1);
        this.setRosterLimits(this._rosterLimitsVO);
    }

    public function as_updateVehicleFilters(param1:Object):void {
        if (this._vehicleSelectorFilterVO) {
            this._vehicleSelectorFilterVO.dispose();
        }
        this._vehicleSelectorFilterVO = new VehicleSelectorFilterVO(param1);
        this.updateVehicleFilters(this._vehicleSelectorFilterVO);
    }

    protected function setVehicleSelection(param1:VehicleVO):void {
        var _loc2_:String = "as_setVehicleSelection" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setRangeSelection(param1:SettingRosterVO):void {
        var _loc2_:String = "as_setRangeSelection" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setStaticData(param1:RosterSlotSettingsWindowStaticVO):void {
        var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setRosterLimits(param1:RosterLimitsVO):void {
        var _loc2_:String = "as_setRosterLimits" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateVehicleFilters(param1:VehicleSelectorFilterVO):void {
        var _loc2_:String = "as_updateVehicleFilters" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
