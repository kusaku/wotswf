package net.wg.gui.lobby.quests.components {
import flash.display.Sprite;
import flash.events.Event;

import net.wg.data.constants.Linkages;
import net.wg.gui.interfaces.IContentSize;
import net.wg.gui.lobby.quests.data.SeasonsDataVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class SeasonsListView extends UIComponentEx implements IContentSize {

    public var container:Sprite = null;

    private var _data:SeasonsDataVO = null;

    public function SeasonsListView() {
        super();
    }

    override protected function onDispose():void {
        this.clearItems();
        this.container = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA) && this._data) {
            this.redrawItems();
        }
    }

    public function setData(param1:SeasonsDataVO):void {
        this._data = param1;
        invalidateData();
    }

    private function redrawItems():void {
        var _loc1_:SeasonViewRenderer = null;
        this.clearItems();
        var _loc2_:Number = 0;
        var _loc3_:uint = this._data.seasons.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc1_ = App.utils.classFactory.getComponent(Linkages.SEASON_VIEW_RENDERER, SeasonViewRenderer);
            _loc1_.model = this._data.seasons[_loc4_];
            _loc1_.y = _loc2_;
            this.container.addChild(_loc1_);
            _loc2_ = _loc2_ + _loc1_.contentHeight;
            _loc4_++;
        }
        initSize();
        dispatchEvent(new Event(Event.RESIZE));
    }

    private function clearItems():void {
        var _loc1_:SeasonViewRenderer = null;
        while (this.container.numChildren) {
            _loc1_ = SeasonViewRenderer(this.container.getChildAt(0));
            this.container.removeChild(_loc1_);
            _loc1_.dispose();
        }
    }

    public function get contentWidth():Number {
        return width;
    }

    public function get contentHeight():Number {
        var _loc2_:SeasonViewRenderer = null;
        var _loc1_:Number = 0;
        if (this.container.numChildren > 0) {
            _loc2_ = SeasonViewRenderer(this.container.getChildAt(this.container.numChildren - 1));
            _loc1_ = _loc2_.y + _loc2_.contentHeight;
        }
        return _loc1_;
    }
}
}
