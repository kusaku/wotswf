package net.wg.infrastructure.managers {
import flash.display.Graphics;
import flash.events.IEventDispatcher;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IAtlasManager extends IEventDispatcher, IDisposable {

    function registerAtlas(param1:String):void;

    function isAtlasInitialized(param1:String):Boolean;

    function drawGraphics(param1:String, param2:String, param3:Graphics, param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false):void;
}
}
