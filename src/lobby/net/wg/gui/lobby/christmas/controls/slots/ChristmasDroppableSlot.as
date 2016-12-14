package net.wg.gui.lobby.christmas.controls.slots {
import flash.display.Sprite;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.ui.Mouse;
import flash.ui.MouseCursor;

import net.wg.data.constants.Cursors;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.Image;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.event.ChristmasSlotsEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDroppableSlot;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;

public class ChristmasDroppableSlot extends ChristmasSlot implements IChristmasDroppableSlot {

    public var icon:Image;

    public var rank:Image;

    public var backDefault:Sprite;

    public var backDrag:Sprite;

    public var backDragHover:Sprite;

    public var removeBtn:ISoundButtonEx;

    public var hitMc:ChristmasTreeSlotHitArea;

    private var _backs:Vector.<Sprite>;

    public function ChristmasDroppableSlot() {
        super();
        this._backs = new <Sprite>[this.backDefault, this.backDrag, this.backDragHover];
        this.hitMc.setDropItem(this);
        this.hideHighlight();
        this.removeBtn.addEventListener(ButtonEvent.CLICK, this.onRemoveBtnClickHandler);
        this.removeBtn.addEventListener(MouseEvent.ROLL_OVER, this.onRemoveBtnRollOverHandler);
        this.removeBtn.addEventListener(MouseEvent.ROLL_OUT, this.onRemoveBtnRollOutHandler);
    }

    override public function getMouseTarget():IEventDispatcher {
        return this.hitMc;
    }

    override public function setData(param1:SlotVO):void {
        super.setData(param1);
        if (this.icon.visible = StringUtils.isNotEmpty(param1.icon)) {
            this.icon.source = param1.icon;
        }
        if (this.rank.visible = StringUtils.isNotEmpty(param1.rankIcon)) {
            this.rank.source = param1.rankIcon;
        }
        this.removeBtn.visible = param1.btnRemoveVisible;
    }

    override protected function configUI():void {
        super.configUI();
        this.hitMc.addEventListener(MouseEvent.DOUBLE_CLICK, this.onHitMcDoubleClickHandler);
        this.hitMc.doubleClickEnabled = true;
    }

    override protected function onDispose():void {
        this.removeBtn.removeEventListener(ButtonEvent.CLICK, this.onRemoveBtnClickHandler);
        this.hitMc.removeEventListener(MouseEvent.DOUBLE_CLICK, this.onHitMcDoubleClickHandler);
        this.removeBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onRemoveBtnRollOverHandler);
        this.removeBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onRemoveBtnRollOutHandler);
        this.backDefault = null;
        this.backDrag = null;
        this.backDragHover = null;
        this._backs.splice(0, this._backs.length);
        this._backs = null;
        this.removeBtn.dispose();
        this.removeBtn = null;
        this.icon.dispose();
        this.icon = null;
        this.rank.dispose();
        this.rank = null;
        super.onDispose();
        this.hitMc.dispose();
        this.hitMc = null;
    }

    public function hideHighlight():void {
        this.showBack(this.backDefault);
    }

    public function highlightDropHover():void {
        this.showBack(this.backDragHover);
    }

    public function highlightDropping():void {
        this.showBack(this.backDrag);
    }

    private function showBack(param1:Sprite):void {
        var _loc2_:Sprite = null;
        for each(_loc2_ in this._backs) {
            _loc2_.visible = _loc2_ == param1;
        }
    }

    private function dispatchItemRemoveEvent():void {
        dispatchEvent(new ChristmasSlotsEvent(ChristmasSlotsEvent.ITEM_REMOVED, slotData.slotId, Values.DEFAULT_INT, Values.DEFAULT_INT, true));
    }

    public function get decorationInfo():DecorationInfoVO {
        return slotData;
    }

    public function get getCursorType():String {
        return slotData != null && slotData.decorationId != Values.DEFAULT_INT ? Cursors.DRAG_OPEN : Cursors.ARROW;
    }

    public function get slotType():String {
        return slotData != null ? slotData.slotType : null;
    }

    private function onRemoveBtnRollOverHandler(param1:MouseEvent):void {
        Mouse.cursor = MouseCursor.HAND;
    }

    private function onRemoveBtnRollOutHandler(param1:MouseEvent):void {
        Mouse.cursor = MouseCursor.AUTO;
    }

    private function onRemoveBtnClickHandler(param1:ButtonEvent):void {
        this.dispatchItemRemoveEvent();
    }

    private function onHitMcDoubleClickHandler(param1:MouseEvent):void {
        if (App.utils.commons.isLeftButton(param1)) {
            this.dispatchItemRemoveEvent();
        }
    }
}
}
