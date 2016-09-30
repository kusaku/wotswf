package net.wg.infrastructure.managers.counter {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import flash.utils.Dictionary;

import net.wg.gui.components.common.Counter;
import net.wg.utils.ICounterManager;
import net.wg.utils.ICounterProps;

public class CounterManager implements ICounterManager {

    private var _counters:Dictionary;

    public function CounterManager() {
        super();
        this._counters = new Dictionary(false);
    }

    public function containsCounter(param1:DisplayObject):Boolean {
        return param1 in this._counters;
    }

    public final function dispose():void {
        var _loc1_:* = null;
        for (_loc1_ in this._counters) {
            this.removeCounter(Sprite(_loc1_));
        }
        App.utils.data.cleanupDynamicObject(this._counters);
        this._counters = null;
    }

    public function removeCounter(param1:DisplayObject):void {
        var _loc2_:Counter = null;
        if (this.containsCounter(param1)) {
            _loc2_ = this.getCounter(param1);
            delete this._counters[param1];
            _loc2_.dispose();
        }
    }

    public function setCounter(param1:DisplayObject, param2:String, param3:ICounterProps = null):void {
        var _loc5_:Counter = null;
        if (param3 == null) {
            param3 = CounterProps.DEFAULT_PROPS;
        }
        var _loc4_:Point = new Point(param3.offsetX, param3.offsetY);
        if (!this.containsCounter(param1)) {
            _loc5_ = App.utils.classFactory.getComponent(param3.linkage, Counter);
            this._counters[param1] = _loc5_;
            _loc5_.setTarget(param1, _loc4_, param3.horizontalAlign, param3.addToTop, param3.tfPadding);
        }
        else {
            this.updateCounterOffset(param1, _loc4_);
            this.updateCounterHorizontalAlign(param1, param3.horizontalAlign);
        }
        this.updateCounterValue(param1, param2);
    }

    public function updateCounterHorizontalAlign(param1:DisplayObject, param2:String):void {
        this.getCounter(param1).updateHorizontalAlign(param2);
    }

    public function updateCounterOffset(param1:DisplayObject, param2:Point):void {
        this.getCounter(param1).updatePosition(param2);
    }

    public function updateCounterValue(param1:DisplayObject, param2:String):void {
        this.getCounter(param1).setCount(param2);
    }

    private function getCounter(param1:DisplayObject):Counter {
        return this._counters[param1];
    }
}
}
