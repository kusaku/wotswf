package net.wg.gui.lobby.vehiclePreview.controls {
import flash.events.Event;
import flash.text.TextField;

import net.wg.gui.lobby.components.HeaderBackground;
import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBottomPanelVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewPriceDataVO;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBottomPanel;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBuyingPanel;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ICommons;

import scaleform.clik.constants.InvalidationType;

public class VehPreviewBottomPanel extends UIComponentEx implements IVehPreviewBottomPanel {

    private static const RULERS_GAP:int = 13;

    private static const INVALIDATE_LAYOUT:String = "invalidateLayout";

    public var modulesTitleTf:TextField;

    public var statusInfoTf:TextField;

    public var background:HeaderBackground;

    public var buyingLabelTf:TextField;

    private var _buyingPanel:IVehPreviewBuyingPanel;

    private var _modules:IModulesPanel;

    private var _commons:ICommons;

    public function VehPreviewBottomPanel() {
        super();
        this._commons = App.utils.commons;
    }

    override protected function configUI():void {
        super.configUI();
        this._buyingPanel.addEventListener(Event.RESIZE, this.onBuyingPanelResizeHandler);
    }

    override protected function onDispose():void {
        this._buyingPanel.removeEventListener(Event.RESIZE, this.onBuyingPanelResizeHandler);
        this._modules = null;
        this.modulesTitleTf = null;
        this._buyingPanel.dispose();
        this._buyingPanel = null;
        this.buyingLabelTf = null;
        this.background.dispose();
        this.background = null;
        this.statusInfoTf = null;
        this._commons = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:* = 0;
        var _loc2_:int = 0;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.background.width = width;
            this.invalidateLayout();
        }
        if (isInvalid(INVALIDATE_LAYOUT)) {
            _loc1_ = width >> 1;
            _loc2_ = _loc1_ + RULERS_GAP;
            this._commons.updateTextFieldSize(this.buyingLabelTf, true, false);
            if (this._buyingPanel.visible) {
                this._buyingPanel.x = _loc1_ - this._buyingPanel.width | 0;
                this.buyingLabelTf.x = _loc2_;
            }
            else {
                this.buyingLabelTf.x = _loc1_ - (this.buyingLabelTf.width >> 1);
            }
            this._modules.x = _loc1_ - this._modules.width | 0;
            this.modulesTitleTf.x = _loc2_;
            this.statusInfoTf.x = _loc2_;
        }
    }

    public function update(param1:Object):void {
        var _loc2_:VehPreviewBottomPanelVO = VehPreviewBottomPanelVO(param1);
        this.modulesTitleTf.htmlText = _loc2_.modulesLabel;
        this._buyingPanel.visible = _loc2_.isBuyingAvailable;
        this.buyingLabelTf.htmlText = _loc2_.buyingLabel;
        this.invalidateLayout();
    }

    public function updateBuyButton(param1:Boolean, param2:String):void {
        if (this._buyingPanel.visible) {
            this._buyingPanel.updateBuyButton(param1, param2);
        }
    }

    public function updatePrice(param1:VehPreviewPriceDataVO):void {
        if (this._buyingPanel.visible) {
            this._buyingPanel.updatePrice(param1);
            this.invalidateLayout();
        }
    }

    public function updateVehicleStatus(param1:String):void {
        this.statusInfoTf.htmlText = param1;
        this._commons.updateTextFieldSize(this.statusInfoTf, false, true);
    }

    private function invalidateLayout():void {
        invalidate(INVALIDATE_LAYOUT);
    }

    public function get buyingPanel():IVehPreviewBuyingPanel {
        return this._buyingPanel;
    }

    public function set buyingPanel(param1:IVehPreviewBuyingPanel):void {
        this._buyingPanel = param1;
    }

    public function get modules():IModulesPanel {
        return this._modules;
    }

    public function set modules(param1:IModulesPanel):void {
        this._modules = param1;
    }

    private function onBuyingPanelResizeHandler(param1:Event):void {
        this.invalidateLayout();
    }
}
}
