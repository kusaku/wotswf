package net.wg.gui.cyberSport.staticFormation.components {
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.advanced.AdvancedLineDescrIconText;
import net.wg.gui.components.common.containers.IGroupEx;
import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.ResizableTileList;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsViewVO;
import net.wg.gui.cyberSport.staticFormation.events.StaticFormationStatsEvent;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.DirectionMode;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class StaticFormationStatsContainer extends UIComponentEx {

    public var battlesNumLDIT:AdvancedLineDescrIconText = null;

    public var winsPercentLDIT:AdvancedLineDescrIconText = null;

    public var winsByCaptureLDIT:AdvancedLineDescrIconText = null;

    public var techDefeatsLDIT:AdvancedLineDescrIconText = null;

    public var leftStats:IGroupEx = null;

    public var centerStats:IGroupEx = null;

    public var rightStats:IGroupEx = null;

    public var awardsTF:TextField = null;

    public var noAwardsTF:TextField = null;

    public var separator:MovieClip = null;

    public var awardsTileList:ResizableTileList = null;

    public var ddlSeasonFilter:DropdownMenu = null;

    public var lblSeasonFilter:TextField = null;

    public function StaticFormationStatsContainer() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.separator.mouseChildren = this.separator.mouseEnabled = false;
        this.leftStats.itemRendererLinkage = this.centerStats.itemRendererLinkage = this.rightStats.itemRendererLinkage = Linkages.STATS_GROUP_ITEM;
        this.leftStats.layout = new Vertical100PercWidthLayout();
        this.centerStats.layout = new Vertical100PercWidthLayout();
        this.rightStats.layout = new Vertical100PercWidthLayout();
        this.awardsTileList.direction = DirectionMode.VERTICAL;
        this.awardsTileList.addEventListener(Event.RESIZE, this.onAwardsTileListResizeHandler);
        this.ddlSeasonFilter.addEventListener(ListEvent.INDEX_CHANGE, this.onDdlSeasonFilterIndexChangeHandler);
    }

    override protected function onDispose():void {
        this.ddlSeasonFilter.removeEventListener(ListEvent.INDEX_CHANGE, this.onDdlSeasonFilterIndexChangeHandler);
        this.ddlSeasonFilter.dispose();
        this.ddlSeasonFilter = null;
        this.awardsTileList.removeEventListener(Event.RESIZE, this.onAwardsTileListResizeHandler);
        this.awardsTileList.dispose();
        this.awardsTileList = null;
        this.battlesNumLDIT.dispose();
        this.battlesNumLDIT = null;
        this.winsPercentLDIT.dispose();
        this.winsPercentLDIT = null;
        this.winsByCaptureLDIT.dispose();
        this.winsByCaptureLDIT = null;
        this.techDefeatsLDIT.dispose();
        this.techDefeatsLDIT = null;
        this.leftStats.dispose();
        this.leftStats = null;
        this.centerStats.dispose();
        this.centerStats = null;
        this.rightStats.dispose();
        this.rightStats = null;
        this.awardsTF = null;
        this.separator = null;
        this.noAwardsTF = null;
        this.lblSeasonFilter = null;
        super.onDispose();
    }

    public function setData(param1:StaticFormationStatsViewVO):void {
        this.ddlSeasonFilter.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.seasonFilters));
        this.ddlSeasonFilter.selectedIndex = param1.selectedSeason;
        this.ddlSeasonFilter.enabled = param1.seasonFilterEnable;
        this.awardsTF.htmlText = param1.awardsText;
        this.lblSeasonFilter.htmlText = param1.seasonFilterName;
        this.leftStats.width = this.centerStats.width = this.rightStats.width = param1.statsGroupWidth;
        this.noAwardsTF.htmlText = param1.noAwardsText;
        this.noAwardsTF.visible = param1.noAwards;
        this.awardsTileList.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.achievements));
    }

    public function setStats(param1:StaticFormationStatsVO):void {
        this.battlesNumLDIT.setData(param1.battlesNumData);
        this.winsPercentLDIT.setData(param1.winsPercentData);
        this.winsByCaptureLDIT.setData(param1.winsByCaptureData);
        this.techDefeatsLDIT.setData(param1.techDefeatsData);
        this.leftStats.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.leftStats));
        this.centerStats.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.centerStats));
        this.rightStats.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.rightStats));
    }

    private function onDdlSeasonFilterIndexChangeHandler(param1:ListEvent):void {
        dispatchEvent(new StaticFormationStatsEvent(param1.index));
    }

    private function onAwardsTileListResizeHandler(param1:Event):void {
        height = this.awardsTileList.y + this.awardsTileList.height;
    }
}
}
