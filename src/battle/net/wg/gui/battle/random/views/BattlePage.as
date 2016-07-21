package net.wg.gui.battle.random.views {
import flash.events.Event;

import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
import net.wg.gui.battle.components.DestroyTimersPanel;
import net.wg.gui.battle.random.views.fragCorrelationBar.FragCorrelationBar;
import net.wg.gui.battle.random.views.stats.components.fullStats.FullStats;
import net.wg.gui.battle.random.views.stats.components.playersPanel.PlayersPanel;
import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
import net.wg.gui.battle.views.BaseBattlePage;
import net.wg.gui.battle.views.battleEndWarning.BattleEndWarningPanel;
import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
import net.wg.gui.battle.views.debugPanel.DebugPanel;
import net.wg.gui.battle.views.radialMenu.RadialMenu;
import net.wg.gui.battle.views.sixthSense.SixthSense;
import net.wg.gui.battle.views.ticker.BattleTicker;
import net.wg.gui.components.common.ticker.Ticker;
import net.wg.gui.components.common.ticker.events.BattleTickerEvent;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;

public class BattlePage extends BaseBattlePage {

    private static const CONSUMABLES_POPUP_OFFSET:int = 60;

    public var debugPanel:DebugPanel = null;

    public var teamBasesPanelUI:TeamBasesPanel = null;

    public var sixthSense:SixthSense = null;

    public var consumablesPanel:ConsumablesPanel = null;

    public var destroyTimersPanel:DestroyTimersPanel = null;

    public var battleTicker:BattleTicker = null;

    public var damageInfoPanel:DamageInfoPanel = null;

    public var battleMessenger:BattleMessenger = null;

    public var fragCorrelationBar:FragCorrelationBar = null;

    public var fullStats:FullStats = null;

    public var playersPanel:PlayersPanel = null;

    public var radialMenu:RadialMenu = null;

    public var endWarningPanel:BattleEndWarningPanel = null;

    private var _team_bases_panel_start_y_pos:Number = 0;

    private var _frag_correlation_bar_start_y_pos:Number = 0;

    public function BattlePage() {
        super();
        this._team_bases_panel_start_y_pos = this.teamBasesPanelUI.y;
        this._frag_correlation_bar_start_y_pos = this.fragCorrelationBar.y;
    }

    override protected function initializeStatisticsController():void {
        battleStatisticDataController = new BattleStatisticDataController(this);
        battleStatisticDataController.registerComponentController(this.fragCorrelationBar);
        battleStatisticDataController.registerComponentController(this.fullStats);
        battleStatisticDataController.registerComponentController(this.playersPanel);
    }

    override protected function configUI():void {
        this.consumablesPanel.addEventListener(ConsumablesPanelEvent.SWITCH_POPUP, this.onConsumablesPanelSwitchPopupHandler);
        this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onBattleMessengerRequestFocusHandler);
        this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS, this.onBattleMessengerRemoveFocusHandler);
        this.battleTicker.addEventListener(BattleTickerEvent.SHOW, this.onBattleTickerShowHandler);
        this.battleTicker.addEventListener(BattleTickerEvent.HIDE, this.onBattleTickerShowHandler);
        super.configUI();
    }

    override protected function onPopulate():void {
        registerComponent(this.teamBasesPanelUI, BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
        registerComponent(this.sixthSense, BATTLE_VIEW_ALIASES.SIXTH_SENSE);
        registerComponent(this.damageInfoPanel, BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
        registerComponent(this.fullStats, BATTLE_VIEW_ALIASES.FULL_STATS);
        registerComponent(this.debugPanel, BATTLE_VIEW_ALIASES.DEBUG_PANEL);
        registerComponent(this.playersPanel, BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
        registerComponent(this.battleMessenger, BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
        registerComponent(this.fragCorrelationBar, BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR);
        registerComponent(this.consumablesPanel, BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
        registerComponent(this.destroyTimersPanel, BATTLE_VIEW_ALIASES.DESTROY_TIMERS_PANEL);
        registerComponent(this.radialMenu, BATTLE_VIEW_ALIASES.RADIAL_MENU);
        registerComponent(this.battleTicker, BATTLE_VIEW_ALIASES.TICKER);
        registerComponent(this.endWarningPanel, BATTLE_VIEW_ALIASES.BATTLE_END_WARNING_PANEL);
        super.onPopulate();
    }

    override protected function onRegisterStatisticController():void {
        registerFlashComponentS(battleStatisticDataController, BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
    }

    override protected function onDispose():void {
        this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.SWITCH_POPUP, this.onConsumablesPanelSwitchPopupHandler);
        this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onBattleMessengerRequestFocusHandler);
        this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS, this.onBattleMessengerRemoveFocusHandler);
        this.battleMessenger = null;
        this.debugPanel = null;
        this.teamBasesPanelUI = null;
        this.sixthSense = null;
        this.damageInfoPanel = null;
        this.fragCorrelationBar = null;
        this.fullStats = null;
        this.playersPanel = null;
        this.consumablesPanel = null;
        this.destroyTimersPanel = null;
        this.radialMenu = null;
        this.battleTicker.removeEventListener(BattleTickerEvent.SHOW, this.onBattleTickerShowHandler);
        this.battleTicker.removeEventListener(BattleTickerEvent.HIDE, this.onBattleTickerShowHandler);
        this.battleTicker = null;
        this.endWarningPanel = null;
        super.onDispose();
    }

    private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(param1.focusContainer.getComponentForFocus());
    }

    private function onBattleMessengerRemoveFocusHandler(param1:Event):void {
        setFocus(this);
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        var _loc3_:Number = param1 >> 1;
        this.teamBasesPanelUI.x = _loc3_;
        this.sixthSense.x = _loc3_;
        this.sixthSense.y = param2 >> 2;
        this.damageInfoPanel.y = (param2 >> 1) / stage.scaleY + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * stage.scaleY | 0;
        this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
        this.battleTicker.x = param1 - this.battleTicker.width >> 1;
        this.battleTicker.y = 0;
        this.fragCorrelationBar.x = param1 - this.fragCorrelationBar.width >> 1;
        this.battleMessenger.x = damagePanel.x;
        this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + MESSANGER_Y_OFFSET;
        this.destroyTimersPanel.updateStage(param1, param2);
        this.fullStats.updateStageSize(param1, param2);
        this.playersPanel.updateStageSize(param1, param2);
        this.consumablesPanel.updateStage(param1, param2);
        this.radialMenu.updateStage(param1, param2);
        this.endWarningPanel.x = _loc3_;
        this.updateTopConstraneOffset();
    }

    private function onBattleTickerShowHandler(param1:BattleTickerEvent):void {
        this.updateTopConstraneOffset();
    }

    protected function updateTopConstraneOffset():void {
        var _loc1_:Number = !!this.battleTicker.visible ? Number(this.battleTicker.y + this.battleTicker.height + Ticker.TICKER_Y_PADDING) : Number(0);
        prebattleTimer.y = PREBATTLE_TIMER_Y_OFFSET + _loc1_;
        this.teamBasesPanelUI.y = this._team_bases_panel_start_y_pos + _loc1_;
        this.fragCorrelationBar.y = this._frag_correlation_bar_start_y_pos + _loc1_;
        this.endWarningPanel.y = this.fragCorrelationBar.y + this.fragCorrelationBar.height + _loc1_;
    }

    override protected function playerMessageListPositionUpdate():void {
        if (minimap.visible) {
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0, _originalHeight - minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y);
        }
        else {
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0, this.battleMessenger.y);
        }
    }

    private function onConsumablesPanelSwitchPopupHandler(param1:ConsumablesPanelEvent):void {
        var _loc2_:int = 0;
        if (!postmortemTips || !postmortemTips.visible) {
            _loc2_ = !!this.consumablesPanel.isExpand ? int(CONSUMABLES_POPUP_OFFSET) : 0;
            vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1, _originalHeight - VEHICLE_MESSAGES_LIST_OFFSET.y - _loc2_ | 0);
        }
    }
}
}
