package net.wg.gui.lobby.hangar.maintenance {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Currencies;
import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.AlertIco;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DynamicScrollingListEx;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.events.EquipmentEvent;
import net.wg.gui.events.ModuleInfoEvent;
import net.wg.gui.events.ShellRendererEvent;
import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceShellVO;
import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceVO;
import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
import net.wg.infrastructure.base.meta.ITechnicalMaintenanceMeta;
import net.wg.infrastructure.base.meta.impl.TechnicalMaintenanceMeta;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ButtonGroup;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;

public class TechnicalMaintenance extends TechnicalMaintenanceMeta implements ITechnicalMaintenanceMeta {

    private static const PERCENT_CHAR:String = "%";

    private static const SPLITTER_CHAR:String = "/";

    private static const MONEY:String = "money";

    private static const EQUIPMENT:String = "equipment";

    private static const EQUIPMENT_CHANGED:String = "equipmentChanged";

    public var repairTextfield:TextField;

    public var repairIndicator:MaintenanceStatusIndicator;

    public var repairAuto:CheckBox;

    public var repairPrice:IconText;

    public var repairBtn:SoundButtonEx;

    public var shellsTextfield:TextField;

    public var casseteField:TextField;

    public var shellsIndicator:MaintenanceStatusIndicator;

    public var shellsAuto:CheckBox;

    public var shellsHeaderInventory:TextField;

    public var shellsHeaderBuy:TextField;

    public var shellsHeaderPrice:TextField;

    public var shellsTotalGold:IconText;

    public var shellsTotalCredits:IconText;

    public var shells:DynamicScrollingListEx;

    public var eqTextfield:TextField;

    public var eqIndicator:MaintenanceStatusIndicator;

    public var eqAuto:CheckBox;

    public var eqHeaderInventory:TextField;

    public var eqHeaderBuy:TextField;

    public var eqHeaderPrice:TextField;

    public var eqTotalGold:IconText;

    public var eqTotalCredits:IconText;

    public var eqItem1:EquipmentItem;

    public var eqItem2:EquipmentItem;

    public var eqItem3:EquipmentItem;

    public var applyBtn:SoundButtonEx;

    public var closeBtn:SoundButtonEx;

    public var totalCredits:IconText;

    public var totalGold:IconText;

    public var labelTotal:TextField;

    public var infoTF:TextField;

    public var infoAlertIcon:AlertIco;

    protected var _btnGroup:ButtonGroup;

    private var _maintenanceData:MaintenanceVO;

    private var _totalPrice:Prices;

    private var _shellsCountChanged:Boolean = false;

    private var _shellsOrderChanged:Boolean = false;

    private var _equipmentList:Array;

    private var _equipmentSetup:Array;

    private var _equipmentInstalled:Array;

    private var _eqOrderChanged:Boolean = false;

    private var _prevVehicleId:String = "";

    private var _prevGunIntCD:Number = -1;

    private var _isApplyEnable:Boolean = false;

    public function TechnicalMaintenance() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._isApplyEnable = false;
        this._btnGroup = new ButtonGroup("buttonGroup", this);
        this.repairTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_REPAIR_LABEL;
        this.shellsTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LABEL;
        this.shellsHeaderBuy.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_BUY;
        this.shellsHeaderInventory.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_INVENTORY;
        this.shellsHeaderPrice.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_AMMO_LIST_PRICE;
        this.eqTextfield.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LABEL;
        this.eqHeaderBuy.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_BUY;
        this.eqHeaderInventory.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_INVENTORY;
        this.eqHeaderPrice.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_EQUIPMENT_LIST_PRICE;
        this.labelTotal.text = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_BUTTONS_LABELTOTAL;
        this.shells.addEventListener(ShellRendererEvent.TOTAL_PRICE_CHANGED, this.onAmmoPriceChanged);
        this.shells.addEventListener(ShellRendererEvent.CURRENCY_CHANGED, this.onAmmoCurrencyChanged);
        this.autoChBListeners();
        this.subscribeModules();
        this.repairBtn.addEventListener(ButtonEvent.CLICK, this.onRepairClick);
        this.applyBtn.addEventListener(ButtonEvent.CLICK, this.onApplyClick);
        this.closeBtn.addEventListener(ButtonEvent.CLICK, this.onClose);
        this.infoTF.autoSize = TextFieldAutoSize.LEFT;
        this.infoAlertIcon.enabled = false;
    }

    override protected function draw():void {
        super.draw();
        if (this._maintenanceData && isInvalid(InvalidationType.DATA)) {
            this.updateRepairBlock();
            this.updateShellsBlock();
            this.updateTotalPrice();
            this.infoTF.htmlText = this._maintenanceData.infoAfterShellBlock;
            this.infoAlertIcon.visible = this.infoTF.visible = this._maintenanceData.infoAfterShellBlock != Values.EMPTY_STR;
        }
        if (isInvalid(MONEY)) {
            this.updateRepairBlock();
            this.updateShellsBlock();
        }
        if (isInvalid(EQUIPMENT)) {
            this.updateEquipmentBlock(this._equipmentInstalled, this._equipmentSetup, this._equipmentList);
        }
        if (isInvalid(ShellRendererEvent.TOTAL_PRICE_CHANGED, MONEY, EQUIPMENT)) {
            this.updateTotalPrice();
        }
        if (invalidate(EQUIPMENT_CHANGED)) {
            getEquipmentS(!!this.eqItem1.selectedItem ? this.eqItem1.selectedItem.id : undefined, !!this.eqItem1.selectedItem ? this.eqItem1.selectedItem.currency : undefined, !!this.eqItem2.selectedItem ? this.eqItem2.selectedItem.id : undefined, !!this.eqItem2.selectedItem ? this.eqItem2.selectedItem.currency : undefined, !!this.eqItem3.selectedItem ? this.eqItem3.selectedItem.id : undefined, !!this.eqItem3.selectedItem ? this.eqItem3.selectedItem.currency : undefined, undefined);
        }
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.title = MENU.HANGAR_AMMUNITIONPANEL_TECHNICALMAITENANCE_TITLE;
        window.useBottomBtns = true;
        var _loc1_:Padding = window.contentPadding as Padding;
        App.utils.asserter.assertNotNull(_loc1_, "padding" + Errors.CANT_NULL);
        _loc1_.top = _loc1_.top + 1;
        window.contentPadding = _loc1_;
        _loc1_ = window.formBgPadding;
        _loc1_.top = _loc1_.top + 585;
        _loc1_.right = _loc1_.right + 1;
        window.formBgPadding = _loc1_;
        App.stage.addEventListener(ModuleInfoEvent.SHOW_INFO, this.onShowModuleInfo);
        App.stage.addEventListener(ShellRendererEvent.CHANGE_ORDER, this.onChangeOrder);
    }

    override protected function onDispose():void {
        this.subscribeModules(false);
        this.repairTextfield = null;
        this.repairIndicator.dispose();
        this.repairIndicator = null;
        this.repairPrice.dispose();
        this.repairPrice = null;
        this.shellsTextfield = null;
        this.casseteField = null;
        this.shellsIndicator.dispose();
        this.shellsIndicator = null;
        this.shellsHeaderInventory = null;
        this.shellsHeaderBuy = null;
        this.shellsHeaderPrice = null;
        this.shellsTotalGold.dispose();
        this.shellsTotalGold = null;
        this.shellsTotalCredits.dispose();
        this.shellsTotalCredits = null;
        this.eqTextfield = null;
        this.eqIndicator.dispose();
        this.eqIndicator = null;
        this.eqHeaderInventory = null;
        this.eqHeaderBuy = null;
        this.eqHeaderPrice = null;
        this.eqTotalGold.dispose();
        this.eqTotalGold = null;
        this.eqTotalCredits.dispose();
        this.eqTotalCredits = null;
        this.totalCredits.dispose();
        this.totalCredits = null;
        this.totalGold.dispose();
        this.totalGold = null;
        this.labelTotal = null;
        this.infoTF = null;
        this.infoAlertIcon.dispose();
        this.infoAlertIcon = null;
        this.eqItem1.dispose();
        this.eqItem1 = null;
        this.eqItem2.dispose();
        this.eqItem2 = null;
        this.eqItem3.dispose();
        this.eqItem3 = null;
        this._maintenanceData = null;
        App.stage.removeEventListener(ModuleInfoEvent.SHOW_INFO, this.onShowModuleInfo);
        App.stage.removeEventListener(ShellRendererEvent.CHANGE_ORDER, this.onChangeOrder);
        this.shells.removeEventListener(ShellRendererEvent.TOTAL_PRICE_CHANGED, this.onAmmoPriceChanged);
        this.shells.removeEventListener(ShellRendererEvent.CURRENCY_CHANGED, this.onAmmoCurrencyChanged);
        this.repairBtn.removeEventListener(ButtonEvent.CLICK, this.onRepairClick);
        this.applyBtn.removeEventListener(ButtonEvent.CLICK, this.onApplyClick);
        this.closeBtn.removeEventListener(ButtonEvent.CLICK, this.onClose);
        if (this._btnGroup != null) {
            this._btnGroup.dispose();
            this._btnGroup = null;
        }
        this._equipmentList = null;
        this._equipmentSetup = null;
        this._equipmentInstalled = null;
        this._totalPrice = null;
        this.autoChBListeners(false);
        this.repairAuto.dispose();
        this.repairAuto = null;
        this.shellsAuto.dispose();
        this.shellsAuto = null;
        this.eqAuto.dispose();
        this.eqAuto = null;
        this.shells.dispose();
        this.shells = null;
        this.repairBtn.dispose();
        this.repairBtn = null;
        this.applyBtn.dispose();
        this.applyBtn = null;
        this.closeBtn.dispose();
        this.closeBtn = null;
        super.onDispose();
    }

    public function as_onAmmoInstall():void {
    }

    public function as_resetEquipment(param1:String):void {
        var _loc3_:EquipmentItem = null;
        var _loc2_:Vector.<EquipmentItem> = new <EquipmentItem>[this.eqItem1, this.eqItem2, this.eqItem3];
        for each(_loc3_ in _loc2_) {
            if (_loc3_.selectedItem && _loc3_.selectedItem.id == param1) {
                _loc3_.setEmptyItem();
                break;
            }
        }
    }

    public function as_setCredits(param1:Number):void {
        if (this._maintenanceData) {
            this._maintenanceData.credits = param1;
            invalidate(MONEY, EQUIPMENT);
        }
    }

    override protected function setData(param1:MaintenanceVO):void {
        this.updateOldData();
        this._maintenanceData = param1;
        invalidateData();
    }

    override protected function setEquipment(param1:Array, param2:Array, param3:Array):void {
        this._equipmentList = param3;
        this._equipmentSetup = param2;
        this._equipmentInstalled = param1;
        invalidate(EQUIPMENT);
    }

    public function as_setGold(param1:Number):void {
        if (this._maintenanceData) {
            this._maintenanceData.gold = param1;
            invalidate(MONEY, EQUIPMENT);
        }
    }

    public function isResetWindow():Boolean {
        return this._prevVehicleId != this._maintenanceData.vehicleId || this._prevGunIntCD != this._maintenanceData.gunIntCD;
    }

    private function subscribeModules(param1:Boolean = true):void {
        var _loc3_:EquipmentItem = null;
        var _loc2_:Array = [this.eqItem1, this.eqItem2, this.eqItem3];
        for each(_loc3_ in _loc2_) {
            if (param1) {
                this._btnGroup.addButton(_loc3_);
                _loc3_.addEventListener(EquipmentEvent.NEED_UPDATE, this.onEquipmentUpdate);
                _loc3_.addEventListener(EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                _loc3_.addEventListener(EquipmentEvent.TOTAL_PRICE_CHANGED, this.onEquipmentPriceChanged);
                _loc3_.addEventListener(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.onEquipmentItemOver);
            }
            else {
                this._btnGroup.removeButton(_loc3_);
                _loc3_.removeEventListener(EquipmentEvent.NEED_UPDATE, this.onEquipmentUpdate);
                _loc3_.removeEventListener(EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
                _loc3_.removeEventListener(EquipmentEvent.TOTAL_PRICE_CHANGED, this.onEquipmentPriceChanged);
                _loc3_.removeEventListener(OnEquipmentRendererOver.ON_EQUIPMENT_RENDERER_OVER, this.onEquipmentItemOver);
            }
        }
    }

    private function updateOldData():void {
        if (this._maintenanceData) {
            this._prevVehicleId = this._maintenanceData.vehicleId;
            this._prevGunIntCD = this._maintenanceData.gunIntCD;
        }
    }

    private function autoChBListeners(param1:Boolean = true):void {
        var _loc3_:CheckBox = null;
        var _loc2_:Array = [this.repairAuto, this.shellsAuto, this.eqAuto];
        for each(_loc3_ in _loc2_) {
            if (param1) {
                _loc3_.addEventListener(Event.SELECT, this.updateRefillSettings);
                _loc3_.addEventListener(MouseEvent.ROLL_OVER, this.onAutoRollOver);
                _loc3_.addEventListener(MouseEvent.ROLL_OUT, this.onAutoRollOut);
                _loc3_.addEventListener(MouseEvent.CLICK, this.onAutoRollOut);
            }
            else {
                _loc3_.removeEventListener(Event.SELECT, this.updateRefillSettings);
                _loc3_.removeEventListener(MouseEvent.ROLL_OVER, this.onAutoRollOver);
                _loc3_.removeEventListener(MouseEvent.ROLL_OUT, this.onAutoRollOut);
                _loc3_.removeEventListener(MouseEvent.CLICK, this.onAutoRollOut);
            }
        }
    }

    private function updateRepairBlock():void {
        var _loc1_:Number = NaN;
        this.repairAuto.removeEventListener(Event.SELECT, this.updateRefillSettings);
        this.repairAuto.selected = this._maintenanceData.autoRepair;
        this.repairAuto.addEventListener(Event.SELECT, this.updateRefillSettings);
        this.repairPrice.textColor = Currencies.TEXT_COLORS[this._maintenanceData.repairCost > this._maintenanceData.credits ? CURRENCIES_CONSTANTS.ERROR : CURRENCIES_CONSTANTS.CREDITS];
        this.repairPrice.text = App.utils.locale.integer(this._maintenanceData.repairCost);
        this.repairIndicator.maximum = this._maintenanceData.maxRepairCost;
        this.repairIndicator.value = this._maintenanceData.maxRepairCost - this._maintenanceData.repairCost;
        if (this._maintenanceData.maxRepairCost != 0) {
            _loc1_ = Math.round((this._maintenanceData.maxRepairCost - this._maintenanceData.repairCost) * 100 / this._maintenanceData.maxRepairCost);
            if (_loc1_ < 0) {
                _loc1_ = 0;
            }
            this.repairIndicator.label = _loc1_ + PERCENT_CHAR;
        }
        else {
            this.repairIndicator.label = "";
        }
    }

    private function updateShellsBlock(param1:Boolean = false):void {
        var _loc2_:MaintenanceShellVO = null;
        var _loc4_:MaintenanceShellVO = null;
        var _loc5_:MaintenanceShellVO = null;
        var _loc6_:MaintenanceShellVO = null;
        var _loc7_:Array = null;
        if (this.isResetWindow()) {
            this._shellsOrderChanged = false;
        }
        else if (!param1) {
            _loc7_ = [];
            for each(_loc5_ in this.shells.dataProvider) {
                for each(_loc6_ in this._maintenanceData.shells) {
                    if (_loc5_.id == _loc6_.id) {
                        _loc6_.setUserCount(_loc5_.userCount);
                        _loc6_.possibleMax = _loc5_.possibleMax;
                        _loc6_.currency = _loc5_.currency;
                        _loc7_.push(_loc6_);
                    }
                }
            }
            for each(_loc6_ in _loc7_) {
                _loc6_.list = _loc7_.slice();
                _loc6_.list.splice(_loc7_.indexOf(_loc6_), 1);
            }
            if (_loc7_.length) {
                this._maintenanceData.shells = _loc7_;
            }
        }
        for each(_loc2_ in this._maintenanceData.shells) {
            _loc2_.userCredits = {
                "credits": this._maintenanceData.credits,
                "gold": this._maintenanceData.gold
            };
        }
        if (this.shells.dataProvider != this._maintenanceData.shells) {
            if (this.shells.dataProvider) {
                this.shells.dataProvider.cleanUp();
            }
            this.shells.dataProvider = new DataProvider(this._maintenanceData.shells);
        }
        this.shellsAuto.removeEventListener(Event.SELECT, this.updateRefillSettings);
        this.shellsAuto.selected = this._maintenanceData.autoShells;
        this.shellsAuto.addEventListener(Event.SELECT, this.updateRefillSettings);
        this.casseteField.text = this._maintenanceData.casseteFieldText;
        var _loc3_:int = 0;
        for each(_loc4_ in this._maintenanceData.shells) {
            _loc3_ = _loc3_ + _loc4_.count;
        }
        this.shellsIndicator.maximum = this._maintenanceData.maxAmmo;
        this.shellsIndicator.value = this._maintenanceData.maxAmmo - _loc3_;
        this.shellsIndicator.setDivisor(_loc3_, this._maintenanceData.maxAmmo);
        this.shellsIndicator.textField.text = _loc3_ + SPLITTER_CHAR + this._maintenanceData.maxAmmo;
    }

    private function updateEquipmentBlock(param1:Array, param2:Array, param3:Array):void {
        var _loc7_:EquipmentItem = null;
        var _loc9_:Array = null;
        var _loc10_:ModuleVO = null;
        this.eqAuto.removeEventListener(Event.SELECT, this.updateRefillSettings);
        this.eqAuto.selected = this._maintenanceData.autoEqip;
        this.eqAuto.addEventListener(Event.SELECT, this.updateRefillSettings);
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:Array = [this.eqItem1, this.eqItem2, this.eqItem3];
        var _loc8_:int = _loc6_.length;
        var _loc11_:int = param3.length;
        var _loc12_:int = 0;
        _loc4_ = 0;
        while (_loc4_ < _loc8_) {
            _loc9_ = [];
            _loc7_ = _loc6_[_loc4_] as EquipmentItem;
            App.utils.asserter.assertNotNull(_loc7_, "slot" + Errors.CANT_NULL);
            if (_loc4_ > 0) {
                _loc5_ = 0;
                while (_loc5_ < _loc11_) {
                    _loc10_ = param3[_loc5_].clone();
                    _loc10_.slotIndex = _loc4_;
                    _loc9_.push(_loc10_);
                    _loc5_++;
                }
            }
            else {
                _loc9_ = param3.slice(0);
            }
            _loc7_.setData(_loc9_, _loc4_, param2, param1.slice(), this._maintenanceData.credits, this._maintenanceData.gold);
            if (!this._isApplyEnable && _loc7_.selectedItem) {
                if (_loc7_.selectedItem.count > 0 && param1.indexOf(_loc7_.selectedItem.compactDescr) == -1) {
                    this.doApplyEnable();
                }
            }
            if (param1[_loc4_] != undefined && param1[_loc4_] != 0) {
                _loc12_ = _loc12_ + 1;
            }
            _loc4_++;
        }
        this.eqIndicator.maximum = _loc6_.length;
        this.eqIndicator.value = _loc12_;
        this.eqIndicator.setDivisor(_loc12_, _loc6_.length);
        this.eqIndicator.textField.text = _loc12_ + SPLITTER_CHAR + _loc6_.length;
    }

    private function updateTotalPrice():void {
        var _loc1_:Prices = this.__getAmmoPrice();
        this.updatePriceLabels(this.shellsTotalCredits, this.shellsTotalGold, _loc1_);
        var _loc2_:Prices = this.__getEquipmentsPrice();
        this.updatePriceLabels(this.eqTotalCredits, this.eqTotalGold, _loc2_);
        this._totalPrice = new Prices(_loc1_.credits + _loc2_.credits + this._maintenanceData.repairCost, _loc1_.gold + _loc2_.gold);
        this.updatePriceLabels(this.totalCredits, this.totalGold, this._totalPrice);
        if (this._totalPrice.credits > 0 || this._totalPrice.gold > 0) {
            this.doApplyEnable();
        }
        this.updateButtonStates();
    }

    private function updateButtonStates():void {
        var _loc3_:MaintenanceShellVO = null;
        var _loc4_:Number = NaN;
        var _loc5_:Array = null;
        var _loc6_:EquipmentItem = null;
        this.repairBtn.enabled = this._maintenanceData.repairCost != 0 && this._maintenanceData.repairCost <= this._maintenanceData.credits;
        var _loc1_:Number = 0;
        var _loc2_:Prices = this.__getAmmoPrice();
        this._shellsCountChanged = false;
        for each(_loc3_ in this._maintenanceData.shells) {
            _loc1_ = _loc1_ + _loc3_.userCount;
            if (_loc3_.userCount != _loc3_.count) {
                this.doApplyEnable();
                this._shellsCountChanged = true;
            }
        }
        this.shellsIndicator.maximum = this._maintenanceData.maxAmmo;
        this.shellsIndicator.value = _loc1_;
        this.shellsIndicator.label = _loc1_ + SPLITTER_CHAR + this._maintenanceData.maxAmmo;
        _loc4_ = 0;
        _loc5_ = [this.eqItem1, this.eqItem2, this.eqItem3];
        for each(_loc6_ in _loc5_) {
            if (_loc6_.selectedItem) {
                _loc4_ = _loc4_ + 1;
            }
        }
        this.eqIndicator.value = _loc4_;
        this.eqIndicator.label = _loc4_ + SPLITTER_CHAR + 3;
        this.applyBtn.enabled = this._isApplyEnable && (this._maintenanceData.credits >= this._totalPrice.credits && this._maintenanceData.gold >= this._totalPrice.gold);
    }

    private function __getAmmoPrice():Prices {
        var _loc2_:MaintenanceShellVO = null;
        var _loc1_:Prices = new Prices();
        for each(_loc2_ in this._maintenanceData.shells) {
            _loc1_[_loc2_.currency] = _loc1_[_loc2_.currency] + _loc2_.buyShellsCount * _loc2_.price;
        }
        return _loc1_;
    }

    private function __getEquipmentsPrice():Prices {
        var _loc3_:EquipmentItem = null;
        var _loc1_:Prices = new Prices();
        var _loc2_:Array = [this.eqItem1, this.eqItem2, this.eqItem3];
        for each(_loc3_ in _loc2_) {
            if (_loc3_.selectedItem && _loc3_.selectedItem.count == 0 && this._equipmentInstalled.indexOf(_loc3_.selectedItem.compactDescr) == -1) {
                _loc1_[_loc3_.selectedItem.currency] = _loc1_[_loc3_.selectedItem.currency] + _loc3_.selectedItem.price;
            }
        }
        return _loc1_;
    }

    private function updatePriceLabels(param1:IconText, param2:IconText, param3:Prices):void {
        param1.textColor = Currencies.TEXT_COLORS[param3.credits > this._maintenanceData.credits ? CURRENCIES_CONSTANTS.ERROR : CURRENCIES_CONSTANTS.CREDITS];
        var _loc4_:ILocale = App.utils.locale;
        param1.text = _loc4_.integer(param3.credits || 0);
        param2.textColor = Currencies.TEXT_COLORS[param3.gold > this._maintenanceData.gold ? CURRENCIES_CONSTANTS.ERROR : CURRENCIES_CONSTANTS.GOLD];
        param2.text = _loc4_.gold(param3.gold || 0);
    }

    private function onEquipmentItemOver(param1:OnEquipmentRendererOver):void {
        var _loc4_:EquipmentItem = null;
        var _loc5_:String = null;
        var _loc2_:Array = [];
        var _loc3_:Array = [this.eqItem1, this.eqItem2, this.eqItem3];
        for each(_loc4_ in _loc3_) {
            _loc5_ = !!_loc4_.selectedItem ? _loc4_.selectedItem.id : null;
            _loc2_.push(_loc5_);
        }
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_MODULE, null, param1.moduleID, param1.modulePrices, param1.inventoryCount, param1.vehicleCount, param1.moduleIndex, _loc2_);
    }

    private function onAutoRollOver(param1:MouseEvent):void {
        var _loc2_:String = null;
        if (param1.target == this.repairAuto) {
            _loc2_ = TOOLTIPS.REPAIR_AUTO;
        }
        else if (param1.target == this.shellsAuto) {
            _loc2_ = TOOLTIPS.AMMO_AUTO;
        }
        else if (param1.target == this.eqAuto) {
            _loc2_ = TOOLTIPS.EQUIPMENT_AUTO;
        }
        if (_loc2_) {
            App.toolTipMgr.showComplex(_loc2_, null);
        }
    }

    private function onAutoRollOut(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onEquipmentUpdate(param1:EquipmentEvent):void {
        invalidate(EQUIPMENT_CHANGED);
    }

    private function onEquipmentChange(param1:EquipmentEvent):void {
        var _loc2_:Array = null;
        var _loc3_:EquipmentItem = null;
        var _loc4_:EquipmentItem = null;
        if (param1.changeIndex != -1) {
            _loc2_ = [this.eqItem1, this.eqItem2, this.eqItem3];
            _loc3_ = param1.target as EquipmentItem;
            App.utils.asserter.assertNotNull(_loc3_, "itemChangeFrom" + Errors.CANT_NULL);
            _loc4_ = _loc2_[param1.changeIndex] as EquipmentItem;
            App.utils.asserter.assertNotNull(_loc4_, "itemChangeTo" + Errors.CANT_NULL);
            _loc4_.removeEventListener(EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
            _loc3_.removeEventListener(EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
            _loc4_.toggleSelectChange(false);
            if (_loc3_.selectedItem) {
                _loc3_.selectedItem.currency = !!_loc4_.selectedItem ? _loc4_.selectedItem.currency : Values.EMPTY_STR;
            }
            _loc4_.select.selectedIndex = param1.changePos;
            if (_loc4_.selectedItem) {
                _loc4_.selectedItem.currency = param1.changeCurrency;
            }
            _loc4_.toggleSelectChange(true);
            _loc4_.addEventListener(EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
            _loc3_.addEventListener(EquipmentEvent.EQUIPMENT_CHANGE, this.onEquipmentChange);
            this._eqOrderChanged = true;
        }
        this.doApplyEnable();
        getEquipmentS(!!this.eqItem1.selectedItem ? this.eqItem1.selectedItem.id : undefined, !!this.eqItem1.selectedItem ? this.eqItem1.selectedItem.currency : undefined, !!this.eqItem2.selectedItem ? this.eqItem2.selectedItem.id : undefined, !!this.eqItem2.selectedItem ? this.eqItem2.selectedItem.currency : undefined, !!this.eqItem3.selectedItem ? this.eqItem3.selectedItem.id : undefined, !!this.eqItem3.selectedItem ? this.eqItem3.selectedItem.currency : undefined, EquipmentItem(param1.target).index);
    }

    private function onShowModuleInfo(param1:ModuleInfoEvent):void {
        showModuleInfoS(param1.id);
    }

    private function onChangeOrder(param1:ShellRendererEvent):void {
        var _loc4_:Array = null;
        var _loc5_:Array = null;
        var _loc6_:MaintenanceShellVO = null;
        var _loc2_:MaintenanceShellVO = param1.shell;
        var _loc3_:MaintenanceShellVO = param1.shellToReplace;
        if (_loc2_ && _loc3_) {
            _loc4_ = this._maintenanceData.shells;
            _loc5_ = [];
            for each(_loc6_ in _loc4_) {
                if (_loc6_ == _loc2_) {
                    _loc5_.push(_loc3_);
                }
                else if (_loc6_ == _loc3_) {
                    _loc5_.push(_loc2_);
                }
                else {
                    _loc5_.push(_loc6_);
                }
            }
            for each(_loc6_ in _loc5_) {
                _loc6_.list = _loc5_.slice();
                _loc6_.list.splice(_loc5_.indexOf(_loc6_), 1);
            }
            this._maintenanceData.shells = _loc5_;
            this.updateShellsBlock(true);
            this.doApplyEnable();
            this._shellsOrderChanged = true;
        }
    }

    private function updateRefillSettings(param1:Event):void {
        if (this._maintenanceData) {
            setRefillSettingsS(this._maintenanceData.vehicleId, this.repairAuto.selected, this.shellsAuto.selected, this.eqAuto.selected);
        }
    }

    private function onAmmoPriceChanged(param1:ShellRendererEvent):void {
        invalidate(ShellRendererEvent.TOTAL_PRICE_CHANGED);
    }

    private function onAmmoCurrencyChanged(param1:ShellRendererEvent):void {
        this.doApplyEnable();
    }

    private function onEquipmentPriceChanged(param1:EquipmentEvent):void {
        this.doApplyEnable();
        var _loc2_:EquipmentItem = param1.currentTarget as EquipmentItem;
        App.utils.asserter.assertNotNull(_loc2_, "equipmentItem" + Errors.CANT_NULL);
        updateEquipmentCurrencyS(_loc2_.index, param1.changeCurrency);
        invalidate(ShellRendererEvent.TOTAL_PRICE_CHANGED);
    }

    private function doApplyEnable():void {
        this._isApplyEnable = true;
    }

    private function onRepairClick(param1:ButtonEvent):void {
        repairS();
    }

    private function onApplyClick(param1:ButtonEvent):void {
        var _loc3_:MaintenanceShellVO = null;
        var _loc4_:Boolean = false;
        var _loc5_:Boolean = false;
        var _loc6_:Prices = null;
        var _loc7_:Boolean = false;
        var _loc8_:Prices = null;
        var _loc9_:Boolean = false;
        var _loc2_:Boolean = false;
        for each(_loc3_ in this._maintenanceData.shells) {
            if (_loc3_.userCount - _loc3_.count > 0) {
                _loc2_ = true;
                break;
            }
        }
        _loc4_ = !_loc2_ && this._shellsCountChanged;
        _loc2_ = _loc2_ || this._totalPrice.credits - this._maintenanceData.repairCost > 0 || this._totalPrice.gold > 0 || this.eqItem1.changed && this.eqItem1.selectedItem && this._equipmentInstalled.indexOf(this.eqItem1.selectedItem.compactDescr) == -1 || this.eqItem2.changed && this.eqItem2.selectedItem && this._equipmentInstalled.indexOf(this.eqItem2.selectedItem.compactDescr) == -1 || this.eqItem3.changed && this.eqItem3.selectedItem && this._equipmentInstalled.indexOf(this.eqItem3.selectedItem.compactDescr) == -1;
        _loc5_ = this._shellsOrderChanged || this._eqOrderChanged;
        _loc6_ = this.__getAmmoPrice();
        _loc7_ = _loc6_.credits > 0 || _loc6_.gold > 0;
        _loc8_ = this.__getEquipmentsPrice();
        _loc9_ = _loc8_.credits > 0 || _loc8_.gold > 0;
        fillVehicleS(this.repairBtn.enabled, _loc7_, _loc9_, _loc2_, _loc4_, _loc5_, this._maintenanceData.shells, [this.eqItem1.selectedItem, this.eqItem2.selectedItem, this.eqItem3.selectedItem]);
    }

    private function onClose(param1:ButtonEvent):void {
        onWindowCloseS();
    }
}
}
class Prices {

    public var credits:Number = 0;

    public var gold:Number = 0;

    function Prices(param1:Number = 0, param2:Number = 0) {
        super();
        this.credits = param1;
        this.gold = param2;
    }

    public function toString():Object {
        return "credits: " + this.credits + ", gold: " + this.gold;
    }
}
