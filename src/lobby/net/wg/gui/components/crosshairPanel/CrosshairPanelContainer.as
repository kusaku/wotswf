package net.wg.gui.components.crosshairPanel {
import flash.display.DisplayObject;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.external.ExternalInterface;
import flash.utils.clearInterval;
import flash.utils.getDefinitionByName;
import flash.utils.getTimer;
import flash.utils.setInterval;

import net.wg.data.constants.Values;
import net.wg.gui.components.crosshairPanel.VO.CrosshairSettingsVO;
import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarker;
import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
import net.wg.infrastructure.base.meta.ICrosshairPanelContainerMeta;
import net.wg.infrastructure.base.meta.impl.CrosshairPanelContainerMeta;

public class CrosshairPanelContainer extends CrosshairPanelContainerMeta implements ICrosshairPanelContainerMeta {

    private static const SETTINGS_VALIDATION:String = "settings_invalidation";

    private static const MODE_VALIDATION:String = "mode_invalidation";

    private static const DATA_VALIDATION:String = "data_invalidation";

    private static const NET_VISIBLE_VALIDATION:String = "net_visible_invalidation";

    public var crosshairArcade:CrosshairArcade = null;

    public var crosshairPostmortem:CrosshairPostmortem = null;

    public var crosshairSniper:CrosshairSniper = null;

    public var crosshairStrategic:CrosshairStrategic = null;

    protected var _gunMarkers:Object = null;

    private var _currentCrosshair:ICrosshair = null;

    private var _viewId:int = -1;

    private var _visibleNet:Boolean = true;

    private var _settingId:int = -1;

    private var _settings:Array = null;

    private var _healthInPercents:Number = 0;

    private var _zoomStr:String = "";

    private var _distanceStr:String = "";

    private var _playerInfoStr:String = "";

    private var _isDistanceShown:Boolean = true;

    private var _scale:Number = 1;

    private var _reloadingInterval:Number = -1;

    private var _currReloadingPercent:Number = 0;

    private var _previousReloadingPercent:Number = 0;

    private var _reloadingTimeShift:Number = 0;

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

    private var _crosshairs:Array = null;

    private var _netType:int = -1;

    public function CrosshairPanelContainer() {
        super();
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        this._settings = [];
        this._gunMarkers = {};
        this._crosshairs = [undefined, this.crosshairArcade, this.crosshairSniper, this.crosshairStrategic, this.crosshairPostmortem];
        addEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        this.hideAll();
    }

    override protected function draw():void {
        var _loc1_:CrosshairSettingsVO = null;
        var _loc2_:IGunMarker = null;
        super.draw();
        if (isInvalid(MODE_VALIDATION)) {
            if (this._viewId < 0) {
                this.hideAll();
            }
            else {
                if (this._currentCrosshair && this._currentCrosshair.visible) {
                    this._currentCrosshair.visible = false;
                }
                this._currentCrosshair = this._crosshairs[this._viewId];
                this._currentCrosshair.visible = true;
                this._currentCrosshair.setVisibleNet(this._visibleNet);
            }
        }
        if (isInvalid(SETTINGS_VALIDATION)) {
            if (this._currentCrosshair) {
                _loc1_ = this._settings[this._settingId];
                if (_loc1_) {
                    this._currentCrosshair.setNetType(this._netType != -1 ? Number(this._netType) : Number(_loc1_.netType));
                    this._currentCrosshair.setComponentsAlpha(_loc1_.netAlphaValue, _loc1_.centerAlphaValue, _loc1_.reloaderAlphaValue, _loc1_.conditionAlphaValue, _loc1_.cassetteAlphaValue, _loc1_.reloaderTimerAlphaValue, _loc1_.zoomIndicatorAlphaValue);
                    this._currentCrosshair.setCenterType(_loc1_.centerType);
                    for each(_loc2_ in this._gunMarkers) {
                        _loc2_.setSettings(_loc1_.gunTagType, _loc1_.mixingType, _loc1_.gunTagAlpha, _loc1_.mixingAlpha);
                    }
                }
            }
        }
        if (isInvalid(DATA_VALIDATION)) {
            if (this._currentCrosshair) {
                this._currentCrosshair.setInfo(this._healthInPercents, this._zoomStr, this._currReloadingState, this._isReloadingTimeFieldShown, this._isDistanceShown, this._distanceStr, this._playerInfoStr, this._clipCapacity, this._burst, this._ammoState, this._ammoQuantity, this._ammoQuantityInClip, this._isAmmoLow, this._ammoClipState, this._ammoClipReloaded);
                this.updateCurrentCrosshairReloadingParams();
            }
        }
        if (isInvalid(NET_VISIBLE_VALIDATION)) {
            if (this._currentCrosshair) {
                this._currentCrosshair.setVisibleNet(this._visibleNet);
            }
        }
    }

    override protected function onDispose():void {
        var _loc1_:IGunMarker = null;
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        this.clearReloadingTimer();
        this._currentCrosshair = null;
        this._settings = null;
        for each(_loc1_ in this._gunMarkers) {
            _loc1_.dispose();
        }
        this._gunMarkers = this.cleanupObject(_loc1_);
        this.crosshairArcade.dispose();
        this.crosshairArcade = null;
        this.crosshairPostmortem.dispose();
        this.crosshairPostmortem = null;
        this.crosshairSniper.dispose();
        this.crosshairSniper = null;
        this.crosshairStrategic.dispose();
        this.crosshairStrategic = null;
        this._crosshairs.length = 0;
        this._crosshairs = null;
        super.onDispose();
    }

    public function as_clearDistance(param1:Boolean):void {
        this._distanceStr = Values.EMPTY_STR;
        this._isDistanceShown = false;
        if (this._currentCrosshair) {
            this._currentCrosshair.clearDistance(param1);
        }
    }

    public function as_createGunMarker(param1:Number, param2:String, param3:String):Boolean {
        var gunMarker:IGunMarker = null;
        var settings:CrosshairSettingsVO = null;
        var viewID:Number = param1;
        var linkageName:String = param2;
        var sceneName:String = param3;
        var gunMarkerClass:Class = null;
        try {
            gunMarkerClass = getDefinitionByName(linkageName) as Class;
            gunMarker = addChild(new gunMarkerClass()) as IGunMarker;
            gunMarker.name = sceneName;
            gunMarker.setScale(this._scale);
            this._gunMarkers[sceneName] = gunMarker;
            settings = this._settings[this._settingId];
            if (settings) {
                gunMarker.setSettings(settings.gunTagType, settings.mixingType, settings.gunTagAlpha, settings.mixingAlpha);
            }
            gunMarker.setReloadingParams(this._currReloadingPercent, this._currReloadingState);
            return true;
        }
        catch (e:ReferenceError) {
        }
        return false;
    }

    public function as_destroyGunMarker(param1:String):Boolean {
        var _loc2_:IGunMarker = this._gunMarkers[param1];
        if (_loc2_) {
            _loc2_.dispose();
            removeChild(_loc2_ as DisplayObject);
            delete this._gunMarkers[param1];
            return true;
        }
        return false;
    }

    public final function as_dispose():void {
        dispose();
    }

    public final function as_populate():void {
    }

    public function as_recreateDevice(param1:Number, param2:Number):void {
        this.crosshairArcade.x = param1;
        this.crosshairArcade.y = param2;
        this.crosshairPostmortem.x = param1;
        this.crosshairPostmortem.y = param2;
        this.crosshairSniper.x = param1;
        this.crosshairSniper.y = param2;
        this.crosshairStrategic.x = param1;
        this.crosshairStrategic.y = param2;
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

    public function as_setGunMarkerColor(param1:String, param2:String):void {
        var _loc3_:IGunMarker = this._gunMarkers[param1];
        if (_loc3_) {
            _loc3_.setColor(param2);
        }
    }

    public function as_setHealth(param1:Number):void {
        this._healthInPercents = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.setHealth(this._healthInPercents);
        }
    }

    public function as_setNetVisible(param1:Boolean):void {
        this._visibleNet = param1;
        invalidate(NET_VISIBLE_VALIDATION);
    }

    public function as_setNetType(param1:int):void {
        if (this._netType != param1) {
            this._netType = param1;
            invalidate(SETTINGS_VALIDATION);
        }
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
                this._previousReloadingPercent = this._currReloadingPercent;
                this._reloadingTimeShift = 1 - this._currReloadingPercent;
            }
            else {
                this._remainingTimeInSec = param1 - param3;
                this._currReloadingPercent = param3 / this._remainingTimeInSec;
                this._previousReloadingPercent = 0;
                this._reloadingTimeShift = 1;
            }
            this._currReloadingState = CrosshairConsts.RELOADING_PROGRESS;
            this._initReloadingTime = getTimer();
            this._totalReloadingTimeInMsec = this._remainingTimeInSec * 1000;
            this._reloadingInterval = setInterval(this.updateReloadingTimer, CrosshairConsts.COUNTER_UPDATE_TICK, false);
        }
        this.updateCurrentCrosshairReloadingParams();
    }

    public function as_setReloadingAsPercent(param1:Number, param2:Boolean):void {
        if (param1 >= 100) {
            this._currReloadingPercent = 1;
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
            this._currReloadingPercent = param1 / 100;
        }
        invalidate(DATA_VALIDATION);
    }

    public function as_setReloadingCounterShown(param1:Boolean):void {
        this._isReloadingTimeFieldShown = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.showReloadingTimeField(param1);
        }
    }

    public function as_setScale(param1:Number):void {
        var _loc2_:IGunMarker = null;
        if (this._scale == param1) {
            return;
        }
        this._scale = param1;
        this.crosshairStrategic.scaleX = this.crosshairStrategic.scaleY = this._scale;
        this.crosshairArcade.scaleX = this.crosshairArcade.scaleY = this._scale;
        this.crosshairSniper.scaleX = this.crosshairSniper.scaleY = this._scale;
        this.crosshairPostmortem.scaleX = this.crosshairPostmortem.scaleY = this._scale;
        if (this._gunMarkers) {
            for each(_loc2_ in this._gunMarkers) {
                _loc2_.setScale(this._scale);
            }
        }
    }

    public function as_setSettings(param1:Object):void {
        var _loc2_:* = null;
        var _loc3_:Object = null;
        for (_loc2_ in param1) {
            _loc3_ = param1[_loc2_];
            if (_loc3_) {
                this._settings[int(_loc2_)] = new CrosshairSettingsVO(_loc3_);
            }
        }
        invalidate(SETTINGS_VALIDATION);
    }

    public function as_setView(param1:int, param2:int):void {
        this._viewId = param1;
        this._settingId = param2;
        invalidate(SETTINGS_VALIDATION);
        invalidate(MODE_VALIDATION);
        invalidate(DATA_VALIDATION);
    }

    public function as_setZoom(param1:String):void {
        this._zoomStr = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.setZoom(this._zoomStr);
        }
    }

    public function as_updateAmmoState(param1:String):void {
        this._ammoState = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.updateAmmoState(this._ammoState);
        }
    }

    public function as_updatePlayerInfo(param1:String):void {
        this._playerInfoStr = param1;
        if (this._currentCrosshair) {
            this._currentCrosshair.updatePlayerInfo(this._playerInfoStr);
        }
    }

    private function updateReloadingTimer():void {
        var _loc1_:Number = getTimer() - this._initReloadingTime;
        this._currReloadingPercent = this._reloadingTimeShift * _loc1_ / this._totalReloadingTimeInMsec + this._previousReloadingPercent;
        if (this._currReloadingPercent >= 1) {
            this.clearReloadingTimer();
            this._currReloadingState = CrosshairConsts.RELOADING_ENDED;
        }
        this._remainingTimeInSec = (this._totalReloadingTimeInMsec - _loc1_) / 1000;
        this.updateCurrentCrosshairReloadingParams();
    }

    private function updateCurrentCrosshairReloadingParams():void {
        var _loc1_:IGunMarker = null;
        if (this._currentCrosshair) {
            if (this._isReloadingTimeFieldShown) {
                this._currentCrosshair.setReloadingTime(this._remainingTimeInSec);
            }
            this._currentCrosshair.setReloadingAsPercent(this._currReloadingPercent);
            this._currentCrosshair.setReloadingState(this._currReloadingState);
        }
        for each(_loc1_ in this._gunMarkers) {
            _loc1_.setReloadingParams(this._currReloadingPercent, this._currReloadingState);
        }
    }

    private function clearReloadingTimer():void {
        if (this._reloadingInterval != -1) {
            clearInterval(this._reloadingInterval);
            this._reloadingInterval = -1;
        }
    }

    private function cleanupObject(param1:Object):Object {
        var _loc3_:* = null;
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

    private function hideAll():void {
        this.crosshairArcade.visible = false;
        this.crosshairSniper.visible = false;
        this.crosshairPostmortem.visible = false;
        this.crosshairStrategic.visible = false;
    }

    private function callExternalInterface(param1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        ExternalInterface.call("registerCrosshairPanel");
    }
}
}
