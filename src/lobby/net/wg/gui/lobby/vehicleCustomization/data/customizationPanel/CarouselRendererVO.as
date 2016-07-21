package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel {
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class CarouselRendererVO extends CustomizationItemVO {

    private static const SALE_PRICE_FIELD:String = "salePrice";

    public var bonusPower:String = "";

    public var label:String = "";

    public var state:String = "";

    public var selected:Boolean = false;

    public var goToTaskBtnVisible:Boolean = false;

    public var goToTaskBtnText:String = "";

    public var newElementIndicatorVisible:Boolean = false;

    private var _salePrice:ActionPriceVO = null;

    public function CarouselRendererVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SALE_PRICE_FIELD) {
            this._salePrice = new ActionPriceVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this._salePrice != null) {
            this._salePrice.dispose();
            this._salePrice = null;
        }
        super.onDispose();
    }

    public function get salePrice():ActionPriceVO {
        return this._salePrice;
    }

    public function set salePrice(param1:ActionPriceVO):void {
        this._salePrice = param1;
    }
}
}
