package net.wg.gui.battle.views.destroyTimers {
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.Time;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.BATTLE_DESTROY_TIMER_STATES;
import net.wg.gui.battle.components.FrameAnimationTimer;
import net.wg.gui.battle.views.destroyTimers.components.DestroyTimerContainer;
import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;
import net.wg.utils.IClassFactory;
import net.wg.utils.IScheduler;

public class DestroyTimer extends FrameAnimationTimer {

    private static const START_FRAME:int = 13;

    private static const END_FRAME:int = 157;

    private static const ICON_WARNING_Y_POS:int = 0;

    private static const ICON_CRITICAL_Y_POS:int = -12;

    private static const HIDE_SCALE_STEP_VALUE:Number = 0.005;

    private static const HIDE_ALPHA_STEP_VALUE:Number = 0.1;

    private static const MOVE_ICON_SPEED:int = 34;

    private static const MOVE_ICON_STEPS:int = 12;

    private static const POSITIVE_DIRECTION:int = 1;

    private static const NEGATIVE_DIRECTION:int = -1;

    private static const ICON_BTM_POSITION_VALIDATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const ICON_SPR_POSITION_VALIDATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    public static const ACTIVE_FRAME_LABEL:String = "active";

    public static const SHOW_FRAME_LABEL:String = "show";

    public static const BEAT_LAST_FRAME:String = "repeat";

    public static const HIDDEN_FRAME_LABEL:String = "hidden";

    public var graphicsSpr:DestroyTimerContainer = null;

    private var _timerViewTypeID:int = -1;

    private var _iconSpr:Sprite = null;

    private var _iconBitmap:Bitmap = null;

    private var _scheduler:IScheduler = null;

    private var _moveIconYStep:int = -1;

    private var _xScale:Number = 1.0;

    private var _yScale:Number = 1.0;

    private var _alpha:Number = 1.0;

    private var _iconBitmapX:Number = 0;

    private var _iconBitmapY:Number = 0;

    private var _iconSpriteY:Number = 0;

    public function DestroyTimer() {
        super();
        init(true, true);
        this._scheduler = App.utils.scheduler;
    }

    override protected function invokeAdditionalActionOnIntervalUpdate():void {
        gotoAndPlay(BEAT_LAST_FRAME);
    }

    override protected function getProgressBarMc():MovieClip {
        return this.graphicsSpr.progressBar;
    }

    override protected function getTimerTF():TextField {
        return this.graphicsSpr.textField;
    }

    override protected function onDispose():void {
        this.resetTimer();
        this._scheduler = null;
        this.getProgressBarMc().stop();
        stop();
        this.graphicsSpr.dispose();
        this.graphicsSpr = null;
        this._iconSpr.removeChild(this._iconBitmap);
        this._iconSpr = null;
        this._iconBitmap.bitmapData.dispose();
        this._iconBitmap.bitmapData = null;
        this._iconBitmap = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            scaleX = this._xScale;
            scaleY = this._yScale;
            alpha = this._alpha;
        }
        if (isInvalid(ICON_BTM_POSITION_VALIDATE)) {
            this._iconBitmap.x = this._iconBitmapX;
            this._iconBitmap.y = this._iconBitmapY;
        }
        if (isInvalid(ICON_SPR_POSITION_VALIDATE)) {
            this._iconSpr.y = this._iconSpriteY;
        }
    }

    override protected function getStartFrame():int {
        return START_FRAME;
    }

    override protected function getEndFrame():int {
        return END_FRAME;
    }

    override protected function resetAnimState():void {
        if (alpha != 1) {
            this._xScale = 1;
            this._yScale = 1;
            this._alpha = 1;
            invalidate(InvalidationType.SIZE);
        }
    }

    override protected function onIntervalHideUpdateHandler():void {
        if (alpha <= 0) {
            pauseHideTimer();
            pauseRadialTimer();
            stop();
            dispatchEvent(new DestroyTimerEvent(DestroyTimerEvent.TIMER_HIDDEN_EVENT, this));
        }
        else {
            this._xScale = this._xScale - HIDE_SCALE_STEP_VALUE;
            this._yScale = this._yScale - HIDE_SCALE_STEP_VALUE;
            this._alpha = this._alpha - HIDE_ALPHA_STEP_VALUE;
            invalidate(InvalidationType.SIZE);
        }
    }

    public function resetTimer():void {
        this.cancelSchedulerTasks();
        this._timerViewTypeID = Values.DEFAULT_INT;
    }

    public function setIcon(param1:String):void {
        var _loc2_:IClassFactory = App.utils.classFactory;
        var _loc3_:Class = _loc2_.getClass(param1);
        this._iconBitmap = new Bitmap(new _loc3_());
        this._iconSpr = this.graphicsSpr.iconSpr;
        this._iconSpr.addChild(this._iconBitmap);
        this._iconBitmapX = -this._iconBitmap.width >> 1;
        this._iconBitmapY = -this._iconBitmap.height >> 1;
        invalidate(ICON_BTM_POSITION_VALIDATE);
    }

    public function updateViewID(param1:int):void {
        this.cancelSchedulerTasks();
        this.resetAnimState();
        if (this._timerViewTypeID != param1) {
            this._timerViewTypeID = param1;
            if (param1 == BATTLE_DESTROY_TIMER_STATES.CRITICAL_VIEW) {
                if (this._iconSpr.y != ICON_CRITICAL_Y_POS) {
                    this._iconSpriteY = ICON_WARNING_Y_POS;
                    invalidate(ICON_SPR_POSITION_VALIDATE);
                    this._moveIconYStep = NEGATIVE_DIRECTION;
                    this.startMoveIconTimer();
                }
                gotoAndStop(ACTIVE_FRAME_LABEL);
            }
            else {
                if (this._iconSpr.y != ICON_WARNING_Y_POS) {
                    this._iconSpriteY = ICON_CRITICAL_Y_POS;
                    invalidate(ICON_SPR_POSITION_VALIDATE);
                    this._moveIconYStep = POSITIVE_DIRECTION;
                    this.startMoveIconTimer();
                }
                setTTFText(Values.EMPTY_STR);
                this.getProgressBarMc().gotoAndStop(SHOW_FRAME_LABEL);
                this._scheduler.scheduleTask(this.startWarningBlinkAnimation, Time.MILLISECOND_IN_SECOND);
                if (currentFrameLabel == HIDDEN_FRAME_LABEL) {
                    gotoAndPlay(SHOW_FRAME_LABEL);
                }
            }
        }
        else if (this._timerViewTypeID == BATTLE_DESTROY_TIMER_STATES.CRITICAL_VIEW) {
            if (this._iconSpr.y != ICON_CRITICAL_Y_POS) {
                this._iconSpriteY = ICON_WARNING_Y_POS;
                invalidate(ICON_SPR_POSITION_VALIDATE);
                this._moveIconYStep = NEGATIVE_DIRECTION;
                this.startMoveIconTimer();
            }
            gotoAndStop(ACTIVE_FRAME_LABEL);
        }
    }

    private function cancelSchedulerTasks():void {
        pauseHideTimer();
        pauseRadialTimer();
        this._scheduler.cancelTask(this.onMoveIconHandler);
        this._scheduler.cancelTask(this.startWarningBlinkAnimation);
        this._scheduler.cancelTask(this.playWarningBlinkAnimation);
    }

    private function startMoveIconTimer():void {
        this._scheduler.cancelTask(this.onMoveIconHandler);
        this._scheduler.scheduleRepeatableTask(this.onMoveIconHandler, MOVE_ICON_SPEED, MOVE_ICON_STEPS);
    }

    private function startWarningBlinkAnimation():void {
        this.playWarningBlinkAnimation();
    }

    private function playWarningBlinkAnimation():void {
        this._scheduler.scheduleTask(this.playWarningBlinkAnimation, Time.MILLISECOND_IN_SECOND);
        this.invokeAdditionalActionOnIntervalUpdate();
    }

    private function onMoveIconHandler():void {
        this._iconSpriteY = this._iconSpriteY + this._moveIconYStep;
        invalidate(ICON_SPR_POSITION_VALIDATE);
    }
}
}
