package net.wg.gui.lobby.vehicleCustomization {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.ListDAAPIDataProvider;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.InitBuyWindowVO;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchaseVO;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesTotalVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
import net.wg.infrastructure.base.meta.ICustomizationBuyWindowMeta;
import net.wg.infrastructure.base.meta.impl.CustomizationBuyWindowMeta;
import net.wg.infrastructure.interfaces.IWindow;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.utils.Padding;

public class CustomizationBuyWindow extends CustomizationBuyWindowMeta implements ICustomizationBuyWindowMeta {

    private static const TABLE_LIST_PADDING:Padding = new Padding(5, 0, 0, 0);

    private static const INV_FOCUS_CHAIN:String = "InvFocusChain";

    public var btnBuy:ISoundButtonEx = null;

    public var btnCancel:ISoundButtonEx = null;

    public var table:SortableTable = null;

    public var lblTotalPrice:TextField = null;

    public var lblTotalGoldPrice:TextField = null;

    public var lblTotalCreditsPrice:TextField = null;

    public var imgTotalCredits:Image = null;

    public var imgTotalGold:Image = null;

    private var _initData:InitBuyWindowVO = null;

    private var _totalData:PurchasesTotalVO = null;

    private var _toolTipMgr:ITooltipMgr = null;

    private var _focusChain:Vector.<InteractiveObject>;

    public function CustomizationBuyWindow() {
        this._focusChain = new Vector.<InteractiveObject>();
        super();
        isModal = true;
        canDrag = false;
    }

    override public function setWindow(param1:IWindow):void {
        super.setWindow(param1);
        window.useBottomBtns = true;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INV_FOCUS_CHAIN)) {
            this.refreshFocusChain();
        }
    }

    override protected function configUI():void {
        super.configUI();
        this._toolTipMgr = App.toolTipMgr;
        this.btnBuy.mouseEnabledOnDisabled = true;
        this.btnBuy.addEventListener(ButtonEvent.CLICK, this.onBtnBuyClickHandler);
        this.btnCancel.addEventListener(ButtonEvent.CLICK, this.onBtnCancelClickHandler);
        addEventListener(CustomizationItemEvent.SELECT_ITEM, this.onSelectHandler);
        addEventListener(CustomizationItemEvent.DESELECT_ITEM, this.onDeselectHandler);
        this.table.addEventListener(CustomizationItemEvent.CHANGE_PRICE, this.onChangePriceHandler);
        this.btnBuy.addEventListener(MouseEvent.MOUSE_OUT, this.onOutBtnBuyHandler);
        this.btnBuy.addEventListener(MouseEvent.MOUSE_OVER, this.onOverBtnBuyHandler);
        this.lblTotalCreditsPrice.addEventListener(MouseEvent.MOUSE_OUT, this.onOutLblTotalCreditsPriceHandler);
        this.lblTotalCreditsPrice.addEventListener(MouseEvent.MOUSE_OVER, this.onOverLblTotalCreditsPriceHandler);
        this.lblTotalGoldPrice.addEventListener(MouseEvent.MOUSE_OUT, this.onOutLblTotalGoldPriceHandler);
        this.lblTotalGoldPrice.addEventListener(MouseEvent.MOUSE_OVER, this.onOverLblTotalGoldPriceHandler);
        this.imgTotalGold.addEventListener(MouseEvent.MOUSE_OUT, this.onOutImgTotalGoldHandler);
        this.imgTotalGold.addEventListener(MouseEvent.MOUSE_OVER, this.onOverImgTotalGoldHandler);
        this.imgTotalCredits.addEventListener(MouseEvent.MOUSE_OUT, this.onOutImgTotalCreditsHandler);
        this.imgTotalCredits.addEventListener(MouseEvent.MOUSE_OVER, this.onOverImgTotalCreditsHandler);
        this.table.listPadding = TABLE_LIST_PADDING;
        this.table.headerSelectedIndex = -1;
        this.table.isSortable = false;
        this.table.isListSelectable = false;
    }

    override protected function onDispose():void {
        this.btnBuy.removeEventListener(ButtonEvent.CLICK, this.onBtnBuyClickHandler);
        this.btnCancel.removeEventListener(ButtonEvent.CLICK, this.onBtnCancelClickHandler);
        removeEventListener(CustomizationItemEvent.SELECT_ITEM, this.onSelectHandler);
        removeEventListener(CustomizationItemEvent.DESELECT_ITEM, this.onDeselectHandler);
        this.table.removeEventListener(CustomizationItemEvent.CHANGE_PRICE, this.onChangePriceHandler);
        this.btnBuy.removeEventListener(MouseEvent.MOUSE_OUT, this.onOutBtnBuyHandler);
        this.btnBuy.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverBtnBuyHandler);
        this.lblTotalCreditsPrice.removeEventListener(MouseEvent.MOUSE_OUT, this.onOutLblTotalCreditsPriceHandler);
        this.lblTotalCreditsPrice.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverLblTotalCreditsPriceHandler);
        this.lblTotalGoldPrice.removeEventListener(MouseEvent.MOUSE_OUT, this.onOutLblTotalGoldPriceHandler);
        this.lblTotalGoldPrice.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverLblTotalGoldPriceHandler);
        this.imgTotalGold.removeEventListener(MouseEvent.MOUSE_OUT, this.onOutImgTotalGoldHandler);
        this.imgTotalGold.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverImgTotalGoldHandler);
        this.imgTotalCredits.removeEventListener(MouseEvent.MOUSE_OUT, this.onOutImgTotalCreditsHandler);
        this.imgTotalCredits.removeEventListener(MouseEvent.MOUSE_OVER, this.onOverImgTotalCreditsHandler);
        this._initData = null;
        this._totalData = null;
        this.imgTotalCredits.dispose();
        this.imgTotalCredits = null;
        this.imgTotalGold.dispose();
        this.imgTotalGold = null;
        this.btnBuy.dispose();
        this.btnBuy = null;
        this.btnCancel.dispose();
        this.btnCancel = null;
        this.table.dispose();
        this.table = null;
        this.lblTotalGoldPrice = null;
        this.lblTotalCreditsPrice = null;
        this.lblTotalPrice = null;
        this._toolTipMgr = null;
        this._focusChain.splice(0, this._focusChain.length);
        this._focusChain = null;
        super.onDispose();
    }

    override protected function setInitData(param1:InitBuyWindowVO):void {
        App.utils.asserter.assertNull(this._initData, "Reinitialization CustomizationBuyWindow");
        this._initData = param1;
        window.title = param1.windowTitle;
        this.imgTotalCredits.source = param1.imgCredits;
        this.imgTotalGold.source = param1.imgGold;
        this.table.headerDP = new DataProvider(App.utils.data.vectorToArray(param1.tableHeader));
        this.table.headerSelectedIndex = param1.defaultSortIndex;
        this.btnBuy.label = param1.btnBuyLabel;
        this.btnCancel.label = param1.btnCancelLabel;
    }

    override protected function setTotalData(param1:PurchasesTotalVO):void {
        this._totalData = param1;
        this.lblTotalPrice.htmlText = this._totalData.totalLabel;
        this.lblTotalCreditsPrice.htmlText = this._totalData.credits;
        this.lblTotalGoldPrice.htmlText = this._totalData.gold;
        this.btnBuy.enabled = this._totalData.buyEnabled;
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        invalidate(INV_FOCUS_CHAIN);
    }

    public function as_getPurchaseDP():Object {
        var _loc1_:ListDAAPIDataProvider = new ListDAAPIDataProvider(PurchaseVO);
        this.table.listDP = _loc1_;
        return _loc1_;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
        _loc1_.push(this.btnBuy);
        _loc1_.push(this.btnCancel);
        _loc1_.push(window.getCloseBtn());
        _loc1_ = _loc1_.concat(this.table.getFocusChain());
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
        setFocus(this.btnBuy as InteractiveObject);
    }

    private function showNotEnoughCreditsTooltip():void {
        if (!this._totalData.enoughCredits) {
            this._toolTipMgr.showComplex(this._totalData.notEnoughCreditsTooltip);
        }
    }

    private function showNotEnoughGoldTooltip():void {
        if (!this._totalData.enoughGold) {
            this._toolTipMgr.showComplex(this._totalData.notEnoughGoldTooltip);
        }
    }

    private function onBtnBuyClickHandler(param1:ButtonEvent):void {
        buyS();
    }

    private function onBtnCancelClickHandler(param1:ButtonEvent):void {
        handleWindowClose();
    }

    private function onSelectHandler(param1:CustomizationItemEvent):void {
        selectItemS(param1.itemId);
    }

    private function onDeselectHandler(param1:CustomizationItemEvent):void {
        deselectItemS(param1.itemId);
    }

    private function onChangePriceHandler(param1:CustomizationItemEvent):void {
        changePriceItemS(param1.itemId, param1.groupId);
    }

    private function onOverImgTotalGoldHandler(param1:MouseEvent):void {
        this.showNotEnoughGoldTooltip();
    }

    private function onOverImgTotalCreditsHandler(param1:MouseEvent):void {
        this.showNotEnoughCreditsTooltip();
    }

    private function onOverLblTotalGoldPriceHandler(param1:MouseEvent):void {
        this.showNotEnoughGoldTooltip();
    }

    private function onOverLblTotalCreditsPriceHandler(param1:MouseEvent):void {
        this.showNotEnoughCreditsTooltip();
    }

    private function onOutLblTotalGoldPriceHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onOutLblTotalCreditsPriceHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onOutImgTotalCreditsHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onOutImgTotalGoldHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onOutBtnBuyHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onOverBtnBuyHandler(param1:MouseEvent):void {
        if (!this._totalData.buyEnabled) {
            this._toolTipMgr.show(this._initData.buyDisabledTooltip);
        }
    }
}
}
