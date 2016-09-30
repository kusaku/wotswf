package net.wg.gui.components.controls.scroller {
import net.wg.infrastructure.interfaces.IUIComponentEx;

public interface IScrollerBase extends IUIComponentEx {

    function get horizontalScrollPosition():Number;

    function set horizontalScrollPosition(param1:Number):void;

    function get verticalScrollPosition():Number;

    function set verticalScrollPosition(param1:Number):void;

    function get horizontalScrollStep():Number;

    function set horizontalScrollStep(param1:Number):void;

    function get verticalScrollStep():Number;

    function set verticalScrollStep(param1:Number):void;

    function get minHorizontalScrollPosition():Number;

    function get minVerticalScrollPosition():Number;

    function get maxHorizontalScrollPosition():Number;

    function get maxVerticalScrollPosition():Number;
}
}
