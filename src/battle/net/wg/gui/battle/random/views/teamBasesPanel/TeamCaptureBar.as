package net.wg.gui.battle.random.views.teamBasesPanel {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class TeamCaptureBar extends Sprite implements IDisposable {

    private static const ANIMATE_STEP_TIME:Number = 40;

    private static const TWEEN_EASE_IN_OUT:Array = [0, 0.002, 0.006, 0.013, 0.03, 0.049, 0.087, 0.125, 0.167, 0.247, 0.32, 0.44, 0.544, 0.628, 0.823, 0.83, 0.868, 0.907, 0.935, 0.966, 0.981, 0.993, 0.998, 0.999, 1];

    private static const TWEEN_EASE_NONE:Array = [0.032, 0.068, 0.116, 0.152, 0.2, 0.232, 0.268, 0.316, 0.352, 0.4, 0.432, 0.468, 0.516, 0.552, 0.6, 0.664, 0.668, 0.716, 0.752, 0.8, 0.832, 0.868, 0.916, 0.952, 1];

    private static const COLOR_ALIAS_PREFIX:String = "capture_bar_";

    public var textField:TextField = null;

    public var pointsTextField:TextField = null;

    public var tfVehiclesCount:TextField = null;

    public var tfTimeLeft:TextField = null;

    public var bg:TeamCaptureBarBg = null;

    public var progressBar:TeamCaptureProgress = null;

    private var _getColorType:String = "";

    private var _points:Number = -1;

    private var _prevDeltaPoints:Number = 0;

    private var _colorTypeFromVo:String = "";

    private var _title:String = "";

    private var _pointsStr:String = "";

    private var _startAnimateScale:Number = 0;

    private var _currentEaseArray:Array = null;

    private var _currentEaseLen:Number = 0;

    private var _currentEaseStep:Number = 0;

    private var _easeParam:Number = 0;

    private var _animateRate:Number = 10;

    private var _sortWeight:Number = -1;

    private var _id:Number = -1;

    public function TeamCaptureBar() {
        super();
    }

    public function dispose():void {
        App.utils.scheduler.cancelTask(this.animationStepHandler);
        this.textField = null;
        this.pointsTextField = null;
        this.progressBar.dispose();
        this.progressBar = null;
        this.bg.dispose();
        this.bg = null;
        this._getColorType = null;
        this._colorTypeFromVo = null;
        this.tfVehiclesCount = null;
        this.tfTimeLeft = null;
        this._currentEaseArray = null;
    }

    public function setData(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:String, param7:String):void {
        this.sortWeight = param2;
        this._id = param1;
        this._colorTypeFromVo = param3;
        this.updateColors();
        this.updateCaptureData(param5, false, false, 1, param6, param7);
        this.updateTitle(param4);
    }

    public function stopCapture(param1:Number):void {
        this.updateCaptureData(param1, false, true, 1, "", "0");
    }

    public function updateCaptureData(param1:Number, param2:Boolean, param3:Boolean, param4:Number, param5:String, param6:String):void {
        var _loc7_:Number = NaN;
        this.progressBar.animate(param3);
        if (this._points != param1) {
            _loc7_ = param1 - this._points;
            this._points = param1;
            this.animateProgress(param1, _loc7_, param2, param4);
            this._pointsStr = this._points.toString();
            this.updateTexts();
        }
        this.tfVehiclesCount.text = param6;
        this.tfTimeLeft.text = param5;
    }

    public function updateColors():void {
        var _loc1_:String = App.colorSchemeMgr.getAliasColor(COLOR_ALIAS_PREFIX + this._colorTypeFromVo);
        if (_loc1_ == null) {
            _loc1_ = this._colorTypeFromVo;
        }
        this.colorType = _loc1_;
    }

    public function updateTitle(param1:String):void {
        this._title = param1;
        this.updateTexts();
    }

    private function animateProgress(param1:Number, param2:Number, param3:Boolean, param4:Number):void {
        App.utils.scheduler.cancelTask(this.animationStepHandler);
        if (!param3) {
            this.progressBar.scaleX = param1 * 0.01;
        }
        else {
            if (this._prevDeltaPoints != param2) {
                this._currentEaseArray = TWEEN_EASE_IN_OUT;
            }
            else {
                this._currentEaseArray = TWEEN_EASE_NONE;
            }
            this._startAnimateScale = this.progressBar.scaleX;
            this._easeParam = param1 * 0.01 - this._startAnimateScale;
            this._currentEaseLen = this._currentEaseArray.length;
            this._currentEaseStep = 0;
            this._animateRate = param4;
            App.utils.scheduler.scheduleRepeatableTask(this.animationStepHandler, ANIMATE_STEP_TIME, int.MAX_VALUE);
        }
        this._prevDeltaPoints = param2;
    }

    private function animationStepHandler():void {
        var _loc1_:Number = this._currentEaseStep | 0;
        this.progressBar.scaleX = this._startAnimateScale + this._currentEaseArray[_loc1_] * this._easeParam;
        this._currentEaseStep = this._currentEaseStep + this._animateRate;
        if (_loc1_ >= this._currentEaseLen) {
            App.utils.scheduler.cancelTask(this.animationStepHandler);
        }
    }

    private function updateTexts():void {
        this.textField.text = this._title;
        this.pointsTextField.text = this._pointsStr;
    }

    public function get sortWeight():Number {
        return this._sortWeight;
    }

    public function set sortWeight(param1:Number):void {
        this._sortWeight = param1;
    }

    public function get id():Number {
        return this._id;
    }

    public function set id(param1:Number):void {
        this._id = param1;
    }

    public function get colorType():String {
        return this._getColorType;
    }

    public function set colorType(param1:String):void {
        this._getColorType = param1;
        this.bg.colorType = param1;
        this.progressBar.colorType = param1;
    }
}
}
