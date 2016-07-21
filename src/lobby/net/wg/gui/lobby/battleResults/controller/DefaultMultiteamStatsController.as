package net.wg.gui.lobby.battleResults.controller {
import flash.events.IEventDispatcher;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.Values;
import net.wg.gui.lobby.battleResults.components.TeamStatsList;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;

public class DefaultMultiteamStatsController extends MultiteamStatsControllerAbstract {

    public function DefaultMultiteamStatsController(param1:IEventDispatcher) {
        super(param1);
    }

    override protected function setupListRenderer(param1:TeamStatsList):void {
        param1.itemRendererName = Linkages.FALLOUT_MULTITEAM_RENDERER_UI;
    }

    override protected function initColumnsData():void {
        columnTooltip[ColumnConstants.SQUAD] = BATTLE_RESULTS.TEAM_SQUADHEADERNOSORT;
        columnWidth[ColumnConstants.SQUAD] = ColumnConstants.NARROW_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.COLUMN_ID_TEAM_SCORE] = BATTLE_RESULTS.TEAM_TEAMSCORE;
        columnWidth[ColumnConstants.COLUMN_ID_TEAM_SCORE] = ColumnConstants.NARROW_COLUMN_WIDTH;
        sortingKey[ColumnConstants.COLUMN_ID_TEAM_SCORE] = [ColumnConstants.KEY_TEAM_SCORE, ColumnConstants.KEY_SQUAD_ID, ColumnConstants.VICTORY_SCORE, ColumnConstants.KEY_DAMAGE, ColumnConstants.KEY_XP, ColumnConstants.KEY_PLAYER_ID];
        sortingDirection[ColumnConstants.COLUMN_ID_TEAM_SCORE] = SortingInfo.ASCENDING_SORT;
        columnTooltip[ColumnConstants.PLAYER] = BATTLE_RESULTS.TEAM_PLAYERHEADERNOSORT;
        columnWidth[ColumnConstants.PLAYER] = ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.VICTORY_SCORE] = BATTLE_RESULTS.TEAM_VICTORYSCORENOSORT;
        columnWidth[ColumnConstants.VICTORY_SCORE] = ColumnConstants.NARROW_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.FLAG] = BATTLE_RESULTS.TEAM_FLAGSNOSORT;
        columnWidth[ColumnConstants.FLAG] = ColumnConstants.FLAG_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.DAMAGE] = BATTLE_RESULTS.TEAM_DAMAGEHEADERNOSORT;
        columnWidth[ColumnConstants.DAMAGE] = ColumnConstants.WIDE_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.FRAG] = BATTLE_RESULTS.TEAM_FRAGHEADERNOSORT;
        columnWidth[ColumnConstants.FRAG] = ColumnConstants.MULTITEAM_FRAG_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.XP] = BATTLE_RESULTS.TEAM_XPHEADERNOSORT;
        columnWidth[ColumnConstants.XP] = ColumnConstants.WIDE_COLUMN_WIDTH;
        columnTooltip[ColumnConstants.DEATHS] = BATTLE_RESULTS.TEAM_DEATHSNOSORT;
        columnWidth[ColumnConstants.DEATHS] = ColumnConstants.WIDE_COLUMN_WIDTH;
    }

    override protected function getColumnIds():Vector.<String> {
        return new <String>[ColumnConstants.SQUAD, ColumnConstants.COLUMN_ID_TEAM_SCORE, ColumnConstants.PLAYER, ColumnConstants.VICTORY_SCORE, ColumnConstants.FLAG, ColumnConstants.DAMAGE, ColumnConstants.FRAG, ColumnConstants.XP, ColumnConstants.DEATHS];
    }

    override protected function updateTeamInfo(param1:Array):void {
        var _loc7_:TeamMemberItemVO = null;
        var _loc2_:int = 1;
        var _loc3_:int = param1.length;
        var _loc4_:int = Values.DEFAULT_INT;
        var _loc5_:int = Values.DEFAULT_INT;
        var _loc6_:int = 0;
        while (_loc6_ < _loc3_) {
            _loc7_ = TeamMemberItemVO(param1[_loc6_]);
            if (_loc7_.squadID <= 0) {
                _loc7_.showTeamDivider = true;
                _loc7_.showTeamInfo = true;
            }
            else if (_loc4_ != _loc7_.squadID) {
                _loc7_.showTeamDivider = true;
                _loc7_.showTeamInfo = false;
                _loc5_ = 0;
            }
            else {
                _loc7_.showTeamDivider = false;
                _loc5_ = _loc5_ + 1;
                _loc7_.showTeamInfo = _loc5_ == _loc2_;
            }
            _loc4_ = _loc7_.squadID;
            _loc6_++;
        }
    }
}
}
