package net.wg.gui.lobby.vehicleCustomization.controls {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.assets.NewIndicator;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselRendererVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.events.ButtonEvent;

public class CarouselItemRenderer extends UIComponentEx implements IScrollerItemRenderer {

    private static const IMAGE_SCALE:Number = 0.59375;

    public var imgIcon:Image = null;

    public var imgBonusIco:Image = null;

    public var lblBonus:TextField = null;

    public var lblStatus:TextField = null;

    public var btnSlot:CarouselItemSlot = null;

    public var salePrice:ActionPrice = null;

    public var gradient:Sprite = null;

    public var newIndicator:NewIndicator = null;

    public var goToTaskBtn:SoundButtonEx = null;

    private var _initData:CarouselRendererVO = null;

    private var _selected:Boolean = false;

    private var _index:uint = 0;

    private var _owner:UIComponent = null;

    private var _toolTipMgr:ITooltipMgr = null;

    public function CarouselItemRenderer() {
        super();
    }

    override protected function draw():void {
        var _loc1_:Number = NaN;
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            _loc1_ = width - this.btnSlot.width;
            this.btnSlot.width = this.btnSlot.width + _loc1_;
            this.lblStatus.x = this.lblStatus.x + _loc1_;
            this.goToTaskBtn.x = width - this.goToTaskBtn.width >> 1;
            this.gradient.width = this.gradient.width + _loc1_;
            this.salePrice.x = width - (this.salePrice.width >> 2);
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.imgIcon.scaleY = IMAGE_SCALE;
        this.imgIcon.scaleX = IMAGE_SCALE;
        mouseChildren = true;
        this.imgIcon.mouseEnabled = false;
        this.imgIcon.mouseChildren = false;
        this.imgBonusIco.mouseEnabled = false;
        this.imgBonusIco.mouseChildren = false;
        this.lblBonus.mouseEnabled = false;
        this.lblStatus.mouseEnabled = false;
        this.newIndicator.mouseEnabled = false;
        this.newIndicator.mouseChildren = false;
        this.gradient.mouseEnabled = false;
        this.gradient.mouseChildren = false;
        this.salePrice.mouseChildren = false;
        this.btnSlot.addEventListener(ButtonEvent.CLICK, this.onBtnSlotClickHandler);
        this.goToTaskBtn.addEventListener(ButtonEvent.CLICK, this.onGoToTaskClickHandler);
        this.btnSlot.addEventListener(MouseEvent.MOUSE_OUT, this.onBtnSlotOutHandler);
        this.btnSlot.addEventListener(MouseEvent.MOUSE_OVER, this.onBtnSlotOverHandler);
    }

    override protected function onDispose():void {
        this.btnSlot.removeEventListener(ButtonEvent.CLICK, this.onBtnSlotClickHandler);
        this.goToTaskBtn.removeEventListener(ButtonEvent.CLICK, this.onGoToTaskClickHandler);
        this.btnSlot.removeEventListener(MouseEvent.MOUSE_OUT, this.onBtnSlotOutHandler);
        this.btnSlot.removeEventListener(MouseEvent.MOUSE_OVER, this.onBtnSlotOverHandler);
        this._toolTipMgr = null;
        this.imgIcon.dispose();
        this.imgIcon = null;
        this.imgBonusIco.dispose();
        this.imgBonusIco = null;
        this.lblBonus = null;
        this.lblStatus = null;
        this.btnSlot.dispose();
        this.btnSlot = null;
        this.goToTaskBtn.dispose();
        this.goToTaskBtn = null;
        this.gradient = null;
        this._initData = null;
        this._owner = null;
        this.salePrice.dispose();
        this.salePrice = null;
        this.newIndicator.dispose();
        this.newIndicator = null;
        super.onDispose();
    }

    public function measureSize(param1:Point = null):Point {
        return null;
    }

    private function setEnable(param1:Boolean):void {
        if (enabled != param1) {
            enabled = param1;
            this.btnSlot.enabled = param1;
            this.imgIcon.visible = param1;
            this.imgBonusIco.visible = param1;
            this.lblBonus.visible = param1;
            this.lblStatus.visible = param1;
            this.gradient.visible = param1;
            this.salePrice.visible = param1;
        }
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function get data():Object {
        return this._initData;
    }

    public function set data(param1:Object):void {
        if (param1 != null) {
            this.setEnable(true);
            this._initData = CarouselRendererVO(param1);
            this.imgIcon.source = this._initData.icon;
            this.imgBonusIco.source = this._initData.bonusType;
            this.lblBonus.htmlText = this._initData.bonusPower;
            this.lblStatus.htmlText = this._initData.label;
            this.salePrice.setData(this._initData.salePrice);
            this._selected = this._initData.selected;
            this.goToTaskBtn.label = this._initData.goToTaskBtnText;
            this.goToTaskBtn.visible = this._initData.goToTaskBtnVisible && this._selected;
            this.newIndicator.visible = this._initData.newElementIndicatorVisible;
            this.btnSlot.selected = this.selected;
            if (this._initData.goToTaskBtnVisible && this.selected) {
                this.lblStatus.visible = false;
            }
            else {
                this.lblStatus.visible = !this.salePrice.visible;
            }
        }
        else {
            this._initData = null;
            this.setEnable(false);
            this._selected = false;
            this.newIndicator.visible = false;
            this.goToTaskBtn.visible = false;
            this.btnSlot.selected = false;
        }
    }

    public function get owner():UIComponent {
        return this._owner;
    }

    public function set owner(param1:UIComponent):void {
        this._owner = param1;
    }

    public function get selected():Boolean {
        return this._selected;
    }

    public function set selected(param1:Boolean):void {
        if (this._selected != param1) {
            this._selected = param1;
        }
    }

    public function set tooltipDecorator(param1:ITooltipMgr):void {
        this._toolTipMgr = param1;
    }

    private function onBtnSlotClickHandler(param1:ButtonEvent):void {
        if (!this._selected) {
            dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.INSTALL_ITEM, this.index));
        }
    }

    private function onGoToTaskClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.GO_TO_TASK, this.index));
    }

    private function onBtnSlotOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onBtnSlotOverHandler(param1:MouseEvent):void {
        this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM, null, this.index);
    }
}
}
