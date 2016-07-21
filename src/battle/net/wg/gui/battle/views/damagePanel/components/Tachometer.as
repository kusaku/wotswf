package net.wg.gui.battle.views.damagePanel.components {
import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.Event;
import flash.text.TextField;
import flash.utils.getTimer;

import net.wg.data.constants.InvalidationType;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.utils.IScheduler;

import scaleform.gfx.TextFieldEx;

public class Tachometer extends BattleUIComponent {

    private static var TACHOMETER_ANGLES_TABLE_STEP:Number = 0.004;

    private static var TACHOMETER_ANGLES_TABLE_STEP_INV:Number = 1 / TACHOMETER_ANGLES_TABLE_STEP;

    private static const ANIM_TARGET_VEL_TABLE_STEP:Number = 0.05;

    private static const ANIM_TARGET_VEL_TABLE_STEP_INV:Number = 1 / ANIM_TARGET_VEL_TABLE_STEP;

    private static const MAX_VEL_FRAME:int = 15;

    private static const EXTRA_VEL_FRAMES:int = 5;

    private static const MAX_RPM:Number = 1.2;

    private static const MAX_RPM_HALF:Number = MAX_RPM * 0.5;

    private static const MAX_RPM_DELTA:Number = MAX_RPM - 1;

    private static const START_RPM_ANGLE:int = -108;

    private static const MAX_RPM_ANGLE:int = 45;

    private static const EXTRA_RPM_ANGLES:int = 63;

    private static const FPS:int = 50;

    private static const MS_TO_FRAMES:Number = FPS / 1000;

    private static const MAX_RPM_UPDATE_TIME:int = 1000;

    private static const MAX_RPM_VEL:Number = 1.4 / FPS;

    private static const RPM_ENGINE_TARGET:Number = 0.5;

    private static const RPM_VEHICLE_START_TARGET:int = 1;

    private static const RPM_ANIM_START_VEL:Number = 3 / FPS;

    private static const RPM_ANIM_ACC:Number = 3 / (FPS * FPS);

    private static const RPM_ANIM_DELAY:int = 150;

    private static const RPM_ENGINE_END_VEL:Number = 0.6 / FPS;

    private static const RPM_VEHICLE_START_END_VEL:Number = 1 / FPS;

    private static const RPM_ANIM_DISTANCE:Number = RPM_ANIM_START_VEL * RPM_ANIM_START_VEL / RPM_ANIM_ACC;

    private static const RPM_ANIM_ACC_2:Number = RPM_ANIM_ACC * 2;

    private static const INVALID_SPEED:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    private static const INVALID_MAX_SPEED:int = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const INVALID_RPM_VIBRATION_INTENSITY:int = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    private static const INVALID_TACHOMETER_ARROW_ROTATION:int = InvalidationType.SYSTEM_FLAGS_BORDER << 4;

    public var speedTF:TextField = null;

    public var maxSpeedTF:TextField = null;

    public var tachometerArrow:MovieClip = null;

    public var speedometer:MovieClip = null;

    private var _speed:int = 0;

    private var _absSpeed:int = 0;

    private var _maxSpeed:int = -1;

    private var _maxAbsSpeed:int = -1;

    private var _speedometerFrame:int = 0;

    private var _rpm:Number = 0;

    private var _rpmV:Number = 0;

    private var _rpmTarget:Number = 0;

    private var _rpmUpdateTime:Number = 0;

    private var _rpmAnim:Number = 0;

    private var _rpmAnimV:Number = 0;

    private var _rpmAnimTarget:Number = 0;

    private var _rpmAnimTargetVel:Number = 0;

    private var _rpmAnimEndVel:Number = 0;

    private var _rpmAnimActive:Boolean = false;

    private var _rpmVibrationIntensity:int = 0;

    private var _tachometerArrowRotation:Number = -108;

    private var _stage:Stage;

    private var _scheduler:IScheduler;

    private var _tachometerAnglesTable:Vector.<Number>;

    private var _tachometerAnglesTableLength:int = 0;

    private var _animTargetVelTable:Vector.<Number>;

    private var _rpmVibrationFrames:Vector.<String>;

    public function Tachometer() {
        this._stage = App.stage;
        this._scheduler = App.utils.scheduler;
        this._tachometerAnglesTable = new Vector.<Number>();
        this._animTargetVelTable = new Vector.<Number>();
        this._rpmVibrationFrames = new <String>["healthy", "sick1", "sick2", "sick3"];
        super();
        TextFieldEx.setNoTranslate(this.speedTF, true);
        TextFieldEx.setNoTranslate(this.maxSpeedTF, true);
        this.initPrecalculatedTables();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_SPEED)) {
            this.speedTF.text = String(this._speed);
            this.speedometer.gotoAndStop(this._speedometerFrame);
        }
        if (isInvalid(INVALID_MAX_SPEED)) {
            this.maxSpeedTF.text = String(this._maxSpeed);
        }
        if (isInvalid(INVALID_RPM_VIBRATION_INTENSITY)) {
            this.tachometerArrow.gotoAndPlay(this._rpmVibrationFrames[this._rpmVibrationIntensity]);
        }
        if (isInvalid(INVALID_TACHOMETER_ARROW_ROTATION)) {
            this.tachometerArrow.rotation = this._tachometerArrowRotation;
        }
    }

    public function reset():void {
        this.updateSpeed(0);
        this.setNormalizedEngineRpm(0);
    }

    public function updateSpeed(param1:int):void {
        if (this._speed != param1) {
            this._speed = param1;
            this._absSpeed = Math.abs(this._speed);
            this._speedometerFrame = Math.floor(this.convertValue(this._absSpeed, this._maxAbsSpeed, EXTRA_VEL_FRAMES, 1, MAX_VEL_FRAME, EXTRA_VEL_FRAMES));
            invalidate(INVALID_SPEED);
        }
    }

    public function setMaxSpeed(param1:int):void {
        this._maxSpeed = param1;
        this._maxAbsSpeed = Math.abs(this._maxSpeed);
        invalidate(INVALID_MAX_SPEED);
    }

    public function setNormalizedEngineRpm(param1:Number):void {
        var _loc3_:Number = NaN;
        var _loc2_:Number = getTimer() * MS_TO_FRAMES;
        if (this._rpmTarget != param1) {
            _loc3_ = Math.min(_loc2_ - this._rpmUpdateTime, MAX_RPM_UPDATE_TIME);
            this._rpmV = (param1 - this._rpm) / _loc3_;
            this._rpmV = Math.min(MAX_RPM_VEL, this._rpmV);
            this._rpmV = Math.max(-MAX_RPM_VEL, this._rpmV);
            if (!this._rpmAnimActive) {
                this._rpmTarget = param1;
                this.removeStageEventListeners();
                this._stage.addEventListener(Event.ENTER_FRAME, this.updateTachometer);
            }
            else {
                this._rpmTarget = param1;
            }
        }
        this._rpmUpdateTime = _loc2_;
    }

    public function setRpmVibration(param1:int):void {
        this._rpmVibrationIntensity = param1;
        invalidate(INVALID_RPM_VIBRATION_INTENSITY);
    }

    public function playEngineStartAnim():void {
        this.playRpmAnim(RPM_ENGINE_TARGET, RPM_ENGINE_END_VEL);
    }

    public function startVehicleStartAnim():void {
        this.playRpmAnim(RPM_VEHICLE_START_TARGET, RPM_VEHICLE_START_END_VEL);
    }

    public function finishVehicleStartAnim():void {
        this.finishRpmAnim();
    }

    private function initPrecalculatedTables():void {
        var _loc1_:int = 0;
        var _loc2_:Number = 0;
        do
        {
            this._tachometerAnglesTable[_loc1_++] = this.convertValue(_loc2_, 1, MAX_RPM_DELTA, START_RPM_ANGLE, MAX_RPM_ANGLE, EXTRA_RPM_ANGLES);
            _loc2_ = _loc2_ + TACHOMETER_ANGLES_TABLE_STEP;
        }
        while (_loc2_ <= MAX_RPM);

        this._tachometerAnglesTableLength = this._tachometerAnglesTable.length - 1;
        _loc1_ = 0;
        _loc2_ = 0;
        do
        {
            this._animTargetVelTable[_loc1_++] = Math.sqrt(_loc2_ * RPM_ANIM_ACC_2);
            _loc2_ = _loc2_ + ANIM_TARGET_VEL_TABLE_STEP;
        }
        while (_loc2_ <= MAX_RPM_HALF);

    }

    private function updateTachometer(param1:Event):void {
        var _loc2_:Number = NaN;
        if (this._rpmV != 0) {
            this._rpm = this._rpm + this._rpmV;
            _loc2_ = this._rpmV;
            if (_loc2_ > 0) {
                this._rpm = Math.min(this._rpmTarget, this._rpm);
            }
            else {
                this._rpm = Math.max(this._rpmTarget, this._rpm);
            }
        }
        this._tachometerArrowRotation = this.getTachometerAngel(this._rpm * TACHOMETER_ANGLES_TABLE_STEP_INV >> 0);
        invalidate(INVALID_TACHOMETER_ARROW_ROTATION);
        if (this._rpm == this._rpmTarget) {
            this._rpmAnimActive = false;
            this.removeStageEventListeners();
        }
    }

    private function convertValue(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number):Number {
        var _loc7_:Number = NaN;
        var _loc8_:Number = param1 - param2;
        if (_loc8_ <= 0) {
            _loc7_ = param4 + param1 / param2 * (param5 - param4);
        }
        else if (_loc8_ < param3) {
            _loc7_ = param5 + _loc8_ / param3 * param6;
        }
        else {
            _loc7_ = param5 + param6;
        }
        return _loc7_;
    }

    private function playRpmAnim(param1:Number, param2:Number):void {
        var _loc3_:Number = !!this._rpmAnimActive ? Number(this._rpmAnim) : Number(this._rpm);
        var _loc4_:Number = (param1 - _loc3_) * 0.5;
        if (_loc4_ > 0) {
            this._scheduler.cancelTask(this.startRpmAnimFinal);
            this._rpmAnim = _loc3_;
            this._rpmAnimV = !!this._rpmAnimActive ? Number(this._rpmAnimV) : Number(0);
            this._rpmAnimEndVel = param2;
            this._rpmAnimActive = true;
            if (_loc4_ < RPM_ANIM_DISTANCE) {
                this._rpmAnimTargetVel = this._animTargetVelTable[_loc4_ * ANIM_TARGET_VEL_TABLE_STEP_INV >> 0];
            }
            else {
                this._rpmAnimTargetVel = RPM_ANIM_START_VEL;
            }
            this._rpmAnimTarget = param1 - _loc4_;
            this.removeStageEventListeners();
            this._stage.addEventListener(Event.ENTER_FRAME, this.updateRpmAnim);
        }
    }

    private function finishRpmAnim():void {
        if (this._rpmAnimActive) {
            this._scheduler.cancelTask(this.startRpmAnimFinal);
            this._rpmAnimTargetVel = this._rpmAnimEndVel;
            this.removeStageEventListeners();
            this._stage.addEventListener(Event.ENTER_FRAME, this.updateRpmAnimFinal);
        }
    }

    private function updateRpmAnim(param1:Event):void {
        if (this._rpmAnimV < this._rpmAnimTargetVel) {
            this._rpmAnimV = this._rpmAnimV + RPM_ANIM_ACC;
            this._rpmAnimV = Math.min(this._rpmAnimTargetVel, this._rpmAnimV);
        }
        this._rpmAnim = this._rpmAnim + this._rpmAnimV;
        this._tachometerArrowRotation = this.getTachometerAngel(this._rpmAnim * TACHOMETER_ANGLES_TABLE_STEP_INV >> 0);
        invalidate(INVALID_TACHOMETER_ARROW_ROTATION);
        if (this._rpmAnim >= this._rpmAnimTarget) {
            this._rpmAnimTargetVel = 0;
            this.removeStageEventListeners();
            this._stage.addEventListener(Event.ENTER_FRAME, this.updateRpmAnimDeceleration);
        }
    }

    private function updateRpmAnimDeceleration(param1:Event):void {
        if (this._rpmAnimV > this._rpmAnimTargetVel) {
            this._rpmAnimV = this._rpmAnimV - RPM_ANIM_ACC;
            this._rpmAnimV = Math.max(this._rpmAnimTargetVel, this._rpmAnimV);
        }
        this._rpmAnim = this._rpmAnim + this._rpmAnimV;
        this._tachometerArrowRotation = this.getTachometerAngel(this._rpmAnim * TACHOMETER_ANGLES_TABLE_STEP_INV >> 0);
        invalidate(INVALID_TACHOMETER_ARROW_ROTATION);
        if (this._rpmAnimV <= this._rpmAnimTargetVel) {
            this._scheduler.scheduleTask(this.startRpmAnimFinal, RPM_ANIM_DELAY);
            this.removeStageEventListeners();
        }
    }

    private function startRpmAnimFinal():void {
        this._rpmAnimTargetVel = this._rpmAnimEndVel;
        this.removeStageEventListeners();
        this._stage.addEventListener(Event.ENTER_FRAME, this.updateRpmAnimFinal);
    }

    private function updateRpmAnimFinal(param1:Event):void {
        var _loc4_:Number = NaN;
        var _loc2_:Number = this._rpmTarget - this._rpmAnim;
        var _loc3_:Number = Math.abs(this._rpmAnimV);
        if (Math.abs(_loc2_) <= _loc3_ && _loc3_ <= RPM_ANIM_ACC_2) {
            this.onRpmAnimFinished();
        }
        else {
            _loc4_ = this._rpmAnimV * this._rpmAnimV / RPM_ANIM_ACC_2;
            if (this._rpmAnimV < 0) {
                _loc4_ = _loc4_ * -1;
            }
            if (_loc4_ > _loc2_) {
                this._rpmAnimV = this._rpmAnimV - RPM_ANIM_ACC;
                this._rpmAnimV = Math.max(-this._rpmAnimTargetVel, this._rpmAnimV);
            }
            else {
                this._rpmAnimV = this._rpmAnimV + RPM_ANIM_ACC;
                this._rpmAnimV = Math.min(this._rpmAnimTargetVel, this._rpmAnimV);
            }
            this._rpmAnim = this._rpmAnim + this._rpmAnimV;
            this._tachometerArrowRotation = this.getTachometerAngel(this._rpmAnim * TACHOMETER_ANGLES_TABLE_STEP_INV >> 0);
            invalidate(INVALID_TACHOMETER_ARROW_ROTATION);
        }
    }

    private function getTachometerAngel(param1:int):Number {
        return this._tachometerAnglesTable[param1 < this._tachometerAnglesTableLength ? param1 : this._tachometerAnglesTableLength];
    }

    private function onRpmAnimFinished():void {
        this._rpm = this._rpmAnim;
        this.removeStageEventListeners();
        if (this._rpm != this._rpmTarget) {
            this._stage.addEventListener(Event.ENTER_FRAME, this.updateTachometer);
        }
        else {
            this._rpmAnimActive = false;
        }
    }

    private function removeStageEventListeners():void {
        this._stage.removeEventListener(Event.ENTER_FRAME, this.updateTachometer);
        this._stage.removeEventListener(Event.ENTER_FRAME, this.updateRpmAnim);
        this._stage.removeEventListener(Event.ENTER_FRAME, this.updateRpmAnimFinal);
        this._stage.removeEventListener(Event.ENTER_FRAME, this.updateRpmAnimDeceleration);
    }

    override protected function onDispose():void {
        this._scheduler.cancelTask(this.startRpmAnimFinal);
        this.removeStageEventListeners();
        this.speedTF = null;
        this.maxSpeedTF = null;
        this.tachometerArrow = null;
        this.speedometer = null;
        this._stage = null;
        this._scheduler = null;
        this._tachometerAnglesTable.splice(0, this._tachometerAnglesTable.length);
        this._tachometerAnglesTable = null;
        this._animTargetVelTable.splice(0, this._animTargetVelTable.length);
        this._animTargetVelTable = null;
        this._rpmVibrationFrames.splice(0, this._rpmVibrationFrames.length);
        this._rpmVibrationFrames = null;
        super.onDispose();
    }
}
}
