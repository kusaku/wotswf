package net.wg.gui.lobby.vehicleCustomization.data.purchase {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.vehicleCustomization.data.DDPriceRendererVO;

public class PurchaseVO extends DAAPIDataClass {

    private static const DD_PRICE:String = "DDPrice";

    private static const SALE_PRICE_FIELD:String = "salePrice";

    public var id:uint = 0;

    public var slotIdx:uint = 0;

    public var price:uint = 0;

    public var cType:uint = 0;

    public var selectIndex:int = -1;

    public var selected:Boolean = false;

    public var itemName:String = "";

    public var imgBonus:String = "";

    public var lblBonus:String = "";

    public var titleMode:Boolean = false;

    public var titleText:String = "";

    public var duplicatePriceText:String = "";

    public var isDuplicatePrice:Boolean = false;

    public var duplicatePriceTooltip:String = "";

    private var _DDPrice:Vector.<DDPriceRendererVO> = null;

    private var _salePrice:ActionPriceVO = null;

    public function PurchaseVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Object = null;
        if (param1 == SALE_PRICE_FIELD) {
            this._salePrice = new ActionPriceVO(param2);
            return false;
        }
        if (param1 == DD_PRICE) {
            this._DDPrice = new Vector.<DDPriceRendererVO>();
            _loc3_ = null;
            for each(_loc3_ in param2) {
                this._DDPrice.push(new DDPriceRendererVO(_loc3_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:DDPriceRendererVO = null;
        if (this._salePrice) {
            this._salePrice.dispose();
            this._salePrice = null;
        }
        if (this._DDPrice) {
            for each(_loc1_ in this._DDPrice) {
                _loc1_.dispose();
            }
            this._DDPrice.splice(0, this._DDPrice.length);
            this._DDPrice = null;
        }
        super.onDispose();
    }

    public function get salePrice():ActionPriceVO {
        return this._salePrice;
    }

    public function set salePrice(param1:ActionPriceVO):void {
        this._salePrice = param1;
    }

    public function get dDPrice():Vector.<DDPriceRendererVO> {
        return this._DDPrice;
    }

    public function set dDPrice(param1:Vector.<DDPriceRendererVO>):void {
        this._DDPrice = param1;
    }
}
}
