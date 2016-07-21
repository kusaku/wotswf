package net.wg.gui.lobby.vehiclePreview.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class VehPreviewPriceDataVO extends DAAPIDataClass {

    private static const ACTION_DATA_FIELD_NAME:String = "actionData";

    public var value:String = "";

    public var icon:String = "";

    public var showAction:Boolean = false;

    public var actionTooltipType:String = "";

    public var actionData:ActionPriceVO = null;

    public function VehPreviewPriceDataVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ACTION_DATA_FIELD_NAME && param2 != null) {
            this.actionData = new ActionPriceVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.actionData != null) {
            this.actionData.dispose();
            this.actionData = null;
        }
        super.onDispose();
    }
}
}
