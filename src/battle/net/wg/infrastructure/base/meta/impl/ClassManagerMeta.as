package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.VehicleStatusLightVO;
import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
import net.wg.data.VO.daapi.DAAPIFalloutTotalStatsVO;
import net.wg.data.VO.daapi.DAAPIFalloutVehicleStatsVO;
import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
import net.wg.data.VO.daapi.DAAPIQuestTipsVO;
import net.wg.data.VO.daapi.DAAPITotalStatsVO;
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInteractiveStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
import net.wg.data.constants.BattleStatisticsModelStatus;
import net.wg.data.constants.InvalidationType;
import net.wg.data.constants.InvitationStatus;
import net.wg.data.constants.PersonalStatus;
import net.wg.data.constants.PlayerStatus;
import net.wg.data.constants.StatisticDataFacadeName;
import net.wg.data.constants.VehicleStatus;
import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.BATTLE_DESTROY_TIMER_STATES;
import net.wg.data.constants.generated.BATTLE_ICONS_CONSTS;
import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
import net.wg.data.constants.generated.FLAG_NOTIFICATION_CONSTS;
import net.wg.data.constants.generated.INTERFACE_STATES;
import net.wg.data.constants.generated.KEYBOARD_KEYS;
import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.gui.battle.components.BattleDAAPIComponent;
import net.wg.gui.battle.components.BattleDisplayable;
import net.wg.gui.battle.components.BattleIconHolder;
import net.wg.gui.battle.components.BattleUIComponent;
import net.wg.gui.battle.components.BattleUIComponentsHolder;
import net.wg.gui.battle.components.BattleUIDisplayable;
import net.wg.gui.battle.components.CoolDownTimer;
import net.wg.gui.battle.components.DestroyTimersPanel;
import net.wg.gui.battle.components.FrameAnimationTimer;
import net.wg.gui.battle.components.buttons.BattleButton;
import net.wg.gui.battle.components.buttons.BattleStateButton;
import net.wg.gui.battle.components.buttons.BattleToolTipButton;
import net.wg.gui.battle.components.buttons.btnConfig.BattleStateBtnSettings;
import net.wg.gui.battle.components.buttons.interfaces.IBattleButton;
import net.wg.gui.battle.components.buttons.interfaces.IBattleToolTipButton;
import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.IDragOutButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.IDragOverButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.IPressButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.IReleaseOutSideButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.IRollOutButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.IRollOverButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.IStateChangedButtonHandler;
import net.wg.gui.battle.components.buttons.interfaces.ITooltipTarget;
import net.wg.gui.battle.components.constants.InteractiveStates;
import net.wg.gui.battle.components.damageIndicator.AnimationContainer;
import net.wg.gui.battle.components.damageIndicator.DamageIndicator;
import net.wg.gui.battle.components.damageIndicator.DamageIndicatorItem;
import net.wg.gui.battle.components.damageIndicator.ExtendedStateContainer;
import net.wg.gui.battle.components.damageIndicator.ItemWithRotation;
import net.wg.gui.battle.components.damageIndicator.StandardStateContainer;
import net.wg.gui.battle.components.falloutScorePanel.BarGlowAnimation;
import net.wg.gui.battle.components.falloutScorePanel.FalloutBaseScorePanel;
import net.wg.gui.battle.components.falloutScorePanel.FalloutClassicScorePanel;
import net.wg.gui.battle.components.falloutScorePanel.FalloutMultiteamScorePanel;
import net.wg.gui.battle.components.interfaces.IBattleDisplayable;
import net.wg.gui.battle.components.interfaces.IBattleUIComponent;
import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
import net.wg.gui.battle.falloutClassic.components.fullStats.FCFullStats;
import net.wg.gui.battle.falloutClassic.components.fullStats.FCStatsTable;
import net.wg.gui.battle.falloutClassic.components.fullStats.FCStatsTableController;
import net.wg.gui.battle.falloutClassic.components.fullStats.tableItem.FCStatsItem;
import net.wg.gui.battle.falloutClassic.components.fullStats.tableItem.FCStatsItemHolder;
import net.wg.gui.battle.falloutClassic.views.FalloutClassicPage;
import net.wg.gui.battle.falloutMultiteam.views.FalloutMultiteamPage;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMFullStats;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMStatsItem;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMStatsItemHolder;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMStatsTable;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMStatsTableController;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMStatsTeam;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMStatsTeamsController;
import net.wg.gui.battle.random.views.BattlePage;
import net.wg.gui.battle.random.views.fragCorrelationBar.FCVehicleMarker;
import net.wg.gui.battle.random.views.fragCorrelationBar.FragCorrelationBar;
import net.wg.gui.battle.random.views.fragCorrelationBar.IVehicleMarkerAnimFinishedHandler;
import net.wg.gui.battle.random.views.fragCorrelationBar.VehicleMarkersList;
import net.wg.gui.battle.random.views.stats.components.fullStats.BattleIconView;
import net.wg.gui.battle.random.views.stats.components.fullStats.FullStats;
import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTable;
import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTableCtrl;
import net.wg.gui.battle.random.views.stats.components.fullStats.constants.RandomFullStatsValidationType;
import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.IDynamicSquadCtrl;
import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.PlayerStatusView;
import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItem;
import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItemHolder;
import net.wg.gui.battle.random.views.stats.components.playersPanel.PlayersPanel;
import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelItemEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelListEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.InviteReceivedIndicator;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelList;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItem;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListItemHolder;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListLeft;
import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelListRight;
import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitch;
import net.wg.gui.battle.random.views.stats.components.playersPanel.panelSwitch.PlayersPanelSwitchButton;
import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBar;
import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBarBg;
import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureFeel;
import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureProgress;
import net.wg.gui.battle.tutorial.views.TutorialPage;
import net.wg.gui.battle.tutorial.views.tutorial.BattleTutorial;
import net.wg.gui.battle.tutorial.views.tutorial.components.doneAnim.BattleTutorialDoneAnim;
import net.wg.gui.battle.tutorial.views.tutorial.components.doneAnim.BattleTutorialDoneAnimContainer;
import net.wg.gui.battle.tutorial.views.tutorial.components.progressBar.BattleProgressItemLabel;
import net.wg.gui.battle.tutorial.views.tutorial.components.progressBar.BattleProgressItemLine;
import net.wg.gui.battle.tutorial.views.tutorial.components.progressBar.BattleTutorialProgressBar;
import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.BattleTutorialTasksPanel;
import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Header;
import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Hint;
import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Icon;
import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.Task;
import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers.TaskAnimation;
import net.wg.gui.battle.tutorial.views.tutorial.interfaces.IBattleTutorialDoneAnim;
import net.wg.gui.battle.tutorial.views.tutorial.interfaces.IBattleTutorialTasksPanel;
import net.wg.gui.battle.tutorial.views.tutorial.utils.tween.ITutorialTweenerHandler;
import net.wg.gui.battle.tutorial.views.tutorial.utils.tween.TutorialTweener;
import net.wg.gui.battle.tutorial.views.tutorial.utils.tween.TweenFlowFactory;
import net.wg.gui.battle.views.BaseBattlePage;
import net.wg.gui.battle.views.BaseFalloutPage;
import net.wg.gui.battle.views.battleDamagePanel.BattleDamageLogPanel;
import net.wg.gui.battle.views.battleDamagePanel.components.DamageLogDetailsController;
import net.wg.gui.battle.views.battleDamagePanel.components.DamageLogDetailsImages;
import net.wg.gui.battle.views.battleDamagePanel.components.DamageLogDetailsText;
import net.wg.gui.battle.views.battleDamagePanel.components.DefaultSummaryImages;
import net.wg.gui.battle.views.battleDamagePanel.components.SummaryAnimation;
import net.wg.gui.battle.views.battleDamagePanel.constants.BattleDamageLogConstants;
import net.wg.gui.battle.views.battleDamagePanel.models.MessageRenderModel;
import net.wg.gui.battle.views.battleEndWarning.BattleEndWarningPanel;
import net.wg.gui.battle.views.battleEndWarning.containers.Timer;
import net.wg.gui.battle.views.battleMessenger.BattleImageSubstitution;
import net.wg.gui.battle.views.battleMessenger.BattleMessage;
import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
import net.wg.gui.battle.views.battleMessenger.BattleMessengerPool;
import net.wg.gui.battle.views.battleMessenger.BattleSmileyMap;
import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerReceiverVO;
import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerSettingsVO;
import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerToxicVO;
import net.wg.gui.battle.views.battleMessenger.VO.ButtonToxicStatusVO;
import net.wg.gui.battle.views.battleMessenger.actionPanel.BattleMessengerActionContainer;
import net.wg.gui.battle.views.battleMessenger.interfaces.IBattleMessenger;
import net.wg.gui.battle.views.battleTimer.BattleAnimationTimer;
import net.wg.gui.battle.views.battleTimer.BattleTimer;
import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
import net.wg.gui.battle.views.consumablesPanel.BattleOptionalDeviceButton;
import net.wg.gui.battle.views.consumablesPanel.BattleOrderButton;
import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
import net.wg.gui.battle.views.consumablesPanel.EntitiesStatePopup;
import net.wg.gui.battle.views.consumablesPanel.EntityStateButton;
import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleOrderButton;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesPanel;
import net.wg.gui.battle.views.consumablesPanel.interfaces.IEntityStateButton;
import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
import net.wg.gui.battle.views.damageInfoPanel.components.DamageItem;
import net.wg.gui.battle.views.damageInfoPanel.components.Fire;
import net.wg.gui.battle.views.damagePanel.DamagePanel;
import net.wg.gui.battle.views.damagePanel.VO.DamagePanelTooltipVO;
import net.wg.gui.battle.views.damagePanel.VO.ItemStates;
import net.wg.gui.battle.views.damagePanel.VO.TankIndicatorItem;
import net.wg.gui.battle.views.damagePanel.VO.TooltipStringByItemStateVO;
import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemClickArea;
import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
import net.wg.gui.battle.views.damagePanel.components.FireIndicator;
import net.wg.gui.battle.views.damagePanel.components.HealthBar;
import net.wg.gui.battle.views.damagePanel.components.Tachometer;
import net.wg.gui.battle.views.damagePanel.components.modules.ModuleAssets;
import net.wg.gui.battle.views.damagePanel.components.modules.ModuleRepairAnim;
import net.wg.gui.battle.views.damagePanel.components.modules.ModuleWarningAnim;
import net.wg.gui.battle.views.damagePanel.components.modules.ModulesCtrl;
import net.wg.gui.battle.views.damagePanel.components.tankIndicator.ItemWithModules;
import net.wg.gui.battle.views.damagePanel.components.tankIndicator.SPGRotator;
import net.wg.gui.battle.views.damagePanel.components.tankIndicator.TankIndicator;
import net.wg.gui.battle.views.damagePanel.components.tankIndicator.TankRotator;
import net.wg.gui.battle.views.damagePanel.components.tankIndicator.VehicleTurret;
import net.wg.gui.battle.views.damagePanel.components.tankman.TankmanAssets;
import net.wg.gui.battle.views.damagePanel.components.tankman.TankmanDumper;
import net.wg.gui.battle.views.damagePanel.components.tankman.TankmanIdentifiers;
import net.wg.gui.battle.views.damagePanel.components.tankman.TankmenCtrl;
import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelItemsCtrl;
import net.wg.gui.battle.views.debugPanel.DebugPanel;
import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
import net.wg.gui.battle.views.destroyTimers.FalloutDestroyTimersPanel;
import net.wg.gui.battle.views.destroyTimers.components.DestroyTimerContainer;
import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;
import net.wg.gui.battle.views.directionIndicator.DirectionIndicator;
import net.wg.gui.battle.views.directionIndicator.DirectionIndicatorImage;
import net.wg.gui.battle.views.directionIndicator.DirectionIndicatorShape;
import net.wg.gui.battle.views.directionIndicator.DirnIndicatorDistance;
import net.wg.gui.battle.views.falloutConsumablesPanel.FalloutConsumablesPanel;
import net.wg.gui.battle.views.falloutConsumablesPanel.interfaces.IFalloutConsumablesPanel;
import net.wg.gui.battle.views.falloutConsumablesPanel.rageBar.HitSplash;
import net.wg.gui.battle.views.falloutConsumablesPanel.rageBar.RageBar;
import net.wg.gui.battle.views.falloutConsumablesPanel.rageBar.VO.RageBarVO;
import net.wg.gui.battle.views.falloutRespawnView.FalloutRespawnView;
import net.wg.gui.battle.views.falloutRespawnView.RespawnVehicleSlot;
import net.wg.gui.battle.views.falloutRespawnView.VO.FalloutRespawnViewVO;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleSlotVO;
import net.wg.gui.battle.views.falloutRespawnView.VO.VehicleStateVO;
import net.wg.gui.battle.views.falloutRespawnView.components.EmptyInfo;
import net.wg.gui.battle.views.falloutRespawnView.interfaces.IFalloutRespawnView;
import net.wg.gui.battle.views.flagNotification.FlagNotification;
import net.wg.gui.battle.views.flagNotification.containers.FlagNotificationTFsContainer;
import net.wg.gui.battle.views.messages.FadedMessagesPool;
import net.wg.gui.battle.views.messages.FadedTextMessage;
import net.wg.gui.battle.views.messages.IMessage;
import net.wg.gui.battle.views.messages.MessageList;
import net.wg.gui.battle.views.messages.MessageListDAAPI;
import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
import net.wg.gui.battle.views.messages.VO.MessageListSettingsVO;
import net.wg.gui.battle.views.messages.VO.PoolSettingsVO;
import net.wg.gui.battle.views.messages.components.TextMessageRenderer;
import net.wg.gui.battle.views.messages.events.MessageEvent;
import net.wg.gui.battle.views.messages.interfaces.IMessageList;
import net.wg.gui.battle.views.minimap.Minimap;
import net.wg.gui.battle.views.minimap.MinimapEntryController;
import net.wg.gui.battle.views.minimap.components.entries.background.TutorialTargetMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.constants.AbsorptionFlagEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.constants.BackgroundMinimapEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.constants.FlagMinimapEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.constants.FortConsumablesMinimapEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.constants.PersonalMinimapEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.constants.RepairMinimapEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.constants.TeamBaseMinimapEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.constants.VehicleMinimapEntryConst;
import net.wg.gui.battle.views.minimap.components.entries.fallout.absorptionFlag.AllyAbsorptionFlagMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.fallout.absorptionFlag.EnemyAbsorptionFlagMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.fallout.absorptionFlag.containers.AbsorptionFlagAnimContainer;
import net.wg.gui.battle.views.minimap.components.entries.fallout.flag.FlagMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.fallout.repair.AllyRepairMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.fallout.repair.EnemyRepairMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.fortconsumables.ArtilleryMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.fortconsumables.BomberMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.interfaces.IHighlightableMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.interfaces.IMinimapEntryWithNonScaleContent;
import net.wg.gui.battle.views.minimap.components.entries.interfaces.IVehicleMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.AnimationMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.ArcadeCameraMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.CellFlashMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.DeadPointMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.StrategicCameraMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.VideoCameraMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.ViewPointMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.personal.ViewRangeCirclesMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.teambase.AllyTeamBaseMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.teambase.AllyTeamSpawnMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.teambase.ControlPointMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.teambase.EnemyTeamBaseMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.teambase.EnemyTeamSpawnMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.vehicle.MarkerTopAnimation;
import net.wg.gui.battle.views.minimap.components.entries.vehicle.VehicleAnimationMinimapEntry;
import net.wg.gui.battle.views.minimap.components.entries.vehicle.VehicleMinimapEntry;
import net.wg.gui.battle.views.minimap.constants.MinimapColorConst;
import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
import net.wg.gui.battle.views.minimap.containers.MinimapEntriesContainer;
import net.wg.gui.battle.views.minimap.events.MinimapEvent;
import net.wg.gui.battle.views.postmortemPanel.PostmortemGasInfo;
import net.wg.gui.battle.views.postmortemPanel.PostmortemPanel;
import net.wg.gui.battle.views.postmortemPanel.VehiclePanel;
import net.wg.gui.battle.views.prebattleTimer.PrebattleTimer;
import net.wg.gui.battle.views.radialMenu.RadialButton;
import net.wg.gui.battle.views.radialMenu.RadialMenu;
import net.wg.gui.battle.views.radialMenu.components.BackGround;
import net.wg.gui.battle.views.radialMenu.components.Content;
import net.wg.gui.battle.views.radialMenu.components.Icons;
import net.wg.gui.battle.views.radialMenu.components.SectorHoveredWrapper;
import net.wg.gui.battle.views.radialMenu.components.SectorWrapper;
import net.wg.gui.battle.views.repairPointTimer.RepairPointTimer;
import net.wg.gui.battle.views.ribbonsPanel.AnimationSet;
import net.wg.gui.battle.views.ribbonsPanel.RibbonCtrl;
import net.wg.gui.battle.views.ribbonsPanel.RibbonIcons;
import net.wg.gui.battle.views.ribbonsPanel.RibbonTexts;
import net.wg.gui.battle.views.ribbonsPanel.RibbonsPanel;
import net.wg.gui.battle.views.ribbonsPanel.data.BackgroundAtlasNames;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonAnimationStates;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonQueue;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonQueueItem;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonSettings;
import net.wg.gui.battle.views.ribbonsPanel.data.RibbonTextSettings;
import net.wg.gui.battle.views.sixthSense.SixthSense;
import net.wg.gui.battle.views.staticMarkers.flag.FlagIcon;
import net.wg.gui.battle.views.staticMarkers.flag.FlagMarker;
import net.wg.gui.battle.views.staticMarkers.flag.constant.FlagMarkerState;
import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointIcon;
import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointMarker;
import net.wg.gui.battle.views.staticMarkers.safeZone.SafeZoneMarker;
import net.wg.gui.battle.views.stats.BattleTipsController;
import net.wg.gui.battle.views.stats.SpeakAnimation;
import net.wg.gui.battle.views.stats.SquadTooltip;
import net.wg.gui.battle.views.stats.StatsUserProps;
import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
import net.wg.gui.battle.views.stats.constants.FalloutStatsValidationType;
import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
import net.wg.gui.battle.views.stats.fullStats.FalloutStatsItem;
import net.wg.gui.battle.views.stats.fullStats.SquadInviteStatusView;
import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemBase;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemPositionController;
import net.wg.gui.battle.views.stats.fullStats.interfaces.IStatsTableItemHandler;
import net.wg.gui.battle.views.stats.fullStats.interfaces.IStatsTableItemHolderBase;
import net.wg.gui.battle.views.statsHint.StatsHint;
import net.wg.gui.battle.views.ticker.BattleTicker;
import net.wg.gui.battle.views.vehicleMarkers.AnimateExplosion;
import net.wg.gui.battle.views.vehicleMarkers.DamageLabel;
import net.wg.gui.battle.views.vehicleMarkers.FlagContainer;
import net.wg.gui.battle.views.vehicleMarkers.FortConsumablesMarker;
import net.wg.gui.battle.views.vehicleMarkers.HPFieldContainer;
import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;
import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedPart;
import net.wg.gui.battle.views.vehicleMarkers.IMarkerManagerHandler;
import net.wg.gui.battle.views.vehicleMarkers.StaticObjectMarker;
import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerSettings;
import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;
import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;
import net.wg.gui.battle.views.vehicleMarkers.VehicleIconAnimation;
import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersLinkages;
import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
import net.wg.gui.battle.views.vehicleMarkers.events.TimelineEvent;
import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
import net.wg.gui.battle.views.vehicleMessages.VehicleMessage;
import net.wg.gui.battle.views.vehicleMessages.VehicleMessages;
import net.wg.gui.battle.views.vehicleMessages.VehicleMessagesPool;
import net.wg.gui.battle.views.vehicleMessages.VehicleMessagesVoQueue;
import net.wg.gui.battle.views.vehicleMessages.vo.VehicleMessageVO;
import net.wg.gui.battle.windows.DeserterDialog;
import net.wg.gui.battle.windows.IngameHelpWindow;
import net.wg.gui.battle.windows.IngameMenu;
import net.wg.gui.battle.windows.ReplenishAmmoDialog;
import net.wg.infrastructure.base.BaseBattleDAAPIComponent;
import net.wg.infrastructure.base.meta.IBaseBattleDAAPIComponentMeta;
import net.wg.infrastructure.base.meta.IBattleDAAPIComponentMeta;
import net.wg.infrastructure.base.meta.IBattleDamageLogPanelMeta;
import net.wg.infrastructure.base.meta.IBattleEndWarningPanelMeta;
import net.wg.infrastructure.base.meta.IBattleMessageListMeta;
import net.wg.infrastructure.base.meta.IBattleMessengerMeta;
import net.wg.infrastructure.base.meta.IBattlePageMeta;
import net.wg.infrastructure.base.meta.IBattleStatisticDataControllerMeta;
import net.wg.infrastructure.base.meta.IBattleTimerMeta;
import net.wg.infrastructure.base.meta.IBattleTutorialMeta;
import net.wg.infrastructure.base.meta.IConsumablesPanelMeta;
import net.wg.infrastructure.base.meta.IDamageInfoPanelMeta;
import net.wg.infrastructure.base.meta.IDamagePanelMeta;
import net.wg.infrastructure.base.meta.IDebugPanelMeta;
import net.wg.infrastructure.base.meta.IDeserterDialogMeta;
import net.wg.infrastructure.base.meta.IDestroyTimersPanelMeta;
import net.wg.infrastructure.base.meta.IFCStatsMeta;
import net.wg.infrastructure.base.meta.IFMStatsMeta;
import net.wg.infrastructure.base.meta.IFalloutBaseScorePanelMeta;
import net.wg.infrastructure.base.meta.IFalloutBattlePageMeta;
import net.wg.infrastructure.base.meta.IFalloutConsumablesPanelMeta;
import net.wg.infrastructure.base.meta.IFalloutDestroyTimersPanelMeta;
import net.wg.infrastructure.base.meta.IFalloutRespawnViewMeta;
import net.wg.infrastructure.base.meta.IFlagNotificationMeta;
import net.wg.infrastructure.base.meta.IFragCorrelationBarMeta;
import net.wg.infrastructure.base.meta.IFullStatsMeta;
import net.wg.infrastructure.base.meta.IIngameHelpWindowMeta;
import net.wg.infrastructure.base.meta.IIngameMenuMeta;
import net.wg.infrastructure.base.meta.IMinimapMeta;
import net.wg.infrastructure.base.meta.IPlayersPanelMeta;
import net.wg.infrastructure.base.meta.IPostmortemPanelMeta;
import net.wg.infrastructure.base.meta.IPrebattleTimerMeta;
import net.wg.infrastructure.base.meta.IRadialMenuMeta;
import net.wg.infrastructure.base.meta.IRepairPointTimerMeta;
import net.wg.infrastructure.base.meta.IRibbonsPanelMeta;
import net.wg.infrastructure.base.meta.ISixthSenseMeta;
import net.wg.infrastructure.base.meta.IStatsBaseMeta;
import net.wg.infrastructure.base.meta.ITeamBasesPanelMeta;
import net.wg.infrastructure.base.meta.IVehicleMarkersManagerMeta;
import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
import net.wg.infrastructure.helpers.statisticsDataController.FalloutStatisticsDataController;
import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;

