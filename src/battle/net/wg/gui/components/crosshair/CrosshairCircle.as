package net.wg.gui.components.crosshair {
import flash.display.Shape;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CrosshairCircle extends Shape implements IDisposable {

    private static const GREEN_COLOR:int = 9305906;

    private static const RED_COLOR:int = 16711680;

    private static const LINE_NO_SCALE:String = "none";

    private static const DEFAULT_ANGLE_STEP:Number = Math.PI / 4;

    private static const DEFAULT_PERCENT_STEP:Number = 12.5;

    private static const RADIUS:int = 342;

    private static const CIRCLE_ALPHA:int = 1;

    private static const PERCENTS_TO_ANGLE_COEF:Number = Math.PI * 0.02;

    private static const PI8:Number = Math.PI * 0.125;

    private static const PI2:Number = Math.PI * 0.5;

    private static const STANDARD_DISTANCE:Number = RADIUS / Math.sin(3 * PI8);

    public var curPercents:Number;

    private var _lineWidth:int = 1;

    private var _defaultStepsPoints:Vector.<CircleStepPoints>;

    public function CrosshairCircle() {
        this._defaultStepsPoints = this.getDefaultCirclePoints();
        super();
        rotation = -90;
        this.setPercents(100);
    }

    private function getDefaultCirclePoints():Vector.<CircleStepPoints> {
        var _loc1_:Vector.<CircleStepPoints> = new Vector.<CircleStepPoints>();
        var _loc2_:Number = DEFAULT_ANGLE_STEP;
        var _loc3_:Number = 2 * Math.PI;
        while (_loc2_ <= _loc3_) {
            _loc1_.push(new CircleStepPoints(STANDARD_DISTANCE * Math.cos(_loc2_ - PI8), STANDARD_DISTANCE * Math.sin(_loc2_ - PI8), RADIUS * Math.cos(_loc2_), RADIUS * Math.sin(_loc2_)));
            _loc2_ = _loc2_ + DEFAULT_ANGLE_STEP;
        }
        return _loc1_;
    }

    public function setAimLineStyle(param1:int):void {
        this._lineWidth = param1;
        graphics.clear();
        this.drawCircle(RED_COLOR, CIRCLE_ALPHA, this.curPercents, 100);
        this.drawCircle(GREEN_COLOR, CIRCLE_ALPHA, 0, this.curPercents);
    }

    public function setPercents(param1:Number):void {
        if (param1 > 100 || param1 < 0) {
            throw new Error("Invalid value for percent " + param1.toString() + ". Value must be <= 100 && > 0");
        }
        if (this.curPercents != param1) {
            this.curPercents = param1;
            graphics.clear();
            this.drawCircle(RED_COLOR, CIRCLE_ALPHA, param1, 100);
            this.drawCircle(GREEN_COLOR, CIRCLE_ALPHA, 0, param1);
        }
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        this._defaultStepsPoints.splice(0, this._defaultStepsPoints.length);
        this._defaultStepsPoints = null;
    }

    private function drawCircle(param1:Number, param2:Number, param3:Number, param4:Number):void {
        var _loc12_:CircleStepPoints = null;
        if (param3 >= 100) {
            return;
        }
        graphics.lineStyle(this._lineWidth, param1, param2, false, LINE_NO_SCALE);
        graphics.moveTo(RADIUS, 0);
        var _loc5_:Number = 0;
        var _loc6_:Number = 0;
        var _loc7_:Number = param3 < 100 ? Number(PERCENTS_TO_ANGLE_COEF * param3) : Number(0);
        var _loc8_:Number = PERCENTS_TO_ANGLE_COEF * param4;
        var _loc9_:Number = _loc7_ > 0 ? Number(_loc7_) : Number(0);
        var _loc10_:* = _loc7_ > 0;
        var _loc11_:* = param4 % DEFAULT_PERCENT_STEP == 0;
        if (_loc10_) {
            graphics.moveTo(RADIUS * Math.cos(_loc7_), RADIUS * Math.sin(_loc7_));
            _loc9_ = DEFAULT_ANGLE_STEP * (1 + _loc9_ / DEFAULT_ANGLE_STEP ^ 0);
            _loc5_ = (_loc9_ - _loc7_) * 0.5;
            _loc6_ = RADIUS / Math.sin(PI2 - _loc5_);
            graphics.curveTo(_loc6_ * Math.cos(_loc9_ - _loc5_), _loc6_ * Math.sin(_loc9_ - _loc5_), RADIUS * Math.cos(_loc9_), RADIUS * Math.sin(_loc9_));
        }
        _loc9_ = _loc9_ + DEFAULT_ANGLE_STEP;
        _loc5_ = PI8;
        _loc6_ = STANDARD_DISTANCE;
        while (_loc9_ <= _loc8_) {
            _loc12_ = this._defaultStepsPoints[_loc9_ / DEFAULT_ANGLE_STEP - 1];
            graphics.curveTo(_loc12_.step0, _loc12_.step1, _loc12_.step2, _loc12_.step3);
            _loc9_ = _loc9_ + DEFAULT_ANGLE_STEP;
        }
        if (!_loc11_) {
            _loc5_ = _loc8_ % DEFAULT_ANGLE_STEP * 0.5;
            _loc6_ = RADIUS / Math.sin(PI2 - _loc5_);
            graphics.curveTo(_loc6_ * Math.cos(_loc8_ - _loc5_), _loc6_ * Math.sin(_loc8_ - _loc5_), RADIUS * Math.cos(_loc8_), RADIUS * Math.sin(_loc8_));
        }
    }
}
}
