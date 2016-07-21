package net.wg.gui.lobby.vehiclePreview.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.data.DataClassItemVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class VehPreviewInfoPanelVO extends DAAPIDataClass {

    private static const TAB_DATA_FIELD_NAME:String = "tabData";

    public var tabData:Vector.<DataClassItemVO> = null;

    public var selectedTab:int = -1;

    public var nation:String = "";

    public function VehPreviewInfoPanelVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == TAB_DATA_FIELD_NAME) {
            this.tabData = Vector.<DataClassItemVO>(App.utils.data.convertVOArrayToVector(param1, param2, DataClassItemVO));
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        if (this.tabData != null) {
            for each(_loc1_ in this.tabData) {
                _loc1_.dispose();
            }
            this.tabData.fixed = false;
            this.tabData.splice(0, this.tabData.length);
            this.tabData = null;
        }
        super.onDispose();
    }
}
}