public class ClassManagerMeta {

    public static const NET_WG_DATA_VO_VEHICLESTATUSLIGHTVO:Class = VehicleStatusLightVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIARENAINFOVO:Class = DAAPIArenaInfoVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIFALLOUTTOTALSTATSVO:Class = DAAPIFalloutTotalStatsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIFALLOUTVEHICLESTATSVO:Class = DAAPIFalloutVehicleStatsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIINVITATIONSTATUSVO:Class = DAAPIInvitationStatusVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIPLAYERSTATUSVO:Class = DAAPIPlayerStatusVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIQUESTTIPSVO:Class = DAAPIQuestTipsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPITOTALSTATSVO:Class = DAAPITotalStatsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLEINFOVO:Class = DAAPIVehicleInfoVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESTATSVO:Class = DAAPIVehicleStatsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESTATUSVO:Class = DAAPIVehicleStatusVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLEUSERTAGSVO:Class = DAAPIVehicleUserTagsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESDATAVO:Class = DAAPIVehiclesDataVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESINTERACTIVESTATSVO:Class = DAAPIVehiclesInteractiveStatsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESINVITATIONSTATUSVO:Class = DAAPIVehiclesInvitationStatusVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESSTATSVO:Class = DAAPIVehiclesStatsVO;

    public static const NET_WG_DATA_VO_DAAPI_DAAPIVEHICLESUSERTAGSVO:Class = DAAPIVehiclesUserTagsVO;

