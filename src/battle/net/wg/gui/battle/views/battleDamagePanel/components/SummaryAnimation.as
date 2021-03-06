package net.wg.gui.battle.views.battleDamagePanel.components {
import flash.display.MovieClip;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class SummaryAnimation extends MovieClip implements IDisposable {

    private var _preCacheAnimation:Boolean = false;

    public function SummaryAnimation() {
        super();
        this.addFrameScript(this.totalFrames - 1, this.frameScriptFunction);
        if (!this._preCacheAnimation) {
            alpha = 0;
            visible = true;
            gotoAndPlay(1);
        }
    }

    public function dispose():void {
        gotoAndStop(1);
    }

    public function frameScriptFunction():void {
        if (!this._preCacheAnimation) {
            visible = false;
            alpha = 1;
            gotoAndStop(1);
            this._preCacheAnimation = true;
        }
        gotoAndStop(1);
        visible = false;
    }

    public function playAnimation():void {
        if (!this.visible) {
            this.visible = true;
        }
        if (currentFrame != 1) {
            gotoAndStop(1);
        }
        gotoAndPlay(1);
    }
}
}
