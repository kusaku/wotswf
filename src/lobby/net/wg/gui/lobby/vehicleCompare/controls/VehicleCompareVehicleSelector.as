package net.wg.gui.lobby.vehicleCompare.controls {
import net.wg.data.SortableVoDAAPIDataProvider;
import net.wg.gui.components.controls.interfaces.ISortableTable;
import net.wg.gui.lobby.components.VehicleSelectorFilter;
import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareVehicleSelectorItemVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.interfaces.IDataProvider;

public class VehicleCompareVehicleSelector extends UIComponentEx {

    public var filtersView:VehicleSelectorFilter;

    public var table:ISortableTable = null;

    private var _dataProvider:IDataProvider = null;

    public function VehicleCompareVehicleSelector() {
        super();
        this._dataProvider = new SortableVoDAAPIDataProvider(VehicleCompareVehicleSelectorItemVO);
        this.filtersView.mode = VehicleSelectorFilter.MODE_USER_VEHICLES;
    }

    override protected function onDispose():void {
        this.table.dispose();
        this.table = null;
        this.filtersView.dispose();
        this.filtersView = null;
        this._dataProvider = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.table.listDP = this._dataProvider;
    }

    public function getListDP():IDataProvider {
        return this._dataProvider;
    }

    public function setFiltersData(param1:VehicleSelectorFilterVO):void {
        this.filtersView.setData(param1);
        this.filtersView.validateNow();
        this.filtersView.compatibleOnlyCheckBox.label = VEH_COMPARE.ADDVEHPOPOVER_SHOWONLYMYVAHICLES;
    }

    public function setHeaderDP(param1:IDataProvider):void {
        this.table.headerDP = param1;
    }

    public function updateTableSortField(param1:String, param2:String):void {
        this.table.setSelectedField(param1, param2);
    }
}
}