    public static const NET_WG_DATA_CONSTANTS_BATTLESTATISTICSMODELSTATUS:Class = BattleStatisticsModelStatus;

    public static const NET_WG_DATA_CONSTANTS_INTERACTIVESTATES:Class = net.wg.data.constants.InteractiveStates;

    public static const NET_WG_DATA_CONSTANTS_INVALIDATIONTYPE:Class = InvalidationType;

    public static const NET_WG_DATA_CONSTANTS_INVITATIONSTATUS:Class = InvitationStatus;

    public static const NET_WG_DATA_CONSTANTS_PERSONALSTATUS:Class = PersonalStatus;

    public static const NET_WG_DATA_CONSTANTS_PLAYERSTATUS:Class = PlayerStatus;

    public static const NET_WG_DATA_CONSTANTS_STATISTICDATAFACADENAME:Class = StatisticDataFacadeName;

    public static const NET_WG_DATA_CONSTANTS_VEHICLESTATUS:Class = VehicleStatus;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_CONSUMABLES_PANEL_TAGS:Class = BATTLE_CONSUMABLES_PANEL_TAGS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_CONTEXT_MENU_HANDLER_TYPE:Class = BATTLE_CONTEXT_MENU_HANDLER_TYPE;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_DESTROY_TIMER_STATES:Class = BATTLE_DESTROY_TIMER_STATES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_ICONS_CONSTS:Class = BATTLE_ICONS_CONSTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_ITEM_STATES:Class = BATTLE_ITEM_STATES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_MESSAGES_CONSTS:Class = BATTLE_MESSAGES_CONSTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_VIEW_ALIASES:Class = BATTLE_VIEW_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_DAMAGE_INFO_PANEL_CONSTS:Class = DAMAGE_INFO_PANEL_CONSTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_FLAG_NOTIFICATION_CONSTS:Class = FLAG_NOTIFICATION_CONSTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_INTERFACE_STATES:Class = INTERFACE_STATES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_KEYBOARD_KEYS:Class = KEYBOARD_KEYS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_PLAYERS_PANEL_STATE:Class = PLAYERS_PANEL_STATE;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEATLASSPRITE:Class = BattleAtlasSprite;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEDAAPICOMPONENT:Class = BattleDAAPIComponent;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEDISPLAYABLE:Class = BattleDisplayable;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEICONHOLDER:Class = BattleIconHolder;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEUICOMPONENT:Class = BattleUIComponent;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEUICOMPONENTSHOLDER:Class = BattleUIComponentsHolder;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BATTLEUIDISPLAYABLE:Class = BattleUIDisplayable;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_COOLDOWNTIMER:Class = CoolDownTimer;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_DESTROYTIMERSPANEL:Class = DestroyTimersPanel;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_FRAMEANIMATIONTIMER:Class = FrameAnimationTimer;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BATTLEBUTTON:Class = BattleButton;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BATTLESTATEBUTTON:Class = BattleStateButton;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BATTLETOOLTIPBUTTON:Class = BattleToolTipButton;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_BTNCONFIG_BATTLESTATEBTNSETTINGS:Class = BattleStateBtnSettings;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IBATTLEBUTTON:Class = IBattleButton;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IBATTLETOOLTIPBUTTON:Class = IBattleToolTipButton;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_ICLICKBUTTONHANDLER:Class = IClickButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IDRAGOUTBUTTONHANDLER:Class = IDragOutButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IDRAGOVERBUTTONHANDLER:Class = IDragOverButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IPRESSBUTTONHANDLER:Class = IPressButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IRELEASEOUTSIDEBUTTONHANDLER:Class = IReleaseOutSideButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IROLLOUTBUTTONHANDLER:Class = IRollOutButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_IROLLOVERBUTTONHANDLER:Class = IRollOverButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_ISTATECHANGEDBUTTONHANDLER:Class = IStateChangedButtonHandler;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_BUTTONS_INTERFACES_ITOOLTIPTARGET:Class = ITooltipTarget;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_CONSTANTS_INTERACTIVESTATES:Class = InteractiveStates;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_CONSTANTS_INVALIDATIONTYPE:Class = net.wg.gui.battle.components.constants.InvalidationType;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_DAMAGEINDICATOR_ANIMATIONCONTAINER:Class = AnimationContainer;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_DAMAGEINDICATOR_DAMAGEINDICATOR:Class = DamageIndicator;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_DAMAGEINDICATOR_DAMAGEINDICATORITEM:Class = DamageIndicatorItem;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_DAMAGEINDICATOR_EXTENDEDSTATECONTAINER:Class = ExtendedStateContainer;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_DAMAGEINDICATOR_ITEMWITHROTATION:Class = ItemWithRotation;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_DAMAGEINDICATOR_STANDARDSTATECONTAINER:Class = StandardStateContainer;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_FALLOUTSCOREPANEL_BARGLOWANIMATION:Class = BarGlowAnimation;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_FALLOUTSCOREPANEL_FALLOUTBASESCOREPANEL:Class = FalloutBaseScorePanel;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_FALLOUTSCOREPANEL_FALLOUTCLASSICSCOREPANEL:Class = FalloutClassicScorePanel;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_FALLOUTSCOREPANEL_FALLOUTMULTITEAMSCOREPANEL:Class = FalloutMultiteamScorePanel;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERFACES_IBATTLEDISPLAYABLE:Class = IBattleDisplayable;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERFACES_IBATTLEUICOMPONENT:Class = IBattleUIComponent;

