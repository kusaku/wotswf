package net.wg.gui.battle.views.vehicleMarkers {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.getDefinitionByName;

import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.components.constants.InvalidationType;

public class HealthBar extends BattleUIComponent {

    private static const ORIGINAL_SPLASH_WIDTH_MULT:Number = 1 / 26;

    private static const HEALTH_BAR_WIDTH:int = 70;

    private static const INVALIDATE_COLOR:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    private static const INVALIDATE_BAR:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    private static const HEALTH_PROGRESS_BAR_PREFIX:String = "HealthProgressBar_";

    public var healthBar:MovieClip = null;

    public var hitSplash:HealthBarAnimatedPart = null;

    private var _color:String = "green";

    private var _maxHealth:Number = NaN;

    private var _currHealth:Number = NaN;

    public var isSplashRunning:Boolean = false;

    private var _beforeLastHit:Number = NaN;

    private var _maxHealthMult:Number = NaN;

    public function HealthBar() {
        super();
    }

    override protected function onDispose():void {
        this.hitSplash.removeEventListener(HealthBarAnimatedPart.SHOW, this.onHitSplashShowHandler);
        this.hitSplash.removeEventListener(HealthBarAnimatedPart.HIDE, this.onHitSplashHideHandler);
        this.healthBar = null;
        this.hitSplash.dispose();
        this.hitSplash = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.hitSplash.addEventListener(HealthBarAnimatedPart.SHOW, this.onHitSplashShowHandler);
        this.hitSplash.addEventListener(HealthBarAnimatedPart.HIDE, this.onHitSplashHideHandler);
    }

    override protected function draw():void {
        var _loc1_:String = null;
        var _loc2_:Class = null;
        var _loc3_:MovieClip = null;
        var _loc4_:Number = NaN;
        var _loc5_:int = 0;
        super.draw();
        if (isInvalid(INVALIDATE_COLOR)) {
            if (this.healthBar != null) {
                removeChild(this.healthBar);
            }
            _loc1_ = this._color != VehicleMarkersConstants.COLOR_RED && this._color != VehicleMarkersConstants.COLOR_PURPLE ? VehicleMarkersConstants.COLOR_GREEN : this._color;
            _loc2_ = getDefinitionByName(HEALTH_PROGRESS_BAR_PREFIX + _loc1_) as Class;
            _loc3_ = new _loc2_();
            this.healthBar = addChildAt(_loc3_, 0) as MovieClip;
        }
        if (isInvalid(INVALIDATE_BAR)) {
            if (!isNaN(this._maxHealth) && !isNaN(this._currHealth)) {
                _loc4_ = this._currHealth * this._maxHealthMult;
                _loc5_ = Math.ceil(_loc4_ * (this.healthBar.totalFrames - 1)) + 1;
                this.healthBar.gotoAndStop(_loc5_);
            }
        }
    }

    public function updateHealth(param1:int, param2:String):void {
        if (this._maxHealth == 0) {
            return;
        }
        this.hitSplash.setAnimationType(param2);
        if (!this.isSplashRunning) {
            this._beforeLastHit = this._currHealth;
        }
        this._currHealth = param1;
        this.isSplashRunning = true;
        this.hitSplash.x = this.getXForHealth(this._currHealth, true);
        var _loc3_:int = this.getXForHealth(this._beforeLastHit, false) - this.hitSplash.x;
        this.hitSplash.scaleX = _loc3_ * ORIGINAL_SPLASH_WIDTH_MULT;
        this.hitSplash.playShowTween();
    }

    public function getVisibleWidth():int {
        return this.getXForHealth(Math.min(this._currHealth, this._maxHealth), true);
    }

    private function getXForHealth(param1:int, param2:Boolean):int {
        var _loc4_:Number = NaN;
        var _loc3_:int = 0;
        if (!isNaN(this._maxHealth) && this._maxHealth != 0) {
            _loc4_ = HEALTH_BAR_WIDTH * (param1 * this._maxHealthMult);
            _loc3_ = !!param2 ? _loc4_ >> 0 : int(Math.round(_loc4_));
        }
        return _loc3_ > 0 ? int(_loc3_) : 0;
    }

    public function get color():String {
        return this._color;
    }

    public function set color(param1:String):void {
        if (param1 == this._color) {
            return;
        }
        this._color = param1;
        invalidate(INVALIDATE_COLOR);
    }

    public function get maxHealth():int {
        return this._maxHealth;
    }

    public function set maxHealth(param1:int):void {
        this._maxHealth = param1;
        this._maxHealthMult = 1 / this._maxHealth;
        invalidate(INVALIDATE_BAR);
    }

    public function get currHealth():int {
        return this._currHealth;
    }

    public function set currHealth(param1:int):void {
        this._currHealth = param1;
        this._currHealth = this._currHealth >= 0 ? Number(this._currHealth) : Number(0);
        invalidate(INVALIDATE_BAR);
    }

    private function onHitSplashShowHandler(param1:Event):void {
        invalidate(INVALIDATE_BAR);
    }

    private function onHitSplashHideHandler(param1:Event):void {
        this.isSplashRunning = false;
    }
}
}
