package net.wg.gui.lobby.sellDialog {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.BaseTooltips;
import net.wg.data.constants.Errors;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.AlertIco;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.lobby.sellDialog.VO.SellVehicleVo;
import net.wg.infrastructure.base.UIComponentEx;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class SellHeaderComponent extends UIComponentEx {

    private static const PADDING_FOR_NEXT_ELEMENT:int = 8;

    private static const TO_BARRACKS_INDEX:int = 0;

    private static const DEMOBILIZE_INDEX:int = 1;

    private static const TOOLTIP_MAX_WIDTH:int = 330;

    public var emptySellIT:IconText;

    public var vehicleActionPrice:ActionPrice;

    public var tankLevelTF:TextField;

    public var tankNameTF:TextField;

    public var tankPriceTF:TextField;

    public var tankDescribeTF:TextField;

    public var tankIcon:TankIcon;

    public var crewTF:TextField;

    public var inBarracksDrop:DropdownMenu;

    public var crewBG:MovieClip;

    public var priceDots:MovieClip;

    public var alertIcon:AlertIco = null;

    private var _tankPrice:Number = 0;

    private var _tankGoldPrice:Number = 0;

    private var _creditsCommon:Number = 0;

    private var _crewTooltip:String;

    private var _sellData:SellVehicleVo;

    public function SellHeaderComponent() {
        super();
    }

    override protected function onDispose():void {
        this.vehicleActionPrice.dispose();
        this.vehicleActionPrice = null;
        this.emptySellIT.dispose();
        this.emptySellIT = null;
        this.inBarracksDrop.removeEventListener(ListEvent.INDEX_CHANGE, this.onInBarracksDropIndexChangeHandler);
        this.inBarracksDrop.dispose();
        this.inBarracksDrop = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler, false);
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onAlertIconRollOutHandler, false);
        this.alertIcon.dispose();
        this.alertIcon = null;
        this.tankLevelTF = null;
        this.tankNameTF = null;
        this.tankPriceTF = null;
        this.tankDescribeTF = null;
        this.crewTF = null;
        this.crewBG = null;
        this.priceDots = null;
        this._sellData = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.emptySellIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        this.vehicleActionPrice.textYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
    }

    public function getNextPosition():int {
        return this.crewBG.y + this.crewBG.height + PADDING_FOR_NEXT_ELEMENT;
    }

    public function setData(param1:SellVehicleVo):void {
        App.utils.asserter.assertNotNull(param1, "sellData" + Errors.CANT_NULL);
        this._sellData = param1;
        this.tankNameTF.htmlText = param1.userName;
        this.tankLevelTF.htmlText = param1.levelStr;
        this.tankDescribeTF.text = param1.description;
        this.tankPriceTF.text = param1.priceLabel;
        this.crewTF.text = param1.crewLabel;
        this._crewTooltip = param1.crewTooltip;
        this.tankIcon.image = param1.icon;
        this.tankIcon.level = param1.level;
        this.tankIcon.isElite = param1.isElite;
        this.tankIcon.isPremium = param1.isPremium;
        this.tankIcon.tankType = param1.type;
        this.tankIcon.nation = param1.nationID;
        App.utils.asserter.assertNotNull(param1.barracksDropDownData, "barracksDropDownData" + Errors.CANT_NULL);
        this.inBarracksDrop.dataProvider = new DataProvider(param1.barracksDropDownData);
        this.inBarracksDrop.addEventListener(ListEvent.INDEX_CHANGE, this.onInBarracksDropIndexChangeHandler);
        if (param1.hasCrew) {
            this.inBarracksDrop.selectedIndex = TO_BARRACKS_INDEX;
            this.inBarracksDrop.enabled = true;
        }
        else {
            this.inBarracksDrop.selectedIndex = DEMOBILIZE_INDEX;
            this.inBarracksDrop.enabled = false;
        }
        this.inBarracksDrop.validateNow();
        this.alertIcon.buttonMode = false;
        if (param1.hasCrew && StringUtils.isNotEmpty(this._crewTooltip)) {
            this.alertIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler);
            this.alertIcon.addEventListener(MouseEvent.ROLL_OUT, this.onAlertIconRollOutHandler);
        }
        this.showDemobilizationAlert();
        this.emptySellIT.visible = this.vehicleActionPrice.visible = false;
        if (param1.isRented) {
            this._tankGoldPrice = 0;
            this._tankPrice = 0;
            this.tankPriceTF.visible = this.priceDots.visible = false;
        }
        else {
            if (param1.sellPrice[CURRENCIES_CONSTANTS.GOLD_INDEX] > 0) {
                this._tankGoldPrice = param1.sellPrice[CURRENCIES_CONSTANTS.GOLD_INDEX];
                this._tankPrice = 0;
            }
            else {
                this._tankPrice = param1.sellPrice[CURRENCIES_CONSTANTS.CREDITS_INDEX];
                this._tankGoldPrice = 0;
                this.creditsCommon = this.creditsCommon + this.tankPrice;
            }
            this.emptySellIT.text = param1.priceTextValue;
            if (param1.action != null) {
                this.vehicleActionPrice.setData(param1.action);
            }
            else {
                this.emptySellIT.icon = param1.currencyIcon;
                this.emptySellIT.textColor = param1.priceTextColor;
                this.emptySellIT.validateNow();
                this.emptySellIT.visible = true;
            }
        }
    }

    private function showDemobilizationAlert():void {
        this.alertIcon.visible = this._sellData.hasCrew && this._sellData.crewRecoveryBufferFull && this.inBarracksDrop.selectedIndex == DEMOBILIZE_INDEX;
    }

    public function get tankGoldPrice():Number {
        return this._tankGoldPrice;
    }

    public function get tankPrice():Number {
        return this._tankPrice;
    }

    public function get creditsCommon():Number {
        return this._creditsCommon;
    }

    public function set creditsCommon(param1:Number):void {
        this._creditsCommon = param1;
    }

    private function onAlertIconRollOverHandler(param1:MouseEvent):void {
        var _loc2_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO, 0, 0, 0, -1, 0, TOOLTIP_MAX_WIDTH);
        App.toolTipMgr.show(this._crewTooltip, _loc2_);
    }

    private function onAlertIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onInBarracksDropIndexChangeHandler(param1:ListEvent):void {
        this.showDemobilizationAlert();
    }
}
}
