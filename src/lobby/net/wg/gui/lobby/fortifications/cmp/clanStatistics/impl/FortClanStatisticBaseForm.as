package net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl {
import net.wg.gui.components.advanced.AdvancedLineDescrIconText;
import net.wg.gui.components.common.containers.Group;
import net.wg.gui.components.common.containers.VerticalGroupLayout;
import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;

public class FortClanStatisticBaseForm extends UIComponentEx {

    private static const STATS_GROUP_WIDTH:Number = 580;

    private static const ICON_STATS_WIDTH_CORRECTION:Number = 3;

    private static const GROUP_GAP:int = 30;

    public var battlesField:AdvancedLineDescrIconText;

    public var winsField:AdvancedLineDescrIconText;

    public var avgDefresField:AdvancedLineDescrIconText;

    public var battlesStatsGroup:ClanStatsGroup;

    public var defresStatsGroup:ClanStatsGroup;

    private var _model:ClanStatsVO;

    private var _mainGroup:Group;

    private var _isDataInitialized:Boolean = false;

    public function FortClanStatisticBaseForm() {
        super();
        alpha = 0;
    }

    override protected function onDispose():void {
        this.battlesField.dispose();
        this.battlesField = null;
        this.winsField.dispose();
        this.winsField = null;
        this.avgDefresField.dispose();
        this.avgDefresField = null;
        if (this._mainGroup) {
            this._mainGroup.removeChild(this.battlesStatsGroup);
            this._mainGroup.removeChild(this.defresStatsGroup);
            this._mainGroup.dispose();
            this._mainGroup = null;
        }
        this.battlesStatsGroup = null;
        this.defresStatsGroup = null;
        this._model = null;
        super.onDispose();
    }

    override protected function draw():void {
        var _loc1_:VerticalGroupLayout = null;
        super.draw();
        if (this._model && isInvalid(InvalidationType.DATA)) {
            if (!this._isDataInitialized) {
                this._isDataInitialized = true;
                alpha = 1;
                this._mainGroup = new Group();
                _loc1_ = new VerticalGroupLayout();
                _loc1_.gap = GROUP_GAP;
                this._mainGroup.layout = _loc1_;
                addChild(this._mainGroup);
                this._mainGroup.y = this.battlesStatsGroup.y;
                this._mainGroup.addChild(this.battlesStatsGroup);
                this._mainGroup.addChild(this.defresStatsGroup);
                this.battlesStatsGroup.width = STATS_GROUP_WIDTH;
                this.defresStatsGroup.width = STATS_GROUP_WIDTH + ICON_STATS_WIDTH_CORRECTION;
                this.defresStatsGroup.verticalPadding = ClanStatsGroup.DEFRES_STATS_PADDING;
            }
            this.applyData();
        }
    }

    protected function applyData():void {
        this.defresStatsGroup.validateNow();
        this.battlesStatsGroup.validateNow();
        this._mainGroup.validateNow();
    }

    public function get model():ClanStatsVO {
        return this._model;
    }

    public function set model(param1:ClanStatsVO):void {
        this._model = param1;
        invalidateData();
    }
}
}
