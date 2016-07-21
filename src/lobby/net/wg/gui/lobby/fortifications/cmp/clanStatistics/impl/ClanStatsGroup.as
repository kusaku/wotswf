package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl {
import net.wg.data.constants.Linkages;
import net.wg.gui.components.common.containers.GroupEx;
import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;

public class ClanStatsGroup extends GroupEx {

    private static const BATTLE_STATS_PADDING:Number = 8;

    public static const DEFRES_STATS_PADDING:Number = 7;

    private var _verticalPadding:Number = 8;

    public function ClanStatsGroup() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        var _loc1_:Vertical100PercWidthLayout = new Vertical100PercWidthLayout();
        _loc1_.gap = this._verticalPadding;
        layout = _loc1_;
        itemRendererLinkage = Linkages.CLAN_STAT_DASH_LINE_TEXT_ITEM;
    }

    public function get verticalPadding():Number {
        return this._verticalPadding;
    }

    public function set verticalPadding(param1:Number):void {
        this._verticalPadding = param1;
        invalidateLayout();
    }
}
}
