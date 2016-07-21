package net.wg.gui.lobby.store.views.base {
import flash.text.TextField;

import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.RadioButton;

public class SimpleStoreMenuView extends FitsSelectableStoreMenuView {

    public var myVehiclesRadioBtn:RadioButton = null;

    public var otherVehiclesRadioBtn:RadioButton = null;

    public var onVehicleChkBx:CheckBox = null;

    public var vehChBxHeader:TextField;

    public function SimpleStoreMenuView() {
        super();
    }

    override protected function onTagsArrayRequest():Array {
        return [new ViewUIElementVO("onVehicle", this.onVehicleChkBx)];
    }

    override protected function onFitsArrayRequest():Array {
        return [new ViewUIElementVO("myVehicle", myVehicleRadioBtn), new ViewUIElementVO("myVehicles", this.myVehiclesRadioBtn), new ViewUIElementVO("otherVehicles", this.otherVehiclesRadioBtn)];
    }

    override protected function getTagsName():String {
        return "extra";
    }
}
}
