package net.wg.gui.battle.views.prebattleTimer {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFormat;

import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.Values;
import net.wg.infrastructure.base.meta.IPrebattleTimerMeta;
import net.wg.infrastructure.base.meta.impl.PrebattleTimerMeta;
import net.wg.utils.IScheduler;

import scaleform.gfx.TextFieldEx;

public class PrebattleTimer extends PrebattleTimerMeta implements IPrebattleTimerMeta {

    private static const INVALID_WIN_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const INVALID_MESSAGE_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const INVALID_TIME_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    private static const INVALID_TIME_TFS_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;

    private static const INVALID_DOTS_TF_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;

    private static const INVALID_ELEMENTS_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;

    public var winTF:TextField = null;

    public var messageTF:TextField = null;

    public var minutesTF:TextField = null;

    public var dotsTF:TextField = null;

    public var secondsTF:TextField = null;

    public var background:MovieClip = null;

    private var _winTFVisibility:Boolean = false;

    private var _messageTFVisibility:Boolean = false;

    private var _dotsTFVisibility:Boolean = false;

    private var _timeTFsVisibility:Boolean = false;

    private var _backgroundVisibility:Boolean = false;

    private var _totalTime:Number = 0;

    private var _active:Boolean = false;

    private var _winMessageText:String = "";

    private var _messageText:String = "";

    private var _minutesText:String = "";

    private var _secondsText:String = "";

    private var _currentAlphaHideStep:int = 0;

    private var _scheduler:IScheduler = null;

    private const TICK_DURATION:int = 500;

    private const HIDE_ALPHA_STEP:Number = 0.01;

    private const HIDE_STEP_DURATION:int = 17;

    private const WINTF_SINGLELINE_TEXT_SIZE:int = 16;

    private const WINTF_MULTILINE_TEXT_SIZE:int = 14;

    private const WINTF_SINGLELINE_Y_POS:int = -48;

    private const WINTF_MULTILINE_Y_POS:int = -50;

    private const DOTS:String = ":";

    private const HIDE_TIMER_STEPS:int = 100;

    public function PrebattleTimer() {
        super();
        this._scheduler = App.utils.scheduler;
        mouseChildren = false;
        mouseEnabled = false;
        this.background.cacheAsBitmap = true;
        this.dotsTF.text = this.DOTS;
        this.dotsTF.cacheAsBitmap = true;
        this.winTF.cacheAsBitmap = true;
        TextFieldEx.setNoTranslate(this.winTF, true);
        TextFieldEx.setNoTranslate(this.messageTF, true);
        TextFieldEx.setNoTranslate(this.minutesTF, true);
        TextFieldEx.setNoTranslate(this.dotsTF, true);
        TextFieldEx.setNoTranslate(this.secondsTF, true);
    }

    override protected function onDispose():void {
        this.winTF = null;
        this.messageTF = null;
        this.minutesTF = null;
        this.dotsTF = null;
        this.secondsTF = null;
        this.background = null;
        this._scheduler.cancelTask(this.hideDots);
        this._scheduler.cancelTask(this.hideTimer);
        this._scheduler = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_ELEMENTS_VISIBILITY)) {
            this.winTF.visible = this._winTFVisibility;
            this.messageTF.visible = this._messageTFVisibility;
            this.background.visible = this._backgroundVisibility;
        }
        if (isInvalid(INVALID_TIME_TFS_VISIBILITY)) {
            this.minutesTF.visible = this._timeTFsVisibility;
            this.secondsTF.visible = this._timeTFsVisibility;
        }
        if (isInvalid(INVALID_DOTS_TF_VISIBILITY)) {
            this.dotsTF.visible = this._dotsTFVisibility;
        }
        if (isInvalid(INVALID_MESSAGE_TF)) {
            this.messageTF.text = this._messageText;
            this.messageTF.visible = this._messageTFVisibility;
        }
        if (isInvalid(INVALID_WIN_TF)) {
            this.winTF.y = this.winTF.numLines == 1 ? Number(this.WINTF_SINGLELINE_Y_POS) : Number(this.WINTF_MULTILINE_Y_POS);
            this.winTF.text = this._winMessageText;
            this.background.visible = this._backgroundVisibility;
            this.winTF.visible = this._winTFVisibility;
        }
        if (isInvalid(INVALID_TIME_TF)) {
            this.minutesTF.text = this._minutesText;
            this.secondsTF.text = this._secondsText;
        }
        if (isInvalid(InvalidationType.STATE)) {
            if (this._active) {
                if (alpha != Values.DEFAULT_ALPHA) {
                    alpha = Values.DEFAULT_ALPHA;
                }
                visible = true;
            }
            else {
                visible = false;
            }
        }
    }

    public function as_hideAll(param1:int):void {
        this._scheduler.cancelTask(this.hideDots);
        this._scheduler.cancelTask(this.hideTimer);
        if (param1 > 0) {
            this.setActiveState();
            this.hideTime();
            this._currentAlphaHideStep = this.HIDE_TIMER_STEPS;
            this._scheduler.scheduleRepeatableTask(this.hideTimer, this.HIDE_STEP_DURATION, this.HIDE_TIMER_STEPS);
        }
        else {
            this.setInActiveState();
        }
    }

    public function as_setTimer(param1:int):void {
        this._totalTime = param1;
        this.showDots();
        this.applyTime();
        this.setActiveState();
    }

    public function as_hideTimer():void {
        this.hideTime();
    }

    private function hideTime():void {
        this._timeTFsVisibility = false;
        invalidate(INVALID_TIME_TFS_VISIBILITY);
        this.hideDots();
    }

    public function as_setMessage(param1:String):void {
        if (this._messageText != param1) {
            this._messageText = param1;
            this._messageTFVisibility = true;
            invalidate(INVALID_MESSAGE_TF);
        }
    }

    public function as_setWinConditionText(param1:String):void {
        var _loc2_:TextFormat = null;
        if (this._winMessageText != param1) {
            this._backgroundVisibility = true;
            _loc2_ = this.winTF.getTextFormat();
            _loc2_.size = this.winTF.numLines == 1 ? this.WINTF_SINGLELINE_TEXT_SIZE : this.WINTF_MULTILINE_TEXT_SIZE;
            this.winTF.defaultTextFormat = _loc2_;
            this._winMessageText = param1;
            this._winTFVisibility = true;
            invalidate(INVALID_WIN_TF);
        }
        this.setActiveState();
    }

    private function applyTime():void {
        var _loc1_:int = this._totalTime % 60;
        var _loc2_:int = (this._totalTime - _loc1_) / 60;
        this._minutesText = _loc2_ < 10 ? "0" + _loc2_.toString() : _loc2_.toString();
        this._secondsText = _loc1_ < 10 ? "0" + _loc1_.toString() : _loc1_.toString();
        this._scheduler.cancelTask(this.hideDots);
        this._scheduler.scheduleTask(this.hideDots, this.TICK_DURATION);
        invalidate(INVALID_TIME_TF);
        if (!this.minutesTF.visible) {
            this.showDots();
            this._timeTFsVisibility = true;
            invalidate(INVALID_TIME_TFS_VISIBILITY);
        }
    }

    private function hideTimer():void {
        this._currentAlphaHideStep--;
        alpha = alpha - this.HIDE_ALPHA_STEP;
        if (this._currentAlphaHideStep == 0) {
            this.setInActiveState();
        }
    }

    private function setActiveState():void {
        if (!this._active) {
            this._scheduler.cancelTask(this.hideTimer);
            this._active = true;
            if (!this.background.visible || !this.winTF.visible || !this.messageTF.visible) {
                this._backgroundVisibility = true;
                this._winTFVisibility = true;
                this._messageTFVisibility = true;
                invalidate(INVALID_ELEMENTS_VISIBILITY);
            }
            invalidate(InvalidationType.STATE);
        }
    }

    private function setInActiveState():void {
        if (this._active) {
            this._scheduler.cancelTask(this.hideTimer);
            this._scheduler.cancelTask(this.hideDots);
            this._active = false;
            invalidate(InvalidationType.STATE);
            this._winTFVisibility = false;
            this._messageTFVisibility = false;
            this._backgroundVisibility = false;
            invalidate(INVALID_ELEMENTS_VISIBILITY);
            this._dotsTFVisibility = false;
            invalidate(INVALID_DOTS_TF_VISIBILITY);
            this._timeTFsVisibility = false;
            invalidate(INVALID_TIME_TFS_VISIBILITY);
        }
    }

    private function showDots():void {
        this._dotsTFVisibility = true;
        invalidate(INVALID_DOTS_TF_VISIBILITY);
    }

    private function hideDots():void {
        this._dotsTFVisibility = false;
        invalidate(INVALID_DOTS_TF_VISIBILITY);
    }
}
}
