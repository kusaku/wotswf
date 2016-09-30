package net.wg.gui.components.crosshairPanel.components {
import flash.display.MovieClip;

import net.wg.infrastructure.base.SimpleContainer;

public class CrosshairClipQuantityBar extends SimpleContainer {

    public static const STATE_NORMAL:String = "normal";

    public static const STATE_RELOADED:String = "reloaded";

    public static const MODE_PERCENT:String = "percent";

    public static const MODE_QUEUE:String = "queue";

    public static const MODE_AMMO:String = "ammo";

    private static const DATA_VALIDATION:String = "dataValidation";

    public var capacityBar:MovieClip = null;

    public var quantityInClipBar:MovieClip = null;

    private var _currentQuantityBarCurrentFrame:Number = -1;

    private var _currentQuantityInClip:Number = -1;

    private var _currentClipState:String = "normal";

    private var _isReloaded:Boolean = false;

    private var _initQuantityBarTotalFrames:Number = -1;

    private var _initClipCapacity:Number = -1;

    private var _initBurst:Number = -1;

    private var _initMode:String = "percent";

    public function CrosshairClipQuantityBar() {
        super();
    }

    override protected function onDispose():void {
        this.capacityBar = null;
        this.quantityInClipBar = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(DATA_VALIDATION)) {
            gotoAndStop(this._currentClipState);
            this.quantityInClipBar.gotoAndStop(this._currentQuantityBarCurrentFrame);
            if (this._isReloaded && this._initClipCapacity == this._currentQuantityInClip) {
                gotoAndPlay(STATE_RELOADED);
            }
        }
    }

    public function updateInfo(param1:Number, param2:String, param3:Boolean):void {
        this._isReloaded = param3;
        this._currentClipState = param2;
        this._currentQuantityInClip = param1;
        this._currentQuantityBarCurrentFrame = this.calcCurrentFrame();
        invalidate(DATA_VALIDATION);
    }

    private function calcCurrentFrame():Number {
        var _loc1_:Number = this._initQuantityBarTotalFrames;
        if (this._initClipCapacity != this._currentQuantityInClip) {
            if (this._initMode == MODE_QUEUE) {
                _loc1_ = Math.ceil(this._currentQuantityInClip / this._initBurst) + 1;
            }
            else if (this._initMode == MODE_AMMO) {
                _loc1_ = this._currentQuantityInClip + 1;
            }
            else {
                _loc1_ = this._initQuantityBarTotalFrames * this._currentQuantityInClip / this._initClipCapacity ^ 0;
            }
        }
        return _loc1_;
    }

    public function initialize(param1:String, param2:Number, param3:Number, param4:Number):void {
        this._initMode = param1;
        this._initClipCapacity = param2;
        this._initBurst = param3;
        this._initQuantityBarTotalFrames = param4;
        this.capacityBar.gotoAndStop(this._initQuantityBarTotalFrames);
    }
}
}
