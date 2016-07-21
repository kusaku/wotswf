package net.wg.gui.lobby.fortifications.windows {
import flash.text.TextFieldAutoSize;

import net.wg.data.VO.DialogSettingsVO;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.gui.components.advanced.ExtraModuleIcon;
import net.wg.gui.lobby.fortifications.data.ConfirmOrderVO;
import net.wg.infrastructure.base.meta.IFortOrderConfirmationWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortOrderConfirmationWindowMeta;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.utils.ILocale;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;

public class FortOrderConfirmationWindow extends FortOrderConfirmationWindowMeta implements IFortOrderConfirmationWindowMeta {

    private static const DATA_INVALID:String = "dataInv";

    private static const RESULT_INVALID:String = "resultInv";

    private static const SELECTED_CURRENCY_INVALID:String = "currencyInv";

    private static const SETTINGS_INVALID:String = "settingsInv";

    private static const LABEL_PADDING:int = 155;

    private static const TIME_COLOR:int = 9211006;

    private static const PURPLE_COLOR:int = 10656624;

    private static const TEXT_PADDING:int = 5;

    private var _orderInfo:ConfirmOrderVO;

    private var _settings:DialogSettingsVO;

    private var _selectedCount:Number = 0;

    public function FortOrderConfirmationWindow() {
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

    override protected function configUI():void {
        super.configUI();
        content.dropdownMenu.visible = content.actionPrice.visible = false;
        content.leftIT.iconPosition = content.leftResultIT.iconPosition = TextFieldAutoSize.LEFT;
        content.leftIT.icon = content.leftResultIT.icon = IconsTypes.EMPTY;
        content.rightIT.icon = content.rightResultIT.icon = IconsTypes.DEFRES;
        content.leftResultIT.x = content.leftLabel.x = content.leftIT.x = LABEL_PADDING;
        content.leftResultIT.textColor = content.leftIT.textColor = TIME_COLOR;
        content.rightResultIT.textColor = content.rightIT.textColor = PURPLE_COLOR;
    }

    override protected function onDispose():void {
        this._orderInfo = null;
        this._settings = null;
        super.onDispose();
    }

    override protected function setLabels():void {
        content.countLabel.text = DIALOGS.CONFIRMMODULEDIALOG_COUNTLABEL;
        content.leftLabel.text = FORTIFICATIONS.ORDERS_ORDERCONFIRMATIONWINDOW_PREPARATIONTIME;
        content.rightLabel.text = FORTIFICATIONS.ORDERS_ORDERCONFIRMATIONWINDOW_COST;
        content.resultLabel.text = DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL;
    }

    override protected function draw():void {
        var _loc2_:ExtraModuleIcon = null;
        var _loc3_:uint = 0;
        var _loc4_:uint = 0;
        var _loc5_:Number = NaN;
        var _loc6_:Number = NaN;
        var _loc7_:Number = NaN;
        var _loc8_:Number = NaN;
        var _loc9_:String = null;
        var _loc10_:String = null;
        super.draw();
        var _loc1_:ILocale = App.utils.locale;
        if (isInvalid(DATA_INVALID)) {
            if (this._orderInfo != null) {
                _loc2_ = App.utils.classFactory.getComponent(this._orderInfo.linkage, ExtraModuleIcon);
                _loc2_.setValuesWithType(FITTING_TYPES.ORDER, this._orderInfo.icon, this._orderInfo.level);
                content.setIcon(_loc2_);
                content.moduleName.text = this._orderInfo.name;
                content.description.htmlText = this._orderInfo.description;
                content.description.height = content.description.textHeight + TEXT_PADDING;
                _loc3_ = this._orderInfo.productionTime;
                _loc4_ = this._orderInfo.productionCost;
                content.leftIT.text = getTimeStrS(_loc3_);
                content.rightIT.text = _loc1_.gold(_loc4_);
                if (this._orderInfo.defaultValue != -1) {
                    this._selectedCount = this._orderInfo.defaultValue;
                }
                else {
                    this._selectedCount = content.nsCount.value;
                }
            }
            invalidate(SELECTED_CURRENCY_INVALID);
        }
        if (isInvalid(SELECTED_CURRENCY_INVALID)) {
            if (this._orderInfo) {
                _loc5_ = this._orderInfo.maxAvailableCount;
                _loc6_ = Math.min(1, _loc5_);
                content.nsCount.minimum = _loc6_;
                content.nsCount.maximum = _loc5_;
                content.nsCount.value = Math.min(this._selectedCount, _loc5_);
                content.submitBtn.enabled = _loc6_ > 0;
                if (!content.submitBtn.enabled && lastFocusedElement == content.submitBtn) {
                    setFocus(content.cancelBtn);
                }
            }
            invalidate(RESULT_INVALID);
        }
        if (this._orderInfo && isInvalid(RESULT_INVALID)) {
            _loc7_ = content.nsCount.value * this._orderInfo.productionTime;
            _loc8_ = content.nsCount.value * this._orderInfo.productionCost;
            _loc9_ = getTimeStrS(_loc7_);
            _loc10_ = _loc1_.gold(_loc8_);
            content.leftResultIT.text = _loc9_;
            content.rightResultIT.text = _loc10_;
        }
        if (this._settings && window && isInvalid(SETTINGS_INVALID)) {
            window.title = this._settings.title;
            content.submitBtn.label = this._settings.submitBtnLabel;
            content.cancelBtn.label = this._settings.cancelBtnLabel;
        }
    }

    override protected function onClosingApproved():void {
    }

    override protected function setData(param1:ConfirmOrderVO):void {
        this._orderInfo = param1;
        invalidate(DATA_INVALID);
    }

    override protected function setSettings(param1:DialogSettingsVO):void {
        this._settings = param1;
        invalidate(SETTINGS_INVALID);
    }

    override protected function selectedCountChangeHandler(param1:IndexEvent):void {
        this._selectedCount = content.nsCount.value;
        invalidate(RESULT_INVALID);
    }

    override protected function submitBtnClickHandler(param1:ButtonEvent):void {
        submitS(this._selectedCount);
    }
}
}
