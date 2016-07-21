package net.wg.gui.lobby.modulesPanel.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class DeviceVO extends DAAPIDataClass {

    private static const ACTION_PRICE_DATA_FIELD_DATA:String = "actionPriceData";

    public var currency:String = "";

    public var showPrice:Boolean = true;

    public var price:String = "";

    public var isEnoughCurrency:Boolean = false;

    public var id:Number = NaN;

    public var type:String = "";

    public var slotIndex:int = -1;

    public var name:String = "";

    public var actionPriceData:ActionPriceVO = null;

    public var target:String = "";

    public var targetVisible:Boolean = false;

    public var status:String = "";

    public var isSelected:Boolean = false;

    public var disabled:Boolean = false;

    public var moduleLabel:String = "";

    public var tooltipType:String = "";

    public function DeviceVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        if (this.actionPriceData != null) {
            this.actionPriceData.dispose();
            this.actionPriceData = null;
        }
        super.onDispose();
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ACTION_PRICE_DATA_FIELD_DATA && param2 != null) {
            this.actionPriceData = new ActionPriceVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }
}
}
