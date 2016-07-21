package net.wg.gui.lobby.hangar.tcarousel {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import net.wg.data.constants.SoundManagerStatesLobby;
import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
import net.wg.gui.lobby.hangar.tcarousel.event.TankItemEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.core.UIComponent;
import scaleform.gfx.MouseEventEx;

public class TankCarouselItemRenderer extends UIComponentEx implements IScrollerItemRenderer {

    public var price:IconText = null;

    public var infoText:TextField = null;

    public var additionalText:TextField = null;

    public var clanLock:ClanLockUI = null;

    public var actionPrice:ActionPrice = null;

    public var slot:TankCarouselRendererSlot = null;

    private var _index:uint = 0;

    private var _owner:UIComponent = null;

    private var _selected:Boolean = false;

    private var _dataVO:VehicleCarouselVO = null;

    private var _toolTipMgr:ITooltipMgr = null;

    public function TankCarouselItemRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.slot.soundType = SoundTypes.CAROUSEL_BTN;
        this.slot.soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
        this.actionPrice.mouseChildren = false;
        this.actionPrice.mouseEnabled = false;
        this.infoText.mouseEnabled = false;
        this.clanLock.mouseChildren = false;
        this.clanLock.mouseEnabled = false;
        this.price.mouseChildren = false;
        this.price.mouseEnabled = false;
        this.additionalText.mouseEnabled = false;
        this.addListeners();
    }

    override protected function onDispose():void {
        this.removeListeners();
        this.actionPrice.dispose();
        this.actionPrice = null;
        this.clanLock.dispose();
        this.clanLock = null;
        this.slot.dispose();
        this.slot = null;
        this.price.dispose();
        this.price = null;
        this.infoText = null;
        this.additionalText = null;
        this._dataVO = null;
        this._owner = null;
        this._toolTipMgr = null;
        super.onDispose();
    }

    public function measureSize(param1:Point = null):Point {
        return null;
    }

    protected function updateData():void {
        if (this._dataVO != null) {
            this.slot.enabled = true;
            if (this._dataVO.showInfoText) {
                this.infoText.htmlText = this._dataVO.infoText;
                this.infoText.visible = true;
            }
            else {
                this.infoText.visible = false;
            }
            if (this._dataVO.buySlot || this._dataVO.buyTank) {
                this.slot.setIcon(this._dataVO.icon);
            }
            else {
                this.slot.updateData(this._dataVO);
            }
            if (this._dataVO.buySlot) {
                if (this._dataVO.hasSale) {
                    this.actionPrice.setData(this._dataVO.getActionPriceVO());
                }
                else {
                    this.price.text = this._dataVO.slotPrice.toString();
                }
                this.price.visible = !this._dataVO.hasSale;
                this.actionPrice.visible = this._dataVO.hasSale;
            }
            else {
                this.actionPrice.visible = false;
                this.price.visible = false;
            }
            if (this._dataVO.buyTank) {
                this.additionalText.text = this._dataVO.additionalText;
                this.additionalText.visible = true;
            }
            else {
                this.additionalText.visible = false;
            }
            this.clanLock.timer = this._dataVO.clanLock;
        }
    }

    private function addListeners():void {
        this.slot.addEventListener(MouseEvent.ROLL_OVER, this.onSlotMouseRollOverHandler);
        this.slot.addEventListener(MouseEvent.ROLL_OUT, this.onSlotMouseRollOutHandler);
        this.slot.addEventListener(MouseEvent.CLICK, this.onSlotMouseClickHandler);
    }

    private function removeListeners():void {
        this.slot.removeEventListener(MouseEvent.ROLL_OVER, this.onSlotMouseRollOverHandler);
        this.slot.removeEventListener(MouseEvent.ROLL_OUT, this.onSlotMouseRollOutHandler);
        this.slot.removeEventListener(MouseEvent.CLICK, this.onSlotMouseClickHandler);
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function get data():Object {
        return null;
    }

    public function set data(param1:Object):void {
        if (this._dataVO != null) {
            this._dataVO.removeEventListener(Event.CHANGE, this.onDataVOChangeHandler);
            this._dataVO = null;
        }
        if (param1 != null) {
            this._dataVO = VehicleCarouselVO(param1);
            this._dataVO.addEventListener(Event.CHANGE, this.onDataVOChangeHandler);
            this.updateData();
        }
        else {
            this.additionalText.visible = false;
            this.actionPrice.visible = false;
            this.price.visible = false;
            this.infoText.visible = false;
            this.clanLock.visible = false;
            this.slot.enabled = false;
            this.slot.hideAllContent();
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
            this.slot.selected = param1;
        }
    }

    public function set tooltipDecorator(param1:ITooltipMgr):void {
        this._toolTipMgr = param1;
    }

    private function onSlotMouseClickHandler(param1:Event):void {
        var _loc4_:String = null;
        var _loc2_:MouseEventEx = param1 as MouseEventEx;
        var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
        if (!this.selected && _loc3_ == MouseEventEx.LEFT_BUTTON) {
            if (this._dataVO.buySlot) {
                _loc4_ = TankItemEvent.SELECT_BUY_SLOT;
            }
            else if (this._dataVO.buyTank) {
                _loc4_ = TankItemEvent.SELECT_BUY_TANK;
            }
            else {
                _loc4_ = TankItemEvent.SELECT_ITEM;
                dispatchEvent(new Event(Event.SELECT));
            }
            dispatchEvent(new TankItemEvent(_loc4_, this._dataVO.id));
        }
        else if (_loc3_ == MouseEventEx.RIGHT_BUTTON && !this._dataVO.buySlot && !this._dataVO.buyTank) {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.VEHICLE, this, {"inventoryId": this._dataVO.id});
        }
        this._toolTipMgr.hide();
    }

    private function onSlotMouseRollOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onSlotMouseRollOverHandler(param1:MouseEvent):void {
        if (this._dataVO.buyTank) {
            this._toolTipMgr.showComplex(TOOLTIPS.TANKS_CAROUSEL_BUY_VEHICLE);
        }
        else if (this._dataVO.buySlot) {
            this._toolTipMgr.showComplex(TOOLTIPS.TANKS_CAROUSEL_BUY_SLOT);
        }
        else {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CAROUSEL_VEHICLE, null, this._dataVO.id);
        }
    }

    private function onDataVOChangeHandler(param1:Event):void {
        this.updateData();
    }
}
}
