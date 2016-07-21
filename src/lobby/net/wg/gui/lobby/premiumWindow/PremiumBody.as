package net.wg.gui.lobby.premiumWindow {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.TileList;
import net.wg.gui.lobby.premiumWindow.data.PremiumItemRendererVo;
import net.wg.gui.lobby.premiumWindow.data.PremiumWindowRatesVO;
import net.wg.gui.lobby.premiumWindow.events.PremiumWindowEvent;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.gfx.MouseEventEx;

public class PremiumBody extends UIComponentEx {

    public var headerTf:TextField = null;

    public var premList:TileList = null;

    private var _rates:Array = null;

    private var _headerTfTooltip:String = null;

    private var _selectedRateId:String = "";

    private var _lastSelectedItem:String;

    public function PremiumBody() {
        super();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._rates != null) {
            if (this.premList.dataProvider != null) {
                this.premList.dataProvider.cleanUp();
            }
            this.premList.dataProvider = new DataProvider(this._rates);
            this.premList.selectedIndex = this.getSelectedRateIndexById(this._selectedRateId);
        }
    }

    override protected function onDispose():void {
        this.premList.removeEventListener(ListEvent.INDEX_CHANGE, this.onPremListIndexChangeHandler);
        this.premList.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK, this.onPremListItemDoubleClickHandler);
        this.setHeaderTfListeners(false);
        this.headerTf = null;
        this.premList.dispose();
        this.premList = null;
        this._rates = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.premList.addEventListener(ListEvent.INDEX_CHANGE, this.onPremListIndexChangeHandler);
        this.premList.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, this.onPremListItemDoubleClickHandler);
    }

    public function getSelectedRate():String {
        return this._selectedRateId;
    }

    public function setData(param1:PremiumWindowRatesVO):void {
        this.headerTf.htmlText = param1.header;
        this._headerTfTooltip = param1.headerTooltip;
        this.setHeaderTfListeners(StringUtils.isNotEmpty(this._headerTfTooltip));
        this._rates = param1.rates;
        this._selectedRateId = this.getSelectedRateId(param1.selectedRateId);
        invalidateData();
    }

    private function setHeaderTfListeners(param1:Boolean):void {
        if (param1) {
            this.headerTf.addEventListener(MouseEvent.ROLL_OVER, this.onHeaderTfRollOverHandler);
            this.headerTf.addEventListener(MouseEvent.ROLL_OUT, this.onHeaderTfRollOutHandler);
        }
        else {
            this.headerTf.removeEventListener(MouseEvent.ROLL_OVER, this.onHeaderTfRollOverHandler);
            this.headerTf.removeEventListener(MouseEvent.ROLL_OUT, this.onHeaderTfRollOutHandler);
        }
    }

    private function getSelectedRateId(param1:String):String {
        var _loc2_:PremiumItemRendererVo = null;
        if (this._lastSelectedItem) {
            for each(_loc2_ in this._rates) {
                if (_loc2_.id == this._lastSelectedItem && _loc2_.enabled) {
                    return this._lastSelectedItem;
                }
            }
        }
        return param1;
    }

    private function getSelectedRateIndexById(param1:String):int {
        var _loc2_:int = -1;
        var _loc3_:Number = this._rates.length;
        var _loc4_:Number = 0;
        while (_loc4_ < _loc3_) {
            if (param1 == PremiumItemRendererVo(this._rates[_loc4_]).id) {
                _loc2_ = _loc4_;
                break;
            }
            _loc4_++;
        }
        return _loc2_;
    }

    private function onHeaderTfRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._headerTfTooltip);
    }

    private function onHeaderTfRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onPremListIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:PremiumItemRenderer = PremiumItemRenderer(param1.itemRenderer);
        var _loc3_:PremiumItemRendererVo = _loc2_.dataVO;
        if (_loc3_ != null) {
            this._selectedRateId = this._lastSelectedItem = _loc3_.id;
        }
    }

    private function onPremListItemDoubleClickHandler(param1:ListEvent):void {
        if (param1.buttonIdx == MouseEventEx.LEFT_BUTTON) {
            if (param1.itemRenderer.enabled) {
                dispatchEvent(new PremiumWindowEvent(PremiumWindowEvent.PREMIUM_RENDERER_DOUBLE_CLICK));
            }
        }
    }
}
}
