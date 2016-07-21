package net.wg.gui.lobby.fortifications.windows {
import flash.display.DisplayObject;
import flash.display.MovieClip;

import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.PeriodDefenceStatisticForm;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.SortieStatisticsForm;
import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
import net.wg.infrastructure.base.meta.IFortClanStatisticsWindowMeta;
import net.wg.infrastructure.base.meta.impl.FortClanStatisticsWindowMeta;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class FortClanStatisticsWindow extends FortClanStatisticsWindowMeta implements IFortClanStatisticsWindowMeta {

    public var sortieForm:SortieStatisticsForm;

    public var periodDefenceForm:PeriodDefenceStatisticForm;

    public var tabs:ContentTabBar;

    public var mcLineAsset:MovieClip;

    private var _tabsDependencies:Vector.<DisplayObject> = null;

    private var _model:ClanStatsVO;

    private var _emptyMCHitArea:MovieClip;

    public function FortClanStatisticsWindow() {
        super();
        isModal = false;
        isCentered = true;
        this._emptyMCHitArea = new MovieClip();
        this._tabsDependencies = new <DisplayObject>[this.sortieForm];
    }

    override protected function setData(param1:ClanStatsVO):void {
        this._model = param1;
        invalidateData();
    }

    override protected function configUI():void {
        super.configUI();
        this.mcLineAsset.hitArea = this._emptyMCHitArea;
    }

    override protected function draw():void {
        super.draw();
        if (this._model && isInvalid(InvalidationType.DATA)) {
            window.title = App.utils.locale.makeString(FORTIFICATIONS.FORTCLANSTATISTICSWINDOW_TITLE, {"clanName": this._model.clanName});
            this.sortieForm.model = this._model;
            this.periodDefenceForm.model = this._model;
        }
    }

    override protected function onDispose():void {
        this.sortieForm.dispose();
        this.sortieForm = null;
        this.periodDefenceForm.dispose();
        this.periodDefenceForm = null;
        this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        this.tabs.dispose();
        this.tabs = null;
        this._tabsDependencies.splice(0, this._tabsDependencies.length);
        this._tabsDependencies = null;
        this.mcLineAsset = null;
        this._emptyMCHitArea = null;
        this._model = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        var _loc1_:DataProvider = new DataProvider();
        _loc1_.push({"label": FORTIFICATIONS.CLANSTATS_TABS_BUTTONLBL_SORTIE});
        _loc1_.push({"label": FORTIFICATIONS.CLANSTATS_TABS_BUTTONLBL_PERIODDEFENCE});
        this._tabsDependencies.push(this.periodDefenceForm);
        this.tabs.dataProvider = _loc1_;
    }

    private function updateCurrentTab():void {
        var _loc1_:int = this._tabsDependencies.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._tabsDependencies[_loc2_].visible = this.tabs.selectedIndex == _loc2_;
            _loc2_++;
        }
    }

    private function onTabsIndexChangeHandler(param1:IndexEvent):void {
        if (initialized) {
            this.updateCurrentTab();
        }
    }
}
}
