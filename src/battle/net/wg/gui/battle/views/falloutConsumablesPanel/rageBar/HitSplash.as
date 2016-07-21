package net.wg.gui.battle.views.falloutConsumablesPanel.rageBar {
import flash.display.MovieClip;

public class HitSplash extends MovieClip {

    private static const SHOW_STATE:String = "show";

    private static const ACTIVE_STATE:String = "active";

    private static const HIDE_STATE:String = "hide";

    private static const INACTIVE_STATE:String = "inactive";

    private static const ACTIVE_STATE_FRAME:int = 9;

    private static const INACTIVE_STATE_FRAME:int = 54;

    private var _currentState:String = "inactive";

    public function HitSplash() {
        super();
        visible = false;
        addFrameScript(ACTIVE_STATE_FRAME, this.onActiveFrame);
        addFrameScript(INACTIVE_STATE_FRAME, this.onInActiveFrame);
    }

    private function onActiveFrame():void {
        this._currentState = ACTIVE_STATE;
    }

    private function onInActiveFrame():void {
        this._currentState = INACTIVE_STATE;
        visible = false;
    }

    public function changeState():void {
        var _loc1_:String = this._currentState;
        if (this._currentState == INACTIVE_STATE) {
            visible = true;
            this._currentState = SHOW_STATE;
        }
        else if (this._currentState == ACTIVE_STATE) {
            this.playAnimationState();
        }
        else if (this._currentState == HIDE_STATE) {
            this._currentState = SHOW_STATE;
        }
        if (_loc1_ != this._currentState) {
            this.playAnimationState();
        }
    }

    public function get isActive():Boolean {
        return this._currentState != INACTIVE_STATE;
    }

    public function setInActiveState():void {
        this._currentState = INACTIVE_STATE;
        this.playAnimationState();
    }

    public function playAnimationState():void {
        gotoAndPlay(this._currentState);
    }
}
}
