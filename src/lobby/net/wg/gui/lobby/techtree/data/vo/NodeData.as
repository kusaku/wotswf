package net.wg.gui.lobby.techtree.data.vo {
import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.data.VehCompareEntrypointVO;
import net.wg.gui.lobby.techtree.constants.NamedLabels;
import net.wg.gui.lobby.techtree.interfaces.IValueObject;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.utils.IAssertable;
import net.wg.utils.ILocale;

public class NodeData implements IValueObject {

    private static var _displayInfoClass:Class = null;

    public static const UNLOCK_PROPS_FIELD:String = "unlockProps";

    public static const VEH_COMPARE_ROOT_DATA:String = "vehCompareRootData";

    public static const VEH_COMPARE_TREE_NODE_DATA:String = "vehCompareTreeNodeData";

    private static const EMPTY_STR:String = "";

    private static const EXTRA_INFO_FIELD:String = "extraInfo";

    private static const IS_PREMIUM_IGR_FIELD:String = "isPremiumIGR";

    private static const STATUS_LEVEL_FIELD:String = "statusLevel";

    private static const STATUS_FIELD:String = "status";

    private static const SHOW_VEHICLE_BTN_LABEL:String = "showVehicleBtnLabel";

    private static const SHOW_VEHICLE_BTN_ENABLED:String = "showVehicleBtnEnabled";

    private static const FROM_ARRAY:String = "NodeData.fromArray";

    public var id:Number = 0;

    public var nameString:String = "";

    public var level:int = -1;

    public var state:Number = 0;

    public var smallIconPath:String = "";

    public var iconPath:String = "";

    public var longName:String = "";

    public var extraInfo:String = null;

    public var status:String = "";

    public var statusLevel:String = "";

    public var isPremiumIGR:Boolean = false;

    public var primaryClassName:String = "";

    public var showVehicleBtnLabel:String = "";

    public var showVehicleBtnEnabled:Boolean = false;

    public var shopPrice:ShopPrice = null;

    public var displayInfo:IValueObject = null;

    public var dataIsReady:Boolean = false;

    private var _actionPriceDataVo:ActionPriceVO = null;

    private var _earnedXPLabel:String = "";

    private var _vehCompareVO:VehCompareEntrypointVO = null;

    private var _vehCompareTreeNodeVO:VehCompareEntrypointTreeNodeVO = null;

    private var _asserter:IAssertable;

    private var _earnedXP:Number = 0;

    private var _unlockProps:UnlockProps = null;

    public function NodeData() {
        this._asserter = App.utils.asserter;
        super();
    }

    public static function setDisplayInfoClass(param1:Class):void {
        _displayInfoClass = param1;
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function fromArray(param1:Array, param2:ILocale):void {
        throw new AbstractException(FROM_ARRAY + Errors.ABSTRACT_INVOKE);
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
            this.clearActionPriceDataVo();
            this._actionPriceDataVo = new ActionPriceVO(param1.actionPriceData);
        }
        if (!isNaN(param1.state)) {
            this.state = param1.state;
        }
        this.clearUnlockProps();
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
        if (param1.hasOwnProperty(VEH_COMPARE_ROOT_DATA)) {
            this.clearVehCompareVO();
            this._vehCompareVO = new VehCompareEntrypointVO(param1[VEH_COMPARE_ROOT_DATA]);
        }
        if (param1.hasOwnProperty(VEH_COMPARE_TREE_NODE_DATA)) {
            this.clearVehCompareTreeNodeVO();
            this._vehCompareTreeNodeVO = new VehCompareEntrypointTreeNodeVO(param1[VEH_COMPARE_TREE_NODE_DATA]);
        }
        if (param1.hasOwnProperty(IS_PREMIUM_IGR_FIELD)) {
            this.isPremiumIGR = param1[IS_PREMIUM_IGR_FIELD];
        }
        if (param1.hasOwnProperty(STATUS_LEVEL_FIELD)) {
            this.statusLevel = param1[STATUS_LEVEL_FIELD];
            App.utils.asserter.assertNotNull(this.statusLevel, STATUS_LEVEL_FIELD + Errors.CANT_NULL);
        }
        if (param1.hasOwnProperty(STATUS_FIELD)) {
            this.status = param1[STATUS_FIELD];
            App.utils.asserter.assertNotNull(this.status, STATUS_FIELD + Errors.CANT_NULL);
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
        this.clearShopPrice();
        this.shopPrice = new ShopPrice();
        if (param1.shopPrice != null) {
            this.shopPrice.fromArray(param1.shopPrice, param2);
        }
        if (_displayInfoClass != null) {
            this.clearDisplayInfo();
            this.displayInfo = new _displayInfoClass();
        }
        if (param1.displayInfo != null && this.displayInfo != null) {
            this.displayInfo.fromObject(param1.displayInfo, param2);
        }
        this.dataIsReady = true;
    }

    public function getActionData(param1:String):ActionPriceVO {
        var _loc2_:ActionPriceVO = null;
        switch (param1) {
            case NamedLabels.XP_COST:
                _loc2_ = this._unlockProps != null ? this._unlockProps.actionPriceDataVo : null;
                break;
            case NamedLabels.EARNED_XP:
                _loc2_ = this._actionPriceDataVo;
                break;
            case NamedLabels.CREDITS_PRICE:
                _loc2_ = this.shopPrice != null ? this.shopPrice.actionPriceDataVo : null;
                break;
            case NamedLabels.GOLD_PRICE:
                _loc2_ = this.shopPrice != null ? this.shopPrice.actionPriceDataVo : null;
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
                _loc2_ = this._unlockProps != null ? this._unlockProps.xpCostLabel : EMPTY_STR;
                break;
            case NamedLabels.EARNED_XP:
                _loc2_ = this._earnedXPLabel;
                break;
            case NamedLabels.CREDITS_PRICE:
                _loc2_ = this.shopPrice != null ? this.shopPrice.creditsLabel : EMPTY_STR;
                break;
            case NamedLabels.GOLD_PRICE:
                _loc2_ = this.shopPrice != null ? this.shopPrice.goldLabel : EMPTY_STR;
                break;
            case NamedLabels.RESTORE:
                _loc2_ = App.utils.locale.makeString(MENU.RESEARCH_LABELS_BUTTON_RESTORE);
                break;
            default:
                _loc2_ = EMPTY_STR;
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
                _loc2_ = this.shopPrice.credits;
                break;
            case NamedLabels.GOLD_PRICE:
                _loc2_ = this.shopPrice.gold;
                break;
            default:
                _loc2_ = 0;
        }
        return _loc2_;
    }

    public function setVehCompareData(param1:Object):void {
        this.clearVehCompareVO();
        this._vehCompareVO = new VehCompareEntrypointVO(param1);
    }

    public function setVehCompareTreeNode(param1:Object):void {
        this.clearVehCompareTreeNodeVO();
        this._vehCompareTreeNodeVO = new VehCompareEntrypointTreeNodeVO(param1);
    }

    public function toString():String {
        return "[\nNodeData:\n id = " + this.id + ",\n nameString = " + this.nameString + ",\n primaryClassName = " + this.primaryClassName + ",\n level = " + this.level + ",\n earnedXP = " + this.earnedXP + ",\n state = " + this.state + ",\n unlockProps = " + this._unlockProps + ",\n iconPath = " + this.iconPath + ",\n longName = " + this.longName + ",\n extraInfo = " + this.extraInfo + ",\n shopPrice = " + this.shopPrice + ",\n displayInfo = " + this.displayInfo + ",\n actionPriceDataVo = " + this._actionPriceDataVo + "," + ",\n status = " + this.status + ",\n statusLevel = " + this.statusLevel + "\n]";
    }

    protected function onDispose():void {
        this.dataIsReady = false;
        this.clearActionPriceDataVo();
        this.clearShopPrice();
        this.clearUnlockProps();
        this.clearDisplayInfo();
        this.clearVehCompareVO();
        this.clearVehCompareTreeNodeVO();
        this._asserter = null;
    }

    private function clearActionPriceDataVo():void {
        if (this._actionPriceDataVo != null) {
            this._actionPriceDataVo.dispose();
            this._actionPriceDataVo = null;
        }
    }

    private function clearUnlockProps():void {
        if (this._unlockProps != null) {
            this._unlockProps.dispose();
            this._unlockProps = null;
        }
    }

    private function clearVehCompareVO():void {
        if (this._vehCompareVO != null) {
            this._vehCompareVO.dispose();
            this._vehCompareVO = null;
        }
    }

    private function clearVehCompareTreeNodeVO():void {
        if (this._vehCompareTreeNodeVO != null) {
            this._vehCompareTreeNodeVO.dispose();
            this._vehCompareTreeNodeVO = null;
        }
    }

    private function clearShopPrice():void {
        if (this.shopPrice != null) {
            this.shopPrice.dispose();
            this.shopPrice = null;
        }
    }

    private function clearDisplayInfo():void {
        if (this.displayInfo != null) {
            this.displayInfo.dispose();
            this.displayInfo = null;
        }
    }

    public function get unlockProps():UnlockProps {
        return this._unlockProps;
    }

    public function set unlockProps(param1:UnlockProps):void {
        this._unlockProps = param1;
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
            this._earnedXPLabel = EMPTY_STR;
        }
    }

    public function get vehCompareVO():VehCompareEntrypointVO {
        return this._vehCompareVO;
    }

    public function get isCompareModeAvailable():Boolean {
        return this._vehCompareTreeNodeVO && this._vehCompareTreeNodeVO.modeAvailable;
    }

    public function get isCompareBasketFull():Boolean {
        return this._vehCompareTreeNodeVO && this._vehCompareTreeNodeVO.cmpBasketFull;
    }
}
}