    public static const NET_WG_GUI_BATTLE_COMPONENTS_INTERFACES_ICOOLDOWNCOMPLETEHANDLER:Class = ICoolDownCompleteHandler;

    public static const NET_WG_GUI_BATTLE_FALLOUTCLASSIC_COMPONENTS_FULLSTATS_FCFULLSTATS:Class = FCFullStats;

    public static const NET_WG_GUI_BATTLE_FALLOUTCLASSIC_COMPONENTS_FULLSTATS_FCSTATSTABLE:Class = FCStatsTable;

    public static const NET_WG_GUI_BATTLE_FALLOUTCLASSIC_COMPONENTS_FULLSTATS_FCSTATSTABLECONTROLLER:Class = FCStatsTableController;

    public static const NET_WG_GUI_BATTLE_FALLOUTCLASSIC_COMPONENTS_FULLSTATS_TABLEITEM_FCSTATSITEM:Class = FCStatsItem;

    public static const NET_WG_GUI_BATTLE_FALLOUTCLASSIC_COMPONENTS_FULLSTATS_TABLEITEM_FCSTATSITEMHOLDER:Class = FCStatsItemHolder;

    public static const NET_WG_GUI_BATTLE_FALLOUTCLASSIC_VIEWS_FALLOUTCLASSICPAGE:Class = FalloutClassicPage;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_FALLOUTMULTITEAMPAGE:Class = FalloutMultiteamPage;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_COMPONENTS_FULLSTATS_FMFULLSTATS:Class = FMFullStats;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_COMPONENTS_FULLSTATS_FMSTATSITEM:Class = FMStatsItem;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_COMPONENTS_FULLSTATS_FMSTATSITEMHOLDER:Class = FMStatsItemHolder;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_COMPONENTS_FULLSTATS_FMSTATSTABLE:Class = FMStatsTable;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_COMPONENTS_FULLSTATS_FMSTATSTABLECONTROLLER:Class = FMStatsTableController;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_COMPONENTS_FULLSTATS_FMSTATSTEAM:Class = FMStatsTeam;

