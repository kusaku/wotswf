package net.wg.gui.battle.components {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.Errors;
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.Time;
import net.wg.data.constants.Values;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.utils.IDateTime;
import net.wg.utils.IScheduler;

public class FrameAnimationTimer extends BattleUIComponent {

    public static const HIDE_TIMER_STEPS:int = 101;

    public static const HIDE_TIMER_INTERVAL:int = 30;

    public var isActive:Boolean = false;

    private var _totalFrames:int = -1;

    private var _lastFrameID:int = -1;

    private var _lastStrTime:String = "";

    private var _totalTime:int = -1;

    private var _currentTime:int = -1;

    private var _speed:Number = 1;

    private var _progressValues:Vector.<int> = null;

    private var _timerTextValues:Vector.<String> = null;

    private var _lastTimerIndex:int = -1;

    private var _currentTimerIndex:int = -1;

    private var _intervalTime:int = -1;

    private var _isUpdateProgressValues:Boolean = false;

    private var _isUpdateTextValues:Boolean = false;

    private var _scheduler:IScheduler;

    private var _dateTime:IDateTime;

    public function FrameAnimationTimer() {
        this._scheduler = App.utils.scheduler;
        this._dateTime = App.utils.dateTime;
        super();
    }

    override protected function onDispose():void {
        this.pauseRadialTimer();
        this.pauseHideTimer();
        this._scheduler = null;
        this._dateTime = null;
        this.cleanProgressValues();
        this.cleanTimerTextValues();
        super.onDispose();
    }

    protected function init(param1:Boolean = false, param2:Boolean = false):void {
        this._isUpdateProgressValues = param1;
        this._isUpdateTextValues = param2;
        this._totalFrames = this.getEndFrame() - this.getStartFrame();
        if (this._isUpdateProgressValues) {
            this.cleanProgressValues();
            this._progressValues = new Vector.<int>(this._totalFrames + 1, true);
        }
        if (this._isUpdateTextValues) {
            this.cleanTimerTextValues();
            this._timerTextValues = new Vector.<String>(this._totalFrames + 1, true);
        }
        this._lastTimerIndex = this._progressValues.length - 1;
    }

    private function cleanTimerTextValues():void {
        if (this._timerTextValues) {
            this._timerTextValues.fixed = false;
            this._timerTextValues.splice(0, this._timerTextValues.length);
            this._timerTextValues = null;
        }
    }

    private function cleanProgressValues():void {
        if (this._progressValues) {
            this._progressValues.fixed = false;
            this._progressValues.splice(0, this._progressValues.length);
            this._progressValues = null;
        }
    }

    public function updateRadialTimer(param1:int, param2:int):void {
        this.pauseHideTimer();
        this.pauseRadialTimer();
        if (this._totalTime != param1) {
            this._totalTime = param1;
            this.recalculateTimeRelatedValues();
            this.recalculateIntervalTimer();
        }
        this._currentTime = param2;
        this.updateCurrentTime();
        this.runInterval();
    }

    public function setSpeed(param1:Number):void {
        if (this._speed != param1) {
            this.pauseRadialTimer();
            this._speed = param1;
            this.recalculateIntervalTimer();
            if (this.isActive) {
                this.runInterval();
            }
        }
    }

    protected function getStartFrame():int {
        return Values.DEFAULT_INT;
    }

    protected function getEndFrame():int {
        return Values.DEFAULT_INT;
    }

    protected function pauseRadialTimer():void {
        this._scheduler.cancelTask(this.onIntervalUpdateHandler);
    }

    protected function pauseHideTimer():void {
        this._scheduler.cancelTask(this.onIntervalHideUpdateHandler);
    }

    protected function setTimerTFText(param1:String):void {
        if (this._lastStrTime != param1) {
            this.setTTFText(param1);
            this.invokeAdditionalActionOnIntervalUpdate();
        }
    }

    protected function setTTFText(param1:String):void {
        this._lastStrTime = param1;
        invalidate(InvalidationType.DATA);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.getTimerTF().text = this._lastStrTime;
        }
    }

    protected function getProgressBarMc():MovieClip {
        throw new AbstractException("FrameAnimationTimer::getProgressBarMc" + Errors.ABSTRACT_INVOKE);
    }

    protected function getTimerTF():TextField {
        throw new AbstractException("FrameAnimationTimer::getTimerTF" + Errors.ABSTRACT_INVOKE);
    }

    protected function invokeAdditionalActionOnIntervalUpdate():void {
        throw new AbstractException("FrameAnimationTimer::invokeAdditionalActionOnIntervalUpdate" + Errors.ABSTRACT_INVOKE);
    }

    protected function resetAnimState():void {
        throw new AbstractException("FrameAnimationTimer::resetAnimState" + Errors.ABSTRACT_INVOKE);
    }

    protected function onIntervalHideUpdateHandler():void {
        throw new AbstractException("FrameAnimationTimer::onIntervalHideUpdateHandler" + Errors.ABSTRACT_INVOKE);
    }

    private function recalculateIntervalTimer():void {
        this._intervalTime = Time.MILLISECOND_IN_SECOND * this._totalTime / this._totalFrames / this._speed;
    }

    private function recalculateTimeRelatedValues():void {
        var _loc1_:int = this.getStartFrame();
        var _loc2_:Number = this._totalTime / this._totalFrames;
        var _loc3_:int = 0;
        if (this._isUpdateProgressValues && this._isUpdateTextValues) {
            _loc3_ = 0;
            while (_loc3_ <= this._totalFrames) {
                this._progressValues[_loc3_] = _loc1_ + _loc3_;
                this._timerTextValues[_loc3_] = this._dateTime.formatSecondsToString(Math.ceil(this._totalTime - _loc3_ * _loc2_));
                _loc3_++;
            }
        }
        else if (this._isUpdateProgressValues) {
            _loc3_ = 0;
            while (_loc3_ <= this._totalFrames) {
                this._progressValues[_loc3_] = _loc1_ + _loc3_;
                _loc3_++;
            }
        }
        else if (this._isUpdateTextValues) {
            _loc3_ = 0;
            while (_loc3_ <= this._totalFrames) {
                this._timerTextValues[_loc3_] = this._dateTime.formatSecondsToString(Math.ceil(this._totalTime - _loc3_ * _loc2_));
                _loc3_++;
            }
        }
    }

    private function updateCurrentTime():void {
        this._currentTimerIndex = this._currentTime * this._totalFrames / this._totalTime;
        if (this._isUpdateProgressValues) {
            this.setProgressMcPosition(this._progressValues[this._currentTimerIndex]);
        }
        if (this._isUpdateTextValues) {
            this.setTimerTFText(this._timerTextValues[this._currentTimerIndex]);
        }
    }

    private function runInterval():void {
        if (this._speed > 0) {
            this._scheduler.scheduleRepeatableTask(this.onIntervalUpdateHandler, this._intervalTime, this._totalFrames);
        }
    }

    private function onIntervalUpdateHandler():void {
        if (this._currentTimerIndex == this._lastTimerIndex) {
            this.pauseRadialTimer();
            this.resetAnimState();
            stop();
            this._scheduler.scheduleRepeatableTask(this.onIntervalHideUpdateHandler, HIDE_TIMER_INTERVAL, HIDE_TIMER_STEPS);
        }
        else {
            this._currentTimerIndex++;
            if (this._isUpdateProgressValues) {
                this.setProgressMcPosition(this._progressValues[this._currentTimerIndex]);
            }
            if (this._isUpdateTextValues) {
                this.setTimerTFText(this._timerTextValues[this._currentTimerIndex]);
            }
        }
    }

    private function setProgressMcPosition(param1:int):void {
        if (this._lastFrameID != param1) {
            this._lastFrameID = param1;
            this.getProgressBarMc().gotoAndStop(this._lastFrameID);
        }
    }
}
}
