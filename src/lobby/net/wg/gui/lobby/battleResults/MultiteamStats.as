package net.wg.gui.lobby.battleResults {
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.IEventDispatcher;
import flash.text.TextField;

import net.wg.gui.components.advanced.InteractiveSortingButton;
import net.wg.gui.components.advanced.SortableHeaderButtonBar;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.events.FinalStatisticEvent;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.lobby.battleResults.components.TeamMemberStatsView;
import net.wg.gui.lobby.battleResults.components.TeamStatsList;
import net.wg.gui.lobby.battleResults.controller.DefaultMultiteamStatsController;
import net.wg.gui.lobby.battleResults.controller.FFAMultiteamStatsController;
import net.wg.gui.lobby.battleResults.controller.MultiteamStatsControllerAbstract;
import net.wg.gui.lobby.battleResults.controller.TeamStatsControllerAbstract;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.ColumnCollection;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.gfx.TextFieldEx;

public class MultiteamStats extends UIComponentEx implements IViewStackContent {

    public var header:SortableHeaderButtonBar = null;

    public var teamList:TeamStatsList = null;

    public var teamStats:TeamMemberStatsView = null;

    public var mcScrollBar:ScrollBar = null;

    public var unselectedItemMessage:TextField = null;

    public var unselectedItemBg:DisplayObject = null;

    private var _focusCandidate:InteractiveObject = null;

    private var _columns:ColumnCollection;

    private var _controller:TeamStatsControllerAbstract = null;

    private var _data:BattleResultsVO = null;

    private var _updated:Boolean;

    public function MultiteamStats() {
        this._columns = new ColumnCollection();
        super();
        this.teamStats.list = this.teamList;
    }

    override protected function configUI():void {
        super.configUI();
        this.header.focusable = false;
        this.teamStats.visible = false;
        this.teamList.mouseEnabled = false;
        this.unselectedItemMessage.text = BATTLE_RESULTS.FALLOUT_MULTITEAM_NOPLAYERSELECTED;
        TextFieldEx.setVerticalAlign(this.unselectedItemMessage, TextFieldEx.VALIGN_CENTER);
        this.header.addEventListener(ButtonEvent.CLICK, this.onHeaderClickHandler);
        addEventListener(FinalStatisticEvent.HIDE_STATS_VIEW, this.onHideStatsViewHandler);
        this.teamList.addEventListener(ListEvent.INDEX_CHANGE, this.onIndexChangeHandler);
        this.teamList.addEventListener(ListEventEx.ITEM_CLICK, this.onItemSelectHandler);
    }

    override protected function onDispose():void {
        this.teamStats.removeEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
        this.header.removeEventListener(ButtonEvent.CLICK, this.onHeaderClickHandler);
        removeEventListener(FinalStatisticEvent.HIDE_STATS_VIEW, this.onHideStatsViewHandler);
        this.teamList.removeEventListener(ListEvent.INDEX_CHANGE, this.onIndexChangeHandler);
        this.teamList.removeEventListener(ListEventEx.ITEM_CLICK, this.onItemSelectHandler);
        this.header.dispose();
        this.teamList.dispose();
        this.teamStats.dispose();
        this.mcScrollBar.dispose();
        this._columns.dispose();
        this._controller.dispose();
        this.header = null;
        this.teamList = null;
        this.teamStats = null;
        this.mcScrollBar = null;
        this.unselectedItemMessage = null;
        this.unselectedItemBg = null;
        this._focusCandidate = null;
        this._columns = null;
        this._controller = null;
        this._data = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this._focusCandidate;
    }

    public function update(param1:Object):void {
        this._data = BattleResultsVO(param1);
        if (!this._updated) {
            this._updated = true;
            this._controller = this.createController(this._data.isFreeForAll);
            this._controller.update(this._data);
        }
        var _loc2_:TeamMemberItemVO = this.teamStats.data;
        if (_loc2_ != null && _loc2_.isSelf) {
            this.teamStats.setVehicleIdxInGarageDropdown(this._data.selectedIdxInGarageDropdown);
        }
    }

    protected function createController(param1:Boolean):TeamStatsControllerAbstract {
        var _loc3_:MultiteamStatsControllerAbstract = null;
        var _loc2_:IEventDispatcher = this;
        if (param1) {
            _loc3_ = new FFAMultiteamStatsController(_loc2_);
        }
        else {
            _loc3_ = new DefaultMultiteamStatsController(_loc2_);
        }
        _loc3_.setColumns(this._columns);
        _loc3_.setTable(this.teamList, this.header);
        return _loc3_;
    }

    private function onSelectVehicleDropdownIndexChangeHandler(param1:ListEvent):void {
        this._data.selectedIdxInGarageDropdown = param1.index;
    }

    private function onHeaderClickHandler(param1:ButtonEvent):void {
        var _loc2_:InteractiveSortingButton = null;
        if (param1.target is InteractiveSortingButton) {
            _loc2_ = InteractiveSortingButton(this.header.getButtonAt(this.header.selectedIndex));
            this._controller.onHeaderClick(_loc2_, this.header);
        }
    }

    private function onHideStatsViewHandler(param1:FinalStatisticEvent):void {
        this.teamList.selectedIndex = -1;
    }

    private function onIndexChangeHandler(param1:ListEvent):void {
        var _loc3_:* = false;
        var _loc4_:TeamMemberItemVO = null;
        var _loc2_:int = this.teamList.selectedIndex;
        _loc3_ = _loc2_ != -1;
        this.teamStats.visible = _loc3_;
        this.unselectedItemBg.visible = !_loc3_;
        this.unselectedItemMessage.visible = !_loc3_;
        if (_loc3_) {
            _loc4_ = TeamMemberItemVO(this.teamList.dataProvider[_loc2_]);
            this.teamStats.data = TeamMemberItemVO(_loc4_);
            if (_loc4_.isSelf) {
                this.teamStats.setVehicleIdxInGarageDropdown(this._data.selectedIdxInGarageDropdown);
                this.teamStats.addEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
            }
            else {
                this.teamStats.removeEventListener(ListEvent.INDEX_CHANGE, this.onSelectVehicleDropdownIndexChangeHandler);
                this.teamStats.setVehicleIdxInGarageDropdown(0);
            }
        }
    }

    private function onItemSelectHandler(param1:ListEvent):void {
        if (param1.target.selectedIndex == param1.index) {
            param1.target.selectedIndex = -1;
        }
        this._focusCandidate = InteractiveObject(param1.target);
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }
}
}
