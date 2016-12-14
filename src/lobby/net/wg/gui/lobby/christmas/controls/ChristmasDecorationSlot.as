package net.wg.gui.lobby.christmas.controls {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.assets.interfaces.INewIndicator;
import net.wg.gui.lobby.christmas.data.BaseDecorationVO;
import net.wg.gui.lobby.christmas.data.DecorationVO;
import net.wg.gui.lobby.christmas.event.ChristmasDecorationsListEvent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;
import scaleform.clik.data.ListData;
import scaleform.clik.interfaces.IListItemRenderer;

public class ChristmasDecorationSlot extends ChristmasDecorationItem implements IListItemRenderer {

    private static const DISABLED_ALPHA:Number = 0.4;

    private static const ENABLED_ALPHA:Number = 1;

    public var counterTf:TextField;

    public var counterBg:Sprite;

    public var slotBack:ChristmasDecorationSlotBack;

    public var newIndicator:INewIndicator = null;

    private var _data:DecorationVO;

    private var _index:uint = 0;

    private var _selected:Boolean = false;

    private var _items:Vector.<DisplayObject>;

    public function ChristmasDecorationSlot() {
        super();
        this._items = new <DisplayObject>[this.counterTf, this.counterBg, this.slotBack];
        this.setItemsVisible(false);
        setSize(this.slotBack.width, this.slotBack.height);
        this.counterTf.mouseEnabled = false;
        this.counterBg.mouseEnabled = false;
        this.newIndicator.hitArea = this.newIndicator.hitMC;
        this.newIndicator.mouseChildren = this.newIndicator.mouseEnabled = false;
        this.slotBack.addEventListener(MouseEvent.ROLL_OVER, this.onSlotBackRollOverHandler);
        this.slotBack.addEventListener(MouseEvent.ROLL_OUT, this.onSlotBackRollOutHandler);
        this.slotBack.addEventListener(MouseEvent.DOUBLE_CLICK, this.onSlotBackDoubleClickHandler);
        this.slotBack.doubleClickEnabled = true;
        this.newIndicator.visible = false;
    }

    override protected function onDispose():void {
        this.slotBack.removeEventListener(MouseEvent.ROLL_OVER, this.onSlotBackRollOverHandler);
        this.slotBack.removeEventListener(MouseEvent.ROLL_OUT, this.onSlotBackRollOutHandler);
        this.slotBack.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onSlotBackDoubleClickHandler);
        this.slotBack.dispose();
        this.slotBack = null;
        this.counterBg = null;
        this.counterTf = null;
        this.newIndicator.dispose();
        this.newIndicator = null;
        this._data = null;
        this._items.splice(0, this._items.length);
        this._items = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:* = false;
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            _loc1_ = this._data != null;
            this.setItemsVisible(_loc1_);
            this.newIndicator.visible = false;
            if (_loc1_) {
                this.slotBack.enabled = this._data.enabled;
                alpha = !!this._data.enabled ? Number(ENABLED_ALPHA) : Number(DISABLED_ALPHA);
                this.counterBg.visible = this._data.showCount;
                if (this.counterTf.visible = this._data.showCount) {
                    this.counterTf.htmlText = this._data.count;
                }
                if (this._data.isNew) {
                    this.newIndicator.visible = true;
                    this.newIndicator.pause();
                }
            }
        }
    }

    override protected function updateIcons(param1:BaseDecorationVO):void {
        rankIcon.source = this._data.rankIconBig;
        icon.source = this._data.iconBig;
    }

    public function getData():Object {
        return this._data;
    }

    public function setData(param1:Object):void {
        update(param1);
        if (this._data != param1) {
            this._data = DecorationVO(param1);
            this.slotBack.setDropData(this._data);
            invalidateData();
        }
    }

    public function setListData(param1:ListData):void {
        this._index = param1.index;
        this._selected = param1.selected;
    }

    private function setItemsVisible(param1:Boolean):void {
        var _loc2_:DisplayObject = null;
        for each(_loc2_ in this._items) {
            _loc2_.visible = param1;
        }
    }

    public function get index():uint {
        return this._index;
    }

    public function set index(param1:uint):void {
        this._index = param1;
    }

    public function get owner():UIComponent {
        return null;
    }

    public function set owner(param1:UIComponent):void {
    }

    public function get selectable():Boolean {
        return false;
    }

    public function set selectable(param1:Boolean):void {
    }

    public function get selected():Boolean {
        return this._selected;
    }

    public function set selected(param1:Boolean):void {
        if (this._selected != param1) {
            this._selected = param1;
            this.slotBack.selected = param1;
        }
    }

    private function onSlotBackRollOverHandler(param1:MouseEvent):void {
        if (this.newIndicator.visible) {
            this.newIndicator.visible = false;
            dispatchEvent(new ChristmasDecorationsListEvent(ChristmasDecorationsListEvent.HIDE_NEW_ITEM, this._data.decorationId, Values.DEFAULT_INT, true));
        }
        if (this._data != null && StringUtils.isNotEmpty(this._data.tooltip)) {
            App.toolTipMgr.showSpecial(this._data.tooltip, null, this._data.decorationId);
        }
    }

    private function onSlotBackRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onSlotBackDoubleClickHandler(param1:MouseEvent):void {
        if (App.utils.commons.isLeftButton(param1)) {
            dispatchEvent(new ChristmasDecorationsListEvent(ChristmasDecorationsListEvent.INSTALL_ITEM, this._data.decorationId, Values.DEFAULT_INT, true));
        }
    }
}
}
