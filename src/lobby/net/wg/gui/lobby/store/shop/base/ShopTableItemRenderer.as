package net.wg.gui.lobby.store.shop.base {
import net.wg.data.VO.StoreTableData;
import net.wg.data.constants.Currencies;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.SoundManagerStatesLobby;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.store.STORE_STATUS_COLOR;
import net.wg.gui.lobby.store.StoreEvent;
import net.wg.gui.lobby.store.StoreListItemRenderer;
import net.wg.gui.lobby.store.data.StoreTooltipMapVO;
import net.wg.utils.ILocale;

public class ShopTableItemRenderer extends StoreListItemRenderer {

    private static const ERROR_POSTFIX:String = "Error";

    private var _isUseGoldAndCredits:Boolean = false;

    public function ShopTableItemRenderer() {
        super();
        soundId = SoundManagerStatesLobby.RENDERER_SHOP;
        configUI();
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        if (App.instance && param1) {
            App.utils.asserter.assert(param1 is StoreTableData, "data must extends a StoreTableData class.");
        }
        invalidateData();
    }

    override protected function getTooltipMapping():StoreTooltipMapVO {
        return new StoreTooltipMapVO(TOOLTIPS_CONSTANTS.SHOP_VEHICLE, TOOLTIPS_CONSTANTS.SHOP_SHELL, TOOLTIPS_CONSTANTS.SHOP_MODULE);
    }

    override protected function updateText():void {
    }

    override protected function updateTexts(param1:StoreTableData, param2:Number, param3:Number):void {
        var _loc4_:int = param2;
        var _loc5_:Number = param1.tableVO.gold;
        if (param1.currency == Currencies.CREDITS) {
            _loc4_ = param3;
            _loc5_ = param1.tableVO.credits;
        }
        if (0 == _loc4_ && param1.requestType != FITTING_TYPES.VEHICLE) {
            param1.disabled = true;
        }
        var _loc6_:Boolean = false;
        this.updateCreditPriceForAction(param3, param2, param1);
        if (this._isUseGoldAndCredits) {
            if (param2 > param1.tableVO.gold && param3 > param1.tableVO.credits) {
                _loc6_ = true;
            }
        }
        else {
            if (_loc4_ > _loc5_) {
                _loc6_ = true;
            }
            this.updateCredits(param2, param1, param3, _loc6_);
        }
        if (errorField) {
            errorField.text = param1.statusMessage;
            if (param1.statusLevel) {
                errorField.textColor = STORE_STATUS_COLOR.getColor(param1.statusLevel);
            }
            else {
                errorField.textColor = STORE_STATUS_COLOR.INFO;
            }
        }
        enabled = !param1.disabled;
    }

    override protected function onPricesCalculated(param1:Number, param2:Number, param3:StoreTableData):void {
        var _loc4_:Boolean = param1 > 0 && param2 > 0 && param3.goldShellsForCredits && param3.itemTypeName == FITTING_TYPES.SHELL;
        var _loc5_:Boolean = param1 > 0 && param2 > 0 && param3.goldEqsForCredits && param3.itemTypeName == FITTING_TYPES.EQUIPMENT;
        this._isUseGoldAndCredits = _loc4_ || _loc5_;
    }

    override protected function onLeftButtonClick():void {
        var _loc1_:StoreTableData = StoreTableData(data);
        if (_loc1_.disabled) {
            return;
        }
        var _loc2_:Boolean = _loc1_.itemTypeName == FITTING_TYPES.SHELL && _loc1_.goldShellsForCredits;
        var _loc3_:Boolean = _loc1_.itemTypeName == FITTING_TYPES.EQUIPMENT && _loc1_.goldEqsForCredits;
        var _loc4_:* = _loc1_.tableVO.gold >= _loc1_.gold;
        var _loc5_:* = _loc1_.tableVO.credits >= _loc1_.credits;
        var _loc6_:Boolean = _loc2_ || _loc3_ ? _loc4_ || _loc5_ : _loc4_ && _loc5_;
        if (_loc6_) {
            this.buyItem();
        }
    }

    protected function updateCreditPriceForAction(param1:Number, param2:Number, param3:StoreTableData):void {
        var _loc4_:ILocale = null;
        var _loc5_:ActionPriceVO = null;
        if (App.instance) {
            _loc4_ = App.utils.locale;
            if (param1 > param3.tableVO.credits) {
                credits.gotoAndStop(ACTION_CREDITS_STATES.ERROR);
                credits.price.text = _loc4_.integer(param1);
                actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
            else {
                credits.gotoAndStop(ACTION_CREDITS_STATES.CREDITS);
                credits.price.text = _loc4_.integer(param1);
                actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
            }
            if (actionPrice) {
                _loc5_ = param3.actionPriceDataVo;
                if (_loc5_) {
                    _loc5_.forCredits = true;
                }
                actionPrice.setData(_loc5_);
                credits.visible = !actionPrice.visible;
            }
        }
    }

    private function updateCredits(param1:Number, param2:StoreTableData, param3:Number, param4:Boolean):void {
        var _loc5_:ILocale = null;
        var _loc6_:Number = NaN;
        var _loc7_:Number = NaN;
        var _loc8_:String = null;
        var _loc9_:ActionPriceVO = null;
        if (App.instance) {
            _loc5_ = App.utils.locale;
            if (param4) {
                credits.gotoAndStop(param2.currency + ERROR_POSTFIX);
            }
            else {
                credits.gotoAndStop(param2.currency);
            }
            _loc6_ = 0;
            _loc7_ = 0;
            if (param2.currency == Currencies.GOLD) {
                credits.price.text = _loc5_.gold(param1);
                _loc8_ = IconsTypes.GOLD;
                _loc6_ = param1;
            }
            else {
                credits.price.text = _loc5_.integer(param3);
                _loc8_ = IconsTypes.CREDITS;
                _loc6_ = param3;
            }
            _loc9_ = param2.actionPriceDataVo;
            if (_loc9_) {
                _loc9_.forCredits = param2.currency == Currencies.CREDITS;
            }
            actionPrice.setData(_loc9_);
            credits.visible = !actionPrice.visible;
        }
    }

    private function buyItem():void {
        dispatchEvent(new StoreEvent(StoreEvent.BUY, StoreTableData(data)));
    }

    protected function get isUseGoldAndCredits():Boolean {
        return this._isUseGoldAndCredits;
    }
}
}
