package net.wg.gui.utils {
import flash.display.MovieClip;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public interface IFrameWalker extends IDisposable {

    function stop():void;

    function setPosAsPercent(param1:Number):void;

    function restartFromCurrentFrame(param1:Number):void;

    function start(param1:Number, param2:Number, param3:String = null, param4:Function = null):void;

    function setTarget(param1:MovieClip):void;

    function set visible(param1:Boolean):void;

    function set alpha(param1:Number):void;
}
}
