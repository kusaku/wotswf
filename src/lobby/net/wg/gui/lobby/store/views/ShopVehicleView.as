package net.wg.gui.lobby.store.views {
import net.wg.data.VO.ShopSubFilterData;
import net.wg.data.constants.generated.STORE_CONSTANTS;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.lobby.store.StoreViewsEvent;
import net.wg.gui.lobby.store.views.data.DropDownItemData;
import net.wg.gui.lobby.store.views.data.FiltersVO;
import net.wg.gui.lobby.store.views.data.ShopVehiclesFiltersVO;
import net.wg.gui.lobby.store.views.data.VehiclesFiltersVO;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;

public class ShopVehicleView extends VehicleView {

    public var obtainingType:DropdownMenu;

    public function ShopVehicleView() {
        super();
    }

    override public function getFiltersData():FiltersVO {
        var _loc1_:ShopVehiclesFiltersVO = ShopVehiclesFiltersVO(super.getFiltersData());
        _loc1_.obtainingType = this.getObtainingTypeDropDownSelectedId();
        return _loc1_;
    }

    override public function setFiltersData(param1:FiltersVO, param2:Boolean):void {
        super.setFiltersData(param1, param2);
        var _loc3_:ShopVehiclesFiltersVO = ShopVehiclesFiltersVO(param1);
        this.obtainingType.addEventListener(ListEvent.INDEX_CHANGE, this.onObtainingTypeIndexChangeHandler);
        this.obtainingType.selectedIndex = this.getObtainingTypeDropDownSelectedIndex(_loc3_.obtainingType);
    }

    override public function setSubFilterData(param1:int, param2:ShopSubFilterData):void {
        if (this.obtainingType.dataProvider != null) {
            this.obtainingType.dataProvider.cleanUp();
        }
        this.obtainingType.dataProvider = new DataProvider(param2.vehicleObtainingTypes);
    }

    override protected function onDispose():void {
        this.obtainingType.removeEventListener(ListEvent.INDEX_CHANGE, this.onObtainingTypeIndexChangeHandler);
        this.obtainingType.dispose();
        this.obtainingType = null;
        super.onDispose();
    }

    override protected function createFiltersDataVO():VehiclesFiltersVO {
        return new ShopVehiclesFiltersVO(filtersDataHash);
    }

    private function getObtainingTypeDropDownSelectedIndex(param1:String):int {
        var _loc2_:IDataProvider = this.obtainingType.dataProvider;
        var _loc3_:int = _loc2_.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            if (DropDownItemData(_loc2_.requestItemAt(_loc4_)).id == param1) {
                return _loc4_;
            }
            _loc4_++;
        }
        return _loc3_ > 0 ? 0 : -1;
    }

    private function getObtainingTypeDropDownSelectedId():String {
        var _loc1_:int = this.obtainingType.selectedIndex;
        if (_loc1_ >= 0) {
            return DropDownItemData(this.obtainingType.dataProvider.requestItemAt(_loc1_)).id;
        }
        return null;
    }

    override public function get fittingType():String {
        var _loc1_:String = this.getObtainingTypeDropDownSelectedId();
        if (_loc1_ == STORE_CONSTANTS.BUY_VEHICLE_OBTAINING_TYPE) {
            return STORE_CONSTANTS.VEHICLE;
        }
        if (_loc1_ == STORE_CONSTANTS.RESTORE_VEHICLE_OBTAINING_TYPE) {
            return STORE_CONSTANTS.RESTORE_VEHICLE;
        }
        return super.fittingType;
    }

    private function onObtainingTypeIndexChangeHandler(param1:ListEvent):void {
        dispatchEvent(new StoreViewsEvent(StoreViewsEvent.POPULATE_MENU_FILTER, this.fittingType));
    }

    override protected function get isHangarChkBxEnabled():Boolean {
        return true;
    }
}
}
