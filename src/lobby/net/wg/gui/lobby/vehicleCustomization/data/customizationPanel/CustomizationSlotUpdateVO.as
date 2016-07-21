package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationSlotUpdateVO extends DAAPIDataClass {

    private static const DATA_FIELD:String = "data";

    public var type:int = -1;

    public var idx:int = -1;

    private var _data:CustomizationSlotVO = null;

    public function CustomizationSlotUpdateVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == DATA_FIELD) {
            this._data = new CustomizationSlotVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this._data.dispose();
        this._data = null;
        super.onDispose();
    }

    public function get data():CustomizationSlotVO {
        return this._data;
    }
}
}
