package net.wg.gui.battle.views {
import flash.events.Event;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
import net.wg.gui.battle.components.falloutScorePanel.FalloutBaseScorePanel;
import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
import net.wg.gui.battle.views.debugPanel.DebugPanel;
import net.wg.gui.battle.views.destroyTimers.FalloutDestroyTimersPanel;
import net.wg.gui.battle.views.falloutConsumablesPanel.FalloutConsumablesPanel;
import net.wg.gui.battle.views.falloutRespawnView.FalloutRespawnView;
import net.wg.gui.battle.views.flagNotification.FlagNotification;
import net.wg.gui.battle.views.postMortemTips.PostmortemGasInfo;
import net.wg.gui.battle.views.radialMenu.RadialMenu;
import net.wg.gui.battle.views.repairPointTimer.RepairPointTimer;
import net.wg.gui.battle.views.sixthSense.SixthSense;
import net.wg.gui.battle.views.statsHint.StatsHint;
import net.wg.gui.battle.views.ticker.BattleTicker;
import net.wg.gui.components.common.ticker.Ticker;
import net.wg.gui.components.common.ticker.events.BattleTickerEvent;
import net.wg.infrastructure.base.meta.IFalloutBattlePageMeta;
import net.wg.infrastructure.base.meta.impl.FalloutBattlePageMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.helpers.statisticsDataController.FalloutStatisticsDataController;

public class BaseFalloutPage extends FalloutBattlePageMeta implements IFalloutBattlePageMeta {

    protected static const MESSENGER_RESPAWN_Y_OFFSET:int = 43;

    protected static const FLAG_NOTIFICATION_BOTTOM_OFFSET_X:int = -64;

    protected static const FLAG_NOTIFICATION_BOTTOM_OFFSET_Y:int = -313;

    protected static const REPAIR_TIMER_CENTER_OFFSET_X:int = -250;

    protected static const REPAIR_TIMER_BOTTOM_OFFSET_Y:int = -313;

    public var debugPanel:DebugPanel = null;

    public var sixthSense:SixthSense = null;

    public var damageInfoPanel:DamageInfoPanel = null;

    public var battleMessenger:BattleMessenger = null;

    public var falloutRespawnView:FalloutRespawnView = null;

    public var falloutConsumablesPanel:FalloutConsumablesPanel = null;

    public var falloutDestroyTimersPanel:FalloutDestroyTimersPanel = null;

    public var repairPointTimer:RepairPointTimer = null;

    public var flagNotification:FlagNotification = null;

    public var falloutScorePanel:FalloutBaseScorePanel = null;

    public var statsHint:StatsHint = null;

    public var radialMenu:RadialMenu = null;

    public var battleTicker:BattleTicker = null;

    private var _postmortemGasInfo:PostmortemGasInfo = null;

    private var _fallout_score_panel_start_y_pos:Number = 0;

    public function BaseFalloutPage() {
        super();
        this._fallout_score_panel_start_y_pos = this.falloutScorePanel.y;
    }

    override protected function initializeStatisticsController():void {
        super.initializeStatisticsController();
        battleStatisticDataController = new FalloutStatisticsDataController(this);
        battleStatisticDataController.registerComponentController(this.falloutScorePanel);
    }

    override protected function configUI():void {
        this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onBattleMessengerRequestFocusHandler);
        this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS, this.onBattleMessengerRemoveFocusHandler);
        this.battleTicker.addEventListener(BattleTickerEvent.SHOW, this.onBattleTickerShowHandler);
        this.battleTicker.addEventListener(BattleTickerEvent.HIDE, this.onBattleTickerShowHandler);
        super.configUI();
    }

    override protected function onPopulate():void {
        registerComponent(this.sixthSense, BATTLE_VIEW_ALIASES.SIXTH_SENSE);
        registerComponent(this.damageInfoPanel, BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
        registerComponent(this.debugPanel, BATTLE_VIEW_ALIASES.DEBUG_PANEL);
        registerComponent(this.battleMessenger, BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
        registerComponent(this.falloutRespawnView, BATTLE_VIEW_ALIASES.FALLOUT_RESPAWN_VIEW);
        registerComponent(this.falloutConsumablesPanel, BATTLE_VIEW_ALIASES.FALLOUT_CONSUMABLES_PANEL);
        registerComponent(this.falloutDestroyTimersPanel, BATTLE_VIEW_ALIASES.FALLOUT_DESTROY_TIMERS_PANEL);
        registerComponent(this.repairPointTimer, BATTLE_VIEW_ALIASES.REPAIR_POINT_TIMER);
        registerComponent(this.flagNotification, BATTLE_VIEW_ALIASES.FLAG_NOTIFICATION);
        registerComponent(this.falloutScorePanel, BATTLE_VIEW_ALIASES.FALLOUT_SCORE_PANEL);
        registerComponent(this.radialMenu, BATTLE_VIEW_ALIASES.RADIAL_MENU);
        registerComponent(this.battleTicker, BATTLE_VIEW_ALIASES.TICKER);
        super.onPopulate();
    }

    override protected function onRegisterStatisticController():void {
        registerFlashComponentS(battleStatisticDataController, BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
    }

    override protected function onDispose():void {
        this.statsHint.dispose();
        this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onBattleMessengerRequestFocusHandler);
        this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS, this.onBattleMessengerRemoveFocusHandler);
        this.battleMessenger = null;
        this.debugPanel = null;
        this.sixthSense = null;
        this.damageInfoPanel = null;
        this.falloutRespawnView = null;
        this.falloutConsumablesPanel = null;
        this.falloutDestroyTimersPanel = null;
        this.repairPointTimer = null;
        this.flagNotification = null;
        this.falloutScorePanel = null;
        this.statsHint = null;
        this.radialMenu = null;
        if (this._postmortemGasInfo) {
            this._postmortemGasInfo.dispose();
            this._postmortemGasInfo = null;
        }
        this.battleTicker.removeEventListener(BattleTickerEvent.SHOW, this.onBattleTickerShowHandler);
        this.battleTicker.removeEventListener(BattleTickerEvent.HIDE, this.onBattleTickerShowHandler);
        this.battleTicker = null;
        super.onDispose();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        var _loc3_:Number = param1 >> 1;
        this.sixthSense.x = _loc3_;
        this.sixthSense.y = param2 >> 2;
        this.damageInfoPanel.y = (param2 >> 1) / stage.scaleY + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * stage.scaleY | 0;
        this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
        this.radialMenu.updateStage(param1, param2);
        this.repairPointTimer.x = _loc3_ + REPAIR_TIMER_CENTER_OFFSET_X;
        this.repairPointTimer.y = param2 + REPAIR_TIMER_BOTTOM_OFFSET_Y;
        this.flagNotification.x = _loc3_ + FLAG_NOTIFICATION_BOTTOM_OFFSET_X;
        this.flagNotification.y = param2 + FLAG_NOTIFICATION_BOTTOM_OFFSET_Y;
        this.falloutScorePanel.x = _loc3_;
        this.falloutRespawnView.updateStage(param1, param2);
        this.falloutConsumablesPanel.updateStage(param1, param2);
        this.falloutDestroyTimersPanel.updateStage(param1, param2);
        this.battleTicker.x = param1 - this.battleTicker.width >> 1;
        this.battleTicker.y = 0;
        this.changeBattleMessengerPosition();
        if (this._postmortemGasInfo) {
            this.updatePostmortemGasInfoPosition();
        }
        this.updateTopConstraneOffset();
    }

    private function onBattleTickerShowHandler(param1:BattleTickerEvent):void {
        this.updateTopConstraneOffset();
    }

    protected function updateTopConstraneOffset():void {
        var _loc1_:Number = !!this.battleTicker.visible ? Number(this.battleTicker.y + this.battleTicker.height + Ticker.TICKER_Y_PADDING) : Number(0);
        prebattleTimer.y = PREBATTLE_TIMER_Y_OFFSET + _loc1_;
        this.falloutScorePanel.y = this._fallout_score_panel_start_y_pos + _loc1_;
    }

    private function changeBattleMessengerPosition():void {
        this.battleMessenger.x = damagePanel.x;
        if (damagePanel.visible) {
            this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + MESSANGER_Y_OFFSET;
        }
        else {
            this.battleMessenger.y = _originalHeight - MESSENGER_RESPAWN_Y_OFFSET;
        }
    }

    override public function as_setComponentsVisibility(param1:Array, param2:Array):void {
        super.as_setComponentsVisibility(param1, param2);
        this.changeBattleMessengerPosition();
    }

    override protected function playerMessageListPositionUpdate():void {
        if (minimap.visible) {
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0, _originalHeight - minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y);
        }
        else {
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0, this.battleMessenger.y);
        }
    }

    private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent):void {
        setFocus(param1.focusContainer.getComponentForFocus());
    }

    private function onBattleMessengerRemoveFocusHandler(param1:Event):void {
        setFocus(this);
    }

    private function updatePostmortemGasInfoPosition():void {
        this._postmortemGasInfo.x = width >> 1;
        this._postmortemGasInfo.y = height;
    }

    public function as_setPostmortemGasAtackInfo(param1:String, param2:String, param3:Boolean):void {
        if (this._postmortemGasInfo == null) {
            this._postmortemGasInfo = App.utils.classFactory.getComponent(Linkages.POSTMORTEN_GAS_INFO, PostmortemGasInfo);
            addChild(this._postmortemGasInfo);
            this.updatePostmortemGasInfoPosition();
        }
        this._postmortemGasInfo.setInfo(param1, param2, param3);
        this._postmortemGasInfo.visible = true;
    }

    public function as_hidePostmortemGasAtackInfo():void {
        if (this._postmortemGasInfo) {
            this._postmortemGasInfo.visible = false;
        }
    }
}
}
