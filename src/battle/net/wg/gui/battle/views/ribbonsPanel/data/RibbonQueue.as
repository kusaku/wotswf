package net.wg.gui.battle.views.ribbonsPanel.data {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class RibbonQueue implements IDisposable {

    private static const DEFAULT_COUNT_ITEMS_IN_POOL:int = 10;

    private static const COUNT_ADDITIONAL_ITEMS_IN_POOL:int = 5;

    private var _pool:Vector.<RibbonQueueItem> = null;

    private var _queue:Vector.<RibbonQueueItem> = null;

    public function RibbonQueue() {
        super();
        this._pool = new Vector.<RibbonQueueItem>(0);
        this._queue = new Vector.<RibbonQueueItem>(0);
        this.createAdditionalItemsInPool(DEFAULT_COUNT_ITEMS_IN_POOL);
    }

    public function pushShow(param1:String, param2:String, param3:String, param4:String, param5:String):void {
        var _loc6_:RibbonQueueItem = this.getItemFromPool();
        _loc6_.setData(RibbonQueueItem.SHOW, param1, param2, param3, param4, param5);
        this._queue.push(_loc6_);
    }

    public function unshiftHide(param1:String):void {
        var _loc2_:RibbonQueueItem = this.getItemFromPool();
        _loc2_.setData(RibbonQueueItem.HIDE, param1, "", "", "", "");
        this._queue.unshift(_loc2_);
    }

    private function getItemFromPool():RibbonQueueItem {
        if (this._pool.length == 0) {
            this.createAdditionalItemsInPool(COUNT_ADDITIONAL_ITEMS_IN_POOL);
        }
        return this._pool.shift();
    }

    private function createAdditionalItemsInPool(param1:int):void {
        var _loc2_:int = 0;
        while (_loc2_ < param1) {
            this._pool.push(new RibbonQueueItem());
            _loc2_++;
        }
    }

    public function shiftQueue():void {
        var _loc1_:RibbonQueueItem = this._queue.shift();
        if (_loc1_ != null) {
            this._pool.push(_loc1_);
        }
    }

    public function readNext():RibbonQueueItem {
        var _loc1_:RibbonQueueItem = null;
        if (this._queue.length > 0) {
            _loc1_ = this._queue[0];
        }
        return _loc1_;
    }

    public final function dispose():void {
        this._pool.splice(0, this._pool.length);
        this._pool = null;
        this._queue.splice(0, this._queue.length);
        this._queue = null;
    }
}
}