    public static const NET_WG_GUI_BATTLE_FALLOUTMULTITEAM_VIEWS_COMPONENTS_FULLSTATS_FMSTATSTEAMSCONTROLLER:Class = FMStatsTeamsController;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_BATTLEPAGE:Class = BattlePage;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_FCVEHICLEMARKER:Class = FCVehicleMarker;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_FRAGCORRELATIONBAR:Class = FragCorrelationBar;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_IVEHICLEMARKERANIMFINISHEDHANDLER:Class = IVehicleMarkerAnimFinishedHandler;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_FRAGCORRELATIONBAR_VEHICLEMARKERSLIST:Class = VehicleMarkersList;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_BATTLEICONVIEW:Class = BattleIconView;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_FULLSTATS:Class = FullStats;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_FULLSTATSTABLE:Class = FullStatsTable;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_FULLSTATSTABLECTRL:Class = FullStatsTableCtrl;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_CONSTANTS_RANDOMFULLSTATSVALIDATIONTYPE:Class = RandomFullStatsValidationType;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_INTERFACES_IDYNAMICSQUADCTRL:Class = IDynamicSquadCtrl;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_INTERFACES_ISQUADHANDLER:Class = ISquadHandler;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_TABLEITEM_DYNAMICSQUADCTRL:Class = DynamicSquadCtrl;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_TABLEITEM_PLAYERSTATUSVIEW:Class = PlayerStatusView;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_TABLEITEM_STATSTABLEITEM:Class = StatsTableItem;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_FULLSTATS_TABLEITEM_STATSTABLEITEMHOLDER:Class = StatsTableItemHolder;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PLAYERSPANEL:Class = PlayersPanel;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_VO_PLAYERSPANELCONTEXTMENUSENTDATA:Class = PlayersPanelContextMenuSentData;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_CONSTANTS_PLAYERSPANELINVALIDATIONTYPE:Class = PlayersPanelInvalidationType;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_EVENTS_PLAYERSPANELEVENT:Class = PlayersPanelEvent;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_EVENTS_PLAYERSPANELITEMEVENT:Class = PlayersPanelItemEvent;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_EVENTS_PLAYERSPANELLISTEVENT:Class = PlayersPanelListEvent;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_EVENTS_PLAYERSPANELSWITCHEVENT:Class = PlayersPanelSwitchEvent;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_INTERFACES_IPLAYERSPANELLISTITEMHOLDER:Class = IPlayersPanelListItemHolder;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_INVITERECEIVEDINDICATOR:Class = InviteReceivedIndicator;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELDYNAMICSQUAD:Class = PlayersPanelDynamicSquad;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLIST:Class = PlayersPanelList;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEM:Class = PlayersPanelListItem;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTITEMHOLDER:Class = PlayersPanelListItemHolder;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTLEFT:Class = PlayersPanelListLeft;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_LIST_PLAYERSPANELLISTRIGHT:Class = PlayersPanelListRight;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PANELSWITCH_PLAYERSPANELSWITCH:Class = PlayersPanelSwitch;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_COMPONENTS_PLAYERSPANEL_PANELSWITCH_PLAYERSPANELSWITCHBUTTON:Class = PlayersPanelSwitchButton;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_CONSTANTS_VEHICLEACTIONS:Class = VehicleActions;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_STATS_EVENTS_DYNAMICSQUADEVENT:Class = DynamicSquadEvent;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMBASESPANEL:Class = TeamBasesPanel;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREBAR:Class = TeamCaptureBar;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREBARBG:Class = TeamCaptureBarBg;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREFEEL:Class = TeamCaptureFeel;

    public static const NET_WG_GUI_BATTLE_RANDOM_VIEWS_TEAMBASESPANEL_TEAMCAPTUREPROGRESS:Class = TeamCaptureProgress;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIALPAGE:Class = TutorialPage;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_BATTLETUTORIAL:Class = BattleTutorial;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_DONEANIM_BATTLETUTORIALDONEANIM:Class = BattleTutorialDoneAnim;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_DONEANIM_BATTLETUTORIALDONEANIMCONTAINER:Class = BattleTutorialDoneAnimContainer;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_PROGRESSBAR_BATTLEPROGRESSITEMLABEL:Class = BattleProgressItemLabel;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_PROGRESSBAR_BATTLEPROGRESSITEMLINE:Class = BattleProgressItemLine;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_PROGRESSBAR_BATTLETUTORIALPROGRESSBAR:Class = BattleTutorialProgressBar;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_TASKPANEL_BATTLETUTORIALTASKSPANEL:Class = BattleTutorialTasksPanel;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_TASKPANEL_CONTAINERS_HEADER:Class = Header;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_TASKPANEL_CONTAINERS_HINT:Class = Hint;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_TASKPANEL_CONTAINERS_ICON:Class = Icon;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_TASKPANEL_CONTAINERS_TASK:Class = Task;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_COMPONENTS_TASKPANEL_CONTAINERS_TASKANIMATION:Class = TaskAnimation;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_INTERFACES_IBATTLETUTORIALDONEANIM:Class = IBattleTutorialDoneAnim;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_INTERFACES_IBATTLETUTORIALTASKSPANEL:Class = IBattleTutorialTasksPanel;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_UTILS_TWEEN_ITUTORIALTWEENERHANDLER:Class = ITutorialTweenerHandler;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_UTILS_TWEEN_TUTORIALTWEENER:Class = TutorialTweener;

    public static const NET_WG_GUI_BATTLE_TUTORIAL_VIEWS_TUTORIAL_UTILS_TWEEN_TWEENFLOWFACTORY:Class = TweenFlowFactory;

    public static const NET_WG_GUI_BATTLE_VIEWS_BASEBATTLEPAGE:Class = BaseBattlePage;

    public static const NET_WG_GUI_BATTLE_VIEWS_BASEFALLOUTPAGE:Class = BaseFalloutPage;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_BATTLEDAMAGELOGPANEL:Class = BattleDamageLogPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_COMPONENTS_DAMAGELOGDETAILSCONTROLLER:Class = DamageLogDetailsController;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_COMPONENTS_DAMAGELOGDETAILSIMAGES:Class = DamageLogDetailsImages;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_COMPONENTS_DAMAGELOGDETAILSTEXT:Class = DamageLogDetailsText;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_COMPONENTS_DEFAULTSUMMARYIMAGES:Class = DefaultSummaryImages;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_COMPONENTS_SUMMARYANIMATION:Class = SummaryAnimation;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_CONSTANTS_BATTLEDAMAGELOGCONSTANTS:Class = BattleDamageLogConstants;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEDAMAGEPANEL_MODELS_MESSAGERENDERMODEL:Class = MessageRenderModel;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEENDWARNING_BATTLEENDWARNINGPANEL:Class = BattleEndWarningPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEENDWARNING_CONTAINERS_TIMER:Class = Timer;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEIMAGESUBSTITUTION:Class = BattleImageSubstitution;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEMESSAGE:Class = BattleMessage;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEMESSENGER:Class = BattleMessenger;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLEMESSENGERPOOL:Class = BattleMessengerPool;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_BATTLESMILEYMAP:Class = BattleSmileyMap;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BATTLEMESSENGERRECEIVERVO:Class = BattleMessengerReceiverVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BATTLEMESSENGERSETTINGSVO:Class = BattleMessengerSettingsVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BATTLEMESSENGERTOXICVO:Class = BattleMessengerToxicVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_VO_BUTTONTOXICSTATUSVO:Class = ButtonToxicStatusVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_ACTIONPANEL_BATTLEMESSENGERACTIONCONTAINER:Class = BattleMessengerActionContainer;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLEMESSENGER_INTERFACES_IBATTLEMESSENGER:Class = IBattleMessenger;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETIMER_BATTLEANIMATIONTIMER:Class = BattleAnimationTimer;

