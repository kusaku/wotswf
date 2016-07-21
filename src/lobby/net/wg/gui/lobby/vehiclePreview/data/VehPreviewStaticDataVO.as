package net.wg.gui.lobby.vehiclePreview.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.data.ButtonBarItemVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class VehPreviewStaticDataVO extends DAAPIDataClass {

    private static const HEADER_FIELD_NAME:String = "header";

    private static const BOTTOM_PANEL_FIELD_NAME:String = "bottomPanel";

    private static const VEHICLE_INFO_FIELD_NAME:String = "vehicleInfo";

    private static const TAB_BUTTONS_FIELD_NAME:String = "tabButtonsData";

    public var header:VehPreviewHeaderVO = null;

    public var tabButtonsData:Array = null;

    public var bottomPanel:VehPreviewBottomPanelVO = null;

    public var vehicleInfo:VehPreviewVehicleInfoPanelVO = null;

    public function VehPreviewStaticDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == HEADER_FIELD_NAME) {
            this.header = new VehPreviewHeaderVO(param2);
            return false;
        }
        if (param1 == BOTTOM_PANEL_FIELD_NAME) {
            this.bottomPanel = new VehPreviewBottomPanelVO(param2);
            return false;
        }
        if (param1 == VEHICLE_INFO_FIELD_NAME) {
            this.vehicleInfo = new VehPreviewVehicleInfoPanelVO(param2);
            return false;
        }
        if (param1 == TAB_BUTTONS_FIELD_NAME) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, _loc3_ + Errors.CANT_NULL);
            this.tabButtonsData = [];
            for each(_loc4_ in param2) {
                this.tabButtonsData.push(new ButtonBarItemVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        this.header.dispose();
        this.header = null;
        this.bottomPanel.dispose();
        this.bottomPanel = null;
        this.vehicleInfo.dispose();
        this.vehicleInfo = null;
        for each(_loc1_ in this.tabButtonsData) {
            _loc1_.dispose();
        }
        this.tabButtonsData.splice(0, this.tabButtonsData.length);
        this.tabButtonsData = null;
        super.onDispose();
    }
}
}
