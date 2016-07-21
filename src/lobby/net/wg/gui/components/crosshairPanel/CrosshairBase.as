package net.wg.gui.components.crosshairPanel {
import flash.display.MovieClip;

import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBarContainer;
import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
import net.wg.infrastructure.base.SimpleContainer;

public class CrosshairBase extends SimpleContainer implements ICrosshair {

    protected static const TYPE_PREFIX:String = "type";

    protected static const HEALTH_VALIDATION:String = "health";

    protected static const ALPHA_VALIDATION:String = "alpha";

    protected static const NET_TYPE_VALIDATION:String = "netType";

    protected static const CENTER_TYPE_VALIDATION:String = "centerType";

    protected static const RELOAD_VALIDATION:String = "reload";

    public var reloadingTimeField:CrosshairReloadingTimeField = null;

    public var reloadingBar:MovieClip = null;

    public var reloadingAnimationMC:MovieClip = null;

    public var healthBarMC:MovieClip = null;

    public var ammoCountField:CrosshairAmmoCountField = null;

    public var cassetteMC:CrosshairClipQuantityBarContainer = null;

    public var centerMC:MovieClip = null;

    public var netMC:MovieClip = null;

    public var distance:CrosshairDistanceContainer = null;

    protected var _health:Number = 0;

    protected var _reloadingTime:Number = 0;

    protected var _netType:Number = 0;

    protected var _centerType:Number = 0;

    protected var _reloadingState:String = "";

    protected var _centerAlpha:Number = 1;

    protected var _netAlpha:Number = 1;

    protected var _reloadingBarAlpha:Number = 1;

    protected var _healthBarAlpha:Number = 1;

    protected var _cassetteAlpha:Number = 1;

    protected var _reloadingTimeFieldAlpha:Number = 1;

    public function CrosshairBase() {
        super();
    }

    override protected function onDispose():void {
        if (this.reloadingTimeField) {
            this.reloadingTimeField.dispose();
            this.reloadingTimeField = null;
        }
        if (this.ammoCountField) {
            this.ammoCountField.dispose();
            this.ammoCountField = null;
        }
        this.reloadingBar = null;
        this.reloadingAnimationMC = null;
        this.healthBarMC = null;
        this.cassetteMC = null;
        this.centerMC = null;
        this.netMC = null;
        if (this.distance) {
            this.distance.dispose();
            this.distance = null;
        }
        super.onDispose();
    }

    public function setNetType(param1:Number):void {
        if (this._netType != param1) {
            this._netType = param1;
            invalidate(NET_TYPE_VALIDATION);
        }
    }

    public function setCenterType(param1:Number):void {
        if (this._centerType != param1) {
            this._centerType = param1;
            invalidate(CENTER_TYPE_VALIDATION);
        }
    }

    public function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number):void {
        this._netAlpha = param1;
        this._centerAlpha = param2;
        this._reloadingBarAlpha = param3;
        this._healthBarAlpha = param4;
        this._cassetteAlpha = param5;
        this._reloadingTimeFieldAlpha = param6;
        invalidate(ALPHA_VALIDATION);
    }

    override protected function draw():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        super.draw();
        if (isInvalid(NET_TYPE_VALIDATION)) {
            this.updateNetType();
            invalidate(ALPHA_VALIDATION, CENTER_TYPE_VALIDATION, HEALTH_VALIDATION, RELOAD_VALIDATION);
        }
        if (isInvalid(CENTER_TYPE_VALIDATION)) {
            this.centerMC.gotoAndStop(TYPE_PREFIX + this._centerType);
        }
        if (isInvalid(ALPHA_VALIDATION)) {
            this.centerMC.alpha = this._centerAlpha;
            this.netMC.alpha = this._netAlpha;
            this.healthBarMC.alpha = this._healthBarAlpha;
            this.reloadingBar.alpha = this._reloadingBarAlpha;
            this.reloadingAnimationMC.alpha = this._reloadingBarAlpha;
            this.cassetteMC.alpha = this._cassetteAlpha;
            this.reloadingTimeField.setAlpha(this._reloadingTimeFieldAlpha);
        }
        if (isInvalid(HEALTH_VALIDATION)) {
            if (this.healthBarMC) {
                _loc1_ = CrosshairConsts.PROGRESS_TOTAL_FRAMES_COUNT * this._health;
                this.healthBarMC.gotoAndStop(_loc1_);
            }
        }
        if (isInvalid(RELOAD_VALIDATION)) {
            if (this.reloadingBar) {
                this.updateReloadingState();
                _loc2_ = CrosshairConsts.PROGRESS_TOTAL_FRAMES_COUNT * this._reloadingTime;
                this.reloadingBar.gotoAndStop(_loc2_);
            }
        }
    }

    protected function updateNetType():void {
        gotoAndStop(TYPE_PREFIX + this._netType);
    }

    public function setHealth(param1:Number):void {
        this._health = param1;
        invalidate(HEALTH_VALIDATION);
    }

    public function setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean = false):void {
        this.ammoCountField.isLow = param3;
        this.ammoCountField.setCount(param1);
        this.cassetteMC.updateInfo(param2, param4, param5);
    }

    public function setClipsParam(param1:Number, param2:Number):void {
        this.cassetteMC.setClipsParam(param1, param2);
    }

    public function setReloadingAsPercent(param1:Number):void {
        this._reloadingTime = param1;
        invalidate(RELOAD_VALIDATION);
    }

    public function setReloadingState(param1:String):void {
        if (this._reloadingState != param1) {
            this._reloadingState = param1;
            this.updateReloadingState();
        }
    }

    protected function updateReloadingState():void {
        this.reloadingTimeField.setReloadingState(this._reloadingState);
        if (this._reloadingState == CrosshairConsts.RELOADING_END) {
            this.reloadingAnimationMC.visible = true;
            this.reloadingAnimationMC.play();
        }
        else if (this._reloadingState == CrosshairConsts.RELOADING_ENDED) {
            this.reloadingAnimationMC.visible = true;
            this.reloadingAnimationMC.gotoAndStop(1);
        }
        else {
            this.reloadingAnimationMC.visible = false;
        }
    }

    public function setReloadingTime(param1:Number):void {
        this.reloadingTimeField.updateTime(param1);
    }

    public function setDistance(param1:String):void {
        this.distance.setDistance(param1);
    }

    public function setDistanceVisibility(param1:Boolean):void {
    }

    public function clearDistance(param1:Boolean):void {
        this.distance.clearDistance(param1);
    }

    public function showReloadingTimeField(param1:Boolean):void {
        this.reloadingTimeField.visible = param1;
    }

    public function updateAmmoState(param1:String):void {
    }

    public function updatePlayerInfo(param1:String):void {
    }

    public function setZoom(param1:String):void {
    }

    public function setInfo(param1:Number, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:String, param7:String, param8:Number, param9:Number, param10:String, param11:Number, param12:Number, param13:Boolean, param14:String, param15:Boolean = false):void {
        this.setHealth(param1);
        this.setZoom(param2);
        this.setReloadingState(param3);
        this.showReloadingTimeField(param4);
        this.setDistanceVisibility(param5);
        this.setDistance(param6);
        this.updatePlayerInfo(param7);
        this.setClipsParam(param8, param9);
        this.setAmmoStock(param11, param12, param13, param14, param15);
        this.updateAmmoState(param10);
    }
}
}
