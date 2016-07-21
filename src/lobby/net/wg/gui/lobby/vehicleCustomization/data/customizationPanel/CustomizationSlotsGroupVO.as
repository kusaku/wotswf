package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel {
import net.wg.data.daapi.base.DAAPIDataClass;

public class CustomizationSlotsGroupVO extends DAAPIDataClass {

    private static const RENDERERS_DATA:String = "data";

    public var header:String = "";

    private var _data:Vector.<CustomizationSlotVO> = null;

    public function CustomizationSlotsGroupVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        if (param1 == RENDERERS_DATA) {
            this._data = new Vector.<CustomizationSlotVO>();
            for each(_loc3_ in param2) {
                this._data.push(new CustomizationSlotVO(_loc3_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:CustomizationSlotVO = null;
        for each(_loc1_ in this._data) {
            _loc1_.dispose();
        }
        this._data.splice(0, this._data.length);
        this._data = null;
        super.onDispose();
    }

    public function get data():Vector.<CustomizationSlotVO> {
        return this._data;
    }
}
}
