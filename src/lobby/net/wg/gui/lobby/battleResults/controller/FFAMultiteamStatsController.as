package net.wg.gui.lobby.battleResults.controller {
import flash.events.IEventDispatcher;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.SortingInfo;
import net.wg.gui.lobby.battleResults.components.TeamStatsList;

public class FFAMultiteamStatsController extends MultiteamStatsControllerAbstract {

    public function FFAMultiteamStatsController(param1:IEventDispatcher) {
        super(param1);
    }

    override protected function setupListRenderer(param1:TeamStatsList):void {
        param1.itemRendererName = Linkages.FALLOUT_FFA_RENDERER_UI;
    }

    override protected function initColumnsData():void {
        super.initColumnsData();
        columnWidth[ColumnConstants.PLAYER] = ColumnConstants.NARROW_COLUMN_WIDTH * 2 + ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.VICTORY_SCORE] = BATTLE_RESULTS.TEAM_VICTORYSCORE;
        columnWidth[ColumnConstants.VICTORY_SCORE] = ColumnConstants.NARROW_COLUMN_WIDTH;
        sortingKey[ColumnConstants.VICTORY_SCORE] = [ColumnConstants.KEY_VICTORY_SCORE];
        columnTooltip[ColumnConstants.FLAG] = BATTLE_RESULTS.TEAM_FLAGS;
        columnWidth[ColumnConstants.FLAG] = ColumnConstants.FLAG_COLUMN_WIDTH;
        sortingKey[ColumnConstants.FLAG] = [ColumnConstants.KEY_FLAGS];
        columnTooltip[ColumnConstants.DAMAGE] = BATTLE_RESULTS.TEAM_DAMAGEANDCONSUMABLESHEADER;
        columnWidth[ColumnConstants.DAMAGE] = ColumnConstants.WIDE_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.FRAG] = BATTLE_RESULTS.TEAM_FALLOUTFRAGHEADER;
        columnWidth[ColumnConstants.FRAG] = ColumnConstants.MULTITEAM_FRAG_COLUMN_WIDTH;
        columnWidth[ColumnConstants.XP] = ColumnConstants.WIDE_COLUMN_WIDTH;
        sortingKey[ColumnConstants.XP] = [ColumnConstants.KEY_XP, ColumnConstants.KEY_DAMAGE, ColumnConstants.KEY_PLAYER_ID];
        columnTooltip[ColumnConstants.DEATHS] = BATTLE_RESULTS.TEAM_DEATHS;
        columnWidth[ColumnConstants.DEATHS] = ColumnConstants.WIDE_COLUMN_WIDTH;
        sortingKey[ColumnConstants.DEATHS] = [ColumnConstants.KEY_DEATHS];
        sortingDirection[ColumnConstants.DEATHS] = SortingInfo.ASCENDING_SORT;
    }

    override protected function getColumnIds():Vector.<String> {
        return new <String>[ColumnConstants.PLAYER, ColumnConstants.VICTORY_SCORE, ColumnConstants.FLAG, ColumnConstants.DAMAGE, ColumnConstants.FRAG, ColumnConstants.XP, ColumnConstants.DEATHS];
    }
}
}
