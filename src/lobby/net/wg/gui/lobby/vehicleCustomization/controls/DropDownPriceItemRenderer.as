package net.wg.gui.lobby.vehicleCustomization.controls {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.DropDownListItemRendererSound;
import net.wg.gui.lobby.vehicleCustomization.data.DDPriceRendererVO;

import scaleform.clik.constants.InvalidationType;

public class DropDownPriceItemRenderer extends DropDownListItemRendererSound {

    private static const PRICE_OFFSET:int = 5;

    public var actionPrice:ActionPrice = null;

    public var price:TextField = null;

    public var priceLabel:TextField = null;

    public function DropDownPriceItemRenderer() {
        super();
    }

    override public function setData(param1:Object):void {
        invalidate(InvalidationType.DATA);
        super.setData(param1);
    }

    override protected function configUI():void {
        this.price.autoSize = TextFieldAutoSize.LEFT;
        super.configUI();
        this.setup();
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.DATA)) {
            this.setup();
        }
        super.draw();
    }

    override protected function onDispose():void {
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.price = null;
        this.priceLabel = null;
        super.onDispose();
    }

    private function setup():void {
        var _loc1_:DDPriceRendererVO = null;
        if (data != null) {
            _loc1_ = DDPriceRendererVO(data);
            this.actionPrice.setData(_loc1_.salePrice);
            this.priceLabel.htmlText = _loc1_.labelPrice;
            this.price.htmlText = _loc1_.label;
            this.price.visible = !_loc1_.isSale;
            this.actionPrice.x = this.priceLabel.x - PRICE_OFFSET;
            this.price.x = this.priceLabel.x - this.price.width;
            this.actionPrice.validateNow();
        }
    }
}
}
