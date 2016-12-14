package net.wg.gui.utils {
import flash.display.MovieClip;
import flash.utils.clearInterval;
import flash.utils.getTimer;
import flash.utils.setInterval;

import net.wg.gui.components.crosshair.CrosshairCircle;

public class PercentFrameWalker implements IFrameWalker {

    private static const ANIM_INTERVAL:int = 50;

    private var _callback:Function;

    private var _startTimeStamp:Number = 0;

    private var _totalTime:Number = 0;

    private var _intervalID:int = -1;

    private var _targetMC:CrosshairCircle;

    private var _startTime:Number = 0;

    public function PercentFrameWalker(param1:CrosshairCircle, param2:int, param3:Boolean) {
        super();
        this._targetMC = param1;
    }

    public final function dispose():void {
        this.onDispose();
    }

    public function play(param1:String):void {
    }

    public function restartFromCurrentFrame(param1:Number):void {
        var _loc2_:Number = NaN;
        this.stop();
        if (param1 > 0) {
            _loc2_ = this._totalTime - getTimer() + this._startTimeStamp;
            this._totalTime = this._totalTime - _loc2_ + param1 * 1000;
            this._intervalID = setInterval(this.run, ANIM_INTERVAL);
        }
        else {
            this.walkEnd();
        }
    }

    public function setPosAsPercent(param1:Number):void {
        this._targetMC.setPercents(param1);
    }

    public function setTarget(param1:MovieClip):void {
    }

    public function start(param1:Number, param2:Number, param3:String = null, param4:Function = null):void {
        this._callback = param4;
        this.stop();
        if (param1 > 0) {
            if (!isNaN(param2) && param2 >= param1) {
                this.walkEnd();
                return;
            }
            this._totalTime = param1;
            this._startTime = param2;
            this._startTimeStamp = getTimer();
            this._targetMC.setPercents((this._totalTime - (this._totalTime - this._startTime)) / this._totalTime * 100);
            this._totalTime = this._totalTime * 1000;
            this._startTime = this._startTime * 1000;
            this._intervalID = setInterval(this.run, ANIM_INTERVAL);
        }
        else {
            this.walkEnd();
        }
    }

    public function stop():void {
        if (this._intervalID != -1) {
            clearInterval(this._intervalID);
            this._intervalID = -1;
        }
    }

    protected function onDispose():void {
        this.stop();
        this._callback = null;
        this._targetMC = null;
    }

    private function run():void {
        var _loc1_:Number = (this._startTime + (getTimer() - this._startTimeStamp)) / this._totalTime;
        if (_loc1_ >= 1) {
            this.stop();
            this.walkEnd();
        }
        else {
            this._targetMC.setPercents(_loc1_ * 100);
        }
    }

    private function walkEnd():void {
        this._targetMC.setPercents(100);
        if (this._callback != null) {
            this._callback.call();
        }
    }

    public function get startTime():Number {
        return this._startTime;
    }

    public function set visible(param1:Boolean):void {
        this._targetMC.visible = param1;
    }

    public function set alpha(param1:Number):void {
        this._targetMC.alpha = param1;
    }
}
}
