package net.wg.gui.lobby.vehicleBuyWindow {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.utils.VO.PriceVO;

public class VehicleBuyRentItemVO extends DAAPIDataClass {

    private static const ACTION_PRICE_LABEL:String = "actionPrice";

    private static const PRICE_LABEL:String = "price";

    public static const DEF_ITEM_ID:int = -1;

    public var label:String = "";

    public var itemId:int = -1;

    public var price:PriceVO = null;

    public var actionPriceDataVo:ActionPriceVO = null;

    public var enabled:Boolean = true;

    public function VehicleBuyRentItemVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == ACTION_PRICE_LABEL) {
            this.actionPriceDataVo = !!param2 ? new ActionPriceVO(param2) : null;
            return false;
        }
        if (param1 == PRICE_LABEL) {
            this.price = new PriceVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.actionPriceDataVo != null) {
            this.actionPriceDataVo.dispose();
            this.actionPriceDataVo = null;
        }
        this.price.dispose();
        this.price = null;
        super.onDispose();
    }
}
}
