package net.wg.gui.components.crosshair {
import flash.display.MovieClip;
import flash.events.Event;

import net.wg.gui.utils.FrameWalker;
import net.wg.gui.utils.IFrameWalker;
import net.wg.gui.utils.PercentFrameWalker;

public class CrosshairSniper extends CrosshairBase {

    private static const MARKER_STATE_RELOADED:String = "reloaded";

    private static const MARKER_STATE_RELOADING:String = "reloading";

    private static const MARKER_STATE_NORMAL:String = "normal";

    private static const TYPE:String = "type";

    private static const CIRCLE_TYPE_ID:int = 3;

    private static const MIXING_FRAMES_TOTAL:int = 37;

    public var radiusMC:MovieClip;

    public var markerMC:MovieClip;

    private var _radiusFW:FrameWalker;

    private var _circleCrosshair:CrosshairCircle;

    private var _circleFW:PercentFrameWalker;

    private var _currentFW:IFrameWalker;

    private var _isReloaded:Boolean = false;

    private var _currentType:int = 3;

    private var _lastGunType:String = "normal";

    private var _gunTypes:Vector.<String> = null;

    public function CrosshairSniper() {
        super();
    }

    override public function setFilter():void {
        this.radiusMC.filters = [devModeColorFilter];
    }

    override public function setReloading(param1:Number, param2:Number, param3:Boolean, param4:Number = 0):void {
        super.setReloading(param1, param2, param3, param4);
        this._currentFW.stop();
        this._isReloaded = false;
        this.setMarkerType(MARKER_STATE_RELOADING);
        if (param1 == 0) {
            this._currentFW.setPosAsPercent(100);
            this._isReloaded = true;
            this.setMarkerType(MARKER_STATE_RELOADED);
        }
        else if (param1 == -1) {
            this._currentFW.setPosAsPercent(0);
        }
        else if (param4 > 0) {
            this._currentFW.setPosAsPercent(param4);
            this._currentFW.restartFromCurrentFrame(param1);
        }
        else {
            this._currentFW.start(param1, param2);
        }
    }

    override public function setReloadingAsPercent(param1:Number, param2:Boolean):void {
        this._isReloaded = false;
        if (param1 >= 100) {
            this._isReloaded = true;
            this._currentFW.setPosAsPercent(100);
            this.setMarkerType(MARKER_STATE_RELOADED);
        }
        else {
            this._currentFW.setPosAsPercent(param1);
            this.setMarkerType(MARKER_STATE_RELOADING);
        }
    }

    override protected function onDispose():void {
        if (_inited) {
            this._radiusFW.dispose();
            this._radiusFW = null;
            this._circleFW.dispose();
            this._circleFW = null;
            this._currentFW = null;
            this._circleCrosshair.dispose();
            this._circleCrosshair = null;
        }
        this.clearGunTypes();
        this.radiusMC = null;
        this.markerMC = null;
        super.onDispose();
    }

    override public function setScale(param1:Number):void {
        if (this._currentType == CIRCLE_TYPE_ID) {
            this._circleCrosshair.setAimLineStyle(param1);
        }
        this.radiusMC.scaleX = this.radiusMC.scaleY = param1;
        this.markerMC.scaleX = this.markerMC.scaleY = param1;
    }

    public function correctReloadingTime(param1:Number):void {
        if (!this._isReloaded) {
            this._currentFW.stop();
            this._currentFW.restartFromCurrentFrame(param1);
        }
    }

    public function setGunTag(param1:Number, param2:Number):void {
        this.markerMC.gotoAndStop("type" + param2);
        this.markerMC.alpha = param1;
        this.clearGunTypes();
        this.initGunTypes();
        this.setMarkerType(this._lastGunType);
        if (this._isReloaded) {
            this.setReloading(0, 0, false);
        }
    }

    public function setMarkerType(param1:String):void {
        if (this._gunTypes && this._gunTypes.indexOf(param1) == -1) {
            return;
        }
        this.markerMC.tag.gotoAndStop(param1);
        this._lastGunType = param1;
    }

    public function setReloadingType(param1:Number, param2:Number):void {
        this._currentType = param2;
        this.radiusMC.gotoAndStop(TYPE + this._currentType);
        this._radiusFW.setTarget(this.radiusMC.mixingMC);
        var _loc3_:IFrameWalker = this._currentType == CIRCLE_TYPE_ID ? this._circleFW : this._radiusFW;
        if (_loc3_ != this._currentFW) {
            this._currentFW.stop();
            this._currentFW.visible = false;
            this._currentFW = _loc3_;
            this._currentFW.visible = true;
        }
        this._currentFW.alpha = param1;
        if (this._isReloaded) {
            this.setReloading(0, 0, false);
        }
    }

    override protected function init(param1:Event = null):void {
        super.init();
        this._radiusFW = new FrameWalker(this.radiusMC.mixingMC, MIXING_FRAMES_TOTAL, false);
        this._circleCrosshair = new CrosshairCircle();
        this.radiusMC.addChild(this._circleCrosshair);
        this._circleFW = new PercentFrameWalker(this._circleCrosshair, 100, false);
        this._circleFW.visible = false;
        this._currentFW = this._radiusFW;
        this.markerMC.tag.stop();
        this.markerMC.stop();
        this.initGunTypes();
    }

    private function clearGunTypes():void {
        if (this._gunTypes) {
            this._gunTypes.splice(0, this._gunTypes.length);
            this._gunTypes = null;
        }
    }

    private function initGunTypes():void {
        var _loc1_:Array = this.markerMC.tag.currentLabels;
        var _loc2_:int = _loc1_.length;
        this._gunTypes = new Vector.<String>(0);
        var _loc3_:String = "";
        var _loc4_:uint = 0;
        while (_loc4_ < _loc2_) {
            this._gunTypes.push(_loc1_[_loc4_].name);
            _loc3_ = _loc3_ + (_loc1_[_loc4_].name + " ");
            _loc4_++;
        }
    }
}
}
