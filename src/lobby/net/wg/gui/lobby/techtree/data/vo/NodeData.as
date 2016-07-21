package net.wg.gui.lobby.techtree.data.vo {
import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.techtree.constants.NamedLabels;
import net.wg.gui.lobby.techtree.interfaces.IValueObject;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.utils.ILocale;

public class NodeData implements IValueObject {

    private static var displayInfoClass:Class = null;

    public static const UNLOCK_PROPS_FIELD:String = "unlockProps";

    private static const EXTRA_INFO_FIELD:String = "extraInfo";

    private static const IS_PREMIUM_IGR_FIELD:String = "isPremiumIGR";

    private static const STATUS_LEVEL_FIELD:String = "statusLevel";

    private static const STATUS_FIELD:String = "status";

    private static const SHOW_VEHICLE_BTN_LABEL:String = "showVehicleBtnLabel";

    private static const SHOW_VEHICLE_BTN_ENABLED:String = "showVehicleBtnEnabled";

    public var id:Number = 0;

    public var nameString:String = "";

    public var level:int = -1;

    public var state:Number = 0;

    public var smallIconPath:String = "";

    public var iconPath:String = "";

    public var longName:String = "";

    public var extraInfo:String = null;

    public var status:String = null;

    public var statusLevel:String = null;

    public var isPremiumIGR:Boolean = false;

    public var primaryClassName:String = "";

    public var showVehicleBtnLabel:String = "";

    public var showVehicleBtnEnabled:Boolean = false;

    private var _unlockProps:UnlockProps = null;

    private var _shopPrice:ShopPrice = null;

    private var _displayInfo:IValueObject = null;

    private var _earnedXP:Number = 0;

    private var _actionPriceDataVo:ActionPriceVO = null;

    private var _earnedXPLabel:String = "";

    public function NodeData() {
        super();
    }

    public static function setDisplayInfoClass(param1:Class):void {
        displayInfoClass = param1;
    }

    public function dispose():void {
        if (this._actionPriceDataVo != null) {
            this._actionPriceDataVo.dispose();
            this._actionPriceDataVo = null;
        }
        if (this._shopPrice != null) {
            this._shopPrice.dispose();
            this._shopPrice = null;
        }
        if (this._unlockProps != null) {
            this._unlockProps.dispose();
            this._unlockProps = null;
        }
        if (this._displayInfo != null) {
            this._displayInfo.dispose();
            this._displayInfo = null;
        }
    }

    public function fromArray(param1:Array, param2:ILocale):void {
        throw new AbstractException("NodeData.fromArray" + Errors.ABSTRACT_INVOKE);
    }

    public function fromObject(param1:Object, param2:ILocale):void {
        var _loc3_:String = null;
        if (param1 == null) {
            return;
        }
        if (!isNaN(param1.id)) {
            this.id = param1.id;
        }
        if (param1.nameString != null) {
            this.nameString = param1.nameString;
        }
        if (param1.primaryClass != null && param1.primaryClass.name != null) {
            this.primaryClassName = param1.primaryClass.name;
        }
        if (param1.level != null) {
            this.level = param1.level;
        }
        if (!isNaN(param1.earnedXP)) {
            this.earnedXP = param1.earnedXP;
        }
        if (param1.actionPriceData) {
            this._actionPriceDataVo = new ActionPriceVO(param1.actionPriceData);
        }
        if (!isNaN(param1.state)) {
            this.state = param1.state;
        }
        this._unlockProps = new UnlockProps();
        if (param1.unlockProps != null) {
            this._unlockProps.fromArray(param1.unlockProps, param2);
        }
        if (param1.hasOwnProperty(EXTRA_INFO_FIELD)) {
            _loc3_ = param1[EXTRA_INFO_FIELD];
            if (_loc3_) {
                this.extraInfo = _loc3_;
            }
        }
        if (param1.hasOwnProperty(SHOW_VEHICLE_BTN_LABEL)) {
            this.showVehicleBtnLabel = param1[SHOW_VEHICLE_BTN_LABEL];
        }
        if (param1.hasOwnProperty(SHOW_VEHICLE_BTN_ENABLED)) {
            this.showVehicleBtnEnabled = param1[SHOW_VEHICLE_BTN_ENABLED];
        }
        if (param1.hasOwnProperty(IS_PREMIUM_IGR_FIELD)) {
            this.isPremiumIGR = param1[IS_PREMIUM_IGR_FIELD];
        }
        if (param1.hasOwnProperty(STATUS_LEVEL_FIELD)) {
            this.statusLevel = param1[STATUS_LEVEL_FIELD] as String;
        }
        if (param1.hasOwnProperty(STATUS_FIELD)) {
            this.status = param1[STATUS_FIELD] as String;
        }
        if (param1.smallIconPath != null) {
            this.smallIconPath = param1.smallIconPath;
        }
        if (param1.iconPath != null) {
            this.iconPath = param1.iconPath;
        }
        if (param1.longName != null) {
            this.longName = param1.longName;
        }
        this._shopPrice = new ShopPrice();
        if (param1.shopPrice != null) {
            this._shopPrice.fromArray(param1.shopPrice, param2);
        }
        if (displayInfoClass != null) {
            this._displayInfo = new displayInfoClass();
        }
        if (param1.displayInfo != null && this._displayInfo != null) {
            this._displayInfo.fromObject(param1.displayInfo, param2);
        }
    }

    public function getActionData(param1:String):ActionPriceVO {
        var _loc2_:ActionPriceVO = null;
        switch (param1) {
            case NamedLabels.XP_COST:
                _loc2_ = this._unlockProps.actionPriceDataVo;
                break;
            case NamedLabels.EARNED_XP:
                _loc2_ = this._actionPriceDataVo;
                break;
            case NamedLabels.CREDITS_PRICE:
                _loc2_ = this._shopPrice.actionPriceDataVo;
                break;
            case NamedLabels.GOLD_PRICE:
                _loc2_ = this._shopPrice.actionPriceDataVo;
                break;
            default:
                _loc2_ = null;
        }
        return _loc2_;
    }

    public function getNamedLabel(param1:String):String {
        var _loc2_:String = null;
        switch (param1) {
            case NamedLabels.XP_COST:
                _loc2_ = this._unlockProps.xpCostLabel;
                break;
            case NamedLabels.EARNED_XP:
                _loc2_ = this._earnedXPLabel;
                break;
            case NamedLabels.CREDITS_PRICE:
                _loc2_ = this._shopPrice.creditsLabel;
                break;
            case NamedLabels.GOLD_PRICE:
                _loc2_ = this._shopPrice.goldLabel;
                break;
            default:
                _loc2_ = "";
        }
        return _loc2_;
    }

    public function getNamedValue(param1:String):Number {
        var _loc2_:Number = NaN;
        switch (param1) {
            case NamedLabels.XP_COST:
                _loc2_ = this._unlockProps.xpCost;
                break;
            case NamedLabels.EARNED_XP:
                _loc2_ = this._earnedXP;
                break;
            case NamedLabels.CREDITS_PRICE:
                _loc2_ = this._shopPrice.credits;
                break;
            case NamedLabels.GOLD_PRICE:
                _loc2_ = this._shopPrice.gold;
                break;
            default:
                _loc2_ = 0;
        }
        return _loc2_;
    }

    public function toString():String {
        return "[\nNodeData:\n id = " + this.id + ",\n nameString = " + this.nameString + ",\n primaryClassName = " + this.primaryClassName + ",\n level = " + this.level + ",\n earnedXP = " + this.earnedXP + ",\n state = " + this.state + ",\n unlockProps = " + this._unlockProps + ",\n iconPath = " + this.iconPath + ",\n longName = " + this.longName + ",\n extraInfo = " + this.extraInfo + ",\n shopPrice = " + this._shopPrice + ",\n displayInfo = " + this._displayInfo + ",\n actionPriceDataVo = " + this._actionPriceDataVo + "," + ",\n status = " + this.status + ",\n statusLevel = " + this.statusLevel + "\n]";
    }

    public function get earnedXP():Number {
        return this._earnedXP;
    }

    public function set earnedXP(param1:Number):void {
        if (this._earnedXP == param1) {
            return;
        }
        this._earnedXP = param1;
        if (this._earnedXP > 0) {
            this._earnedXPLabel = App.utils.locale.integer(this._earnedXP);
        }
        else {
            this._earnedXPLabel = "";
        }
    }

    public function get unlockProps():UnlockProps {
        return this._unlockProps;
    }

    public function set unlockProps(param1:UnlockProps):void {
        this._unlockProps = param1;
    }

    public function get shopPrice():ShopPrice {
        return this._shopPrice;
    }

    public function set shopPrice(param1:ShopPrice):void {
        this._shopPrice = param1;
    }

    public function get displayInfo():IValueObject {
        return this._displayInfo;
    }

    public function set displayInfo(param1:IValueObject):void {
        this._displayInfo = param1;
    }
}
}
