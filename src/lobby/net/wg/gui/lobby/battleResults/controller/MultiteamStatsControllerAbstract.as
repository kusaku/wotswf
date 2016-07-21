package net.wg.gui.lobby.battleResults.controller {
import flash.events.IEventDispatcher;

import net.wg.data.constants.Errors;
import net.wg.gui.components.advanced.SortableHeaderButtonBar;
import net.wg.gui.lobby.battleResults.components.TeamStatsList;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.ColumnCollection;
import net.wg.gui.lobby.battleResults.data.ColumnData;
import net.wg.infrastructure.exceptions.AbstractException;

import scaleform.clik.data.DataProvider;

public class MultiteamStatsControllerAbstract extends TeamStatsControllerAbstract {

    private var _teamList:TeamStatsList;

    private var _header:SortableHeaderButtonBar;

    public function MultiteamStatsControllerAbstract(param1:IEventDispatcher) {
        super(param1);
    }

    override protected function setupLists(param1:BattleResultsVO):void {
        this.setupListRenderer(this._teamList);
        setupList(param1.team1, param1.common, this._teamList);
    }

    override protected function setupTeamListHeaders(param1:ColumnCollection, param2:int, param3:String):void {
        this._header.dataProvider = new DataProvider(param1.getHeaderData());
        this._header.selectedIndex = param2;
    }

    override protected function sortLists(param1:ColumnData, param2:Number):void {
        var _loc3_:Array = DataProvider(this._teamList.dataProvider).slice();
        _loc3_.sortOn(param1.sortingKeys, param2);
        this.updateTeamInfo(_loc3_);
        this._teamList.selectedIndex = -1;
        this._teamList.dataProvider = new DataProvider(_loc3_);
    }

    public function setTable(param1:TeamStatsList, param2:SortableHeaderButtonBar):void {
        this._teamList = param1;
        this._header = param2;
    }

    protected function setupListRenderer(param1:TeamStatsList):void {
        throw new AbstractException("MultiteamStatsControllerAbstract.setupListRenderer" + Errors.ABSTRACT_INVOKE);
    }

    protected function updateTeamInfo(param1:Array):void {
    }
}
}
