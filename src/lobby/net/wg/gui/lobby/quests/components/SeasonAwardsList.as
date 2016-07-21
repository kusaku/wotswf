package net.wg.gui.lobby.quests.components {
import flash.display.InteractiveObject;
import flash.events.Event;

import net.wg.gui.components.controls.TileList;
import net.wg.gui.lobby.quests.components.renderers.ISeasonAwardListRenderer;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.interfaces.IListItemRenderer;

public class SeasonAwardsList extends TileList implements IFocusChainContainer {

    private static const INVALIDATE_LAYOUT:String = "invalidateLayout";

    public function SeasonAwardsList() {
        super();
    }

    override protected function drawRenderers(param1:Number):void {
        super.drawRenderers(param1);
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_LAYOUT)) {
            this.drawLayout();
        }
    }

    override protected function drawLayout():void {
        var _loc1_:IListItemRenderer = null;
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        if (dataProvider.length == 1) {
            _loc1_ = getRendererAt(0);
            _loc2_ = margin;
            if (direction == DirectionMode.HORIZONTAL) {
                _loc3_ = _loc2_ + this.padding.left;
                _loc4_ = width - (_loc3_ << 1);
                _loc1_.x = (_loc4_ - columnWidth >> 1) + _loc3_ | 0;
            }
            else {
                _loc3_ = _loc2_ + this.padding.top;
                _loc5_ = height - (_loc3_ << 1);
                _loc1_.y = (_loc5_ - rowHeight >> 1) + _loc3_ | 0;
            }
        }
        else {
            super.drawLayout();
        }
    }

    override protected function configUI():void {
        super.configUI();
        tabChildren = true;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc3_:ISeasonAwardListRenderer = null;
        var _loc4_:int = 0;
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>(0);
        var _loc2_:int = _renderers != null ? int(_renderers.length) : 0;
        if (_loc2_ > 0) {
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc3_ = ISeasonAwardListRenderer(getRendererAt(_loc4_));
                _loc1_ = _loc1_.concat(_loc3_.getFocusChain());
                _loc4_++;
            }
        }
        return _loc1_;
    }

    override public function set dataProvider(param1:IDataProvider):void {
        super.dataProvider = param1;
        invalidate(INVALIDATE_LAYOUT);
    }

    override public function set scrollPosition(param1:Number):void {
        var _loc2_:* = scrollPosition != param1;
        super.scrollPosition = param1;
        if (_loc2_) {
            dispatchEvent(new Event(Event.SCROLL));
        }
    }
}
}