    public static const NET_WG_GUI_BATTLE_VIEWS_BATTLETIMER_BATTLETIMER:Class = BattleTimer;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEEQUIPMENTBUTTON:Class = BattleEquipmentButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEOPTIONALDEVICEBUTTON:Class = BattleOptionalDeviceButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLEORDERBUTTON:Class = BattleOrderButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_BATTLESHELLBUTTON:Class = BattleShellButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_CONSUMABLESPANEL:Class = ConsumablesPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_ENTITIESSTATEPOPUP:Class = EntitiesStatePopup;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_ENTITYSTATEBUTTON:Class = EntityStateButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_VO_CONSUMABLESVO:Class = ConsumablesVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_CONSTANTS_COLOR_STATES:Class = COLOR_STATES;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_EVENTS_CONSUMABLESPANELEVENT:Class = ConsumablesPanelEvent;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_IBATTLEORDERBUTTON:Class = IBattleOrderButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_IBATTLESHELLBUTTON:Class = IBattleShellButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_ICONSUMABLESBUTTON:Class = IConsumablesButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_ICONSUMABLESPANEL:Class = IConsumablesPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_CONSUMABLESPANEL_INTERFACES_IENTITYSTATEBUTTON:Class = IEntityStateButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINFOPANEL_DAMAGEINFOPANEL:Class = DamageInfoPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINFOPANEL_COMPONENTS_DAMAGEITEM:Class = DamageItem;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEINFOPANEL_COMPONENTS_FIRE:Class = Fire;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_DAMAGEPANEL:Class = DamagePanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_DAMAGEPANELTOOLTIPVO:Class = DamagePanelTooltipVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_ITEMSTATES:Class = ItemStates;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_TANKINDICATORITEM:Class = TankIndicatorItem;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_VO_TOOLTIPSTRINGBYITEMSTATEVO:Class = TooltipStringByItemStateVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_DAMAGEPANELITEMCLICKAREA:Class = DamagePanelItemClickArea;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_DAMAGEPANELITEMFRAMESTATES:Class = DamagePanelItemFrameStates;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_FIREINDICATOR:Class = FireIndicator;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_HEALTHBAR:Class = HealthBar;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TACHOMETER:Class = Tachometer;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULEASSETS:Class = ModuleAssets;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULEREPAIRANIM:Class = ModuleRepairAnim;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULEWARNINGANIM:Class = ModuleWarningAnim;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_MODULES_MODULESCTRL:Class = ModulesCtrl;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_ITEMWITHMODULES:Class = ItemWithModules;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_SPGROTATOR:Class = SPGRotator;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_TANKINDICATOR:Class = TankIndicator;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_TANKROTATOR:Class = TankRotator;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKINDICATOR_VEHICLETURRET:Class = VehicleTurret;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMANASSETS:Class = TankmanAssets;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMANDUMPER:Class = TankmanDumper;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMANIDENTIFIERS:Class = TankmanIdentifiers;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_COMPONENTS_TANKMAN_TANKMENCTRL:Class = TankmenCtrl;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_INTERFACES_IASSETCREATOR:Class = IAssetCreator;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_INTERFACES_IDAMAGEPANELCLICKABLEITEM:Class = IDamagePanelClickableItem;

    public static const NET_WG_GUI_BATTLE_VIEWS_DAMAGEPANEL_INTERFACES_IDAMAGEPANELITEMSCTRL:Class = IDamagePanelItemsCtrl;

    public static const NET_WG_GUI_BATTLE_VIEWS_DEBUGPANEL_DEBUGPANEL:Class = DebugPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_DESTROYTIMER:Class = DestroyTimer;

    public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_FALLOUTDESTROYTIMERSPANEL:Class = FalloutDestroyTimersPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_COMPONENTS_DESTROYTIMERCONTAINER:Class = DestroyTimerContainer;

    public static const NET_WG_GUI_BATTLE_VIEWS_DESTROYTIMERS_EVENTS_DESTROYTIMEREVENT:Class = DestroyTimerEvent;

    public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRECTIONINDICATOR:Class = DirectionIndicator;

    public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRECTIONINDICATORIMAGE:Class = DirectionIndicatorImage;

    public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRECTIONINDICATORSHAPE:Class = DirectionIndicatorShape;

    public static const NET_WG_GUI_BATTLE_VIEWS_DIRECTIONINDICATOR_DIRNINDICATORDISTANCE:Class = DirnIndicatorDistance;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTCONSUMABLESPANEL_FALLOUTCONSUMABLESPANEL:Class = FalloutConsumablesPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTCONSUMABLESPANEL_INTERFACES_IFALLOUTCONSUMABLESPANEL:Class = IFalloutConsumablesPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTCONSUMABLESPANEL_RAGEBAR_HITSPLASH:Class = HitSplash;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTCONSUMABLESPANEL_RAGEBAR_RAGEBAR:Class = RageBar;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTCONSUMABLESPANEL_RAGEBAR_VO_RAGEBARVO:Class = RageBarVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTRESPAWNVIEW_FALLOUTRESPAWNVIEW:Class = FalloutRespawnView;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTRESPAWNVIEW_RESPAWNVEHICLESLOT:Class = RespawnVehicleSlot;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTRESPAWNVIEW_VO_FALLOUTRESPAWNVIEWVO:Class = FalloutRespawnViewVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTRESPAWNVIEW_VO_VEHICLESLOTVO:Class = VehicleSlotVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTRESPAWNVIEW_VO_VEHICLESTATEVO:Class = VehicleStateVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTRESPAWNVIEW_COMPONENTS_EMPTYINFO:Class = EmptyInfo;

    public static const NET_WG_GUI_BATTLE_VIEWS_FALLOUTRESPAWNVIEW_INTERFACES_IFALLOUTRESPAWNVIEW:Class = IFalloutRespawnView;

    public static const NET_WG_GUI_BATTLE_VIEWS_FLAGNOTIFICATION_FLAGNOTIFICATION:Class = FlagNotification;

    public static const NET_WG_GUI_BATTLE_VIEWS_FLAGNOTIFICATION_CONTAINERS_FLAGNOTIFICATIONTFSCONTAINER:Class = FlagNotificationTFsContainer;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_FADEDMESSAGESPOOL:Class = FadedMessagesPool;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_FADEDTEXTMESSAGE:Class = FadedTextMessage;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_IMESSAGE:Class = IMessage;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_MESSAGELIST:Class = MessageList;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_MESSAGELISTDAAPI:Class = MessageListDAAPI;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_VO_FADINGMESSAGELISTSETTINGSVO:Class = FadingMessageListSettingsVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_VO_MESSAGELISTSETTINGSVO:Class = MessageListSettingsVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_VO_POOLSETTINGSVO:Class = PoolSettingsVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_COMPONENTS_TEXTMESSAGERENDERER:Class = TextMessageRenderer;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_EVENTS_MESSAGEEVENT:Class = MessageEvent;

