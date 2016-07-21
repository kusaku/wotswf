package net.wg.gui.components.crosshair {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ReloadingTimer extends MovieClip implements IDisposable {

    private static const FRACTIONAL_SIGNS:int = 2;

    public var timerTextField:TextField;

    private var _time:Number = 0;

    public function ReloadingTimer() {
        super();
    }

    public function dispose():void {
        this.timerTextField = null;
    }

    public function updateTime(param1:Number, param2:Boolean):void {
        var _loc3_:String = null;
        if (!isNaN(param1)) {
            this._time = param1;
            this.gotoAndStop(!!param2 ? "progress" : "complete");
            _loc3_ = this.formatTimerValue(this._time);
            this.timerTextField.text = _loc3_;
        }
    }

    private function formatTimerValue(param1:Number):String {
        var _loc8_:Array = null;
        var _loc2_:Number = Math.pow(10, FRACTIONAL_SIGNS);
        var _loc3_:Number = Math.round(param1 * _loc2_) / _loc2_;
        var _loc4_:String = String(_loc3_);
        var _loc5_:String = this.getDelimiter(_loc4_);
        var _loc6_:String = "";
        var _loc7_:* = "";
        if (_loc5_) {
            _loc8_ = _loc4_.split(_loc5_);
            _loc6_ = _loc8_.shift();
            _loc7_ = _loc8_.join();
        }
        else {
            _loc5_ = ".";
            _loc6_ = _loc4_;
        }
        if (_loc7_.length > FRACTIONAL_SIGNS) {
            _loc7_ = _loc7_.slice(0, FRACTIONAL_SIGNS);
        }
        if (_loc7_.length < FRACTIONAL_SIGNS) {
            while (_loc7_.length < FRACTIONAL_SIGNS) {
                _loc7_ = _loc7_ + "0";
            }
        }
        return _loc6_ + _loc5_ + _loc7_;
    }

    private function getDelimiter(param1:String):String {
        var _loc7_:String = null;
        var _loc2_:String = "0123456789";
        var _loc3_:Number = param1.length;
        var _loc4_:Array = [];
        var _loc5_:String = "";
        var _loc6_:String = "";
        var _loc8_:Boolean = false;
        var _loc9_:int = 0;
        while (_loc9_ < _loc3_) {
            _loc7_ = param1.charAt(_loc9_);
            if (_loc2_.indexOf(_loc7_) == -1) {
                _loc8_ = true;
                _loc5_ = _loc5_ + _loc7_;
            }
            else {
                _loc6_ = _loc6_ + _loc7_;
                if (_loc8_) {
                    _loc4_.push(_loc5_);
                    _loc5_ = "";
                    _loc8_ = false;
                }
            }
            _loc9_++;
        }
        if (_loc4_.length > 0) {
            _loc5_ = _loc4_[0];
        }
        return _loc5_;
    }
}
}
