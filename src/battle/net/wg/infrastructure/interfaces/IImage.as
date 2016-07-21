package net.wg.infrastructure.interfaces {
import flash.display.BitmapData;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IImage extends IDisplayObject, IDisposable {

    function set bitmapData(param1:BitmapData):void;

    function set source(param1:String):void;
}
}
