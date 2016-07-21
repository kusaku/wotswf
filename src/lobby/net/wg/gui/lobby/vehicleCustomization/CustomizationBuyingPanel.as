package net.wg.gui.lobby.vehicleCustomization {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.gui.components.controls.Image;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBuyingPanelInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBuyingPanelVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;

public class CustomizationBuyingPanel extends UIComponentEx {

    public var totalPriceGold:TextField = null;

    public var totalPriceCredits:TextField = null;

    public var goldIcon:Image = null;

    public var creditsIcon:Image = null;

    public var background:Sprite = null;

    private var _data:CustomizationBuyingPanelVO = null;

    private var _toolTipMgr:ITooltipMgr = null;

    public function CustomizationBuyingPanel() {
        super();
    }

    override protected function draw():void {
        super.draw();
        if (this._data != null && isInvalid(InvalidationType.DATA)) {
            this.totalPriceCredits.htmlText = this._data.totalPriceCredits;
            this.totalPriceGold.htmlText = this._data.totalPriceGold;
        }
    }

    override protected function configUI():void {
        super.configUI();
        _deferredDispose = true;
        this._toolTipMgr = App.toolTipMgr;
        this.background.mouseEnabled = false;
        this.totalPriceGold.autoSize = TextFieldAutoSize.RIGHT;
        this.totalPriceCredits.autoSize = TextFieldAutoSize.RIGHT;
        this.totalPriceGold.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.totalPriceGold.addEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceGoldHandler);
        this.totalPriceCredits.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.totalPriceCredits.addEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceCreditsHandler);
        this.goldIcon.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.goldIcon.addEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceGoldHandler);
        this.creditsIcon.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.creditsIcon.addEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceCreditsHandler);
    }

    override protected function onBeforeDispose():void {
        this.totalPriceGold.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.totalPriceGold.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceGoldHandler);
        this.totalPriceCredits.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.totalPriceCredits.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceCreditsHandler);
        this.goldIcon.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.goldIcon.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceGoldHandler);
        this.creditsIcon.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.creditsIcon.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverPriceCreditsHandler);
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._toolTipMgr = null;
        this.totalPriceCredits = null;
        this.totalPriceGold = null;
        this.background = null;
        this._data = null;
        this.goldIcon.dispose();
        this.goldIcon = null;
        this.creditsIcon.dispose();
        this.creditsIcon = null;
        super.onDispose();
    }

    public function setData(param1:CustomizationBuyingPanelVO):void {
        this._data = param1;
        invalidateData();
    }

    public function setInitData(param1:CustomizationBuyingPanelInitVO):void {
        this.goldIcon.source = param1.goldIcon;
        this.creditsIcon.source = param1.creditsIcon;
    }

    private function showNotEnoughCreditsTooltip():void {
        if (!this._data.enoughCredits) {
            this._toolTipMgr.showComplex(this._data.notEnoughCreditsTooltip);
        }
    }

    private function showNotEnoughGoldTooltip():void {
        if (!this._data.enoughGold) {
            this._toolTipMgr.showComplex(this._data.notEnoughGoldTooltip);
        }
    }

    private function onOverPriceGoldHandler(param1:MouseEvent):void {
        this.showNotEnoughGoldTooltip();
    }

    private function onOverPriceCreditsHandler(param1:MouseEvent):void {
        this.showNotEnoughCreditsTooltip();
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }
}
}
