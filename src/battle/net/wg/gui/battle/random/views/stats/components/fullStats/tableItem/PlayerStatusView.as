package net.wg.gui.battle.random.views.stats.components.fullStats.tableItem {
import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.components.BattleIconHolder;

public class PlayerStatusView extends BattleIconHolder {

    public var inBattle:BattleAtlasSprite = null;

    public var offline:BattleAtlasSprite = null;

    public var killed:BattleAtlasSprite = null;

    public function PlayerStatusView() {
        super();
        this.inBattle.visible = false;
        this.offline.visible = false;
        this.killed.visible = false;
        this.inBattle.imageName = BattleAtlasItem.FULL_STATS_PLAYER_STATUS_IN_BATTLE;
        this.offline.imageName = BattleAtlasItem.FULL_STATS_PLAYER_STATUS_OFFLINE;
        this.killed.imageName = BattleAtlasItem.FULL_STATS_PLAYER_STATUS_KILLED;
    }

    public function showInBattle():void {
        showItem(this.inBattle);
    }

    public function showOffline():void {
        showItem(this.offline);
    }

    public function showKilled():void {
        showItem(this.killed);
    }

    override protected function onDispose():void {
        this.inBattle = null;
        this.offline = null;
        this.killed = null;
        super.onDispose();
    }
}
}
