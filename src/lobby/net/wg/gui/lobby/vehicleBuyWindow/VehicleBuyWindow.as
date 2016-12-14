package net.wg.gui.lobby.vehicleBuyWindow {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

import net.wg.data.Colors;
import net.wg.data.constants.IconsTypes;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.infrastructure.base.meta.IVehicleBuyWindowMeta;
import net.wg.infrastructure.base.meta.impl.VehicleBuyWindowMeta;
import net.wg.infrastructure.constants.WindowViewInvalidationType;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.utils.ILocale;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.utils.Constraints;
import scaleform.clik.utils.Padding;

public class VehicleBuyWindow extends VehicleBuyWindowMeta implements IVehicleBuyWindowMeta {

    public static const WARNING_HEIGHT:int = 85;

    private static const DD_MARGIN:int = 5;

    private static const RIGHT_OFFSET:int = -4;

    private static const LEFT_OFFSET:int = -3;

    private static const INV_TOTAL_RESULT:String = "InvTotalResult";

    private static const INV_EXPAND:String = "InvExpand";

    private static const EMPTY_STR:String = "";

    public var footerMc:FooterMc = null;

    public var bodyMc:BodyMc = null;

    public var headerMc:HeaderMc = null;

    public var backgroundMc:Sprite = null;

    public var bodyMaskMc:MovieClip = null;

    private var _goldColor:uint = 0;

    private var _creditsColor:uint = 0;

    private var _animManager:VehicleBuyWindowAnimManager = null;

    private var _expand:Boolean = true;

    private var _expandImmediate:Boolean = false;

    private var _userTotalGold:Number = NaN;

    private var _userTotalCredits:Number = NaN;

    private var _initInfo:BuyingVehicleVO = null;

    private var _windowBackgroundSizeInitialized:Boolean = false;

    private var _selectedRentId:int = -1;

    private var _isSubmitBtnEnabled:Boolean = true;

    public function VehicleBuyWindow() {
        super();
        isModal = true;
        isCentered = true;
        canDrag = false;
        showWindowBgForm = false;
    }

    override public function setWindow(param1:IWindow):void {
        var _loc3_:Constraints = null;
        if (window != param1) {
            this.disposeWindowRefHandlers();
            if (param1) {
                _loc3_ = param1.getConstraints();
                if (_loc3_) {
                    _loc3_.addEventListener(Event.RESIZE, this.onWindowRefResizeHandler);
                }
            }
        }
        super.setWindow(param1);
        var _loc2_:Padding = Padding(window.contentPadding);
        _loc2_.right = _loc2_.right + RIGHT_OFFSET;
        _loc2_.bottom = _loc2_.bottom + LEFT_OFFSET;
        window.contentPadding = _loc2_;
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        this.moveFocusToSubmitButton();
    }

    override protected function configUI():void {
        super.configUI();
        this._goldColor = this.footerMc.totalGoldPrice.textColor;
        this._creditsColor = this.footerMc.totalCreditsPrice.textColor;
        this._animManager = new VehicleBuyWindowAnimManager(this);
        this.headerMc.rentIcon.visible = false;
        var _loc1_:ILocale = App.utils.locale;
        this.footerMc.submitBtn.label = _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_SUBMITBTN);
        this.footerMc.cancelBtn.label = _loc1_.makeString(DIALOGS.BUYVEHICLEDIALOG_CANCELBTN);
        this.footerMc.expandBtn.addEventListener(ButtonEvent.CLICK, this.onExpandButtonClickHandler);
        this.footerMc.submitBtn.addEventListener(ButtonEvent.CLICK, this.onSubmitButtonClickHandler);
        this.footerMc.cancelBtn.addEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.moveFocusToSubmitButton();
        this.bodyMc.addEventListener(BodyMc.BUTTONS_GROUP_SELECTION_CHANGED, this.onBodyMcButtonsGroupSelectionChangedHandler);
        this.bodyMc.ammoCheckbox.addEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
        this.bodyMc.slotCheckbox.addEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
        this.bodyMc.crewCheckbox.addEventListener(Event.SELECT, this.onCrewCheckBoxSelectHandler);
    }

    override protected function draw():void {
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:DropShadowFilter = null;
        var _loc7_:Object = null;
        var _loc8_:Number = NaN;
        var _loc9_:Number = NaN;
        var _loc10_:Boolean = false;
        super.draw();
        if (window && isInvalid(WindowViewInvalidationType.POSITION_INVALID)) {
            _loc2_ = App.appWidth;
            _loc3_ = App.appHeight;
            if (isCentered) {
                window.x = _loc2_ - window.width >> 1;
                window.y = _loc3_ - window.getBackground().height >> 1;
            }
            else {
                _loc4_ = window.width + window.x;
                _loc5_ = window.getBackground().height + window.y;
                if (_loc4_ > _loc2_) {
                    window.x = window.x - (_loc4_ - _loc2_);
                }
                if (_loc5_ > _loc3_) {
                    window.y = window.y - (_loc5_ - _loc3_);
                }
            }
        }
        var _loc1_:ILocale = App.utils.locale;
        if (this._initInfo != null && isInvalid(InvalidationType.DATA)) {
            _loc6_ = this.headerMc.tankPriceLabel.filters[0];
            this.window.titleUseHtml = true;
            window.title = this._initInfo.title;
            this.headerMc.tankName.htmlText = this._initInfo.longName;
            this.headerMc.tankDescr.text = this._initInfo.description;
            this.bodyMc.tankmenLabel.htmlText = this._initInfo.tankmenLabel;
            this.footerMc.submitBtn.label = this._initInfo.submitBtnLabel;
            this.footerMc.cancelBtn.label = this._initInfo.cancelBtnLabel;
            this.initVehicleIcon();
            this.initStudyButtons();
            this.initPriceControls();
            this.bodyMc.crewCheckbox.label = this._initInfo.crewCheckbox;
            this.bodyMc.crewCheckbox.textField.filters = this.bodyMc.ammoCheckbox.textField.filters = this.bodyMc.slotCheckbox.textField.filters = [_loc6_];
            this.updateRentItems();
            _loc7_ = this.headerMc.rentDD.dataProvider[this.headerMc.rentDD.selectedIndex];
            if (this.headerMc.rentDD.visible && _loc7_) {
                this.checkRentDDSelectedItem(_loc7_.data);
            }
            else {
                this.updateVehiclePrice();
            }
        }
        if (this._windowBackgroundSizeInitialized && isInvalid(INV_EXPAND)) {
            this._animManager.launch(this._expand, this._expandImmediate);
        }
        if (isInvalid(INV_TOTAL_RESULT)) {
            this.headerMc.rentIcon.visible = this._selectedRentId != VehicleBuyRentItemVO.DEF_ITEM_ID;
            _loc8_ = !!this.bodyMc.slotCheckbox.selected ? Number(this._initInfo.slotPrice) : Number(0);
            _loc9_ = !!this.bodyMc.ammoCheckbox.selected ? Number(this._initInfo.ammoPrice) : Number(0);
            if (this._initInfo.vehiclePrice.isGold) {
                _loc8_ = _loc8_ + this._initInfo.vehiclePrice.price;
            }
            else {
                _loc9_ = _loc9_ + this._initInfo.vehiclePrice.price;
            }
            if (!this.bodyMc.crewCheckbox.selected) {
                if (this.bodyMc.isGoldPriceSelected) {
                    _loc8_ = _loc8_ + this.bodyMc.selectedPrice;
                }
                else {
                    _loc9_ = _loc9_ + this.bodyMc.selectedPrice;
                }
            }
            this.footerMc.totalGoldPrice.text = _loc1_.gold(_loc8_);
            _loc9_ = !!isNaN(_loc9_) ? Number(0) : Number(_loc9_);
            this.footerMc.totalCreditsPrice.text = _loc1_.integer(_loc9_);
            _loc10_ = true;
            if (_loc8_ > this._userTotalGold) {
                this.footerMc.totalGoldPrice.textColor = Colors.ERROR_COLOR;
                _loc10_ = false;
            }
            else {
                this.footerMc.totalGoldPrice.textColor = this._goldColor;
            }
            if (_loc9_ > this._userTotalCredits) {
                this.footerMc.totalCreditsPrice.textColor = Colors.ERROR_COLOR;
                _loc10_ = false;
            }
            else {
                this.footerMc.totalCreditsPrice.textColor = this._creditsColor;
            }
            this.footerMc.submitBtn.enabled = _loc10_ && this._isSubmitBtnEnabled;
        }
    }

    override protected function onDispose():void {
        this._animManager.dispose();
        this._animManager = null;
        this.headerMc.rentDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onHeaderMcRentDDIndexChangeHandler);
        this.headerMc.dispose();
        this.headerMc = null;
        this.footerMc.expandBtn.removeEventListener(ButtonEvent.CLICK, this.onExpandButtonClickHandler);
        this.footerMc.submitBtn.removeEventListener(ButtonEvent.CLICK, this.onSubmitButtonClickHandler);
        this.footerMc.cancelBtn.removeEventListener(ButtonEvent.CLICK, this.onCancelButtonClickHandler);
        this.footerMc.dispose();
        this.footerMc = null;
        this.bodyMc.removeEventListener(BodyMc.BUTTONS_GROUP_SELECTION_CHANGED, this.onBodyMcButtonsGroupSelectionChangedHandler);
        this.bodyMc.ammoCheckbox.removeEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
        this.bodyMc.slotCheckbox.removeEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
        this.bodyMc.crewCheckbox.removeEventListener(Event.SELECT, this.onCrewCheckBoxSelectHandler);
        this.bodyMc.dispose();
        this.bodyMc = null;
        this.backgroundMc = null;
        this.bodyMaskMc = null;
        this._initInfo = null;
        this.disposeWindowRefHandlers();
        super.onDispose();
    }

    override protected function setInitData(param1:BuyingVehicleVO):void {
        this.expand(param1.expanded, true);
        this._initInfo = param1;
        if (StringUtils.isNotEmpty(this._initInfo.warningMsg)) {
            this.footerMc.showWarning(this._initInfo.warningMsg);
            this.backgroundMc.height = this.backgroundMc.height + WARNING_HEIGHT;
            this.height = _originalHeight + WARNING_HEIGHT;
            window.updateSize(this.width, this.height, true);
        }
        invalidate(InvalidationType.DATA, INV_TOTAL_RESULT);
    }

    public function as_setCredits(param1:Number):void {
        this._userTotalCredits = param1;
        invalidate(INV_TOTAL_RESULT);
    }

    public function as_setEnabledSubmitBtn(param1:Boolean):void {
        if (this._isSubmitBtnEnabled == param1) {
            return;
        }
        this._isSubmitBtnEnabled = param1;
        invalidate(INV_TOTAL_RESULT);
    }

    public function as_setGold(param1:Number):void {
        if (this._userTotalGold == param1) {
            return;
        }
        this._userTotalGold = param1;
        invalidate(INV_TOTAL_RESULT);
    }

    public function expand(param1:Boolean, param2:Boolean):void {
        if (this._expand != param1) {
            this._expand = param1;
            this._expandImmediate = param2;
            invalidate(INV_EXPAND);
        }
        this.footerMc.expandBtn.expanded = param1;
    }

    public function moveFocusToSubmitButton():void {
        setFocus(this.footerMc.submitBtn);
    }

    private function initPriceControls():void {
        this.headerMc.tankPriceLabel.htmlText = this._initInfo.priceLabel;
        this.bodyMc.slotPrice.text = App.utils.locale.integer(this._initInfo.slotPrice);
        this.bodyMc.slotActionPrice.setData(this._initInfo.slotActionPriceDataVo);
        this.bodyMc.slotPrice.visible = !this.bodyMc.slotActionPrice.visible;
    }

    private function initStudyButtons():void {
        this.bodyMc.scoolBtn.updatePrice(this._initInfo.studyPriceCredits, IconsTypes.CREDITS, this._initInfo.studyPriceCreditsActionDataVo);
        this.bodyMc.academyBtn.updatePrice(this._initInfo.studyPriceGold, IconsTypes.GOLD, this._initInfo.studyPriceGoldActionDataVo);
        this.bodyMc.freeBtn.updatePrice(0, EMPTY_STR);
        this.bodyMc.freeBtn.data = 0;
        this.bodyMc.freeBtn.enabled = !this._initInfo.isStudyDisabled;
        this.bodyMc.scoolBtn.data = this._initInfo.studyPriceCredits;
        this.bodyMc.scoolBtn.enabled = this._userTotalCredits >= this._initInfo.studyPriceCredits && !this._initInfo.isStudyDisabled;
        this.bodyMc.academyBtn.data = this._initInfo.studyPriceGold;
        this.bodyMc.academyBtn.enabled = this._userTotalGold >= this._initInfo.studyPriceGold && !this._initInfo.isStudyDisabled;
        this.bodyMc.scoolBtn.nation = this.bodyMc.academyBtn.nation = this.bodyMc.freeBtn.nation = this._initInfo.nation;
    }

    private function initVehicleIcon():void {
        this.headerMc.icon.tankType = this._initInfo.type;
        this.headerMc.icon.image = this._initInfo.icon;
        this.headerMc.icon.nation = this._initInfo.nation;
        this.headerMc.icon.level = this._initInfo.level;
        this.headerMc.icon.isElite = this._initInfo.isElite;
        this.headerMc.icon.isPremium = this._initInfo.isPremium;
    }

    private function checkAmmo():void {
        var _loc1_:ILocale = null;
        if (this._initInfo.isNoAmmo) {
            _loc1_ = App.utils.locale;
            this.bodyMc.ammoActionPrice.setData(this._initInfo.ammoActionPriceDataVo);
            this.bodyMc.ammoPrice.text = _loc1_.integer(this._initInfo.ammoPrice);
            this.bodyMc.ammoPrice.visible = !this.bodyMc.ammoActionPrice.visible;
        }
        else {
            this.bodyMc.ammoPrice.visible = this.bodyMc.ammoActionPrice.visible = this._initInfo.isNoAmmo;
        }
        this.bodyMc.ammoCheckbox.visible = this._initInfo.isNoAmmo;
    }

    private function updateVehiclePrice():void {
        var _loc1_:ILocale = App.utils.locale;
        var _loc2_:ActionPriceVO = this._initInfo.actualActionPriceDataVo;
        this.headerMc.tankActionPrice.setData(_loc2_);
        this.headerMc.tankPrice.visible = !this.headerMc.tankActionPrice.visible;
        this.headerMc.tankPrice.icon = !!this._initInfo.vehiclePrice.isGold ? CURRENCIES_CONSTANTS.GOLD : CURRENCIES_CONSTANTS.CREDITS;
        this.headerMc.tankPrice.textColor = !!this._initInfo.vehiclePrice.isGold ? Number(this._goldColor) : Number(this._creditsColor);
        this.headerMc.tankPrice.text = _loc1_.integer(this._initInfo.vehiclePrice.price);
    }

    private function updateRentItems():void {
        this.headerMc.rentDD.visible = this._initInfo.isRentable;
        this.bodyMc.scoolBtn.showPriceLabel = !this._initInfo.isStudyDisabled;
        this.bodyMc.academyBtn.showPriceLabel = !this._initInfo.isStudyDisabled;
        this.bodyMc.freeBtn.showPriceLabel = !this._initInfo.isStudyDisabled;
        this.bodyMc.crewCheckbox.visible = !this._initInfo.isStudyDisabled;
        this.bodyMc.crewInVehicle.visible = this._initInfo.isStudyDisabled;
        this.checkAmmo();
        if (this._initInfo.isRentable) {
            this.headerMc.rentDD.dataProvider = new DataProvider(this._initInfo.rentDataProviderDD);
            this.headerMc.rentDD.x = this.headerMc.tankPriceLabel.x + this.headerMc.tankPriceLabel.textWidth + DD_MARGIN ^ 0;
            this.headerMc.rentIcon.x = this.headerMc.rentDD.x + this.headerMc.rentDD.width;
            if (!this.headerMc.rentDD.hasEventListener(ListEvent.INDEX_CHANGE)) {
                this.headerMc.rentDD.addEventListener(ListEvent.INDEX_CHANGE, this.onHeaderMcRentDDIndexChangeHandler);
                this.headerMc.rentDD.selectedIndex = this._initInfo.defSelectedRentIndex;
            }
            if (this._initInfo.isStudyDisabled) {
                this.bodyMc.crewCheckbox.selected = false;
            }
        }
        else {
            this.bodyMc.freeRentSlot.visible = false;
        }
    }

    private function checkRentDDSelectedItem(param1:VehicleBuyRentItemVO):void {
        var _loc2_:ActionPriceVO = null;
        this._selectedRentId = param1.itemId;
        if (param1.itemId == VehicleBuyRentItemVO.DEF_ITEM_ID) {
            this.bodyMc.slotCheckbox.visible = true;
            _loc2_ = this._initInfo.slotActionPriceDataVo;
            this.bodyMc.slotActionPrice.setData(_loc2_);
            this.bodyMc.slotPrice.visible = !this.bodyMc.slotActionPrice.visible;
            this.bodyMc.freeRentSlot.visible = false;
        }
        else {
            this.bodyMc.slotCheckbox.selected = false;
            this.bodyMc.slotCheckbox.visible = false;
            this.bodyMc.slotActionPrice.visible = false;
            this.bodyMc.slotPrice.visible = false;
            this.bodyMc.freeRentSlot.visible = true;
        }
        this._initInfo.actualActionPriceDataVo = param1.actionPriceDataVo;
        this._initInfo.vehiclePrice = param1.price;
        this.updateVehiclePrice();
        invalidate(INV_TOTAL_RESULT);
    }

    private function disposeWindowRefHandlers():void {
        var _loc1_:Constraints = null;
        if (window) {
            _loc1_ = window.getConstraints();
            if (_loc1_) {
                window.removeEventListener(Event.RESIZE, this.onWindowRefResizeHandler);
            }
        }
    }

    private function onHeaderMcRentDDIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:VehicleBuyRentItemVO = VehicleBuyRentItemVO(param1.itemData.data);
        this.checkRentDDSelectedItem(_loc2_);
    }

    private function onCancelButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onCrewCheckBoxSelectHandler(param1:Event):void {
        this.bodyMc.lastItemSelected = !this.bodyMc.crewCheckbox.selected;
        invalidate(INV_TOTAL_RESULT);
    }

    private function onCheckBoxSelectHandler(param1:Event):void {
        invalidate(INV_TOTAL_RESULT);
    }

    private function onBodyMcButtonsGroupSelectionChangedHandler(param1:Event):void {
        this.bodyMc.crewCheckbox.selected = false;
        invalidate(INV_TOTAL_RESULT);
    }

    private function onSubmitButtonClickHandler(param1:ButtonEvent):void {
        var _loc2_:Object = {
            "buySlot": this.bodyMc.slotCheckbox.selected,
            "buyAmmo": this.bodyMc.ammoCheckbox.selected,
            "isHasBeenExpanded": this._expand,
            "crewType": this.bodyMc.crewType,
            "rentId": this._selectedRentId
        };
        this.footerMc.submitBtn.enabled = this._isSubmitBtnEnabled = false;
        submitS(_loc2_);
    }

    private function onWindowRefResizeHandler(param1:Event):void {
        this._windowBackgroundSizeInitialized = true;
        invalidate(WindowViewInvalidationType.POSITION_INVALID);
    }

    private function onExpandButtonClickHandler(param1:ButtonEvent):void {
        this.expand(!this._expand, false);
    }
}
}
