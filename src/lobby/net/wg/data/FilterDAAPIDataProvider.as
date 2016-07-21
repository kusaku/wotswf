package net.wg.data {
import flash.events.Event;

public class FilterDAAPIDataProvider extends ListDAAPIDataProvider {

    private var _isFilter:Boolean = false;

    private var _filteredItems:Array = null;

    private var _isCache:Boolean = false;

    public function FilterDAAPIDataProvider(param1:Class) {
        super(param1);
        this._filteredItems = [];
    }

    override public function as_dispose():void {
        this._filteredItems = null;
        super.as_dispose();
    }

    override public function invalidate(param1:uint = 0):void {
        super.invalidate(param1);
        this.createCache();
    }

    override public function requestItemAt(param1:uint, param2:Function = null):Object {
        if (this._isFilter) {
            return this._filteredItems[param1];
        }
        return super.requestItemAt(param1, param2);
    }

    override public function requestItemRange(param1:int, param2:int, param3:Function = null):Array {
        if (this._isFilter) {
            return this._filteredItems.slice(param1, param2);
        }
        return super.requestItemRange(param1, param2, param3);
    }

    public function as_clearFilter():void {
        if (this._isFilter) {
            this._isFilter = false;
            if (hasEventListener(Event.CHANGE)) {
                dispatchEvent(new Event(Event.CHANGE));
            }
        }
    }

    public function as_setFilter(param1:Object):void {
        var _loc2_:Array = param1 as Array;
        App.utils.asserter.assertNotNull(_loc2_, "filter must be Array");
        if (!this._isCache) {
            this.createCache();
        }
        var _loc3_:int = _loc2_.length;
        this._filteredItems.length = _loc3_;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            this._filteredItems[_loc4_] = cacheGetItemAt(_loc2_[_loc4_]);
            _loc4_++;
        }
        this._isFilter = true;
        if (hasEventListener(Event.CHANGE)) {
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    private function createCache():void {
        super.requestItemRange(0, super.length);
        this._isCache = true;
    }

    override public function get length():uint {
        if (this._isFilter) {
            return this._filteredItems.length;
        }
        return super.length;
    }
}
}