    public static const NET_WG_GUI_BATTLE_VIEWS_MESSAGES_INTERFACES_IMESSAGELIST:Class = IMessageList;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_MINIMAP:Class = Minimap;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_MINIMAPENTRYCONTROLLER:Class = MinimapEntryController;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_BACKGROUND_TUTORIALTARGETMINIMAPENTRY:Class = TutorialTargetMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_ABSORPTIONFLAGENTRYCONST:Class = AbsorptionFlagEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_BACKGROUNDMINIMAPENTRYCONST:Class = BackgroundMinimapEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_FLAGMINIMAPENTRYCONST:Class = FlagMinimapEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_FORTCONSUMABLESMINIMAPENTRYCONST:Class = FortConsumablesMinimapEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_PERSONALMINIMAPENTRYCONST:Class = PersonalMinimapEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_REPAIRMINIMAPENTRYCONST:Class = RepairMinimapEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_TEAMBASEMINIMAPENTRYCONST:Class = TeamBaseMinimapEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_CONSTANTS_VEHICLEMINIMAPENTRYCONST:Class = VehicleMinimapEntryConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FALLOUT_ABSORPTIONFLAG_ALLYABSORPTIONFLAGMINIMAPENTRY:Class = AllyAbsorptionFlagMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FALLOUT_ABSORPTIONFLAG_ENEMYABSORPTIONFLAGMINIMAPENTRY:Class = EnemyAbsorptionFlagMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FALLOUT_ABSORPTIONFLAG_CONTAINERS_ABSORPTIONFLAGANIMCONTAINER:Class = AbsorptionFlagAnimContainer;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FALLOUT_FLAG_FLAGMINIMAPENTRY:Class = FlagMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FALLOUT_REPAIR_ALLYREPAIRMINIMAPENTRY:Class = AllyRepairMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FALLOUT_REPAIR_ENEMYREPAIRMINIMAPENTRY:Class = EnemyRepairMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FORTCONSUMABLES_ARTILLERYMINIMAPENTRY:Class = ArtilleryMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_FORTCONSUMABLES_BOMBERMINIMAPENTRY:Class = BomberMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_INTERFACES_IHIGHLIGHTABLEMINIMAPENTRY:Class = IHighlightableMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_INTERFACES_IMINIMAPENTRYWITHNONSCALECONTENT:Class = IMinimapEntryWithNonScaleContent;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_INTERFACES_IVEHICLEMINIMAPENTRY:Class = IVehicleMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_ANIMATIONMINIMAPENTRY:Class = AnimationMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_ARCADECAMERAMINIMAPENTRY:Class = ArcadeCameraMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_CELLFLASHMINIMAPENTRY:Class = CellFlashMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_DEADPOINTMINIMAPENTRY:Class = DeadPointMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_STRATEGICCAMERAMINIMAPENTRY:Class = StrategicCameraMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_VIDEOCAMERAMINIMAPENTRY:Class = VideoCameraMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_VIEWPOINTMINIMAPENTRY:Class = ViewPointMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_PERSONAL_VIEWRANGECIRCLESMINIMAPENTRY:Class = ViewRangeCirclesMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ALLYTEAMBASEMINIMAPENTRY:Class = AllyTeamBaseMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ALLYTEAMSPAWNMINIMAPENTRY:Class = AllyTeamSpawnMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_CONTROLPOINTMINIMAPENTRY:Class = ControlPointMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ENEMYTEAMBASEMINIMAPENTRY:Class = EnemyTeamBaseMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_TEAMBASE_ENEMYTEAMSPAWNMINIMAPENTRY:Class = EnemyTeamSpawnMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_VEHICLE_MARKERTOPANIMATION:Class = MarkerTopAnimation;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_VEHICLE_VEHICLEANIMATIONMINIMAPENTRY:Class = VehicleAnimationMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_COMPONENTS_ENTRIES_VEHICLE_VEHICLEMINIMAPENTRY:Class = VehicleMinimapEntry;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_CONSTANTS_MINIMAPCOLORCONST:Class = MinimapColorConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_CONSTANTS_MINIMAPSIZECONST:Class = MinimapSizeConst;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_CONTAINERS_MINIMAPENTRIESCONTAINER:Class = MinimapEntriesContainer;

    public static const NET_WG_GUI_BATTLE_VIEWS_MINIMAP_EVENTS_MINIMAPEVENT:Class = MinimapEvent;

    public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMPANEL_POSTMORTEMGASINFO:Class = PostmortemGasInfo;

    public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMPANEL_POSTMORTEMPANEL:Class = PostmortemPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_POSTMORTEMPANEL_VEHICLEPANEL:Class = VehiclePanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_PREBATTLETIMER_PREBATTLETIMER:Class = PrebattleTimer;

    public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_RADIALBUTTON:Class = RadialButton;

    public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_RADIALMENU:Class = RadialMenu;

    public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_BACKGROUND:Class = BackGround;

    public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_CONTENT:Class = Content;

    public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_ICONS:Class = Icons;

    public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_SECTORHOVEREDWRAPPER:Class = SectorHoveredWrapper;

    public static const NET_WG_GUI_BATTLE_VIEWS_RADIALMENU_COMPONENTS_SECTORWRAPPER:Class = SectorWrapper;

    public static const NET_WG_GUI_BATTLE_VIEWS_REPAIRPOINTTIMER_REPAIRPOINTTIMER:Class = RepairPointTimer;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_ANIMATIONSET:Class = AnimationSet;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONCTRL:Class = RibbonCtrl;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONICONS:Class = RibbonIcons;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONTEXTS:Class = RibbonTexts;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_RIBBONSPANEL:Class = RibbonsPanel;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_BACKGROUNDATLASNAMES:Class = BackgroundAtlasNames;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_RIBBONANIMATIONSTATES:Class = RibbonAnimationStates;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_RIBBONQUEUE:Class = RibbonQueue;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_RIBBONQUEUEITEM:Class = RibbonQueueItem;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_RIBBONSETTINGS:Class = RibbonSettings;

    public static const NET_WG_GUI_BATTLE_VIEWS_RIBBONSPANEL_DATA_RIBBONTEXTSETTINGS:Class = RibbonTextSettings;

    public static const NET_WG_GUI_BATTLE_VIEWS_SIXTHSENSE_SIXTHSENSE:Class = SixthSense;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGICON:Class = FlagIcon;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGMARKER:Class = FlagMarker;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_CONSTANT_FLAGMARKERSTATE:Class = FlagMarkerState;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTICON:Class = RepairPointIcon;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTMARKER:Class = RepairPointMarker;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SAFEZONE_SAFEZONEMARKER:Class = SafeZoneMarker;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATSHINT_STATSHINT:Class = StatsHint;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_BATTLETIPSCONTROLLER:Class = BattleTipsController;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_SPEAKANIMATION:Class = SpeakAnimation;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_SQUADTOOLTIP:Class = SquadTooltip;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_STATSUSERPROPS:Class = StatsUserProps;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_DYNAMICSQUADSTATE:Class = DynamicSquadState;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_FALLOUTSTATSVALIDATIONTYPE:Class = FalloutStatsValidationType;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_FULLSTATSVALIDATIONTYPE:Class = FullStatsValidationType;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_PLAYERSTATUSSCHEMENAME:Class = PlayerStatusSchemeName;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_CONSTANTS_SQUADINVALIDATIONTYPE:Class = SquadInvalidationType;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_FALLOUTSTATSITEM:Class = FalloutStatsItem;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_SQUADINVITESTATUSVIEW:Class = SquadInviteStatusView;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLECONTROLLERBASE:Class = StatsTableControllerBase;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMBASE:Class = StatsTableItemBase;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMHOLDERBASE:Class = StatsTableItemHolderBase;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_STATSTABLEITEMPOSITIONCONTROLLER:Class = StatsTableItemPositionController;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_INTERFACES_ISTATSTABLEITEMHANDLER:Class = IStatsTableItemHandler;

    public static const NET_WG_GUI_BATTLE_VIEWS_STATS_FULLSTATS_INTERFACES_ISTATSTABLEITEMHOLDERBASE:Class = IStatsTableItemHolderBase;

