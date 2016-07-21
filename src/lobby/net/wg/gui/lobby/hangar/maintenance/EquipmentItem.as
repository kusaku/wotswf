package net.wg.gui.lobby.hangar.maintenance {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Currencies;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.events.EquipmentEvent;
import net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;
import net.wg.utils.IEventCollector;
import net.wg.utils.ILocale;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.gfx.MouseEventEx;

public class EquipmentItem extends SoundButtonEx {

    private static const SLOTS_MIN_COUNT:int = 9;

    private static const MULTY_CHARS:String = " x ";

    private static const TO_BUY_POS:int = 775;

    private static const BUY_BTN_LEFT_PADDING:int = 10;

    private static const INV_UPDATE:String = "invalidateUpdate";

    private static const INV_CLEAR:String = "invalidateClear";

    public var slotBg:MovieClip;

    public var select:DropdownMenu;

    public var title:TextField;

    public var descr:TextField;

    public var countLabel:TextField;

    public var emptyFocusIndicator:MovieClip;

    public var moduleType:ModuleTypesUIWithFill;

    public var toBuy:IconText;

    public var price:IconText;

    public var actionPrice:ActionPrice;

    public var toBuyTf:TextField;

    public var toBuyDropdown:DropdownMenu;

    public var index:int;

    private var _initialId:String;

    private var _selectedIndexOld:int = -1;

    private var _defaultInitialized:Boolean = false;

    private var _artifactsData:Array;

    private var _installedData:Array;

    public function EquipmentItem() {
        super();
        this.select.handleScroll = false;
        this.select.focusIndicator = this.emptyFocusIndicator;
    }

    override protected function onDispose():void {
        var _loc1_:IEventCollector = App.utils.events;
        _loc1_.removeEvent(this.toBuyDropdown, ListEvent.INDEX_CHANGE, this.onModuleCurrencyChangedHandler);
        _loc1_.removeEvent(this.select, ListEvent.INDEX_CHANGE, this.onItemRendererClickHandler);
        this.cleanupData();
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.moduleType.dispose();
        this.moduleType = null;
        this.select.dispose();
        this.select = null;
        this.toBuy.dispose();
        this.toBuy = null;
        this.toBuyDropdown.dispose();
        this.toBuyDropdown = null;
        this.price.dispose();
        this.price = null;
        this.title = null;
        this.descr = null;
        this.countLabel = null;
        this.emptyFocusIndicator = null;
        this.toBuyTf = null;
        this.slotBg = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        focusTarget = this.select;
        _focusable = tabEnabled = tabChildren = mouseChildren = true;
        this.slotBg.mouseEnabled = this.slotBg.mouseChildren = false;
        this.moduleType.mouseEnabled = this.moduleType.mouseChildren = false;
        this.title.mouseEnabled = false;
        this.descr.mouseEnabled = false;
        this.countLabel.mouseEnabled = false;
        this.toBuy.mouseEnabled = this.toBuy.mouseChildren = false;
        this.price.mouseEnabled = this.price.mouseChildren = false;
        var _loc1_:IEventCollector = App.utils.events;
        _loc1_.addEvent(this.toBuyDropdown, ListEvent.INDEX_CHANGE, this.onModuleCurrencyChangedHandler);
        this.soundType = SoundTypes.ARTEFACT_RENDERER;
    }

    override protected function showTooltip():void {
        var _loc1_:ModuleVO = this.selectedItem;
        if (_loc1_) {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_MAIN_MODULE, null, _loc1_.id, _loc1_.prices, _loc1_.inventoryCount, _loc1_.vehicleCount);
        }
        else {
            App.toolTipMgr.showComplex(TOOLTIPS.EQUIPMENT_EMPTY, null);
        }
    }

    public function setData(param1:Array, param2:int, param3:Array, param4:Array, param5:Number, param6:Number):void {
        var _loc8_:ModuleVO = null;
        var _loc9_:int = 0;
        if (param1) {
            this.select.dataProvider.cleanUp();
            this.cleanupData();
        }
        this.index = param2;
        this._artifactsData = param1;
        this._installedData = param4;
        this._selectedIndexOld = -1;
        var _loc7_:int = -1;
        var _loc10_:int = param1.length;
        _loc9_ = 0;
        while (_loc9_ < _loc10_) {
            _loc8_ = param1[_loc9_];
            _loc8_.userCredits = {
                "credits": param5,
                "gold": param6
            };
            if (_loc8_.target == 1 && param2 == _loc8_.index) {
                this._selectedIndexOld = _loc9_;
            }
            if (_loc8_.compactDescr == param3[param2]) {
                _loc7_ = _loc9_;
            }
            if (_loc8_.compactDescr == param4[param2]) {
                this._initialId = _loc8_.id;
            }
            _loc9_++;
        }
        this.select.close();
        var _loc11_:IEventCollector = App.utils.events;
        _loc11_.removeEvent(this.select, ListEvent.INDEX_CHANGE, this.onItemRendererClickHandler);
        this.select.dataProvider = new DataProvider(param1);
        this.select.menuRowCount = Math.min(SLOTS_MIN_COUNT, param1.length);
        this.select.selectedIndex = this._selectedIndexOld;
        if (_loc7_ != -1 && !this._defaultInitialized) {
            this._defaultInitialized = true;
            this.select.selectedIndex = _loc7_;
            dispatchEvent(new EquipmentEvent(EquipmentEvent.NEED_UPDATE));
        }
        this.select.scrollBar = param1.length > this.select.menuRowCount ? Linkages.SCROLL_BAR : null;
        _loc11_.addEvent(this.select, ListEvent.INDEX_CHANGE, this.onItemRendererClickHandler);
        invalidate(this.select.selectedIndex != -1 ? INV_UPDATE : INV_CLEAR);
    }

    public function setEmptyItem():void {
        var _loc1_:IEventCollector = App.utils.events;
        _loc1_.removeEvent(this.select, ListEvent.INDEX_CHANGE, this.onItemRendererClickHandler);
        this._selectedIndexOld = -1;
        this.select.selectedIndex = -1;
        _loc1_.addEvent(this.select, ListEvent.INDEX_CHANGE, this.onItemRendererClickHandler);
        dispatchEvent(new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE));
    }

    public function toggleSelectChange(param1:Boolean):void {
        if (param1) {
            App.utils.events.addEvent(this.select, ListEvent.INDEX_CHANGE, this.onItemRendererClickHandler);
        }
        else {
            App.utils.events.removeEvent(this.select, ListEvent.INDEX_CHANGE, this.onItemRendererClickHandler);
        }
    }

    override protected function draw():void {
        super.draw();
        if (this.select.selectedIndex == -1 && isInvalid(INV_CLEAR)) {
            this.clear();
        }
        if (this.select.selectedIndex != -1 && isInvalid(INV_UPDATE)) {
            this.update();
        }
    }

    private function cleanupData():void {
        if (this._artifactsData) {
            this._artifactsData.splice(0, this._artifactsData.length);
            this._artifactsData = null;
        }
        if (this._installedData) {
            this._installedData.splice(0);
            this._installedData = null;
        }
    }

    private function update():void {
        var _loc2_:ILocale = null;
        var _loc3_:IEventCollector = null;
        var _loc1_:ModuleVO = this.selectedItem;
        this.toBuyDropdown.visible = false;
        this.toBuyTf.visible = false;
        App.utils.asserter.assertFrameExists(_loc1_.moduleLabel, this.moduleType);
        this.moduleType.gotoAndStop(_loc1_.moduleLabel);
        this.title.text = _loc1_.name;
        this.descr.text = _loc1_.desc;
        this.countLabel.visible = this.toBuy.visible = true;
        this.actionPrice.setup(this);
        this.price.visible = !this.actionPrice.visible;
        this.countLabel.alpha = _loc1_.count > 0 ? Number(1) : Number(0.3);
        _loc2_ = App.utils.locale;
        this.countLabel.text = _loc2_.integer(_loc1_.count);
        if (_loc1_.prices[1] > 0 && _loc1_.prices[0] > 0 && _loc1_.goldEqsForCredits) {
            this.toBuyTf.visible = _loc1_.goldEqsForCredits;
            this.toBuy.visible = !_loc1_.goldEqsForCredits;
            _loc3_ = App.utils.events;
            this.toBuyDropdown.visible = _loc1_.goldEqsForCredits;
            _loc3_.removeEvent(this.toBuyDropdown, ListEvent.INDEX_CHANGE, this.onModuleCurrencyChangedHandler);
            this.toBuyDropdown.dataProvider = new DataProvider([_loc2_.htmlTextWithIcon(_loc2_.integer(_loc1_.prices[0]), Currencies.CREDITS), _loc2_.htmlTextWithIcon(_loc2_.gold(_loc1_.prices[1]), Currencies.GOLD)]);
            this.toBuyDropdown.selectedIndex = _loc1_.currency == Currencies.CREDITS ? 0 : 1;
            _loc3_.addEvent(this.toBuyDropdown, ListEvent.INDEX_CHANGE, this.onModuleCurrencyChangedHandler);
        }
        else {
            this.toBuyDropdown.visible = false;
            this.toBuyTf.visible = false;
            this.toBuy.visible = true;
        }
        this.updateModulePrice();
    }

    private function clear():void {
        this.toBuyDropdown.visible = false;
        this.toBuyTf.visible = false;
        this.moduleType.gotoAndStop("empty");
        this.title.text = "";
        this.descr.text = "";
        this.countLabel.visible = this.toBuy.visible = this.price.visible = this.actionPrice.visible = false;
    }

    private function updateModulePrice():void {
        var _loc1_:ModuleVO = this.selectedItem;
        this.price.icon = this.toBuy.icon = _loc1_.currency;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (_loc1_.count == 0 && this.changed && this._installedData.indexOf(_loc1_.compactDescr) == -1) {
            _loc2_ = 1;
        }
        if (this.toBuyDropdown.visible) {
            _loc3_ = _loc1_.prices[this.toBuyDropdown.selectedIndex];
        }
        else {
            _loc3_ = _loc1_.prices[_loc1_.currency == Currencies.CREDITS ? 0 : 1];
        }
        var _loc4_:ILocale = App.utils.locale;
        var _loc5_:Number = _loc3_ * _loc2_;
        this.toBuy.textColor = Currencies.TEXT_COLORS[_loc1_.currency];
        this.price.textColor = Currencies.TEXT_COLORS[_loc5_ > _loc1_.userCredits[_loc1_.currency] ? Currencies.ERROR : _loc1_.currency];
        this.price.text = _loc1_.currency == Currencies.CREDITS ? _loc4_.integer(_loc5_) : _loc4_.gold(_loc5_);
        var _loc6_:ActionPriceVO = null;
        if (_loc1_.actionPriceVo) {
            _loc6_ = _loc1_.actionPriceVo;
            _loc6_.forCredits = _loc1_.currency == Currencies.CREDITS;
        }
        this.actionPrice.setData(_loc6_);
        this.price.visible = !this.actionPrice.visible;
        if (this.actionPrice.visible) {
            if (_loc1_.status == MENU.MODULEFITS_NOT_WITH_INSTALLED_EQUIPMENT) {
                this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_DISABLE;
            }
            else if (_loc1_.price < _loc1_.userCredits[_loc1_.currency]) {
                this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
            }
            else {
                this.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
        }
        this.toBuy.text = _loc2_ + MULTY_CHARS + this.price.text;
        this.toBuyTf.text = _loc2_ + MULTY_CHARS;
        this.toBuy.enabled = this.price.enabled = _loc2_ != 0;
        this.toBuy.mouseEnabled = this.price.mouseEnabled = false;
        this.toBuy.validateNow();
        this.toBuy.x = TO_BUY_POS - this.toBuy.width + (this.toBuy.textField.textWidth >> 1) + BUY_BTN_LEFT_PADDING ^ 0;
        this.toBuyTf.alpha = _loc2_ != 0 ? Number(1) : Number(0.3);
    }

    public function get changed():Boolean {
        if (this.select.selectedIndex > -1) {
            return this._initialId != this.selectedItem.id;
        }
        return false;
    }

    public function get selectedItem():ModuleVO {
        return this.select.selectedIndex == -1 ? null : this._artifactsData[this.select.selectedIndex];
    }

    override protected function onMouseDownHandler(param1:MouseEvent):void {
        var _loc2_:Boolean = false;
        super.onMouseDownHandler(param1);
        if (this.selectedItem && param1 is MouseEventEx) {
            if (App.utils.commons.isRightButton(param1)) {
                _loc2_ = this.changed && this.selectedItem.count == 0 && this._installedData.indexOf(this.selectedItem.compactDescr) == -1;
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.TECHNICAL_MAINTENANCE, this, {
                    "isCanceled": _loc2_,
                    "equipmentCD": this.selectedItem.id
                });
            }
        }
    }

    private function onModuleCurrencyChangedHandler(param1:ListEvent):void {
        this.price.icon = this.toBuyDropdown.selectedIndex == 0 ? Currencies.CREDITS : Currencies.GOLD;
        this.actionPrice.ico = this.toBuyDropdown.selectedIndex == 0 ? IconsTypes.CREDITS : IconsTypes.GOLD;
        this.selectedItem.currency = this.toBuyDropdown.selectedIndex == 0 ? Currencies.CREDITS : Currencies.GOLD;
        invalidate(INV_UPDATE);
        dispatchEvent(new EquipmentEvent(EquipmentEvent.TOTAL_PRICE_CHANGED, -1, -1, this.selectedItem.currency));
    }

    private function onItemRendererClickHandler(param1:ListEvent):void {
        var _loc2_:EquipmentEvent = null;
        if (this.selectedItem.target == 1) {
            _loc2_ = new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE, !!this.selectedItem ? int(this.selectedItem.index) : -1, this._selectedIndexOld, this._selectedIndexOld > -1 ? this._artifactsData[this._selectedIndexOld].currency : Values.EMPTY_STR);
        }
        else {
            _loc2_ = new EquipmentEvent(EquipmentEvent.EQUIPMENT_CHANGE);
        }
        if (this.select.hitTestPoint(App.stage.mouseX, App.stage.mouseY)) {
            this.showTooltip();
        }
        dispatchEvent(_loc2_);
    }
}
}
