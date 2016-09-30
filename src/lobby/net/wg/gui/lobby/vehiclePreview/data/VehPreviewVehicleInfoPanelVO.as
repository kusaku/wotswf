package net.wg.gui.lobby.vehiclePreview.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.data.VehCompareEntrypointVO;

public class VehPreviewVehicleInfoPanelVO extends DAAPIDataClass {

    private static const VEH_COMPARE_DATA_FIELD_NAME:String = "vehCompareData";

    public var earnedXP:Number = 0.0;

    public var info:String = "";

    public var infoTooltip:String = "";

    private var _vehCompareVO:VehCompareEntrypointVO = null;

    public function VehPreviewVehicleInfoPanelVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == VEH_COMPARE_DATA_FIELD_NAME) {
            this.clearVehCompareVO();
            this._vehCompareVO = new VehCompareEntrypointVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.clearVehCompareVO();
        super.onDispose();
    }

    private function clearVehCompareVO():void {
        if (this._vehCompareVO != null) {
            this._vehCompareVO.dispose();
            this._vehCompareVO = null;
        }
    }

    public function get vehCompareVO():VehCompareEntrypointVO {
        return this._vehCompareVO;
    }
}
}
