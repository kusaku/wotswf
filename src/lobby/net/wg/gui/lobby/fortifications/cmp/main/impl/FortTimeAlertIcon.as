package net.wg.gui.lobby.fortifications.cmp.main.impl {
import flash.display.Sprite;
import flash.events.MouseEvent;

import net.wg.data.constants.Time;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.IUtils;

public class FortTimeAlertIcon extends Sprite implements IDisposable {

    private static const STATE_WRONG_TIME:String = "wrongTime";

    private static const STATE_OWN_DEFENCE_TIME:String = "ownDefenceTime";

    private static const STATE_LOCK_TIME:String = "lockTime";

    public var alertIcon:Sprite = null;

    private var _wrongState:String = "wrongTime";

    private var _currentValue:Number = -1;

    private var _skipValues:Array = null;

    private var _isSkipValue:Boolean = false;

    private var _isDefenceTime:Boolean = false;

    private var _defenceTime:Number = -1;

    public function FortTimeAlertIcon() {
        super();
        this.alertIcon.visible = false;
        this.alertIcon.addEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler);
        this.alertIcon.addEventListener(MouseEvent.ROLL_OUT, this.onAlertIconRollOutHandler);
    }

    public function dispose():void {
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onAlertIconRollOverHandler);
        this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onAlertIconRollOutHandler);
        this.alertIcon = null;
        if (this._skipValues != null) {
            this._skipValues.splice(0, this._skipValues.length);
            this._skipValues = null;
        }
    }

    public function memberValues(param1:Array, param2:Number):void {
        this._skipValues = param1;
        this._defenceTime = param2;
    }

    public function showAlert(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Number):void {
        if (param2) {
            this._wrongState = STATE_WRONG_TIME;
        }
        else if (param3) {
            this._wrongState = STATE_OWN_DEFENCE_TIME;
        }
        else if (param4 && this._skipValues && this._skipValues.length > 1) {
            this._wrongState = STATE_LOCK_TIME;
        }
        else {
            this.alertIcon.visible = false;
            return;
        }
        this._currentValue = param5;
        this._isSkipValue = param4;
        this._isDefenceTime = param3;
        this.alertIcon.visible = param1 && (param2 || param3 || param4);
    }

    private function getLockTimePeriods(param1:Array):Array {
        return [[this.createFullTimeText(param1[0]), this.createFullTimeText(FortCommonUtils.instance.getNextHour(param1[param1.length - 1]))]];
    }

    private function createFullTimeText(param1:Number):String {
        var _loc2_:IUtils = App.utils;
        var _loc3_:String = Values.EMPTY_STR;
        var _loc4_:String = _loc2_.intToStringWithPrefixPaternS(0, Time.COUNT_SYMBOLS_WITH_PREFIX, Time.PREFIX);
        if (_loc2_.isTwelveHoursFormatS()) {
            _loc3_ = Values.SPACE_STR + _loc2_.dateTime.getAmPmPrefix(param1);
            param1 = _loc2_.dateTime.convertToTwelveHourFormat(param1);
        }
        return _loc2_.intToStringWithPrefixPaternS(param1, Time.COUNT_SYMBOLS_WITH_PREFIX, Time.PREFIX) + Time.DELIMITER + _loc4_ + _loc3_;
    }

    private function onAlertIconRollOverHandler(param1:MouseEvent):void {
        var _loc2_:Array = null;
        if (this._wrongState == STATE_LOCK_TIME) {
            _loc2_ = this.getLockTimePeriods(this._skipValues);
        }
        else if (this._wrongState == STATE_OWN_DEFENCE_TIME) {
            _loc2_ = [[this.createFullTimeText(this._defenceTime), this.createFullTimeText(FortCommonUtils.instance.getNextHour(this._defenceTime))]];
        }
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_WRONG_TIME, null, this._wrongState, _loc2_);
    }

    private function onAlertIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
