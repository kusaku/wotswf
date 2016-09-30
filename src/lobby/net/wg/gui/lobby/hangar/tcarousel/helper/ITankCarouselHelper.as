package net.wg.gui.lobby.hangar.tcarousel.helper {
import scaleform.clik.utils.Padding;

public interface ITankCarouselHelper {

    function get linkRenderer():String;

    function get rendererWidth():Number;

    function get rendererHeight():Number;

    function get gap():Number;

    function get padding():Padding;
}
}
