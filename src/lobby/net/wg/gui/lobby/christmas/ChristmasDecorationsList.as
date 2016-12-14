package net.wg.gui.lobby.christmas {
import flash.events.Event;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.TileList;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropActor;
import net.wg.gui.messenger.controls.DashedHighlightArea;

public class ChristmasDecorationsList extends TileList implements IChristmasDropActor {

    private static const HIGHLIGHT_PADDING:int = 5;

    private static const HIGHLIGHT_COLOR:int = 12910461;

    private static const HIGHLIGHT_HOVER_COLOR:int = 16121787;

    private static const HIGHLIGHT_LINE_THICKNESS:int = 0;

    private static const HIGHLIGHT_DASH_LENGTH:int = 4;

    private static const HIGHLIGHT_DASH_GAP:int = 7;

    public var highlightCmp:DashedHighlightArea;

    private var _hoverFilters:Array;

    public function ChristmasDecorationsList() {
        super();
        this._hoverFilters = [new DropShadowFilter(0, 0, 6600704, 1, 5, 5, 1, BitmapFilterQuality.HIGH), new GlowFilter(65286, 1, 21, 21, 1, BitmapFilterQuality.HIGH)];
    }

    override protected function configUI():void {
        this.highlightCmp.visible = false;
        this.highlightCmp.lineThickness = HIGHLIGHT_LINE_THICKNESS;
        this.highlightCmp.dashLength = HIGHLIGHT_DASH_LENGTH;
        this.highlightCmp.gap = HIGHLIGHT_DASH_GAP;
        super.configUI();
    }

    override protected function calculateRendererTotal(param1:Number, param2:Number):uint {
        var _loc3_:int = _totalRows;
        var _loc4_:int = super.calculateRendererTotal(param1, param2);
        if (_loc3_ != _totalRows) {
            dispatchEvent(new Event(Event.RESIZE));
        }
        return _loc4_;
    }

    override protected function onDispose():void {
        this.highlightCmp.filters = null;
        this.highlightCmp.dispose();
        this.highlightCmp = null;
        this._hoverFilters.splice(0, this._hoverFilters.length);
        this._hoverFilters = null;
        super.onDispose();
    }

    public function getRowHeight():Number {
        return rowHeight + padding.bottom;
    }

    public function hideHighlight():void {
        this.highlightCmp.visible = false;
    }

    public function highlightDropHover():void {
        this.highlightCmp.visible = true;
        this.highlightCmp.color = HIGHLIGHT_HOVER_COLOR;
        this.highlightCmp.filters = this._hoverFilters;
        this.setHighlightSize();
    }

    public function highlightDropping():void {
        this.highlightCmp.visible = true;
        this.highlightCmp.color = HIGHLIGHT_COLOR;
        this.highlightCmp.filters = null;
        this.setHighlightSize();
    }

    private function setHighlightSize():void {
        var _loc1_:* = 0;
        _loc1_ = HIGHLIGHT_PADDING << 1;
        this.highlightCmp.x = -HIGHLIGHT_PADDING;
        this.highlightCmp.y = -HIGHLIGHT_PADDING;
        this.highlightCmp.scaleX = 1 / scaleX;
        this.highlightCmp.scaleY = 1 / scaleY;
        this.highlightCmp.setSize(width + _loc1_, height + _loc1_);
    }

    override public function set selectedIndex(param1:int):void {
    }

    public function get slotType():String {
        return null;
    }

    public function get slotId():int {
        return Values.DEFAULT_INT;
    }

    override protected function dispatchItemEvent(param1:Event):Boolean {
        return false;
    }
}
}
