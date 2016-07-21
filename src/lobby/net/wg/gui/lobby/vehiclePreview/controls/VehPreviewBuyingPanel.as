package net.wg.gui.lobby.vehiclePreview.controls {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewPriceDataVO;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBuyingPanel;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.events.ButtonEvent;

public class VehPreviewBuyingPanel extends UIComponentEx implements IVehPreviewBuyingPanel {

    private static const VALUE_ICON_GAP:int = 11;

    private static const SALE_BG_OFFSET:int = -31;

    private static const DEFAULT_BUTTON_OFFSET:int = 29;

    private static const SALE_BUTTON_OFFSET:int = 51;

    public var saleBg:Sprite;

    public var priceTf:TextField;

    public var priceIcon:Image;

    private var _buyBtn:ISoundButtonEx;

    private var _priceData:VehPreviewPriceDataVO;

    public function VehPreviewBuyingPanel() {
        super();
        this.priceIcon.addEventListener(Event.CHANGE, this.onPriceIconChangeHandler);
        this._buyBtn.addEventListener(ButtonEvent.CLICK, this.onBuyButtonClickHandler);
    }

    override protected function onDispose():void {
        this.removeRollOverOutListeners(this.saleBg, this.priceTf, this.priceIcon);
        this._buyBtn.removeEventListener(ButtonEvent.CLICK, this.onBuyButtonClickHandler);
        this.priceIcon.removeEventListener(Event.CHANGE, this.onPriceIconChangeHandler);
        this.priceTf = null;
        this.priceIcon.dispose();
        this.priceIcon = null;
        this._buyBtn.dispose();
        this._buyBtn = null;
        this.saleBg = null;
        this._priceData = null;
        super.onDispose();
    }

    public function updateBuyButton(param1:Boolean, param2:String):void {
        this._buyBtn.enabled = param1;
        this._buyBtn.label = param2;
    }

    public function updatePrice(param1:VehPreviewPriceDataVO):void {
        this._priceData = param1;
        this.priceTf.htmlText = param1.value;
        this.priceIcon.source = param1.icon;
        this.saleBg.visible = param1.showAction;
        if (param1.showAction) {
            this.addRollOverOutListeners(this.saleBg, this.priceTf, this.priceIcon);
        }
        else {
            this.removeRollOverOutListeners(this.saleBg, this.priceTf, this.priceIcon);
        }
        App.utils.commons.updateTextFieldSize(this.priceTf, true, true);
        this.layout();
    }

    private function addRollOverOutListeners(...rest):void {
        var _loc2_:DisplayObject = null;
        for each(_loc2_ in rest) {
            _loc2_.addEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        }
    }

    private function removeRollOverOutListeners(...rest):void {
        var _loc2_:DisplayObject = null;
        for each(_loc2_ in rest) {
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER, this.onControlRollOverHandler);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT, this.onControlRollOutHandler);
        }
    }

    private function layout():void {
        var _loc1_:int = 0;
        this.priceTf.x = _loc1_;
        _loc1_ = _loc1_ + this.priceTf.width;
        this.priceIcon.x = _loc1_ - (this.priceIcon.width >> 1) + VALUE_ICON_GAP;
        this._buyBtn.x = _loc1_ + (!!this.saleBg.visible ? SALE_BUTTON_OFFSET : DEFAULT_BUTTON_OFFSET);
        this.priceIcon.y = this.priceTf.y + (this.priceTf.height - this.priceIcon.height >> 1) | 0;
        this.saleBg.x = this.priceTf.x + this.priceTf.width + SALE_BG_OFFSET | 0;
        width = actualWidth;
        dispatchEvent(new Event(Event.RESIZE));
    }

    public function get buyBtn():ISoundButtonEx {
        return this._buyBtn;
    }

    public function set buyBtn(param1:ISoundButtonEx):void {
        this._buyBtn = param1;
    }

    private function onControlRollOverHandler(param1:MouseEvent):void {
        var _loc2_:ActionPriceVO = this._priceData.actionData;
        App.toolTipMgr.showSpecial(this._priceData.actionTooltipType, null, _loc2_.type, _loc2_.key, _loc2_.newPrices, _loc2_.oldPrices, _loc2_.isBuying, _loc2_.forCredits, _loc2_.rentPackage);
    }

    private function onControlRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onBuyButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new VehPreviewEvent(VehPreviewEvent.BUY_CLICK, true));
    }

    private function onPriceIconChangeHandler(param1:Event):void {
        this.layout();
    }
}
}
