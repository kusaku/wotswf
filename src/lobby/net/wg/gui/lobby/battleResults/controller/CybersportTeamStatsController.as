package net.wg.gui.lobby.battleResults.controller {
import flash.events.IEventDispatcher;

public class CybersportTeamStatsController extends DefaultTeamStatsController {

    public function CybersportTeamStatsController(param1:IEventDispatcher) {
        super(param1);
    }

    override protected function initColumnsData():void {
        super.initColumnsData();
        columnWidth[ColumnConstants.PLAYER] = ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH + ColumnConstants.FIRST_COLUMN_WIDTH;
    }

    override protected function getColumnIds():Vector.<String> {
        return new <String>[ColumnConstants.PLAYER, ColumnConstants.TANK, ColumnConstants.DAMAGE, ColumnConstants.FRAG, ColumnConstants.XP, ColumnConstants.MEDAL];
    }
}
}
