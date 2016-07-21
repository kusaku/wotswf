package net.wg.gui.lobby.profile.pages.statistics.body {
import net.wg.gui.components.common.containers.Group;
import net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo;
import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart;

import scaleform.clik.data.DataProvider;

public class ChartsStatisticsGroup extends Group {

    public var typeChart:StatisticsBarChart;

    public var nationChart:StatisticsBarChart;

    public var levelChart:StatisticsBarChart;

    private var _chartInfoData:Vector.<StatisticChartInfo>;

    private var _orderedCharts:Vector.<StatisticsBarChart>;

    public function ChartsStatisticsGroup() {
        super();
        this._chartInfoData = new Vector.<StatisticChartInfo>();
        this._orderedCharts = new <StatisticsBarChart>[this.typeChart, this.nationChart, this.levelChart];
    }

    override protected function configUI():void {
        super.configUI();
        this.typeChart.setAxisText(PROFILE.SECTION_STATISTICS_CHARTS_BYTYPELABEL);
        this.nationChart.setAxisText(PROFILE.SECTION_STATISTICS_CHARTS_BYNATIONLABEL);
        this.levelChart.setAxisText(PROFILE.SECTION_STATISTICS_CHARTS_BYLEVELLABEL);
    }

    override protected function onDispose():void {
        this.typeChart = null;
        this.nationChart = null;
        this.levelChart = null;
        this.clearChartInfoData();
        this._chartInfoData = null;
        this._orderedCharts.splice(0, this._orderedCharts.length);
        this._orderedCharts = null;
        super.onDispose();
    }

    public function setDossierData(param1:Array):void {
        var _loc4_:Array = null;
        this.clearChartInfoData();
        var _loc2_:int = this._orderedCharts.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this.formChartItemProvider(param1[_loc3_]);
            this._orderedCharts[_loc3_].dataProvider = new DataProvider(_loc4_);
            _loc3_++;
        }
    }

    private function formChartItemProvider(param1:Array):Array {
        var _loc5_:StatisticChartInfo = null;
        var _loc2_:Array = [];
        var _loc3_:int = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = new StatisticChartInfo(param1[_loc4_]);
            _loc2_.push(_loc5_);
            this._chartInfoData.push(_loc5_);
            _loc4_++;
        }
        return _loc2_;
    }

    private function clearChartInfoData():void {
        var _loc1_:int = this._chartInfoData.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            this._chartInfoData[_loc2_].dispose();
            _loc2_++;
        }
        this._chartInfoData.splice(0, _loc1_);
    }
}
}
