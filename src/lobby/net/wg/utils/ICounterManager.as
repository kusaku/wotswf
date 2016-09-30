package net.wg.utils {
import flash.display.DisplayObject;
import flash.geom.Point;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface ICounterManager extends IDisposable {

    function containsCounter(param1:DisplayObject):Boolean;

    function setCounter(param1:DisplayObject, param2:String, param3:ICounterProps = null):void;

    function updateCounterValue(param1:DisplayObject, param2:String):void;

    function updateCounterOffset(param1:DisplayObject, param2:Point):void;

    function updateCounterHorizontalAlign(param1:DisplayObject, param2:String):void;

    function removeCounter(param1:DisplayObject):void;
}
}
