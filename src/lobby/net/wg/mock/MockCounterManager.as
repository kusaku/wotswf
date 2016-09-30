package net.wg.mock {
import flash.display.DisplayObject;
import flash.geom.Point;

import net.wg.utils.ICounterManager;
import net.wg.utils.ICounterProps;

public class MockCounterManager implements ICounterManager {

    public function MockCounterManager() {
        super();
    }

    public function containsCounter(param1:DisplayObject):Boolean {
        return false;
    }

    public final function dispose():void {
    }

    public function removeCounter(param1:DisplayObject):void {
    }

    public function setCounter(param1:DisplayObject, param2:String, param3:ICounterProps = null):void {
    }

    public function updateCounterHorizontalAlign(param1:DisplayObject, param2:String):void {
    }

    public function updateCounterOffset(param1:DisplayObject, param2:Point):void {
    }

    public function updateCounterValue(param1:DisplayObject, param2:String):void {
    }
}
}
