package net.wg.gui.lobby.clans.profile.cmp {
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.common.containers.HorizontalGroupLayout;
import net.wg.gui.components.common.containers.IGroupEx;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationStatsViewVO;
import net.wg.gui.lobby.components.DetailedStatisticsUnit;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class ClanProfileFortStatsGroup extends UIComponentEx {

    private static const STATS_GAP:int = -12;

    private static const STATS_WIDTH:int = 430;

    public var tfHeader:TextField = null;

    public var group:IGroupEx = null;

    public var detailedStat:DetailedStatisticsUnit = null;

    private var _data:ClanProfileFortificationStatsViewVO = null;

    private var _layout:HorizontalGroupLayout = null;

    public function ClanProfileFortStatsGroup() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this._layout = new HorizontalGroupLayout();
        this._layout.gap = STATS_GAP;
        this.group.layout = this._layout;
        this.group.itemRendererLinkage = Linkages.ADVANCED_LINE_DESCR_ICON_TEXT_UI;
        this.detailedStat.width = STATS_WIDTH;
        this.detailedStat.itemRendererLinkage = Linkages.STATISTICS_DASH_LINE_TEXT_ITEM_RENDERER;
        this.detailedStat.invalidateSize();
    }

    override protected function onDispose():void {
        this.tfHeader = null;
        this._layout.dispose();
        this._layout = null;
        this.detailedStat.dispose();
        this.detailedStat = null;
        this.group.dispose();
        this.group = null;
        this._data = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (this._data && isInvalid(InvalidationType.DATA)) {
            this.tfHeader.htmlText = this._data.headerText;
            this.group.dataProvider = this._data.headerParams;
            this.detailedStat.update(this._data.bodyParams);
            this.detailedStat.invalidateSize();
        }
    }

    public function setData(param1:ClanProfileFortificationStatsViewVO):void {
        this._data = param1;
        invalidateData();
    }
}
}
