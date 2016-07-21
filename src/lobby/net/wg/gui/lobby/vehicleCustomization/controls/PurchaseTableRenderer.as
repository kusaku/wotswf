package net.wg.gui.lobby.vehicleCustomization.controls {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchaseVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class PurchaseTableRenderer extends TableRenderer {

    private static const ALPHA_DISABLE:Number = 0.5;

    private static const ALPHA_ENABLE:Number = 1;

    public var lblItemName:TextFieldShort = null;

    public var lblBonus:TextField = null;

    public var title:TextField = null;

    public var duplicatePrice:TextField = null;

    public var checkBox:CheckBox = null;

    public var imgBonus:Image = null;

    public var priceDropDown:DropdownMenu = null;

    private var _purchaseData:PurchaseVO = null;

    private var _toolTipMgr:ITooltipMgr = null;

    public function PurchaseTableRenderer() {
        super();
        addEventListener(ListEvent.INDEX_CHANGE, this.onIndexChangeHandler);
    }

    override public function setData(param1:Object):void {
        super.setData(param1);
        if (param1 != null) {
            this._purchaseData = PurchaseVO(param1);
            this.checkBox.selected = this._purchaseData.selected;
            this.checkBox.label = Values.EMPTY_STR;
            this.imgBonus.source = this._purchaseData.imgBonus;
            this.lblBonus.htmlText = this._purchaseData.lblBonus;
            this.lblItemName.label = this._purchaseData.itemName;
            this.title.htmlText = this._purchaseData.titleText;
            this.duplicatePrice.htmlText = this._purchaseData.duplicatePriceText;
            if (this._purchaseData.titleMode == false) {
                this.priceDropDown.dataProvider = new DataProvider(App.utils.data.vectorToArray(this._purchaseData.dDPrice));
                this.priceDropDown.validateNow();
                this.priceDropDown.selectedIndex = this._purchaseData.selectIndex;
            }
            this.priceDropDown.close();
            this.select(this._purchaseData.selected);
            if (this._purchaseData.titleMode) {
                this.titleState();
            }
            else {
                this.elementState();
            }
        }
        else {
            this.emptyState();
        }
    }

    override protected function configUI():void {
        super.configUI();
        this._toolTipMgr = App.toolTipMgr;
        this.lblItemName.useHtml = true;
        this.lblItemName.buttonMode = false;
        this.title.autoSize = TextFieldAutoSize.LEFT;
        this.duplicatePrice.autoSize = TextFieldAutoSize.LEFT;
        this.checkBox.addEventListener(ButtonEvent.CLICK, this.onCheckBoxClickHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
    }

    override protected function onDispose():void {
        this.checkBox.removeEventListener(ButtonEvent.CLICK, this.onCheckBoxClickHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(ListEvent.INDEX_CHANGE, this.onIndexChangeHandler);
        this._toolTipMgr = null;
        this.duplicatePrice = null;
        this._purchaseData = null;
        this.lblBonus = null;
        this.lblItemName.dispose();
        this.lblItemName = null;
        this.checkBox.dispose();
        this.checkBox = null;
        this.imgBonus.dispose();
        this.imgBonus = null;
        this.priceDropDown.dispose();
        this.priceDropDown = null;
        this.title = null;
        super.onDispose();
    }

    private function titleState():void {
        this.emptyState();
        this.title.visible = true;
    }

    private function elementState():void {
        this.title.visible = false;
        this.checkBox.visible = true;
        this.lblBonus.visible = true;
        this.imgBonus.visible = true;
        this.priceDropDown.visible = true;
        this.duplicatePrice.visible = this._purchaseData.isDuplicatePrice;
        this.priceDropDown.visible = !this._purchaseData.isDuplicatePrice;
        mouseChildren = true;
    }

    private function emptyState():void {
        this.title.visible = false;
        this.checkBox.visible = false;
        this.lblBonus.visible = false;
        this.imgBonus.visible = false;
        this.priceDropDown.visible = false;
        this.duplicatePrice.visible = false;
        mouseEnabled = false;
        mouseChildren = false;
    }

    private function select(param1:Boolean):void {
        var _loc2_:Number = !!param1 ? Number(ALPHA_ENABLE) : Number(ALPHA_DISABLE);
        this.priceDropDown.enabled = param1;
        this.lblItemName.alpha = _loc2_;
        this.lblBonus.alpha = _loc2_;
        this.imgBonus.alpha = _loc2_;
        this.priceDropDown.alpha = _loc2_;
        this.duplicatePrice.alpha = _loc2_;
    }

    private function onIndexChangeHandler(param1:ListEvent):void {
        param1.stopPropagation();
        dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.CHANGE_PRICE, index, this.priceDropDown.selectedIndex));
    }

    private function onCheckBoxClickHandler(param1:Event):void {
        this.select(this.checkBox.selected);
        if (this.checkBox.selected) {
            dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.SELECT_ITEM, index));
        }
        else {
            dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.DESELECT_ITEM, index));
        }
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        if (param1.target != this.checkBox && param1.target != this.priceDropDown) {
            if (param1.target == this.duplicatePrice) {
                this._toolTipMgr.showComplex(this._purchaseData.duplicatePriceTooltip);
            }
            else {
                this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM, null, this._purchaseData.slotIdx, this._purchaseData.cType);
            }
        }
    }
}
}
