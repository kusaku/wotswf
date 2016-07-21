package net.wg.gui.lobby.sellDialog {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.constants.Currencies;
import net.wg.data.constants.IconsTypes;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.sellDialog.VO.SellVehicleVo;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.utils.ILocale;

import scaleform.clik.data.DataProvider;

public class SellHeaderComponent extends UIComponentEx {

    private static const VEHICLE_LEVELS:Array = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];

    private static const PADDING_FOR_NEXT_ELEMENT:int = 8;

    private static const TANK_LVL_COLOR:Number = 16643278;

    private static const SPACE:String = " ";

    public var emptySellIT:IconText;

    public var vehicleActionPrice:ActionPrice;

    public var tankLevelTF:TextField;

    public var tankNameTF:TextField;

    public var tankPriceTF:TextField;

    public var tankDescribeTF:TextField;

    public var tankIcon:TankIcon;

    public var crewTF:TextField;

    public var inBarracsDrop:DropdownMenu;

    public var crewBG:MovieClip;

    public var priceDots:MovieClip;

    private var _tankPrice:Number = 0;

    private var _tankGoldPrice:Number = 0;

    private var _creditsCommon:Number = 0;

    private var _locale:ILocale;

    public function SellHeaderComponent() {
        super();
        this._locale = App.utils.locale;
    }

    private static function showLevel(param1:Number):String {
        return VEHICLE_LEVELS[param1 - 1].toString();
    }

    override protected function onDispose():void {
        this.vehicleActionPrice.dispose();
        this.vehicleActionPrice = null;
        this.emptySellIT.dispose();
        this.emptySellIT = null;
        this.inBarracsDrop.dispose();
        this.inBarracsDrop = null;
        this.tankIcon.dispose();
        this.tankIcon = null;
        this.tankLevelTF = null;
        this.tankNameTF = null;
        this.tankPriceTF = null;
        this.tankDescribeTF = null;
        this.crewTF = null;
        this.crewBG = null;
        this.priceDots = null;
        this._locale = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.tankPriceTF.text = DIALOGS.VEHICLESELLDIALOG_VEHICLE_EMPTYSELLPRICE;
        this.emptySellIT.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
        this.vehicleActionPrice.textYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
    }

    public function getNextPosition():int {
        return this.crewBG.y + this.crewBG.height + PADDING_FOR_NEXT_ELEMENT;
    }

    public function setData(param1:SellVehicleVo):void {
        var _loc2_:String = null;
        this.tankNameTF.htmlText = param1.userName;
        if (param1.isElite) {
            _loc2_ = this._locale.makeString(TOOLTIPS.tankcaruseltooltip_vehicletype_elite(param1.type), {});
        }
        else {
            _loc2_ = this._locale.makeString(DIALOGS.vehicleselldialog_vehicletype(param1.type), {});
        }
        this.tankDescribeTF.text = _loc2_;
        var _loc3_:TextFormat = this.tankLevelTF.getTextFormat();
        _loc3_.color = TANK_LVL_COLOR;
        var _loc4_:String = showLevel(param1.level);
        this.tankLevelTF.text = _loc4_ + SPACE + this._locale.makeString(DIALOGS.VEHICLESELLDIALOG_VEHICLE_LEVEL);
        this.tankLevelTF.setTextFormat(_loc3_, 0, _loc4_.length);
        this.tankIcon.image = param1.icon;
        this.tankIcon.level = param1.level;
        this.tankIcon.isElite = param1.isElite;
        this.tankIcon.isPremium = param1.isPremium;
        this.tankIcon.tankType = param1.type;
        this.tankIcon.nation = param1.nationID;
        var _loc5_:String = this._locale.makeString(DIALOGS.GATHERINGXPFORM_HEADERBUTTONS_CREW);
        this.inBarracsDrop.dataProvider = new DataProvider([{"label": MENU.BARRACKS_BTNUNLOAD}, {"label": MENU.BARRACKS_BTNDISSMISS}]);
        if (param1.hasCrew) {
            this.inBarracsDrop.selectedIndex = 0;
            this.inBarracsDrop.enabled = true;
        }
        else {
            this.inBarracsDrop.selectedIndex = 1;
            this.inBarracsDrop.enabled = false;
        }
        this.inBarracsDrop.validateNow();
        this.crewTF.text = App.utils.toUpperOrLowerCase(_loc5_, true) + ": ";
        if (param1.isRented) {
            this.tankGoldPrice = 0;
            this.tankPrice = 0;
            this.tankPriceTF.visible = this.priceDots.visible = this.emptySellIT.visible = this.vehicleActionPrice.visible = false;
        }
        else if (param1.sellPrice[1] > 0) {
            this.tankGoldPrice = param1.sellPrice[1];
            this.tankPrice = 0;
            if (param1.actionVo) {
                param1.actionVo.ico = IconsTypes.GOLD;
            }
            this.showPrice(true, this.tankGoldPrice, param1.actionVo);
        }
        else {
            this.tankPrice = param1.sellPrice[0];
            this.tankGoldPrice = 0;
            if (param1.actionVo) {
                param1.actionVo.ico = IconsTypes.CREDITS;
            }
            this.showPrice(false, this.tankPrice, param1.actionVo);
            this.creditsCommon = this.creditsCommon + this.tankPrice;
        }
    }

    private function showPrice(param1:Boolean, param2:Number, param3:ActionPriceVO):void {
        if (param1) {
            this.emptySellIT.text = "+ " + this._locale.gold(param2);
        }
        else {
            this.emptySellIT.text = "+ " + this._locale.integer(param2);
        }
        this.emptySellIT.icon = !!param1 ? IconsTypes.GOLD : IconsTypes.CREDITS;
        this.emptySellIT.textColor = !!param1 ? Number(Currencies.GOLD_COLOR) : Number(Currencies.CREDITS_COLOR);
        this.emptySellIT.validateNow();
        this.vehicleActionPrice.setData(param3);
        this.emptySellIT.visible = !this.vehicleActionPrice.visible;
    }

    public function get tankGoldPrice():Number {
        return this._tankGoldPrice;
    }

    public function set tankGoldPrice(param1:Number):void {
        this._tankGoldPrice = param1;
    }

    public function get tankPrice():Number {
        return this._tankPrice;
    }

    public function set tankPrice(param1:Number):void {
        this._tankPrice = param1;
    }

    public function get creditsCommon():Number {
        return this._creditsCommon;
    }

    public function set creditsCommon(param1:Number):void {
        this._creditsCommon = param1;
    }
}
}
