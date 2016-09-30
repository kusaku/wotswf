package net.wg.gui.components.crosshairPanel {
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.external.ExternalInterface;
import flash.utils.clearInterval;
import flash.utils.getTimer;
import flash.utils.setInterval;

import net.wg.data.constants.Values;
import net.wg.gui.components.crosshairPanel.VO.CrosshairSettingsVO;
import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
import net.wg.infrastructure.base.meta.ICrosshairPanelMeta;
import net.wg.infrastructure.base.meta.impl.CrosshairPanelMeta;

public class CrosshairPanel extends CrosshairPanelMeta implements ICrosshairPanelMeta {

    private static const SETTINGS_VALIDATION:String = "settings";

    private static const MODE_VALIDATION:String = "mode";

    private static const DATA_VALIDATION:String = "data";

    private static const CROSSHAIR_VIEW_UNDEFINED:String = "type0";

    private static const CROSSHAIR_VIEW_TYPE_PREFIX:String = "type";

    private var _crosshairs:Object = null;

    private var _viewType:String = "type0";

    public var crosshairArcade:CrosshairArcade = null;

    public var crosshairPostmortem:CrosshairPostmortem = null;

    public var crosshairSniper:CrosshairSniper = null;

    public var crosshairStrategic:CrosshairStrategic = null;

    private var _currentCrosshair:ICrosshair = null;

    private var _settings:Object = null;

    private var _healthInPercents:Number = 0;

    private var _zoomStr:String = "";

    private var _distanceStr:String = "";

    private var _playerInfoStr:String = "";

    private var _isDistanceShown:Boolean = true;

    private var _reloadingInterval:Number = -1;

    private var _currReloadingPercent:Number = 0;

    private var _remainingTimeInSec:Number = 0;

    private var _baseReloadingTimeInSec:Number = 0;

    private var _initReloadingTime:Number = 0;

    private var _totalReloadingTimeInMsec:Number = 0;

    private var _currReloadingState:String = "reloadingInit";

    private var _ammoQuantity:Number = 0;

    private var _ammoQuantityInClip:Number = 0;

    private var _isAmmoLow:Boolean = false;

    private var _ammoClipState:String = "";

    private var _ammoClipReloaded:Boolean = false;

    private var _ammoState:String = "";

    private var _clipCapacity:Number = -1;

    private var _burst:Number = -1;

    private var _isReloadingTimeFieldShown:Boolean = true;

    public function CrosshairPanel() {
        super();
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        this._crosshairs = {
            "type1": this.crosshairArcade,
            "type2": this.crosshairSniper,
            "type3": this.crosshairStrategic,
            "type4": this.crosshairPostmortem
        };
        this._settings = {
            "type1": null,
            "type2": null
        };
        this.hideAll();
        addEventListener(Event.ENTER_FRAME, this.callExternalInterface);
    }

    override protected function draw():void {
        var _loc1_:CrosshairSettingsVO = null;
        super.draw();
        if (isInvalid(MODE_VALIDATION)) {
            if (this._viewType == CROSSHAIR_VIEW_UNDEFINED) {
                this.hideAll();
            }
            else {
                if (this._currentCrosshair) {
                    this._currentCrosshair.visible = false;
                }
                this._currentCrosshair = this._crosshairs[this._viewType];
                this._currentCrosshair.visible = true;
                invalidate(SETTINGS_VALIDATION);
                invalidate(DATA_VALIDATION);
            }
        }
        if (isInvalid(SETTINGS_VALIDATION)) {
            if (this._currentCrosshair) {
                _loc1_ = this._settings[this._viewType];
                if (_loc1_) {
                    this._currentCrosshair.setNetType(_loc1_.netType);
                    this._currentCrosshair.setComponentsAlpha(_loc1_.netAlphaValue, _loc1_.centerAlphaValue, _loc1_.reloaderAlphaValue, _loc1_.conditionAlphaValue, _loc1_.cassetteAlphaValue, _loc1_.reloaderTimerAlphaValue, _loc1_.zoomIndicatorAlphaValue);
                    this._currentCrosshair.setCenterType(_loc1_.centerType);
                }
            }
        }
        if (isInvalid(DATA_VALIDATION)) {
            if (this._currentCrosshair) {
                this._currentCrosshair.setInfo(this._healthInPercents, this._zoomStr, this._currReloadingState, this._isReloadingTimeFieldShown, this._isDistanceShown, this._distanceStr, this._playerInfoStr, this._clipCapacity, this._burst, this._ammoState, this._ammoQuantity, this._ammoQuantityInClip, this._isAmmoLow, this._ammoClipState, this._ammoClipReloaded);
                this.updateCurrentCrosshairReloadingParams();
            }
        }
    }

    public function as_setSettings(param1:Object):void {
        var _loc2_:* = null;
        var _loc3_:Object = null;
        var _loc4_:String = null;
        for (_loc2_ in param1) {
            _loc3_ = param1[_loc2_];
            _loc4_ = CROSSHAIR_VIEW_TYPE_PREFIX + _loc2_;
            if (this._settings.hasOwnProperty(_loc4_)) {
                if (_loc3_) {
                    this._settings[_loc4_] = new CrosshairSettingsVO(_loc3_);
                }
            }
        }
        invalidate(SETTINGS_VALIDATION);
    }

    public function as_recreateDevice(param1:Number, param2:Number):void {
        x = param1;
        y = param2;
    }

    public function as_setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean):void {
        this._ammoQuantity = param1;
        this._ammoQuantityInClip = param2;
        this._isAmmoLow = param3;
        this._ammoClipState = param4;
        this._ammoClipReloaded = param5;
        if (this._ammoQuantity == 0) {
            this._remainingTimeInSec = 0;
            this._currReloadingState = CrosshairConsts.RELOADING_IMPOSSIBLE_AMMO_ENDED;
        }
        if (this._currentCrosshair) {
            this._currentCrosshair.setAmmoStock(this._ammoQuantity, this._ammoQuantityInClip, this._isAmmoLow, this._ammoClipState, this._ammoClipReloaded);
        }
        this._ammoClipReloaded = false;
    }

    public function as_updateAmmoState(param1:String):void {
        this._ammoState = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.updateAmmoState(this._ammoState);
        }
    }

    public function as_setClipParams(param1:Number, param2:Number):void {
        this._clipCapacity = param1;
        this._burst = param2;
        if (this._currentCrosshair) {
            this._currentCrosshair.setClipsParam(this._clipCapacity, this._burst);
        }
    }

    public function as_setDistance(param1:String):void {
        this._distanceStr = param1;
        this._isDistanceShown = true;
        if (this._currentCrosshair) {
            this._currentCrosshair.setDistance(this._distanceStr);
        }
    }

    public function as_clearDistance(param1:Boolean):void {
        this._distanceStr = Values.EMPTY_STR;
        this._isDistanceShown = false;
        if (this._currentCrosshair) {
            this._currentCrosshair.clearDistance(param1);
        }
    }

    public function as_updatePlayerInfo(param1:String):void {
        this._playerInfoStr = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.updatePlayerInfo(this._playerInfoStr);
        }
    }

    public function as_setHealth(param1:Number):void {
        this._healthInPercents = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.setHealth(this._healthInPercents);
        }
    }

    public function as_setView(param1:Number):void {
        this._viewType = CROSSHAIR_VIEW_TYPE_PREFIX + param1;
        invalidate(MODE_VALIDATION);
    }

    public function as_setReloading(param1:Number, param2:Number, param3:Number, param4:Boolean):void {
        this.clearReloadingTimer();
        this._baseReloadingTimeInSec = param2;
        if (param1 == 0) {
            this._currReloadingPercent = 100;
            this._remainingTimeInSec = this._baseReloadingTimeInSec;
            if (param4) {
                this._currReloadingState = CrosshairConsts.RELOADING_END;
            }
            else if (param2 == 0) {
                this._currReloadingState = CrosshairConsts.RELOADING_INIT;
            }
            else {
                this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
            }
        }
        else if (param1 == -1) {
            this._currReloadingPercent = 0;
            if (this._ammoQuantity == 0) {
                this._remainingTimeInSec = 0;
                this._currReloadingState = CrosshairConsts.RELOADING_IMPOSSIBLE_AMMO_ENDED;
            }
            else {
                this._remainingTimeInSec = this._baseReloadingTimeInSec;
                this._currReloadingState = CrosshairConsts.RELOADING_INIT;
            }
        }
        else {
            if (this._currReloadingState == CrosshairConsts.RELOADING_PROGRESS) {
                this._remainingTimeInSec = param1;
            }
            else {
                this._remainingTimeInSec = param1 - param3;
                this._currReloadingPercent = param3 / this._remainingTimeInSec;
            }
            this._currReloadingState = CrosshairConsts.RELOADING_PROGRESS;
            this._initReloadingTime = getTimer();
            this._totalReloadingTimeInMsec = this._remainingTimeInSec * 1000;
            this._reloadingInterval = setInterval(this.updateReloadingTimer, CrosshairConsts.COUNTER_UPDATE_TICK, false);
        }
        this.updateCurrentCrosshairReloadingParams();
    }

    private function updateReloadingTimer():void {
        var _loc1_:Number = getTimer() - this._initReloadingTime;
        this._currReloadingPercent = _loc1_ / this._totalReloadingTimeInMsec;
        if (this._currReloadingPercent >= 1) {
            this.clearReloadingTimer();
            this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
        }
        this._remainingTimeInSec = (this._totalReloadingTimeInMsec - _loc1_) / 1000;
        this.updateCurrentCrosshairReloadingParams();
    }

    private function updateCurrentCrosshairReloadingParams():void {
        if (this._currentCrosshair) {
            if (this._isReloadingTimeFieldShown) {
                this._currentCrosshair.setReloadingTime(this._remainingTimeInSec);
            }
            this._currentCrosshair.setReloadingAsPercent(this._currReloadingPercent);
            this._currentCrosshair.setReloadingState(this._currReloadingState);
        }
    }

    private function clearReloadingTimer():void {
        if (this._reloadingInterval) {
            clearInterval(this._reloadingInterval);
            this._reloadingInterval = -1;
        }
    }

    public function as_setZoom(param1:String):void {
        this._zoomStr = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.setZoom(this._zoomStr);
        }
    }

    public function as_setReloadingAsPercent(param1:Number, param2:Boolean):void {
        if (param1 >= 100) {
            this._currReloadingPercent = 100;
            this._remainingTimeInSec = this._baseReloadingTimeInSec;
            if (param2) {
                this._currReloadingState = CrosshairConsts.RELOADING_END;
            }
            else {
                this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
            }
        }
        else {
            this._currReloadingState = CrosshairConsts.RELOADING_PROGRESS;
            this._currReloadingPercent = param1;
        }
        invalidate(DATA_VALIDATION);
    }

    public function as_setReloadingCounterShown(param1:Boolean):void {
        this._isReloadingTimeFieldShown = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.showReloadingTimeField(param1);
        }
    }

    private function callExternalInterface(param1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        ExternalInterface.call("registerCrosshairPanel");
    }

    private function hideAll():void {
        this.crosshairArcade.visible = false;
        this.crosshairSniper.visible = false;
        this.crosshairPostmortem.visible = false;
        this.crosshairStrategic.visible = false;
    }

    override protected function onDispose():void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        this.clearReloadingTimer();
        this._currentCrosshair = null;
        this.crosshairArcade.dispose();
        this.crosshairArcade = null;
        this.crosshairPostmortem.dispose();
        this.crosshairPostmortem = null;
        this.crosshairSniper.dispose();
        this.crosshairSniper = null;
        this.crosshairStrategic.dispose();
        this.crosshairStrategic = null;
        this._settings = this.cleanupObject(this._settings);
        this._crosshairs = this.cleanupObject(this._crosshairs);
        super.onDispose();
    }

    private function cleanupObject(param1:Object):Object {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for (_loc3_ in param1) {
            _loc2_.push(_loc3_);
        }
        for each(_loc3_ in _loc2_) {
            delete param1[_loc3_];
        }
        _loc2_.splice(0, _loc2_.length);
        return null;
    }

    public final function as_dispose():void {
        dispose();
    }

    public final function as_populate():void {
    }
}
}
