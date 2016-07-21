package net.wg.gui.battle.components.falloutScorePanel {
import flash.text.TextField;

public class FalloutClassicScorePanel extends FalloutBaseScorePanel {

    private static const INVALID_PLAYER_SCORE:String = "invalidPlayerScore";

    public var playerScoreTF:TextField = null;

    public var playerScoreLbl:TextField = null;

    private var _currentPlayerScore:int = 0;

    public function FalloutClassicScorePanel() {
        super();
        this.playerScoreLbl.text = INGAME_GUI.SCOREPANEL_PLAYERSCORE;
    }

    override public function setPlayerScore(param1:int):void {
        if (this._currentPlayerScore != param1) {
            this._currentPlayerScore = param1;
            invalidate(INVALID_PLAYER_SCORE);
        }
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_PLAYER_SCORE)) {
            this.playerScoreTF.text = this._currentPlayerScore.toString();
        }
    }

    override protected function onDispose():void {
        this.playerScoreTF = null;
        this.playerScoreLbl = null;
        super.onDispose();
    }
}
}
