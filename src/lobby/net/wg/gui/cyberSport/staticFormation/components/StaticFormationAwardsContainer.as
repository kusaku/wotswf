package net.wg.gui.cyberSport.staticFormation.components {
import flash.events.Event;

import net.wg.gui.components.controls.ResizableTileList;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;

public class StaticFormationAwardsContainer extends UIComponentEx {

    private static const COLUMN_WIDTH:int = 108;

    public var awardsTileList:ResizableTileList = null;

    private var _data:Array;

    public function StaticFormationAwardsContainer() {
        this._data = [];
        super();
    }

    public function get data():Array {
        return this._data;
    }

    public function set data(param1:Array):void {
        this._data = param1;
        this.awardsTileList.dataProvider = new DataProvider(this._data);
        invalidateSize();
    }

    override protected function configUI():void {
        super.configUI();
        this.awardsTileList.direction = DirectionMode.VERTICAL;
        this.awardsTileList.columnWidth = COLUMN_WIDTH;
        this.awardsTileList.addEventListener(Event.RESIZE, this.onAwardsTileListResizeHandler);
    }

    override protected function onDispose():void {
        this.awardsTileList.removeEventListener(Event.RESIZE, this.onAwardsTileListResizeHandler);
        this.awardsTileList.dispose();
        this.awardsTileList = null;
        this._data.splice(0, this._data.length);
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            _height = this.awardsTileList.height;
            dispatchEvent(new Event(Event.RESIZE));
        }
    }

    private function onAwardsTileListResizeHandler(param1:Event):void {
        invalidateSize();
    }
}
}
