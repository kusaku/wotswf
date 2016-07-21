package net.wg.gui.lobby.window {
import flash.events.Event;
import flash.text.TextField;

import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.WalletResourcesStatus;
import net.wg.infrastructure.base.meta.IExchangeWindowMeta;
import net.wg.utils.ILocale;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;

public class ExchangeCurrencyWindow extends BaseExchangeWindow implements IExchangeWindowMeta {

    private static const SELECTED_PRIMARY_CURRENCY_INVALID:String = "selectedPrimaryCurrencyInv";

    private static const TOTAL_SECONDARY_CURRENCY_CHANGED:String = "totalSecondaryCurrencyChanged";

    private static const SET_WALLET_STATUS_INVALID:String = "set_wallet_status_invalid";

    public var submitBtn:SoundButtonEx;

    public var cancelBtn:SoundButtonEx;

    public var headerMC:ExchangeHeader;

    public var nsPrimaryCurrency:NumericStepper;

    public var nsSecondaryCurrency:NumericStepper;

    public var lblToExchange:TextField;

    public var lblExchangeResult:TextField;

    public var onHandPrimaryCurrencyText:IconText;

    public var onHandSecondaryCurrencyText:IconText;

    public var resultPrimaryCurrencyText:IconText;

    public var resultSecondaryCurrencyText:IconText;

    public var toExchangePrimaryCurrencyIco:IconText;

    public var toExchangeSecondaryCurrencyIco:IconText;

    public var onHandHaveNotGold:WalletResourcesStatus = null;

    public var resultHaveNotGold:WalletResourcesStatus = null;

    protected var isUpdateResult:Boolean;

    private var _selectedPrimaryCurrency:uint = 0;

    private var _totalSecondaryCurrency:Number = 0;

    public function ExchangeCurrencyWindow() {
        super();
        isModal = false;
        canResize = false;
        canMinimize = false;
        isCentered = true;
    }

    override public function as_setPrimaryCurrency(param1:Number):void {
        if (totalPrimaryCurrency != param1) {
            totalPrimaryCurrency = param1;
            if (totalPrimaryCurrency - this.selectedPrimaryCurrency < 0) {
                this.selectedPrimaryCurrency = 0;
                invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
            }
            invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.submitBtn.addEventListener(ButtonEvent.CLICK, this.submitBtnClickHandler);
        this.cancelBtn.addEventListener(ButtonEvent.CLICK, cancelBtnClickHandler);
        this.nsPrimaryCurrency.minimum = this.nsSecondaryCurrency.minimum = 0;
        this.nsPrimaryCurrency.addEventListener(IndexEvent.INDEX_CHANGE, this.nsFirstCurrencyChangeHandler);
        this.nsSecondaryCurrency.addEventListener(IndexEvent.INDEX_CHANGE, this.nsSecondaryCurrencyChangeHandler);
    }

    override protected function draw():void {
        var _loc1_:* = false;
        super.draw();
        if (isInvalid(SET_WALLET_STATUS_INVALID)) {
            _loc1_ = false;
            if (this.onHandHaveNotGold && this.resultHaveNotGold) {
                _loc1_ = !this.onHandHaveNotGold.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
                this.resultHaveNotGold.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
            }
            if (this.onHandPrimaryCurrencyText) {
                this.onHandPrimaryCurrencyText.visible = _loc1_;
            }
            if (this.resultPrimaryCurrencyText) {
                this.resultPrimaryCurrencyText.visible = _loc1_;
            }
            this.submitBtn.enabled = _loc1_;
        }
        if (isInvalid(TOTAL_SECONDARY_CURRENCY_CHANGED)) {
            invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
            this.onHandSecondaryCurrencyText.text = App.utils.locale.gold(this._totalSecondaryCurrency);
            this.isUpdateResult = true;
        }
        if (isInvalid(SELECTED_PRIMARY_CURRENCY_INVALID)) {
            this.isUpdateResult = true;
            this.nsPrimaryCurrency.value = this.selectedPrimaryCurrency;
            this.nsSecondaryCurrency.value = this.selectedPrimaryCurrency * actualRate;
            this.submitBtn.enabled = this.isSubmitOperationAllowed();
        }
        if (this.isUpdateResult) {
            this.applyResultUpdating();
        }
    }

    override protected function applyRatesChanges():void {
        var _loc1_:Number = 1;
        this.nsPrimaryCurrency.stepSize = _loc1_;
        this.nsSecondaryCurrency.stepSize = actualRate * _loc1_;
        this.headerMC.isActionMode = actionMode;
        this.headerMC.setRates(rate, actionRate);
        invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
    }

    override protected function applyPrimaryCurrencyChange():void {
        this.onHandPrimaryCurrencyText.text = App.utils.locale.gold(totalPrimaryCurrency);
        this.isUpdateResult = true;
    }

    override protected function onDispose():void {
        this.submitBtn.removeEventListener(ButtonEvent.CLICK, this.submitBtnClickHandler);
        this.cancelBtn.removeEventListener(ButtonEvent.CLICK, cancelBtnClickHandler);
        this.nsPrimaryCurrency.removeEventListener(IndexEvent.INDEX_CHANGE, this.nsFirstCurrencyChangeHandler);
        this.nsSecondaryCurrency.removeEventListener(IndexEvent.INDEX_CHANGE, this.nsSecondaryCurrencyChangeHandler);
        this.submitBtn.dispose();
        this.submitBtn = null;
        this.cancelBtn.dispose();
        this.cancelBtn = null;
        this.headerMC.dispose();
        this.headerMC = null;
        this.onHandPrimaryCurrencyText.dispose();
        this.onHandPrimaryCurrencyText = null;
        this.onHandSecondaryCurrencyText.dispose();
        this.onHandSecondaryCurrencyText = null;
        this.resultPrimaryCurrencyText.dispose();
        this.resultPrimaryCurrencyText = null;
        this.resultSecondaryCurrencyText.dispose();
        this.resultSecondaryCurrencyText = null;
        this.toExchangePrimaryCurrencyIco.dispose();
        this.toExchangePrimaryCurrencyIco = null;
        this.toExchangeSecondaryCurrencyIco.dispose();
        this.toExchangeSecondaryCurrencyIco = null;
        this.nsPrimaryCurrency.dispose();
        this.nsPrimaryCurrency = null;
        this.nsSecondaryCurrency.dispose();
        this.nsSecondaryCurrency = null;
        if (this.onHandHaveNotGold) {
            this.onHandHaveNotGold.dispose();
            this.onHandHaveNotGold = null;
        }
        if (this.resultHaveNotGold) {
            this.resultHaveNotGold.dispose();
            this.resultHaveNotGold = null;
        }
        this.lblToExchange = null;
        this.lblExchangeResult = null;
        super.onDispose();
    }

    public function as_setSecondaryCurrency(param1:Number):void {
        if (this._totalSecondaryCurrency != param1) {
            this._totalSecondaryCurrency = param1;
            invalidate(TOTAL_SECONDARY_CURRENCY_CHANGED);
        }
    }

    public function as_setWalletStatus(param1:Object):void {
        App.utils.voMgr.walletStatusVO.update(param1);
        invalidate(SET_WALLET_STATUS_INVALID);
    }

    protected function isSubmitOperationAllowed():Boolean {
        return this.selectedPrimaryCurrency > 0;
    }

    protected function applyResultUpdating():void {
        var _loc1_:ILocale = App.utils.locale;
        var _loc2_:Number = totalPrimaryCurrency - this.selectedPrimaryCurrency;
        this.resultPrimaryCurrencyText.text = _loc1_.gold(_loc2_);
        this.resultSecondaryCurrencyText.text = _loc1_.gold(this._totalSecondaryCurrency + this.selectedPrimaryCurrency * actualRate);
    }

    public function get selectedPrimaryCurrency():Number {
        return this._selectedPrimaryCurrency;
    }

    public function set selectedPrimaryCurrency(param1:Number):void {
        if (this._selectedPrimaryCurrency == param1) {
            return;
        }
        this._selectedPrimaryCurrency = param1;
    }

    protected function submitBtnClickHandler(param1:Event):void {
        exchangeS(this.selectedPrimaryCurrency);
    }

    private function nsSecondaryCurrencyChangeHandler(param1:IndexEvent):void {
        this.selectedPrimaryCurrency = param1.index / actualRate | 0;
        invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
    }

    private function nsFirstCurrencyChangeHandler(param1:IndexEvent):void {
        this.selectedPrimaryCurrency = param1.index;
        invalidate(SELECTED_PRIMARY_CURRENCY_INVALID);
    }
}
}
