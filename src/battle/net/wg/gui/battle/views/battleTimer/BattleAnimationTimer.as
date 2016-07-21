package net.wg.gui.battle.views.battleTimer {
import flash.display.MovieClip;

import net.wg.data.constants.InvalidationType;
import net.wg.infrastructure.base.meta.IBattleTimerMeta;
import net.wg.infrastructure.base.meta.impl.BattleTimerMeta;

public class BattleAnimationTimer extends BattleTimerMeta implements IBattleTimerMeta {

    public var displayNormal:TimerDisplay = null;

    public var displayCritical:TimerDisplay = null;

    public var background:MovieClip = null;

    private var _currDisplay:TimerDisplay = null;

    private var _isCritical:Boolean = false;

    private var _minutes:String = null;

    private var _seconds:String = null;

    public function BattleAnimationTimer() {
        super();
    }

    override protected function initialize():void {
        this.displayNormal.visible = false;
        this.displayCritical.visible = false;
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.STATE)) {
            if (this._currDisplay) {
                this._currDisplay.visible = false;
            }
            this._currDisplay = !!this._isCritical ? this.displayCritical : this.displayNormal;
            this._currDisplay.visible = true;
        }
        if (isInvalid(InvalidationType.DATA)) {
            this._currDisplay.setTime(this._minutes, this._seconds);
        }
    }

    public function as_setTotalTime(param1:String, param2:String):void {
        this._minutes = param1;
        this._seconds = param2;
        invalidate(InvalidationType.DATA);
    }

    public function as_setColor(param1:Boolean):void {
        if (this._isCritical != param1) {
            if (param1) {
                this.background.play();
            }
            else {
                this.background.gotoAndStop(1);
            }
            this._isCritical = param1;
            isInvalid(InvalidationType.STATE);
            invalidate(InvalidationType.DATA);
        }
    }

    public function as_showBattleTimer(param1:Boolean):void {
        if (visible != param1) {
            visible = param1;
        }
    }

    override protected function onDispose():void {
        this.displayNormal.dispose();
        this.displayCritical.dispose();
        this.displayNormal = null;
        this.displayCritical = null;
        this.background = null;
        this._currDisplay = null;
        super.onDispose();
    }
}
}
