package net.wg.gui.components.crosshair {
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.utils.clearInterval;
import flash.utils.getTimer;
import flash.utils.setInterval;

import net.wg.gui.utils.FrameWalker;
import net.wg.infrastructure.base.meta.IAimMeta;
import net.wg.infrastructure.base.meta.impl.AimMeta;

public class CrosshairPanelBase extends AimMeta implements IAimMeta {

    public static var COUNTER_UPDATE_TICK:Number = 50;

    public var reloadingTimer:ReloadingTimer;

    public var reloadingBarMC:MovieClip;

    public var universalBarMC:MovieClip;

    public var ammoCountMC:MovieClip;

    public var targetMC:MovieClip;

    public var cassette:MovieClip;

    public var center:MovieClip;

    public var grid1:MovieClip;

    protected var _universalBarWalker:FrameWalker;

    protected var _reloadingBarWalker:FrameWalker;

    protected var _fadingTargetWalker:FrameWalker;

    protected var _health:Number = 0;

    protected var _reloadingSettings:Array;

    protected var _clipCapacity:Number = 1;

    protected var clipQuanityBar:ClipQuantityBar = null;

    private var _startTime:Number = 0;

    private var _mTotalTime:Number = 0;

    private var _reloadingTimerId:Number = 0;

    private var _mIsReloading:Boolean = false;

    private var _reloadingBaseTime:Number = -1;

    private var _reloadingStartTime:Number = 0;

    private var _elapsedReloadingTime:Number = 0;

    private var _correctedReloadingTime:Number = 0;

    public function CrosshairPanelBase() {
        this._reloadingSettings = [0, 0, false];
        super();
        if (stage) {
            this.init();
        }
        else {
            addEventListener(Event.ADDED_TO_STAGE, this.onCrosshairPanelBaseAddedToStageHandler);
        }
    }

    override protected function onDispose():void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onCrosshairPanelBaseAddedToStageHandler);
        if (this._universalBarWalker) {
            this._universalBarWalker.dispose();
            this._universalBarWalker = null;
        }
        if (this._reloadingBarWalker) {
            this._reloadingBarWalker.dispose();
            this._reloadingBarWalker = null;
        }
        if (this._fadingTargetWalker) {
            this._fadingTargetWalker.dispose();
            this._fadingTargetWalker = null;
        }
        if (this._reloadingSettings) {
            this._reloadingSettings.splice(0);
            this._reloadingSettings = null;
        }
        if (this.reloadingTimer) {
            this.reloadingTimer.dispose();
            this.reloadingTimer = null;
        }
        this.center = null;
        this.grid1 = null;
        this.reloadingBarMC = null;
        this.universalBarMC = null;
        this.ammoCountMC = null;
        this.targetMC = null;
        if (this.clipQuanityBar) {
            if (this.cassette && this.cassette.contains(this.clipQuanityBar)) {
                this.cassette.removeChild(this.clipQuanityBar);
            }
            this.clipQuanityBar.dispose();
            this.clipQuanityBar = null;
        }
        this.cassette = null;
        super.onDispose();
    }

    public function as_clearPreviousCorrection():void {
        this.clearCorrection();
    }

    public function as_clearTarget(param1:Number):void {
        this.onClearFadingTarget(param1);
    }

    protected function onClearFadingTarget(param1:Number):void {
        this._fadingTargetWalker.stop();
        this._fadingTargetWalker.start(4, param1);
    }

    public function as_correctReloadingTime(param1:Number):void {
        var _loc2_:Boolean = this._reloadingSettings[2];
        if (_loc2_ && this._reloadingBarWalker) {
            this.clearTimer();
            this.updateCounter(!_loc2_);
            this._reloadingBarWalker.stop();
            this._reloadingBarWalker.restartFromCurrentFrame(param1);
        }
    }

    public function as_initSettings(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number):void {
        this.setCenterType(param1, param2);
        this.setNetType(param3, param4);
        this.setReloaderType(param5, param6);
        this.setConditionType(param7, param8);
        this.setCassetteType(param9, param10);
        this.setReloaderTimerType(param11);
    }

    public function as_recreateDevice(param1:Number, param2:Number):void {
        x = param1;
        y = param2;
    }

    public function as_setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean = false):void {
        var _loc6_:MovieClip = this.ammoCountMC;
        _loc6_.gotoAndStop(!!param3 ? "ammo_low" : "ammo_normal");
        _loc6_.count.text = param1.toString();
        if (this.clipQuanityBar && this.clipQuanityBar.initialized) {
            this.clipQuanityBar.change(param1, param2, param4, param5);
        }
        else {
            ClipQuantityBar.store(param1, param2, param4);
        }
    }

    public function as_setClipParams(param1:Number, param2:Number):void {
        var _loc3_:MovieClip = null;
        if (this._clipCapacity == param1) {
            return;
        }
        this._clipCapacity = param1;
        if (this._clipCapacity > 1) {
            _loc3_ = this.cassette;
            if (_loc3_ && !this.clipQuanityBar) {
                this.clipQuanityBar = ClipQuantityBar.create(this._clipCapacity, param2);
                _loc3_.addChild(this.clipQuanityBar);
            }
        }
        else if (this.clipQuanityBar != null) {
            removeChild(this.clipQuanityBar);
            this.clipQuanityBar = null;
        }
    }

    public function as_setHealth(param1:Number):void {
        this.onSetHealth(param1);
    }

    protected function onSetHealth(param1:Number):void {
        this._health = param1;
        this._universalBarWalker.setPosAsPercent(param1 * 100);
    }

    public function as_setReloading(param1:Number, param2:Number, param3:Boolean, param4:Number, param5:Number = 0):void {
        this.onSetReloading(param1, param2, param3, param4, param5);
    }

    protected function onSetReloading(param1:Number, param2:Number, param3:Boolean, param4:Number, param5:Number):void {
        this.clearTimer();
        var _loc6_:Number = !isNaN(param5) && param1 == 0 ? Number(param5) : Number(param1);
        var _loc7_:Number = param2;
        this.setReloadingTime(_loc6_, _loc7_, param3);
        this._reloadingSettings = [param1, param2, param3];
        this._reloadingBarWalker.stop();
        if (param1 == 0) {
            this._reloadingBarWalker.setPosAsPercent(100);
            if (param3) {
                this._reloadingBarWalker.play("reloaded");
            }
        }
        else if (param1 == -1) {
            this._reloadingBarWalker.setPosAsPercent(0);
        }
        else {
            if (param4 > 0) {
                this._reloadingBarWalker.setPosAsPercent(param4);
                this._reloadingBarWalker.restartFromCurrentFrame(param1);
            }
            else {
                this._reloadingBarWalker.start(param1, param2);
                this._startTime = this._reloadingBarWalker.startTime;
                this._mTotalTime = this._reloadingBarWalker.totalTime;
            }
            if (this._mTotalTime > 0) {
                this.setTimer(this.updateCounter, COUNTER_UPDATE_TICK);
            }
        }
    }

    public function as_setReloadingAsPercent(param1:Number, param2:Boolean):void {
        this.onSetReloadingAsPercent(param1, param2);
    }

    protected function onSetReloadingAsPercent(param1:Number, param2:Boolean):void {
        if (param1 >= 100) {
            this._reloadingBarWalker.setPosAsPercent(100);
            if (param2) {
                this._reloadingBarWalker.play("reloaded");
            }
        }
        else {
            this._reloadingBarWalker.setPosAsPercent(param1);
        }
    }

    public function as_setReloadingTimeWithCorrection(param1:Number, param2:Number, param3:Boolean):void {
        this.onSetReloadingTimeWithCorrection(param1, param2, param3);
    }

    protected function onSetReloadingTimeWithCorrection(param1:Number, param2:Number, param3:Boolean):void {
        this.clearTimer();
        this._reloadingBarWalker.stop();
        this.updateCounter(true);
    }

    public function as_setTarget(param1:String, param2:String, param3:Number):void {
        this.onSetFadingTarget(param1, param2, param3);
    }

    protected function onSetFadingTarget(param1:String, param2:String, param3:Number):void {
        this._fadingTargetWalker.stop();
        this._fadingTargetWalker.setPosAsPercent(0);
    }

    public function as_setupReloadingCounter(param1:Boolean):void {
        this.reloadingTimer.visible = param1;
    }

    public function as_updateAdjust(param1:Number, param2:Number, param3:Number, param4:Number):void {
    }

    public function as_updateAmmoInfoPos():void {
    }

    public function as_updateAmmoState(param1:Boolean):void {
    }

    public function as_updateDistance(param1:Number):void {
    }

    public function as_updatePlayerInfo(param1:String):void {
    }

    public function as_updateReloadingBaseTime(param1:Number, param2:Boolean):void {
        this.setReloadingTime(param1, NaN, param2);
        this.updateCounter(param2);
    }

    public function as_updateTarget(param1:Number):void {
        var _loc2_:MovieClip = null;
        if (this.targetMC) {
            _loc2_ = this.targetMC.target;
            _loc2_.distance.text = param1 + "m";
        }
    }

    public function setCenterType(param1:Number, param2:Number):void {
        this.center.gotoAndStop("type" + param2);
        this.center.alpha = param1;
    }

    public function setConditionType(param1:Number, param2:Number):void {
        this.universalBarMC.alpha = param1;
        this.onSetTargetToWalker(this._universalBarWalker, this.universalBarMC);
        this.as_setHealth(this._health);
    }

    private function onSetTargetToWalker(param1:FrameWalker, param2:MovieClip):void {
        if (param1 && param2) {
            param1.setTarget(param2);
        }
    }

    public function setNetType(param1:Number, param2:Number):void {
        gotoAndStop("type" + param2);
        this.grid1.alpha = param1;
    }

    public function setReloaderType(param1:Number, param2:Number):void {
        this.reloadingBarMC.alpha = param1;
        this.onSetTargetToWalker(this._reloadingBarWalker, this.reloadingBarMC);
        this.as_setReloading(this._reloadingSettings[0], this._reloadingSettings[1], this._reloadingSettings[2], 0);
    }

    public function setReloadingTime(param1:Number, param2:Number, param3:Boolean):void {
        if (param1 != 0) {
            this._reloadingBaseTime = param1;
        }
        if (!isNaN(param2)) {
            this._elapsedReloadingTime = param2;
            if (this._elapsedReloadingTime == this._reloadingBaseTime) {
                this._elapsedReloadingTime = 0;
            }
        }
        else {
            this._elapsedReloadingTime = NaN;
        }
        if (!param3) {
            this.updateCounter(true);
        }
        else if (param1 == -1) {
            this.updateCounter(true);
        }
    }

    public function updateCounter(param1:Boolean = false):void {
        var _loc2_:Number = NaN;
        var _loc3_:Number = NaN;
        var _loc4_:Number = NaN;
        var _loc5_:Number = NaN;
        var _loc6_:Number = NaN;
        if (this.reloadingTimer) {
            _loc2_ = !isNaN(this._elapsedReloadingTime) ? Number(this._elapsedReloadingTime) : Number(0);
            _loc3_ = this._reloadingBaseTime - _loc2_;
            if (this._reloadingBaseTime == -1) {
                this._mIsReloading = false;
                this._correctedReloadingTime = 0;
                this.reloadingTimer.updateTime(0, true);
            }
            else if (param1) {
                this._correctedReloadingTime = 0;
                this._mIsReloading = false;
                this.reloadingTimer.updateTime(_loc3_, false);
            }
            else {
                if (!this._mIsReloading) {
                    this._reloadingStartTime = getTimer();
                    this._mIsReloading = true;
                }
                if (this._correctedReloadingTime > 0) {
                    _loc4_ = (getTimer() - this._reloadingStartTime) / this._correctedReloadingTime;
                    _loc5_ = 1 - _loc4_;
                    _loc6_ = this._correctedReloadingTime / 1000 * _loc5_;
                }
                else if (this._reloadingBarWalker) {
                    this._startTime = this._reloadingBarWalker.startTime;
                    this._mTotalTime = this._reloadingBarWalker.totalTime;
                    _loc4_ = (getTimer() - this._startTime) / this._mTotalTime;
                    _loc5_ = 1 - _loc4_;
                    _loc6_ = _loc3_ * _loc5_;
                }
                this.reloadingTimer.updateTime(_loc6_, true);
            }
        }
    }

    protected function initFrameWalkers():void {
        this._universalBarWalker = new FrameWalker(this.universalBarMC, 60, true);
        this._reloadingBarWalker = new FrameWalker(this.reloadingBarMC, 60, false);
        this._fadingTargetWalker = new FrameWalker(this.targetMC, 60, false);
    }

    protected function setDefaultTargetState():void {
        var _loc1_:MovieClip = this.targetMC.target;
        _loc1_.distance.text = "";
    }

    private function setReloaderTimerType(param1:Number):void {
        this.reloadingTimer.alpha = param1;
    }

    private function setCassetteType(param1:Number, param2:Number):void {
        this.cassette.alpha = param1;
    }

    private function clearCorrection():void {
        this._correctedReloadingTime = 0;
    }

    private function setTimer(param1:Function, param2:int):void {
        this.clearTimer();
        this._reloadingTimerId = setInterval(param1, param2, false);
    }

    private function clearTimer():void {
        if (this._reloadingTimerId > -1) {
            clearInterval(this._reloadingTimerId);
            this._reloadingTimerId = -1;
        }
    }

    private function init():void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onCrosshairPanelBaseAddedToStageHandler);
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        this.initFrameWalkers();
    }

    private function onCrosshairPanelBaseAddedToStageHandler(param1:Event):void {
        this.init();
    }

    public function as_setZoom(param1:String):void {
    }
}
}
