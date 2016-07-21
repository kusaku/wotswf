package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.InitBuyWindowVO;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesTotalVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class CustomizationBuyWindowMeta extends AbstractWindowView {

    public var buy:Function;

    public var selectItem:Function;

    public var deselectItem:Function;

    public var changePriceItem:Function;

    private var _initBuyWindowVO:InitBuyWindowVO;

    private var _purchasesTotalVO:PurchasesTotalVO;

    public function CustomizationBuyWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._initBuyWindowVO) {
            this._initBuyWindowVO.dispose();
            this._initBuyWindowVO = null;
        }
        if (this._purchasesTotalVO) {
            this._purchasesTotalVO.dispose();
            this._purchasesTotalVO = null;
        }
        super.onDispose();
    }

    public function buyS():void {
        App.utils.asserter.assertNotNull(this.buy, "buy" + Errors.CANT_NULL);
        this.buy();
    }

    public function selectItemS(param1:uint):void {
        App.utils.asserter.assertNotNull(this.selectItem, "selectItem" + Errors.CANT_NULL);
        this.selectItem(param1);
    }

    public function deselectItemS(param1:uint):void {
        App.utils.asserter.assertNotNull(this.deselectItem, "deselectItem" + Errors.CANT_NULL);
        this.deselectItem(param1);
    }

    public function changePriceItemS(param1:uint, param2:uint):void {
        App.utils.asserter.assertNotNull(this.changePriceItem, "changePriceItem" + Errors.CANT_NULL);
        this.changePriceItem(param1, param2);
    }

    public function as_setInitData(param1:Object):void {
        if (this._initBuyWindowVO) {
            this._initBuyWindowVO.dispose();
        }
        this._initBuyWindowVO = new InitBuyWindowVO(param1);
        this.setInitData(this._initBuyWindowVO);
    }

    public function as_setTotalData(param1:Object):void {
        if (this._purchasesTotalVO) {
            this._purchasesTotalVO.dispose();
        }
        this._purchasesTotalVO = new PurchasesTotalVO(param1);
        this.setTotalData(this._purchasesTotalVO);
    }

    protected function setInitData(param1:InitBuyWindowVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTotalData(param1:PurchasesTotalVO):void {
        var _loc2_:String = "as_setTotalData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
