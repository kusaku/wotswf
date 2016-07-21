package net.wg.gui.lobby.fortifications.utils {
import flash.display.DisplayObject;
import flash.text.TextField;

import net.wg.gui.fortBase.IFortModeVO;

public interface IFortCommonUtils {

    function getFunctionalState(param1:IFortModeVO):Number;

    function fadeSomeElementSimply(param1:Boolean, param2:Boolean, param3:DisplayObject):void;

    function updateTutorialArrow(param1:Boolean, param2:DisplayObject):void;

    function moveElementSimply(param1:Boolean, param2:Number, param3:DisplayObject):void;

    function changeTextAlign(param1:TextField, param2:String):void;

    function getNextHour(param1:int):int;

    function getNextHourText(param1:int, param2:int):String;

    function getDefencePeriodTime(param1:int, param2:Number):String;
}
}
