package net.wg.gui.battle.components.falloutScorePanel {
import net.wg.data.constants.InvalidationType;
import net.wg.gui.battle.components.BattleUIComponent;

public class BarGlowAnimation extends BattleUIComponent {

    private static const ANIM_LOOP_COUNT:int = 3;

    private static const SHOW_FRAME:String = "show";

    private static const HIDE_FRAME:String = "hide";

    private static const BORDER_OFFSET:int = 16;

    private static const DOUBLE_BORDER_OFFSET:int = BORDER_OFFSET << 1;

    private static const SHOW_STATE_ID:int = 0;

    private static const HIDE_STATE_ID:int = 1;

    private var _loopCount:int = 0;

    private var _refPosX:int = -1;

    private var _refWidth:int = -1;

    private var _stateId:int = 1;

    public function BarGlowAnimation() {
        super();
        addFrameScript(54, this.onAnimFinished);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.STATE)) {
            if (this._stateId == SHOW_STATE_ID) {
                visible = true;
                gotoAndPlay(SHOW_FRAME);
            }
            else {
                visible = false;
                gotoAndStop(HIDE_FRAME);
            }
        }
        if (isInvalid(InvalidationType.POSITION)) {
            x = this._refPosX;
            width = this._refWidth;
        }
    }

    public function show():void {
        this._loopCount = ANIM_LOOP_COUNT;
        this.setState(SHOW_STATE_ID);
    }

    public function setState(param1:int):void {
        this._stateId = param1;
        invalidate(InvalidationType.STATE);
    }

    private function onAnimFinished():void {
        if (--this._loopCount > 0) {
            this.setState(SHOW_STATE_ID);
        }
        else {
            this.setState(HIDE_STATE_ID);
        }
    }

    public function updatePosition(param1:int, param2:int):void {
        if (this._stateId == SHOW_STATE_ID) {
            this._refWidth = param2 + DOUBLE_BORDER_OFFSET;
            this._refPosX = param1 - BORDER_OFFSET;
            invalidate(InvalidationType.POSITION);
        }
    }
}
}
