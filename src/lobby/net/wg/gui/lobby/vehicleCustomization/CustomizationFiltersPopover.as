package net.wg.gui.lobby.vehicleCustomization {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.popOvers.PopOver;
import net.wg.gui.components.popOvers.PopOverConst;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehicleCustomization.controls.RadioButtonListSelectionNavigator;
import net.wg.gui.lobby.vehicleCustomization.data.FiltersPopoverVO;
import net.wg.gui.lobby.vehicleCustomization.data.FiltersStateVO;
import net.wg.infrastructure.base.meta.ICustomizationFiltersPopoverMeta;
import net.wg.infrastructure.base.meta.impl.CustomizationFiltersPopoverMeta;

import scaleform.clik.controls.TileList;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class CustomizationFiltersPopover extends CustomizationFiltersPopoverMeta implements ICustomizationFiltersPopoverMeta {

    private static const PADDING:Number = 26;

    private static const INV_FOCUS_CHAIN:String = "InvFocusChain";

    private static const INV_FILTER_STATE:String = "InvFilterState";

    public var separator:DisplayObject = null;

    public var lblTitle:TextField = null;

    public var lblBonusType:TextField = null;

    public var lblGroups:TextField = null;

    public var lblWaysToBuy:TextField = null;

    public var ddlCustomizationType:DropdownMenu = null;

    public var btnDefault:ISoundButtonEx = null;

    public var listPurchaseType:ScrollingListEx = null;

    public var listBonusType:TileList = null;

    private var _initData:FiltersPopoverVO = null;

    private var _stateData:FiltersStateVO = null;

    private var _focusChain:Vector.<InteractiveObject>;

    public function CustomizationFiltersPopover() {
        this._focusChain = new Vector.<InteractiveObject>();
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.listPurchaseType.setSelectionNavigator(new RadioButtonListSelectionNavigator());
        this.listBonusType.addEventListener(ListEvent.ITEM_CLICK, this.onListBonusTypeItemClickHandler);
        this.ddlCustomizationType.addEventListener(ListEvent.INDEX_CHANGE, this.onDdlCustomizationTypeIndexChangeHandler);
        this.listPurchaseType.addEventListener(ListEvent.ITEM_CLICK, this.onListPurchaseTypeItemClickHandler);
        this.btnDefault.addEventListener(ButtonEvent.CLICK, this.onBtnDefaultClickHandler);
        this.ddlCustomizationType.addEventListener(MouseEvent.MOUSE_OVER, this.onDdlCustomizationTypeMouseOverHandler);
        this.ddlCustomizationType.addEventListener(MouseEvent.MOUSE_OUT, this.onDdlCustomizationTypeMouseOutHandler);
    }

    override protected function onDispose():void {
        this.listBonusType.removeEventListener(ListEvent.ITEM_CLICK, this.onListBonusTypeItemClickHandler);
        this.ddlCustomizationType.removeEventListener(ListEvent.INDEX_CHANGE, this.onDdlCustomizationTypeIndexChangeHandler);
        this.listPurchaseType.removeEventListener(ListEvent.ITEM_CLICK, this.onListPurchaseTypeItemClickHandler);
        this.btnDefault.removeEventListener(ButtonEvent.CLICK, this.onBtnDefaultClickHandler);
        this.ddlCustomizationType.removeEventListener(MouseEvent.MOUSE_OVER, this.onDdlCustomizationTypeMouseOverHandler);
        this.ddlCustomizationType.removeEventListener(MouseEvent.MOUSE_OUT, this.onDdlCustomizationTypeMouseOutHandler);
        this.separator = null;
        this.lblTitle = null;
        this.lblBonusType = null;
        this.lblGroups = null;
        this.lblWaysToBuy = null;
        this.ddlCustomizationType.dispose();
        this.ddlCustomizationType = null;
        this.listPurchaseType.dispose();
        this.listPurchaseType = null;
        this.listBonusType.dispose();
        this.listBonusType = null;
        this.btnDefault.dispose();
        this.btnDefault = null;
        this._initData = null;
        this._stateData = null;
        this._focusChain.splice(0, this._focusChain.length);
        this._focusChain = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        super.draw();
        if (isInvalid(INV_FILTER_STATE) && this._stateData != null) {
            this.ddlCustomizationType.selectedIndex = this._stateData.customizationTypeSelectedIndex;
            this.listPurchaseType.selectedIndex = this._stateData.purchaseTypeSelectedIndex;
            _loc1_ = this._stateData.bonusTypeSelected.length;
            _loc2_ = 0;
            while (_loc2_ < _loc1_) {
                this.listBonusType.getRendererAt(_loc2_).selectable = this._stateData.bonusTypeSelected[_loc2_];
                _loc2_++;
            }
            if (this.ddlCustomizationType.enabled != this._stateData.enableGroupFilter) {
                this.ddlCustomizationType.enabled = this._stateData.enableGroupFilter;
                this.ddlCustomizationType.mouseEnabled = true;
            }
        }
        if (isInvalid(INV_FOCUS_CHAIN)) {
            this.refreshFocusChain();
        }
    }

    override protected function setInitData(param1:FiltersPopoverVO):void {
        App.utils.asserter.assertNull(this._initData, "Reinitialization CustomizationFiltersPopover");
        this._initData = param1;
        this.lblTitle.htmlText = this._initData.lblTitle;
        this.lblBonusType.htmlText = this._initData.lblBonusType;
        this.lblGroups.htmlText = this._initData.lblCustomizationType;
        this.lblWaysToBuy.htmlText = this._initData.lblPurchaseType;
        this.btnDefault.label = this._initData.btnDefault;
        this.btnDefault.tooltip = param1.refreshTooltip;
        this.ddlCustomizationType.dataProvider = new DataProvider(App.utils.data.vectorToArray(this._initData.customizationType));
        this.ddlCustomizationType.selectedIndex = this._initData.customizationTypeSelectedIndex;
        this.ddlCustomizationType.visible = this._initData.customizationTypeVisible;
        this.ddlCustomizationType.enabled = this._initData.enableGroupFilter;
        this.lblBonusType.visible = this._initData.customizationBonusTypeVisible;
        this.listBonusType.visible = this._initData.customizationBonusTypeVisible;
        this.lblGroups.visible = this._initData.customizationTypeVisible;
        this.listPurchaseType.dataProvider = new DataProvider(App.utils.data.vectorToArray(this._initData.purchaseType));
        this.listPurchaseType.selectedIndex = this._initData.purchaseTypeSelectedIndex;
        this.listBonusType.dataProvider = new DataProvider(App.utils.data.vectorToArray(this._initData.bonusTypes));
        this.updateSize();
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
        PopOver(wrapper).isCloseBtnVisible = true;
        super.initLayout();
    }

    override protected function setState(param1:FiltersStateVO):void {
        this._stateData = param1;
        invalidate(INV_FILTER_STATE);
    }

    public function as_enableDefBtn(param1:Boolean):void {
        this.btnDefault.enabled = param1;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        if (this.listBonusType.visible) {
            _loc1_.push(this.listBonusType);
        }
        if (this.ddlCustomizationType.visible) {
            _loc1_.push(this.ddlCustomizationType);
        }
        if (this.listPurchaseType.visible) {
            _loc1_.push(this.listPurchaseType);
        }
        _loc1_.push(this.btnDefault);
        _loc1_.push(PopOver(wrapper).closeBtn);
        return _loc1_;
    }

    private function refreshFocusChain():void {
        var _loc1_:int = this._focusChain.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._focusChain[_loc2_].tabIndex = -1;
            _loc2_++;
        }
        this._focusChain.splice(0, this._focusChain.length);
        this._focusChain = this.getFocusChain();
        App.utils.commons.initTabIndex(this._focusChain);
        var _loc3_:InteractiveObject = null;
        if (this.listBonusType.visible) {
            _loc3_ = this.listBonusType;
        }
        if (this.ddlCustomizationType.visible) {
            _loc3_ = this.ddlCustomizationType;
        }
        if (this.listPurchaseType.visible) {
            _loc3_ = this.listPurchaseType;
        }
        if (_loc3_ != null) {
            setFocus(_loc3_);
        }
    }

    private function updateSize():void {
        var _loc1_:Number = 0;
        if (!this.listBonusType.visible) {
            this.lblGroups.y = this.lblBonusType.y;
            this.ddlCustomizationType.y = this.listBonusType.y;
        }
        if (!this.ddlCustomizationType.visible) {
            this.lblWaysToBuy.y = this.lblGroups.y;
            _loc1_ = _loc1_ + (this.ddlCustomizationType.y - this.listPurchaseType.y);
            this.listPurchaseType.y = this.ddlCustomizationType.y;
        }
        var _loc2_:Number = this._initData.purchaseType.length * this.listPurchaseType.rowHeight;
        _loc1_ = _loc1_ + (_loc2_ - this.listPurchaseType.height);
        this.listPurchaseType.height = _loc2_;
        this.separator.y = this.separator.y + _loc1_;
        this.btnDefault.y = this.btnDefault.y + _loc1_;
        setViewSize(this.width, height + _loc1_ + PADDING);
    }

    private function onListBonusTypeItemClickHandler(param1:ListEvent):void {
        changeFilterS(this._initData.bonusTypeId, param1.index);
        invalidate(INV_FOCUS_CHAIN);
    }

    private function onDdlCustomizationTypeIndexChangeHandler(param1:ListEvent):void {
        changeFilterS(this._initData.customizationTypeId, param1.index);
    }

    private function onListPurchaseTypeItemClickHandler(param1:ListEvent):void {
        changeFilterS(this._initData.purchaseTypeId, param1.index);
    }

    private function onBtnDefaultClickHandler(param1:ButtonEvent):void {
        setDefaultFilterS();
    }

    private function onDdlCustomizationTypeMouseOverHandler(param1:MouseEvent):void {
        if (!this.ddlCustomizationType.enabled) {
            App.toolTipMgr.showComplex(this._initData.bonusTypeDisableTooltip);
        }
    }

    private function onDdlCustomizationTypeMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
