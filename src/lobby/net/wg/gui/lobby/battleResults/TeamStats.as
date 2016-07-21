package net.wg.gui.lobby.battleResults {
import flash.display.InteractiveObject;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.ArenaBonusTypes;
import net.wg.gui.components.advanced.InteractiveSortingButton;
import net.wg.gui.components.advanced.SortableHeaderButtonBar;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.events.FinalStatisticEvent;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.lobby.battleResults.components.SortieTeamStatsController;
import net.wg.gui.lobby.battleResults.components.TeamMemberStatsView;
import net.wg.gui.lobby.battleResults.components.TeamStatsList;
import net.wg.gui.lobby.battleResults.controller.CybersportTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.DefaultTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.FalloutTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.FortTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.RatedCybersportTeamStatsController;
import net.wg.gui.lobby.battleResults.cs.CsTeamStats;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.ColumnCollection;
import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
import net.wg.gui.lobby.battleResults.fallout.VictoryScorePanel;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IViewStackContent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;

public class TeamStats extends UIComponentEx implements IViewStackContent {

    private static const FLAGS_FALLOUT_MODE:String = "flags";

    public var team1List:TeamStatsList = null;

    public var team2List:TeamStatsList = null;

    public var team1Stats:TeamMemberStatsView = null;

    public var team2Stats:TeamMemberStatsView = null;

    public var ownTitle:TextField = null;

    public var enemyTitle:TextField = null;

    public var header1:SortableHeaderButtonBar = null;

    public var header2:SortableHeaderButtonBar = null;

    public var victoryScore1:VictoryScorePanel = null;

    public var victoryScore2:VictoryScorePanel = null;

    public var teamResourceTotal:TextField = null;

    public var teamInfluenceTotal:TextField = null;

    public var csEnemy:CsTeamStats = null;

    public var csAlly:CsTeamStats = null;

    private var _focusCandidate:InteractiveObject = null;

    private var _data:BattleResultsVO;

    private var _columns:ColumnCollection;

    private var _controller:DefaultTeamStatsController;

    public function TeamStats() {
        this._columns = new ColumnCollection();
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.header1.tabEnabled = false;
        this.header1.focusable = false;
        this.header2.tabEnabled = false;
        this.header2.focusable = false;
        this.team1Stats.list = this.team1List;
        this.team2Stats.list = this.team2List;
        this.team2Stats.visible = this.team1Stats.visible = false;
        this.team1List.mouseEnabled = this.team2List.mouseEnabled = false;
        this.header1.addEventListener(ButtonEvent.CLICK, this.onHeaderClickHandler);
        this.header2.addEventListener(ButtonEvent.CLICK, this.onHeaderClickHandler);
        addEventListener(FinalStatisticEvent.HIDE_STATS_VIEW, this.onThisHideStatsViewHandler);
        this.team1List.addEventListener(ListEvent.INDEX_CHANGE, this.onTeamListIndexChangeHandler);
        this.team2List.addEventListener(ListEvent.INDEX_CHANGE, this.onTeamListIndexChangeHandler);
        this.team1List.addEventListener(ListEventEx.ITEM_CLICK, this.onTeamListItemClickHandler);
        this.team2List.addEventListener(ListEventEx.ITEM_CLICK, this.onTeamListItemClickHandler);
        this.teamResourceTotal.autoSize = TextFieldAutoSize.RIGHT;
        this.teamInfluenceTotal.autoSize = TextFieldAutoSize.RIGHT;
    }

    override protected function onDispose():void {
        this.team1Stats.removeEventListener(ListEvent.INDEX_CHANGE, this.onTeam1StatsIndexChangeHandler);
        this.header1.removeEventListener(ButtonEvent.CLICK, this.onHeaderClickHandler);
        this.header2.removeEventListener(ButtonEvent.CLICK, this.onHeaderClickHandler);
        this.team1List.removeEventListener(ListEvent.INDEX_CHANGE, this.onTeamListIndexChangeHandler);
        this.team1List.removeEventListener(ListEventEx.ITEM_CLICK, this.onTeamListItemClickHandler);
        this.team2List.removeEventListener(ListEvent.INDEX_CHANGE, this.onTeamListIndexChangeHandler);
        this.team2List.removeEventListener(ListEventEx.ITEM_CLICK, this.onTeamListItemClickHandler);
        removeEventListener(FinalStatisticEvent.HIDE_STATS_VIEW, this.onThisHideStatsViewHandler);
        this.team1List.dispose();
        this.team2List.dispose();
        this.team1Stats.dispose();
        this.team2Stats.dispose();
        this.header1.dispose();
        this.header2.dispose();
        this.victoryScore1.dispose();
        this.victoryScore2.dispose();
        this.csEnemy.dispose();
        this.csAlly.dispose();
        this._columns.dispose();
        this._controller.dispose();
        this.team1List = null;
        this.team2List = null;
        this.team1Stats = null;
        this.team2Stats = null;
        this.ownTitle = null;
        this.enemyTitle = null;
        this.header1 = null;
        this.header2 = null;
        this.victoryScore1 = null;
        this.victoryScore2 = null;
        this.teamResourceTotal = null;
        this.teamInfluenceTotal = null;
        this.csEnemy = null;
        this.csAlly = null;
        this._focusCandidate = null;
        this._data = null;
        this._columns = null;
        this._controller = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return InteractiveObject(this._focusCandidate);
    }

    public function update(param1:Object):void {
        if (this._data == null) {
            this._data = BattleResultsVO(param1);
            this.createController(this._data.common);
            this._controller.update(this._data);
            this.team1Stats.isCloseBtnVisible = this._data.closingTeamMemberStatsEnabled;
            this.team2Stats.isCloseBtnVisible = this._data.closingTeamMemberStatsEnabled;
        }
        var _loc2_:TeamMemberItemVO = this.team1Stats.data;
        if (_loc2_ != null && _loc2_.isSelf) {
            this.team1Stats.setVehicleIdxInGarageDropdown(this._data.selectedIdxInGarageDropdown);
        }
        this.team1Stats.invalidateMedalsListData();
        this.team2Stats.invalidateMedalsListData();
    }

    private function createController(param1:CommonStatsVO):void {
        if (StringUtils.isNotEmpty(param1.falloutMode)) {
            this._controller = new FalloutTeamStatsController(this, param1.falloutMode == FLAGS_FALLOUT_MODE);
        }
        else {
            switch (param1.bonusType) {
                case ArenaBonusTypes.FORT_BATTLE:
                    this._controller = new FortTeamStatsController(this);
                    break;
                case ArenaBonusTypes.SORTIE:
                    this._controller = new SortieTeamStatsController(this);
                    break;
                case ArenaBonusTypes.CYBERSPORT:
                    this._controller = new CybersportTeamStatsController(this);
                    break;
                case ArenaBonusTypes.RATED_CYBERSPORT:
                    this._controller = new RatedCybersportTeamStatsController(this);
                    break;
                default:
                    this._controller = new DefaultTeamStatsController(this);
            }
        }
        this._controller.setColumns(this._columns);
        this._controller.setTables(this.header1, this.header2, this.team1List, this.team2List);
        this._controller.setTitles(this.ownTitle, this.enemyTitle);
        this._controller.setCybersport(this.csAlly, this.csEnemy);
        this._controller.setResources(this.teamResourceTotal, this.teamInfluenceTotal);
        this._controller.setVictoryScore(this.victoryScore1, this.victoryScore2);
    }

    private function onTeam1StatsIndexChangeHandler(param1:ListEvent):void {
        this._data.selectedIdxInGarageDropdown = param1.index;
    }

    private function onThisHideStatsViewHandler(param1:FinalStatisticEvent):void {
        this.team1List.selectedIndex = -1;
        this.team2List.selectedIndex = -1;
    }

    private function onTeamListItemClickHandler(param1:ListEvent):void {
        var _loc4_:TeamMemberItemVO = null;
        var _loc2_:int = param1.index;
        var _loc3_:ScrollingListEx = ScrollingListEx(param1.target);
        if (this._data.closingTeamMemberStatsEnabled && _loc3_.selectedIndex == _loc2_) {
            _loc3_.selectedIndex = -1;
        }
        if (_loc3_ == this.team1List) {
            _loc4_ = TeamMemberItemVO(this.team1List.dataProvider[_loc2_]);
            if (_loc4_.isSelf) {
                this.team1Stats.setVehicleIdxInGarageDropdown(this._data.selectedIdxInGarageDropdown);
                this.team1Stats.addEventListener(ListEvent.INDEX_CHANGE, this.onTeam1StatsIndexChangeHandler);
            }
            else {
                this.team1Stats.removeEventListener(ListEvent.INDEX_CHANGE, this.onTeam1StatsIndexChangeHandler);
                this.team1Stats.setVehicleIdxInGarageDropdown(0);
            }
        }
        else {
            this.team2Stats.setVehicleIdxInGarageDropdown(0);
        }
        this._focusCandidate = _loc3_;
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    private function onTeamListIndexChangeHandler(param1:ListEvent):void {
        this._controller.handleListIndexChange(ScrollingListEx(param1.target), this.team1Stats, this.team2Stats, this._data);
    }

    private function onHeaderClickHandler(param1:ButtonEvent):void {
        var _loc2_:Object = param1.target;
        if (_loc2_ is InteractiveSortingButton) {
            this._controller.onHeaderClick(InteractiveSortingButton(_loc2_), SortableHeaderButtonBar(param1.currentTarget));
        }
    }
}
}
