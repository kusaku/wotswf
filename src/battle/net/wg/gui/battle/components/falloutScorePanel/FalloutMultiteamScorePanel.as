package net.wg.gui.battle.components.falloutScorePanel {
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.battle.views.stats.StatsUserProps;

public class FalloutMultiteamScorePanel extends FalloutBaseScorePanel {

    private static const INVALID_PLAYER_NAME:String = "invalidPlayerScore";

    private static const INVALID_ENEMY_NAME:String = "invalidEnemyScore";

    public var playerNameTF:TextField = null;

    public var enemyNameTF:TextField = null;

    private var _statsUserProps:StatsUserProps;

    private var _playerTeamName:String = "";

    private var _enemyTeamName:String = "";

    public function FalloutMultiteamScorePanel() {
        this._statsUserProps = new StatsUserProps(Values.EMPTY_STR, Values.EMPTY_STR, Values.EMPTY_STR, 0, []);
        super();
    }

    override public function setPlayerName(param1:String):void {
        if (this._playerTeamName != param1) {
            this._playerTeamName = param1;
            invalidate(INVALID_PLAYER_NAME);
        }
    }

    override public function setEnemyName(param1:String):void {
        if (this._enemyTeamName != param1) {
            this._enemyTeamName = param1;
            invalidate(INVALID_ENEMY_NAME);
        }
    }

    override protected function onDispose():void {
        this._statsUserProps.dispose();
        this._statsUserProps = null;
        this.playerNameTF = null;
        this.enemyNameTF = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_PLAYER_NAME)) {
            this._statsUserProps.userName = this._playerTeamName;
            App.utils.commons.formatPlayerName(this.playerNameTF, this._statsUserProps);
        }
        if (isInvalid(INVALID_ENEMY_NAME)) {
            this._statsUserProps.userName = this._enemyTeamName;
            App.utils.commons.formatPlayerName(this.enemyNameTF, this._statsUserProps);
        }
    }
}
}
