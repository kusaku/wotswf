package net.wg.gui.lobby.window {
import net.wg.data.VO.DialogSettingsVO;
import net.wg.data.constants.Currencies;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.infrastructure.base.meta.IConfirmItemWindowMeta;
import net.wg.infrastructure.base.meta.impl.ConfirmItemWindowMeta;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;

public class ConfirmItemWindow extends ConfirmItemWindowMeta implements IConfirmItemWindowMeta {

    private static const NORMAL_COLOR:int = 6447189;

    private static const ACTION_COLOR:int = 16777215;

    private static const RESULT_INVALID:String = "resultInv";

    private static const SELECTED_CURRENCY_INVALID:String = "currencyInv";

    private static const SETTINGS_INVALID:String = "settingsInv";

    private static const ZERO_STRING:String = "0";

    protected var data:ConfirmItemWindowVO;

    private var _settingsVO:DialogSettingsVO;

    private var _currency:String;

    private var _selectedCount:Number = 0;

    private var _locale:ILocale;

    public function ConfirmItemWindow() {
        this._locale = App.utils.locale;
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
        showWindowBgForm = false;
    }

    override public function setWindow(param1:IWindow):void {
        super.setWindow(param1);
        if (param1) {
            invalidate(SETTINGS_INVALID);
        }
    }

    override protected function setLabels():void {
        content.countLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_COUNTLABEL);
        content.leftLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_PRICELABEL);
        content.rightLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
        content.resultLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(SETTINGS_INVALID) && window != null && this._settingsVO != null) {
            window.title = this._settingsVO.title;
            content.submitBtn.label = this._settingsVO.submitBtnLabel;
            content.cancelBtn.label = this._settingsVO.cancelBtnLabel;
        }
        if (this.data == null) {
            return;
        }
        if (isInvalid(InvalidationType.DATA)) {
            this.applyData();
            invalidate(SELECTED_CURRENCY_INVALID);
        }
        if (isInvalid(SELECTED_CURRENCY_INVALID)) {
            this.applyCurrency();
            invalidate(RESULT_INVALID);
        }
        if (isInvalid(RESULT_INVALID)) {
            this.applyResult();
        }
    }

    override protected function onDispose():void {
        this.data = null;
        this._settingsVO = null;
        if (content != null) {
            content.dropdownMenu.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownMenuIndexChangeHandler);
        }
        this._locale = null;
        super.onDispose();
    }

    override protected function setSettings(param1:DialogSettingsVO):void {
        this._settingsVO = param1;
        invalidate(SETTINGS_INVALID);
    }

    protected function applyData():void {
        var _loc5_:int = 0;
        var _loc1_:DropdownMenu = content.dropdownMenu;
        content.moduleName.text = this.data.name;
        content.description.htmlText = this.data.description;
        var _loc2_:int = this.data.price[CURRENCIES_CONSTANTS.CREDITS_INDEX];
        var _loc3_:int = this.data.price[CURRENCIES_CONSTANTS.GOLD_INDEX];
        var _loc4_:int = NORMAL_COLOR;
        if (this.data.isActionNow) {
            _loc5_ = _loc1_.selectedIndex != -1 ? int(_loc1_.selectedIndex) : 1;
            if (_loc1_.dataProvider != null) {
                _loc1_.dataProvider.cleanUp();
            }
            _loc1_.dataProvider = new DataProvider([this._locale.htmlTextWithIcon(this._locale.integer(_loc2_), CURRENCIES_CONSTANTS.CREDITS), this._locale.htmlTextWithIcon(this._locale.gold(_loc3_), CURRENCIES_CONSTANTS.GOLD)]);
            _loc1_.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownMenuIndexChangeHandler, false, 0, true);
            _loc1_.selectedIndex = _loc5_;
            _loc4_ = ACTION_COLOR;
        }
        else if (this.data.currency == CURRENCIES_CONSTANTS.GOLD) {
            content.leftIT.text = this._locale.gold(_loc3_);
        }
        else {
            content.leftIT.text = this._locale.integer(_loc2_);
        }
        content.leftLabel.textColor = _loc4_;
        content.rightLabel.textColor = _loc4_;
        _loc1_.visible = this.data.isActionNow;
        content.leftIT.visible = !this.data.isActionNow;
        if (this.data.defaultValue != Values.DEFAULT_INT) {
            this._selectedCount = this.data.defaultValue;
        }
        else {
            this._selectedCount = content.nsCount.value;
        }
    }

    private function applyCurrency():void {
        var _loc1_:uint = 0;
        if (this.data.isActionNow) {
            if (content.dropdownMenu.selectedIndex == 0) {
                _loc1_ = this.data.maxAvailableCount[CURRENCIES_CONSTANTS.CREDITS_INDEX];
            }
            else {
                _loc1_ = this.data.maxAvailableCount[CURRENCIES_CONSTANTS.GOLD_INDEX];
            }
        }
        else if (this.data.currency == CURRENCIES_CONSTANTS.GOLD) {
            _loc1_ = this.data.maxAvailableCount[CURRENCIES_CONSTANTS.GOLD_INDEX];
        }
        else {
            _loc1_ = this.data.maxAvailableCount[CURRENCIES_CONSTANTS.CREDITS_INDEX];
        }
        var _loc2_:Number = Math.min(1, _loc1_);
        content.nsCount.minimum = _loc2_;
        content.nsCount.maximum = _loc1_;
        content.nsCount.value = Math.min(this._selectedCount, _loc1_);
        content.submitBtn.enabled = _loc2_ > 0;
    }

    private function applyResult():void {
        var _loc1_:Number = NaN;
        var _loc2_:Number = NaN;
        var _loc3_:String = null;
        var _loc4_:String = null;
        var _loc5_:String = null;
        var _loc6_:ActionPriceVO = null;
        if (this.data.isActionNow) {
            if (content.dropdownMenu.selectedIndex == 0) {
                _loc3_ = ZERO_STRING;
                _loc2_ = content.nsCount.value * this.data.price[CURRENCIES_CONSTANTS.CREDITS_INDEX];
                _loc4_ = this._locale.integer(_loc2_);
                _loc5_ = _loc4_;
                this._currency = CURRENCIES_CONSTANTS.CREDITS;
            }
            else {
                _loc4_ = ZERO_STRING;
                _loc1_ = content.nsCount.value * this.data.price[CURRENCIES_CONSTANTS.GOLD_INDEX];
                _loc3_ = this._locale.gold(_loc1_);
                _loc5_ = _loc3_;
                this._currency = CURRENCIES_CONSTANTS.GOLD;
            }
        }
        else {
            this._currency = this.data.currency;
            if (this.data.currency == CURRENCIES_CONSTANTS.GOLD) {
                _loc1_ = content.nsCount.value * this.data.price[CURRENCIES_CONSTANTS.GOLD_INDEX];
                _loc3_ = this._locale.gold(_loc1_);
                _loc5_ = _loc3_;
                _loc4_ = ZERO_STRING;
            }
            else {
                _loc2_ = content.nsCount.value * this.data.price[CURRENCIES_CONSTANTS.CREDITS_INDEX];
                _loc4_ = this._locale.integer(_loc2_);
                _loc5_ = _loc4_;
                _loc3_ = ZERO_STRING;
            }
        }
        content.leftResultIT.text = _loc3_;
        content.rightResultIT.text = _loc4_;
        content.leftIT.icon = this._currency;
        content.leftIT.textColor = Currencies.TEXT_COLORS[this._currency];
        content.rightIT.icon = this._currency;
        content.rightIT.textColor = Currencies.TEXT_COLORS[this._currency];
        content.rightIT.text = _loc5_;
        content.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
        if (this.data.actionPriceData != null) {
            _loc6_ = this.data.actionPriceData;
            if (this._currency == CURRENCIES_CONSTANTS.CREDITS) {
                _loc6_.newPrices = [_loc2_, _loc6_.newPrices[CURRENCIES_CONSTANTS.GOLD_INDEX]];
                _loc6_.oldPrices = [_loc6_.oldPriceBases[CURRENCIES_CONSTANTS.CREDITS_INDEX] * content.nsCount.value, _loc6_.oldPrices[CURRENCIES_CONSTANTS.GOLD_INDEX]];
            }
            else {
                _loc6_.newPrices = [_loc6_.newPrices[CURRENCIES_CONSTANTS.CREDITS_INDEX], _loc1_];
                _loc6_.oldPrices = [_loc6_.oldPrices[CURRENCIES_CONSTANTS.CREDITS_INDEX], _loc6_.oldPriceBases[CURRENCIES_CONSTANTS.GOLD_INDEX] * content.nsCount.value];
            }
            _loc6_.forCredits = this._currency == CURRENCIES_CONSTANTS.CREDITS;
        }
        content.actionPrice.setData(_loc6_);
        content.rightIT.visible = !content.actionPrice.visible;
    }

    protected function clearData():void {
        if (this.data != null) {
            this.data.dispose();
            this.data = null;
        }
    }

    override protected function selectedCountChangeHandler(param1:IndexEvent):void {
        this._selectedCount = content.nsCount.value;
        invalidate(RESULT_INVALID);
    }

    override protected function submitBtnClickHandler(param1:ButtonEvent):void {
        submitS(this._selectedCount, this._currency);
    }

    private function onDropDownMenuIndexChangeHandler(param1:ListEvent):void {
        invalidate(SELECTED_CURRENCY_INVALID);
    }
}
}