    public static const NET_WG_GUI_BATTLE_VIEWS_TICKER_BATTLETICKER:Class = BattleTicker;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_ANIMATEEXPLOSION:Class = AnimateExplosion;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_DAMAGELABEL:Class = DamageLabel;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FLAGCONTAINER:Class = FlagContainer;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FORTCONSUMABLESMARKER:Class = FortConsumablesMarker;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HPFIELDCONTAINER:Class = HPFieldContainer;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBAR:Class = net.wg.gui.battle.views.vehicleMarkers.HealthBar;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDLABEL:Class = HealthBarAnimatedLabel;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDPART:Class = HealthBarAnimatedPart;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IMARKERMANAGERHANDLER:Class = IMarkerManagerHandler;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATICOBJECTMARKER:Class = StaticObjectMarker;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VMATLASITEMNAME:Class = VMAtlasItemName;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_HPDISPLAYMODE:Class = HPDisplayMode;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERFLAGS:Class = VehicleMarkerFlags;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERSETTINGS:Class = VehicleMarkerSettings;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERVO:Class = VehicleMarkerVO;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEACTIONMARKER:Class = VehicleActionMarker;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEICONANIMATION:Class = VehicleIconAnimation;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKER:Class = VehicleMarker;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSCONSTANTS:Class = VehicleMarkersConstants;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSLINKAGES:Class = VehicleMarkersLinkages;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSMANAGER:Class = VehicleMarkersManager;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_TIMELINEEVENT:Class = TimelineEvent;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_VEHICLEMARKERSMANAGEREVENT:Class = VehicleMarkersManagerEvent;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGE:Class = VehicleMessage;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGES:Class = VehicleMessages;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGESPOOL:Class = VehicleMessagesPool;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VEHICLEMESSAGESVOQUEUE:Class = VehicleMessagesVoQueue;

    public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMESSAGES_VO_VEHICLEMESSAGEVO:Class = VehicleMessageVO;

    public static const NET_WG_GUI_BATTLE_WINDOWS_DESERTERDIALOG:Class = DeserterDialog;

    public static const NET_WG_GUI_BATTLE_WINDOWS_INGAMEHELPWINDOW:Class = IngameHelpWindow;

    public static const NET_WG_GUI_BATTLE_WINDOWS_INGAMEMENU:Class = IngameMenu;

    public static const NET_WG_GUI_BATTLE_WINDOWS_REPLENISHAMMODIALOG:Class = ReplenishAmmoDialog;

    public static const NET_WG_INFRASTRUCTURE_BASE_BASEBATTLEDAAPICOMPONENT:Class = BaseBattleDAAPIComponent;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEBATTLEDAAPICOMPONENTMETA:Class = IBaseBattleDAAPIComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEDAAPICOMPONENTMETA:Class = IBattleDAAPIComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEDAMAGELOGPANELMETA:Class = IBattleDamageLogPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEENDWARNINGPANELMETA:Class = IBattleEndWarningPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEMESSAGELISTMETA:Class = IBattleMessageListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEMESSENGERMETA:Class = IBattleMessengerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEPAGEMETA:Class = IBattlePageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLESTATISTICDATACONTROLLERMETA:Class = IBattleStatisticDataControllerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLETIMERMETA:Class = IBattleTimerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLETUTORIALMETA:Class = IBattleTutorialMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONSUMABLESPANELMETA:Class = IConsumablesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IDAMAGEINFOPANELMETA:Class = IDamageInfoPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IDAMAGEPANELMETA:Class = IDamagePanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IDEBUGPANELMETA:Class = IDebugPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IDESERTERDIALOGMETA:Class = IDeserterDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IDESTROYTIMERSPANELMETA:Class = IDestroyTimersPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFCSTATSMETA:Class = IFCStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFMSTATSMETA:Class = IFMStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFALLOUTBASESCOREPANELMETA:Class = IFalloutBaseScorePanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFALLOUTBATTLEPAGEMETA:Class = IFalloutBattlePageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFALLOUTCONSUMABLESPANELMETA:Class = IFalloutConsumablesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFALLOUTDESTROYTIMERSPANELMETA:Class = IFalloutDestroyTimersPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFALLOUTRESPAWNVIEWMETA:Class = IFalloutRespawnViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFLAGNOTIFICATIONMETA:Class = IFlagNotificationMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFRAGCORRELATIONBARMETA:Class = IFragCorrelationBarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFULLSTATSMETA:Class = IFullStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IINGAMEHELPWINDOWMETA:Class = IIngameHelpWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IINGAMEMENUMETA:Class = IIngameMenuMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMINIMAPMETA:Class = IMinimapMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPLAYERSPANELMETA:Class = IPlayersPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPOSTMORTEMPANELMETA:Class = IPostmortemPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPREBATTLETIMERMETA:Class = IPrebattleTimerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRADIALMENUMETA:Class = IRadialMenuMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IREPAIRPOINTTIMERMETA:Class = IRepairPointTimerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRIBBONSPANELMETA:Class = IRibbonsPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISIXTHSENSEMETA:Class = ISixthSenseMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATSBASEMETA:Class = IStatsBaseMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITEAMBASESPANELMETA:Class = ITeamBasesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEMARKERSMANAGERMETA:Class = IVehicleMarkersManagerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEBATTLEDAAPICOMPONENTMETA:Class = BaseBattleDAAPIComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEDAAPICOMPONENTMETA:Class = BattleDAAPIComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEDAMAGELOGPANELMETA:Class = BattleDamageLogPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEENDWARNINGPANELMETA:Class = BattleEndWarningPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEMESSAGELISTMETA:Class = BattleMessageListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEMESSENGERMETA:Class = BattleMessengerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEPAGEMETA:Class = BattlePageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLESTATISTICDATACONTROLLERMETA:Class = BattleStatisticDataControllerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLETIMERMETA:Class = BattleTimerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLETUTORIALMETA:Class = BattleTutorialMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONSUMABLESPANELMETA:Class = ConsumablesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DAMAGEINFOPANELMETA:Class = DamageInfoPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DAMAGEPANELMETA:Class = DamagePanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DEBUGPANELMETA:Class = DebugPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DESERTERDIALOGMETA:Class = DeserterDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DESTROYTIMERSPANELMETA:Class = DestroyTimersPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FCSTATSMETA:Class = FCStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FMSTATSMETA:Class = FMStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FALLOUTBASESCOREPANELMETA:Class = FalloutBaseScorePanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FALLOUTBATTLEPAGEMETA:Class = FalloutBattlePageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FALLOUTCONSUMABLESPANELMETA:Class = FalloutConsumablesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FALLOUTDESTROYTIMERSPANELMETA:Class = FalloutDestroyTimersPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FALLOUTRESPAWNVIEWMETA:Class = FalloutRespawnViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FLAGNOTIFICATIONMETA:Class = FlagNotificationMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FRAGCORRELATIONBARMETA:Class = FragCorrelationBarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FULLSTATSMETA:Class = FullStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INGAMEHELPWINDOWMETA:Class = IngameHelpWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INGAMEMENUMETA:Class = IngameMenuMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MINIMAPMETA:Class = MinimapMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PLAYERSPANELMETA:Class = PlayersPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_POSTMORTEMPANELMETA:Class = PostmortemPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PREBATTLETIMERMETA:Class = PrebattleTimerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RADIALMENUMETA:Class = RadialMenuMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_REPAIRPOINTTIMERMETA:Class = RepairPointTimerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RIBBONSPANELMETA:Class = RibbonsPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SIXTHSENSEMETA:Class = SixthSenseMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATSBASEMETA:Class = StatsBaseMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TEAMBASESPANELMETA:Class = TeamBasesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEMARKERSMANAGERMETA:Class = VehicleMarkersManagerMeta;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_STATISTICSDATACONTROLLER_BATTLESTATISTICDATACONTROLLER:Class = BattleStatisticDataController;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_STATISTICSDATACONTROLLER_FALLOUTSTATISTICSDATACONTROLLER:Class = FalloutStatisticsDataController;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_STATISTICSDATACONTROLLER_INTARFACES_IBATTLECOMPONENTDATACONTROLLER:Class = IBattleComponentDataController;

    public function ClassManagerMeta() {
        super();
    }
}
}
