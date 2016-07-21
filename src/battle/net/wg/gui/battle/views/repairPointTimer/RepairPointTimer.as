package net.wg.gui.battle.views.repairPointTimer {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.Time;
import net.wg.infrastructure.base.meta.IRepairPointTimerMeta;
import net.wg.infrastructure.base.meta.impl.RepairPointTimerMeta;
import net.wg.utils.IDateTime;
import net.wg.utils.IScheduler;

public class RepairPointTimer extends RepairPointTimerMeta implements IRepairPointTimerMeta {

    private static const STATE_PROGRESS:String = "progress";

    private static const STATE_COOLDOWN:String = "cooldown";

    private static const STATE_NONE:String = "none";

    private static const INVALID_TIME_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const INVALID_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    public var titleTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var cooldownTimeTF:TextField = null;

    public var progressTimeTF:TextField = null;

    public var progressAnimIcon:MovieClip = null;

    public var cooldownIcon:Sprite = null;

    private var _state:String = "";

    private var _totalSeconds:int = -1;

    private var _timeTF:TextField = null;

    private var _timeStr:String = "";

    private var _isASTimer:Boolean = false;

    private var _scheduler:IScheduler;

    private var _dateTime:IDateTime;

    public function RepairPointTimer() {
        this._scheduler = App.utils.scheduler;
        this._dateTime = App.utils.dateTime;
        super();
        this.hide();
        this.mouseChildren = false;
        this.mouseEnabled = false;
        this._timeTF = this.progressTimeTF;
        this.titleTF.text = INGAME_GUI.REPAIRPOINT_TITLE;
        this.descriptionTF.text = INGAME_GUI.REPAIRPOINT_UNAVAILABLE;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_STATE)) {
            if (this._state == STATE_NONE) {
                this.progressAnimIcon.stop();
                visible = false;
            }
            else {
                if (this._state == STATE_PROGRESS) {
                    this.progressAnimIcon.play();
                    this.progressAnimIcon.visible = true;
                    this.cooldownIcon.visible = false;
                    this.descriptionTF.visible = false;
                    this.cooldownTimeTF.visible = false;
                    this.progressTimeTF.visible = true;
                    this._timeTF = this.progressTimeTF;
                }
                else if (this._state == STATE_COOLDOWN) {
                    this.progressAnimIcon.stop();
                    this.progressAnimIcon.visible = false;
                    this.cooldownIcon.visible = true;
                    this.descriptionTF.visible = true;
                    this.progressTimeTF.visible = false;
                    this.cooldownTimeTF.visible = true;
                    this._timeTF = this.cooldownTimeTF;
                }
                invalidate(INVALID_TIME_TF);
                visible = true;
            }
        }
        if (isInvalid(INVALID_TIME_TF)) {
            this._timeTF.text = this._timeStr;
        }
    }

    override protected function onDispose():void {
        this._scheduler.cancelTask(this.timerUpdate);
        this._scheduler = null;
        this._dateTime = null;
        this.titleTF = null;
        this.descriptionTF = null;
        this.cooldownTimeTF = null;
        this.progressTimeTF = null;
        this._timeTF = null;
        this.progressAnimIcon.stop();
        this.progressAnimIcon = null;
        this.cooldownIcon = null;
        super.onDispose();
    }

    public function as_setState(param1:String):void {
        this._scheduler.cancelTask(this.timerUpdate);
        this.setState(param1);
    }

    public function as_useActionScriptTimer(param1:Boolean):void {
        this._scheduler.cancelTask(this.timerUpdate);
        this._isASTimer = param1;
        this.tryStartTimer();
    }

    public function as_setTimeInSeconds(param1:int):void {
        this._scheduler.cancelTask(this.timerUpdate);
        this._totalSeconds = param1;
        this.setTime();
        this.tryStartTimer();
    }

    public function as_setTimeString(param1:String):void {
        this._timeStr = param1;
        invalidate(INVALID_TIME_TF);
    }

    public function as_hide():void {
        this.hide();
    }

    private function hide():void {
        this._scheduler.cancelTask(this.timerUpdate);
        this.setState(STATE_NONE);
    }

    private function tryStartTimer():void {
        if (this._totalSeconds > 0 && this._isASTimer) {
            this._scheduler.scheduleRepeatableTask(this.timerUpdate, Time.MILLISECOND_IN_SECOND, this._totalSeconds + 1);
        }
    }

    private function setState(param1:String):void {
        if (this._state != param1) {
            this._state = param1;
            invalidate(INVALID_STATE);
        }
    }

    private function setTime():void {
        this._timeStr = this._dateTime.formatSecondsToString(this._totalSeconds);
        invalidate(INVALID_TIME_TF);
    }

    private function timerUpdate():void {
        if (--this._totalSeconds < 0) {
            this.hide();
        }
        else {
            this.setTime();
        }
    }
}
}
