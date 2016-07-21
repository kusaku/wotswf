package net.wg.infrastructure.base.interfaces {
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IWaiting extends IUIComponentEx {

    function setMessage(param1:String):void;

    function show():void;

    function hide():void;

    function set backgroundAlpha(param1:Number):void;
}
}
