package net.wg.gui.components.advanced {
import flash.display.Sprite;

import net.wg.gui.components.advanced.interfaces.IStatusDeltaIndicatorAnim;
import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;
import net.wg.gui.components.controls.StatusIndicatorAnim;

import scaleform.clik.constants.InvalidationType;

public class StatusDeltaIndicatorAnim extends StatusIndicatorAnim implements IStatusDeltaIndicatorAnim {

    private static const PADDING:int = 11;

    private static const HUNDRED_PERCENT:int = 100;

    private static const CORRECTION:int = 1;

    private static const ANIM_STEP_TIME:int = 10;

    private static const NUM_CYCLES:int = 40;

    public var commonBar:Sprite = null;

    public var plusBar:Sprite = null;

    public var minusBar:Sprite = null;

    public var marker:Sprite = null;

    private var _endDelta:Number = 0;

    private var _delta:Number = 0;

    private var _markerValue:Number = 0;

    private var _endMarkerValue:Number = 0;

    private var _deltaStepsNumber:int = 0;

    private var _deltaStep:int = 0;

    private var _markerStepsNumber:int = 0;

    private var _markerStep:int = 0;

    private var _onePercent:Number = 0;

    private var _onePercentWidth:Number = 0;

    public function StatusDeltaIndicatorAnim() {
        super();
    }

    override protected function animIndicator():void {
        super.animIndicator();
        this.animMarker();
        this._deltaStepsNumber--;
        if (this._delta - this._endDelta == 0) {
            this._deltaStepsNumber = 0;
            this._delta = this._endDelta;
        }
        else if (this._deltaStepsNumber == 0) {
            this._delta = this._endDelta;
            this.stopAnimation();
        }
        else {
            this._delta = this._delta + this._deltaStep;
        }
        this.updatePosition();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.updatePosition();
        }
    }

    override protected function updatePosition():void {
        this._onePercent = (_maximum - _minimum) / HUNDRED_PERCENT;
        this._onePercentWidth = (width - (PADDING << 1)) / HUNDRED_PERCENT / scaleX;
        this.commonBar.width = _value / this._onePercent * this._onePercentWidth ^ 0;
        this.marker.visible = this._markerValue > 0;
        if (this._markerValue > 0) {
            this.marker.x = (this._markerValue / this._onePercent * this._onePercentWidth ^ 0) + PADDING;
        }
        if (this._delta < 0) {
            this.layoutBar(this.minusBar, -this._delta);
            this.minusBar.visible = true;
            this.plusBar.visible = false;
        }
        else if (this._delta > 0) {
            this.layoutBar(this.plusBar, this._delta);
            this.minusBar.visible = false;
            this.plusBar.visible = true;
        }
        else {
            this.minusBar.visible = false;
            this.plusBar.visible = false;
        }
    }

    override protected function stopAnimation():void {
        if (this._delta == this._endDelta && this._markerValue == this._endMarkerValue) {
            super.stopAnimation();
        }
    }

    override protected function configUI():void {
        super.configUI();
        this.minusBar.visible = false;
        this.plusBar.visible = false;
        this.marker.visible = false;
    }

    override protected function onDispose():void {
        this.commonBar = null;
        this.plusBar = null;
        this.minusBar = null;
        this.marker = null;
        super.onDispose();
    }

    override protected function getAnimStepTime():int {
        return ANIM_STEP_TIME;
    }

    override protected function getNumCycles():int {
        return NUM_CYCLES;
    }

    public function setData(param1:StatusDeltaIndicatorVO):void {
        if (param1 == null) {
            return;
        }
        minimum = param1.minValue;
        maximum = param1.maxValue;
        useAnim = param1.useAnim;
        value = param1.value;
        this.delta = param1.delta;
        this.markerValue = param1.markerValue;
        this.updatePosition();
    }

    private function layoutBar(param1:Sprite, param2:Number):void {
        param1.width = param2 / this._onePercent * this._onePercentWidth - CORRECTION;
        param1.width = param1.width > CORRECTION ? Number(param1.width) : Number(CORRECTION << 1);
        param1.x = (this.commonBar.x + this.commonBar.width ^ 0) + CORRECTION;
    }

    private function animMarker():void {
        this._markerStepsNumber--;
        if (this._markerValue - this._endMarkerValue == 0) {
            this._markerStepsNumber = 0;
            this._markerValue = this._endMarkerValue;
            return;
        }
        if (this._markerStepsNumber == 0) {
            this._markerValue = this._endMarkerValue;
            this.stopAnimation();
        }
        else {
            this._markerValue = this._markerValue + this._markerStep;
        }
    }

    private function calculateDeltaSteps():void {
        var _loc1_:Number = Math.max(this._delta, this._endDelta);
        var _loc2_:Number = Math.min(this._delta, this._endDelta);
        var _loc3_:Number = _loc1_ - _loc2_;
        this._deltaStep = Math.ceil(_loc3_ / numCycles);
        this._deltaStepsNumber = _loc3_ / this._deltaStep;
        if (this._endDelta < this._delta) {
            this._deltaStep = this._deltaStep * -1;
        }
    }

    private function calculateStockSteps():void {
        var _loc1_:Number = Math.max(this._markerValue, this._endMarkerValue);
        var _loc2_:Number = Math.min(this._markerValue, this._endMarkerValue);
        var _loc3_:Number = _loc1_ - _loc2_;
        this._markerStep = Math.ceil(_loc3_ / numCycles);
        this._markerStepsNumber = _loc3_ / this._markerStep;
        if (this._endMarkerValue < this._markerValue) {
            this._markerStep = this._markerStep * -1;
        }
    }

    public function get delta():int {
        return this._delta;
    }

    public function set delta(param1:int):void {
        if (this._delta == param1) {
            return;
        }
        if (useAnim) {
            this._endDelta = param1;
            this.calculateDeltaSteps();
            invalidate(INVALID_ANIMATE);
        }
        else {
            this._delta = param1;
            this.updatePosition();
        }
    }

    public function get markerValue():int {
        return this._markerValue;
    }

    public function set markerValue(param1:int):void {
        if (this._markerValue == param1) {
            return;
        }
        if (useAnim) {
            this._endMarkerValue = param1;
            this.calculateStockSteps();
            invalidate(INVALID_ANIMATE);
        }
        else {
            this._markerValue = param1;
            this.updatePosition();
        }
    }
}
}
