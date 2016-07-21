package net.wg.gui.lobby.battleResults.controller {
import flash.events.IEventDispatcher;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.SortingInfo;
import net.wg.gui.lobby.battleResults.components.TeamStatsList;
import net.wg.gui.lobby.battleResults.data.VictoryPanelVO;
import net.wg.gui.lobby.battleResults.fallout.VictoryScorePanel;

public class FalloutTeamStatsController extends DefaultTeamStatsController {

    private static const FALLOUT_RESOURCE_POINTS:String = "falloutResourcePoints";

    private static const KEY_FALLOUT_RESOURCE_POINTS:String = "falloutResourcePoints";

    private static const FALLOUT_PLAYER_COLUMN_WIDTH:int = 122;

    private static const FALLOUT_STAT_COLUMN_WIDTH:int = 57;

    private var _flagsMode:Boolean;

    public function FalloutTeamStatsController(param1:IEventDispatcher, param2:Boolean) {
        super(param1);
        this._flagsMode = param2;
    }

    override protected function initColumnsData():void {
        super.initColumnsData();
        columnWidth[ColumnConstants.PLAYER] = FALLOUT_PLAYER_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.VICTORY_SCORE] = BATTLE_RESULTS.TEAM_VICTORYSCORE;
        columnWidth[ColumnConstants.VICTORY_SCORE] = FALLOUT_STAT_COLUMN_WIDTH;
        sortingKey[ColumnConstants.VICTORY_SCORE] = [ColumnConstants.KEY_VICTORY_SCORE];
        columnTooltip[ColumnConstants.FLAG] = BATTLE_RESULTS.TEAM_FLAGS;
        columnWidth[ColumnConstants.FLAG] = FALLOUT_STAT_COLUMN_WIDTH;
        sortingKey[ColumnConstants.FLAG] = [ColumnConstants.KEY_FLAGS];
        columnTooltip[FALLOUT_RESOURCE_POINTS] = BATTLE_RESULTS.TEAM_FALLOUTRESOURCEPOINTS;
        columnWidth[FALLOUT_RESOURCE_POINTS] = FALLOUT_STAT_COLUMN_WIDTH;
        sortingKey[FALLOUT_RESOURCE_POINTS] = [KEY_FALLOUT_RESOURCE_POINTS];
        columnTooltip[ColumnConstants.FRAG] = BATTLE_RESULTS.TEAM_FALLOUTFRAGHEADER;
        columnWidth[ColumnConstants.FRAG] = FALLOUT_STAT_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.DAMAGE] = BATTLE_RESULTS.TEAM_DAMAGEANDCONSUMABLESHEADER;
        columnWidth[ColumnConstants.DAMAGE] = FALLOUT_STAT_COLUMN_WIDTH;
        columnWidth[ColumnConstants.XP] = FALLOUT_STAT_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.DEATHS] = BATTLE_RESULTS.TEAM_DEATHS;
        columnWidth[ColumnConstants.DEATHS] = FALLOUT_STAT_COLUMN_WIDTH;
        sortingKey[ColumnConstants.DEATHS] = [ColumnConstants.KEY_DEATHS];
        sortingDirection[ColumnConstants.DEATHS] = SortingInfo.ASCENDING_SORT;
    }

    override protected function getColumnIds():Vector.<String> {
        return new <String>[ColumnConstants.SQUAD, ColumnConstants.PLAYER, ColumnConstants.VICTORY_SCORE, !!this._flagsMode ? ColumnConstants.FLAG : FALLOUT_RESOURCE_POINTS, ColumnConstants.FRAG, ColumnConstants.DAMAGE, ColumnConstants.XP, ColumnConstants.DEATHS];
    }

    override protected function setupRenderers(param1:TeamStatsList, param2:TeamStatsList):void {
        param1.itemRendererName = Linkages.FALLOUT_TEAM_LEFT_RENDERER_UI;
        param2.itemRendererName = Linkages.FALLOUT_TEAM_RIGHT_RENDERER_UI;
    }

    override protected function setupVictoryScore(param1:Vector.<VictoryPanelVO>, param2:VictoryScorePanel, param3:VictoryScorePanel):void {
        param2.visible = true;
        param3.visible = true;
        App.utils.asserter.assert(param1.length == 2, "Victory score expected to have exactly two items instead of " + param1.length);
        param2.setScore(param1[0]);
        param3.setScore(param1[1]);
    }
}
}
