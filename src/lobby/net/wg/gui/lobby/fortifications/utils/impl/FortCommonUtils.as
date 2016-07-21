package net.wg.gui.lobby.fortifications.utils.impl {
import flash.display.DisplayObject;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import net.wg.data.constants.Time;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.lobby.fortifications.utils.IFortCommonUtils;
import net.wg.utils.IDateTime;
import net.wg.utils.IUtils;

public class FortCommonUtils implements IFortCommonUtils {

    private static var _instance:IFortCommonUtils = null;

    public function FortCommonUtils() {
        super();
    }

    public static function get instance():IFortCommonUtils {
        if (_instance == null) {
            _instance = new FortCommonUtils();
        }
        return _instance;
    }

    public function changeTextAlign(param1:TextField, param2:String):void {
        var _loc3_:Array = [TextFormatAlign.LEFT, TextFormatAlign.CENTER, TextFormatAlign.RIGHT, TextFormatAlign.JUSTIFY];
        App.utils.asserter.assert(_loc3_.indexOf(param2) != -1, "unknown align value: " + param2);
        var _loc4_:TextFormat = param1.getTextFormat();
        _loc4_.align = param2;
        param1.setTextFormat(_loc4_);
    }

    public function fadeSomeElementSimply(param1:Boolean, param2:Boolean, param3:DisplayObject):void {
        if (param2) {
            if (param1) {
                App.utils.tweenAnimator.addFadeInAnim(param3, null);
            }
            else {
                App.utils.tweenAnimator.addFadeOutAnim(param3, null);
            }
        }
        else {
            param3.visible = param1;
        }
    }

    public function getDefencePeriodTime(param1:int, param2:Number):String {
        var _loc3_:IUtils = App.utils;
        var _loc4_:String = _loc3_.intToStringWithPrefixPaternS(param2, Time.COUNT_SYMBOLS_WITH_PREFIX, Time.PREFIX);
        var _loc5_:String = "";
        if (_loc3_.isTwelveHoursFormatS()) {
            _loc5_ = " " + _loc3_.dateTime.getAmPmPrefix(param1);
        }
        return Time.DELIMITER + _loc4_ + _loc5_ + Time.BETWEEN_TIMES + this.getNextHourText(param1, param2);
    }

    public function getFunctionalState(param1:IFortModeVO):Number {
        return Number(Number(param1.isEntering) << 1) || Number(Number(param1.isTutorial));
    }

    public function getNextHour(param1:int):int {
        param1++;
        if (param1 >= Time.HOURS_IN_DAY) {
            return 0;
        }
        return param1;
    }

    public function getNextHourText(param1:int, param2:int):String {
        var _loc8_:IDateTime = null;
        var _loc3_:IUtils = App.utils;
        var _loc4_:String = "";
        var _loc5_:int = this.getNextHour(param1);
        var _loc6_:String = _loc3_.intToStringWithPrefixPaternS(param2, Time.COUNT_SYMBOLS_WITH_PREFIX, Time.PREFIX);
        var _loc7_:String = "";
        if (_loc3_.isTwelveHoursFormatS()) {
            _loc8_ = _loc3_.dateTime;
            _loc7_ = _loc3_.intToStringWithPrefixPaternS(_loc8_.convertToTwelveHourFormat(_loc5_), Time.COUNT_SYMBOLS_WITH_PREFIX, Time.PREFIX);
            _loc4_ = _loc7_ + Time.DELIMITER + _loc6_ + " " + _loc8_.getAmPmPrefix(_loc5_);
        }
        else {
            _loc7_ = _loc3_.intToStringWithPrefixPaternS(_loc5_, Time.COUNT_SYMBOLS_WITH_PREFIX, Time.PREFIX);
            _loc4_ = _loc7_ + Time.DELIMITER + _loc6_;
        }
        return _loc4_;
    }

    public function moveElementSimply(param1:Boolean, param2:Number, param3:DisplayObject):void {
        if (param1) {
            App.utils.tweenAnimator.addMoveDownAnim(param3, param2, null);
        }
        else {
            App.utils.tweenAnimator.addMoveUpAnim(param3, param2, null);
        }
    }

    public function updateTutorialArrow(param1:Boolean, param2:DisplayObject):void {
        param2.visible = param1;
        if (param1) {
            App.utils.tweenAnimator.blinkInfinity(param2);
        }
        else {
            App.utils.tweenAnimator.removeAnims(param2);
        }
    }
}
}
