package net.wg.gui.lobby.store.views {
import net.wg.data.constants.generated.STORE_TYPES;
import net.wg.gui.lobby.store.views.base.SimpleStoreMenuView;
import net.wg.gui.lobby.store.views.data.FiltersVO;
import net.wg.gui.lobby.store.views.data.FitItemsFiltersVO;

import scaleform.clik.data.DataProvider;

public class OptionalDeviceView extends SimpleStoreMenuView {

    public function OptionalDeviceView() {
        super();
    }

    override public function resetTemporaryHandlers():void {
        super.resetTemporaryHandlers();
        resetHandlers(getTagsArray(), null);
    }

    override public function setFiltersData(param1:FiltersVO, param2:Boolean):void {
        super.setFiltersData(param1, param2);
        if (getUIName() == STORE_TYPES.SHOP) {
            if (!onVehicleChkBx.selected) {
                onVehicleChkBx.selected = true;
            }
            onVehicleChkBx.visible = vehChBxHeader.visible = false;
        }
        var _loc3_:FitItemsFiltersVO = FitItemsFiltersVO(param1);
        setCurrentVehicle(_loc3_.vehicleCD);
        updateSubFilter(getNation());
        selectFilter(getTagsArray(), param1.extra, true, false);
        dispatchViewChange();
    }

    override protected function configUI():void {
        super.configUI();
        vehChBxHeader.text = MENU.SHOP_MENU_OPTIONALDEVICE_EXTRA_NAME;
        fitsTextField.text = MENU.SHOP_MENU_OPTIONALDEVICE_FITS_NAME;
    }

    override protected function onVehicleFilterUpdated(param1:DataProvider, param2:Number, param3:int):void {
        super.onVehicleFilterUpdated(param1, param2, param3);
        if (param1.length == 0) {
            otherVehiclesRadioBtn.selected = true;
            myVehiclesRadioBtn.enabled = false;
        }
        else {
            getFilterData().current = param1[param2].data;
            myVehiclesRadioBtn.enabled = true;
        }
        otherVehiclesRadioBtn.enabled = true;
    }
}
}
