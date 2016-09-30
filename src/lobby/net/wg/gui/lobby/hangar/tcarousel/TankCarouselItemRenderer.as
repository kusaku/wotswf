package net.wg.gui.lobby.hangar.tcarousel {
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.constants.SoundManagerStatesLobby;
import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
import net.wg.gui.components.controls.scroller.ListRendererEvent;
import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
import net.wg.gui.lobby.hangar.tcarousel.event.TankItemEvent;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.gfx.MouseEventEx;

public class TankCarouselItemRenderer extends SoundButtonEx implements IScrollerItemRenderer {

    private static const LOCK_BG_ALIAS:String = "bgDisPattern";

    private static const LOCK_BG_REPEAT:String = "all";

    public var content:BaseTankIcon = null;

    public var bmpLockBg:BitmapFill = null;

    private var _index:uint = 0;

    private var _dataVO:VehicleCarouselVO = null;

    private var _toolTipMgr:ITooltipMgr = null;

    public function TankCarouselItemRenderer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.bmpLockBg.widthFill = this.content.width;
        this.bmpLockBg.heightFill = this.content.height;
        this.bmpLockBg.repeat = LOCK_BG_REPEAT;
        this.bmpLockBg.source = LOCK_BG_ALIAS;
        this.content.cacheAsBitmap = true;
        soundType = SoundTypes.CAROUSEL_BTN;
        soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
        this.addListeners();
    }

    override protected function onDispose():void {
        this.removeListeners();
        this.content.dispose();
        this.content = null;
        this.bmpLockBg.dispose();
        this.bmpLockBg = null;
        this._dataVO = null;
        _owner = null;
        this._toolTipMgr = null;
        super.onDispose();
    }

    public function measureSize(param1:Point = null):Point {
        return null;
    }

    protected function updateData():void {
        this.bmpLockBg.visible = this._dataVO != null && this._dataVO.lockBackground;
        this.content.setData(this._dataVO);
    }

    private function addListeners():void {
        addEventListener(MouseEvent.ROLL_OVER, this.onSlotMouseRollOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, this.onSlotMouseRollOutHandler);
        addEventListener(MouseEvent.CLICK, this.onSlotMouseClickHandler);
    }

    private function removeListeners():void {
        removeEventListener(MouseEvent.ROLL_OVER, this.onSlotMouseRollOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, this.onSlotMouseRollOutHandler);
        removeEventListener(MouseEvent.CLICK, this.onSlotMouseClickHandler);
    }

    override public function get data():Object {
        return this._dataVO;
    }

    override public function set data(param1:Object):void {
        if (this._dataVO != null) {
            this._dataVO.removeEventListener(Event.CHANGE, this.onDataVOChangeHandler);
            this._dataVO = null;
        }
        if (param1 != null) {
            this._dataVO = VehicleCarouselVO(param1);
            this._dataVO.addEventListener(Event.CHANGE, this.onDataVOChangeHandler);
            enabled = true;
        }
        else {
            enabled = false;
        }
        this.updateData();
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function set tooltipDecorator(param1:ITooltipMgr):void {
        this._toolTipMgr = param1;
    }

    protected function get dataVO():VehicleCarouselVO {
        return this._dataVO;
    }

    private function onSlotMouseClickHandler(param1:Event):void {
        var _loc4_:String = null;
        var _loc2_:MouseEventEx = param1 as MouseEventEx;
        var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
        if (!selected && _loc3_ == MouseEventEx.LEFT_BUTTON) {
            if (this._dataVO.buySlot) {
                _loc4_ = TankItemEvent.SELECT_BUY_SLOT;
            }
            else if (this._dataVO.buyTank) {
                _loc4_ = TankItemEvent.SELECT_BUY_TANK;
            }
            else {
                _loc4_ = TankItemEvent.SELECT_ITEM;
                dispatchEvent(new ListRendererEvent(ListRendererEvent.SELECT));
            }
            dispatchEvent(new TankItemEvent(_loc4_, this._index));
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
