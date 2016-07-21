package net.wg.gui.battle.views.falloutConsumablesPanel.rageBar {
import flash.display.MovieClip;

import net.wg.gui.battle.components.BattleUIComponent;

public class RageBar extends BattleUIComponent {

    private static const HEALTH_BAR_WIDTH:int = 92;

    public var progressBar:MovieClip;

    public var hitSplash:HitSplash;

    private var _maxValue:Number;

    private var _curValue:Number;

    private var _valueBeforeLastHit:Number;

    public function RageBar() {
        super();
        this.hitSplash.visible = false;
    }

    public function set curValue(param1:Number):void {
        this._curValue = param1;
        this._curValue = this._curValue >= 0 ? Number(this._curValue) : Number(0);
        this.updateProgressBar();
    }

    public function set maxValue(param1:Number):void {
        this._maxValue = param1;
        this.updateProgressBar();
    }

    private function updateProgressBar():void {
        var _loc1_:Number = NaN;
        var _loc2_:int = 0;
        if (!isNaN(this._maxValue) && !isNaN(this._curValue)) {
            _loc1_ = this._curValue / this._maxValue;
            _loc2_ = Math.ceil(_loc1_ * (this.progressBar.totalFrames - 1)) + 1;
            this.progressBar.gotoAndStop(_loc2_);
        }
    }

    public function updateProgress(param1:Number):void {
        if (this._maxValue == 0) {
            return;
        }
        if (param1 < 0) {
            param1 = 0;
        }
        if (param1 > this._maxValue) {
            param1 = this._maxValue;
        }
        if (this._curValue >= param1) {
            this.hitSplash.setInActiveState();
            this.curValue = param1;
            this._valueBeforeLastHit = param1;
            return;
        }
        if (!this.hitSplash.isActive) {
            this._valueBeforeLastHit = this._curValue;
        }
        this.curValue = param1;
        this.hitSplash.changeState();
        this.hitSplash.x = this.getXforProgress(this._valueBeforeLastHit);
        this.hitSplash.width = this.getXforProgress(this._curValue) - this.hitSplash.x;
    }

    public function updateProgressDelta(param1:Number):void {
        this.updateProgress(this._curValue + param1);
    }

    private function getXforProgress(param1:Number):int {
        var _loc2_:int = 0;
        if (!isNaN(this._maxValue) && this._maxValue != 0) {
            _loc2_ = Math.ceil(HEALTH_BAR_WIDTH * (param1 / this._maxValue));
        }
        _loc2_ = _loc2_ > 0 ? int(_loc2_) : 0;
        return _loc2_;
    }
}
}
