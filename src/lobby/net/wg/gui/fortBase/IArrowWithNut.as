package net.wg.gui.fortBase {
import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IArrowWithNut extends IUIComponentEx, ITweenAnimatorHandler {

    function show():void;

    function hide():void;

    function get content():IUIComponentEx;

    function set content(param1:IUIComponentEx):void;

    function get isShowed():Boolean;

    function get isHidden():Boolean;

    function get isExport():Boolean;

    function set isExport(param1:Boolean):void;
}
}
