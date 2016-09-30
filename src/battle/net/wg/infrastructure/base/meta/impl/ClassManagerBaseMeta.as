package net.wg.infrastructure.base.meta.impl {
import net.wg.data.Colors;
import net.wg.data.ListDAAPIDataProvider;
import net.wg.data.VO.AchievementCounterVO;
import net.wg.data.VO.AchievementItemVO;
import net.wg.data.VO.AchievementProfileVO;
import net.wg.data.VO.AchievementProgressVO;
import net.wg.data.VO.AtlasItemVO;
import net.wg.data.VO.ColorScheme;
import net.wg.data.VO.ContextItem;
import net.wg.data.VO.IconVO;
import net.wg.data.VO.PaddingVO;
import net.wg.data.VO.SeparateItem;
import net.wg.data.VO.TweenPropertiesVO;
import net.wg.data.VO.UserVO;
import net.wg.data.components.AccordionRendererData;
import net.wg.data.constants.AchievementSection;
import net.wg.data.constants.BaseTooltips;
import net.wg.data.constants.ComponentState;
import net.wg.data.constants.ContextMenuConstants;
import net.wg.data.constants.Cursors;
import net.wg.data.constants.DragType;
import net.wg.data.constants.IconTextPosition;
import net.wg.data.constants.Locales;
import net.wg.data.constants.MarkerState;
import net.wg.data.constants.RolesState;
import net.wg.data.constants.SortingInfo;
import net.wg.data.constants.SoundManagerStatesLobby;
import net.wg.data.constants.SoundTypes;
import net.wg.data.constants.UserTags;
import net.wg.data.constants.VehicleModules;
import net.wg.data.constants.VehicleTypes;
import net.wg.data.constants.generated.BATTLEDAMAGELOG_IMAGES;
import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
import net.wg.data.constants.generated.BLOCKS_TOOLTIP_TYPES;
import net.wg.data.constants.generated.DAMAGE_INDICATOR_ATLAS_ITEMS;
import net.wg.data.constants.generated.DAMAGE_INDICATOR_TYPES;
import net.wg.data.constants.generated.TANK_TYPES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.data.managers.impl.FlashTween;
import net.wg.data.managers.impl.PythonTween;
import net.wg.data.managers.impl.ToolTipParams;
import net.wg.data.managers.impl.TooltipProps;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.ContentTabBar;
import net.wg.gui.components.advanced.FieldSet;
import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.gui.components.advanced.ScalableIconButton;
import net.wg.gui.components.advanced.ScalableIconWrapper;
import net.wg.gui.components.advanced.SortingButtonVO;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.common.BaseLogoView;
import net.wg.gui.components.common.Counter;
import net.wg.gui.components.common.VehicleMarkerAlly;
import net.wg.gui.components.common.VehicleMarkerEnemy;
import net.wg.gui.components.common.bugreport.ReportBugPanel;
import net.wg.gui.components.common.cursor.Cursor;
import net.wg.gui.components.common.cursor.base.BaseInfo;
import net.wg.gui.components.common.cursor.base.DroppingCursor;
import net.wg.gui.components.common.markers.AnimateExplosion;
import net.wg.gui.components.common.markers.DamageLabel;
import net.wg.gui.components.common.markers.HealthBar;
import net.wg.gui.components.common.markers.HealthBarAnimatedLabel;
import net.wg.gui.components.common.markers.HealthBarAnimatedPart;
import net.wg.gui.components.common.markers.VehicleActionMarker;
import net.wg.gui.components.common.markers.VehicleMarker;
import net.wg.gui.components.common.markers.data.HPDisplayMode;
import net.wg.gui.components.common.markers.data.VehicleMarkerFlags;
import net.wg.gui.components.common.markers.data.VehicleMarkerSettings;
import net.wg.gui.components.common.markers.data.VehicleMarkerVO;
import net.wg.gui.components.common.serverStats.ServerDropDown;
import net.wg.gui.components.common.serverStats.ServerHelper;
import net.wg.gui.components.common.serverStats.ServerInfo;
import net.wg.gui.components.common.serverStats.ServerStats;
import net.wg.gui.components.common.serverStats.ServerVO;
import net.wg.gui.components.common.ticker.RSSEntryVO;
import net.wg.gui.components.common.ticker.Ticker;
import net.wg.gui.components.common.ticker.TickerItem;
import net.wg.gui.components.common.ticker.events.BattleTickerEvent;
import net.wg.gui.components.common.waiting.Waiting;
import net.wg.gui.components.common.waiting.WaitingComponent;
import net.wg.gui.components.common.waiting.WaitingMc;
import net.wg.gui.components.common.waiting.WaitingView;
import net.wg.gui.components.containers.Atlas;
import net.wg.gui.components.containers.CursorManagedContainer;
import net.wg.gui.components.containers.MainViewContainer;
import net.wg.gui.components.containers.ManagedContainer;
import net.wg.gui.components.containers.WaitingManagedContainer;
import net.wg.gui.components.controls.ActionPriceBg;
import net.wg.gui.components.controls.AlertIco;
import net.wg.gui.components.controls.AnimationIcon;
import net.wg.gui.components.controls.ArrowButton;
import net.wg.gui.components.controls.BitmapFill;
import net.wg.gui.components.controls.BlackButton;
import net.wg.gui.components.controls.BorderShadowScrollPane;
import net.wg.gui.components.controls.ButtonIconBlack;
import net.wg.gui.components.controls.ButtonIconLoader;
import net.wg.gui.components.controls.ButtonIconNormal;
import net.wg.gui.components.controls.ButtonIconTextTransparent;
import net.wg.gui.components.controls.ButtonIconTransparent;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.CloseButton;
import net.wg.gui.components.controls.CloseButtonText;
import net.wg.gui.components.controls.CompactCheckBox;
import net.wg.gui.components.controls.ContentTabRenderer;
import net.wg.gui.components.controls.ContextMenu;
import net.wg.gui.components.controls.ContextMenuItem;
import net.wg.gui.components.controls.ContextMenuItemSeparate;
import net.wg.gui.components.controls.CoreListEx;
import net.wg.gui.components.controls.CrewOperationBtn;
import net.wg.gui.components.controls.DragableListItemRenderer;
import net.wg.gui.components.controls.DropDownImageText;
import net.wg.gui.components.controls.DropDownListItemRendererSound;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.DynamicScrollingListEx;
import net.wg.gui.components.controls.GlowArrowAsset;
import net.wg.gui.components.controls.HelpButton;
import net.wg.gui.components.controls.HyperLink;
import net.wg.gui.components.controls.IProgressBar;
import net.wg.gui.components.controls.ITableRenderer;
import net.wg.gui.components.controls.IconButton;
import net.wg.gui.components.controls.IconText;
import net.wg.gui.components.controls.IconTextBigButton;
import net.wg.gui.components.controls.IconTextButton;
import net.wg.gui.components.controls.Image;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.ListItemRedererImageText;
import net.wg.gui.components.controls.ListItemRendererWithFocusOnDis;
import net.wg.gui.components.controls.MainMenuButton;
import net.wg.gui.components.controls.NationDropDownMenu;
import net.wg.gui.components.controls.NormalSortingBtnVO;
import net.wg.gui.components.controls.NormalSortingButton;
import net.wg.gui.components.controls.NumericStepper;
import net.wg.gui.components.controls.ProgressBar;
import net.wg.gui.components.controls.RadioButton;
import net.wg.gui.components.controls.RangeSlider;
import net.wg.gui.components.controls.ReadOnlyScrollingList;
import net.wg.gui.components.controls.ResizableScrollPane;
import net.wg.gui.components.controls.ResizableTileList;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.ScrollPane;
import net.wg.gui.components.controls.ScrollThumb;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.components.controls.ScrollingListPx;
import net.wg.gui.components.controls.ScrollingListWithDisRenderers;
import net.wg.gui.components.controls.ServerIndicator;
import net.wg.gui.components.controls.ServerRenderer;
import net.wg.gui.components.controls.SimpleTileList;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.components.controls.SliderBg;
import net.wg.gui.components.controls.SliderKeyPoint;
import net.wg.gui.components.controls.SliderLevelKeyPoint;
import net.wg.gui.components.controls.SortButton;
import net.wg.gui.components.controls.SortableScrollingList;
import net.wg.gui.components.controls.SoundButton;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.SoundListItemRenderer;
import net.wg.gui.components.controls.StatusIndicatorAnim;
import net.wg.gui.components.controls.StatusIndicatorEx;
import net.wg.gui.components.controls.StepSlider;
import net.wg.gui.components.controls.TabButton;
import net.wg.gui.components.controls.TankmanTrainigButtonVO;
import net.wg.gui.components.controls.TextFieldShort;
import net.wg.gui.components.controls.TextInput;
import net.wg.gui.components.controls.TextLoading;
import net.wg.gui.components.controls.TileList;
import net.wg.gui.components.controls.ToggleIndicator;
import net.wg.gui.components.controls.ToggleRenderer;
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.gui.components.controls.UILoaderCut;
import net.wg.gui.components.controls.UnitCommanderStats;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.components.controls.UserNameFieldShadowColor;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.components.controls.VO.SimpleRendererVO;
import net.wg.gui.components.controls.VO.SlotVO;
import net.wg.gui.components.controls.VO.SlotsPanelPropsVO;
import net.wg.gui.components.controls.VO.TankmanTrainingSmallButtonVO;
import net.wg.gui.components.controls.Voice;
import net.wg.gui.components.controls.VoiceWave;
import net.wg.gui.components.controls.WalletResourcesStatus;
import net.wg.gui.components.controls.WgScrollingList;
import net.wg.gui.components.controls.achievements.AchievementCommon;
import net.wg.gui.components.controls.achievements.AchievementCommonVehicle;
import net.wg.gui.components.controls.achievements.AchievementCounter;
import net.wg.gui.components.controls.achievements.AchievementDivision;
import net.wg.gui.components.controls.achievements.AchievementProgress;
import net.wg.gui.components.controls.achievements.AchievementProgressBar;
import net.wg.gui.components.controls.achievements.AchievementProgressComponent;
import net.wg.gui.components.controls.achievements.BeigeCounter;
import net.wg.gui.components.controls.achievements.BigAchievement;
import net.wg.gui.components.controls.achievements.CounterComponent;
import net.wg.gui.components.controls.achievements.GreyRibbonCounter;
import net.wg.gui.components.controls.achievements.RedCounter;
import net.wg.gui.components.controls.achievements.SmallCounter;
import net.wg.gui.components.controls.achievements.YellowRibbonCounter;
import net.wg.gui.components.controls.data.ActionPriceBgConstants;
import net.wg.gui.components.controls.data.constants.TrainingType;
import net.wg.gui.components.controls.events.DropdownMenuEvent;
import net.wg.gui.components.controls.events.ItemSelectorRendererEvent;
import net.wg.gui.components.controls.events.RangeSliderEvent;
import net.wg.gui.components.controls.events.RendererEvent;
import net.wg.gui.components.controls.events.ScrollBarEvent;
import net.wg.gui.components.controls.events.ScrollEvent;
import net.wg.gui.components.controls.events.ScrollPaneEvent;
import net.wg.gui.components.controls.events.SlotsPanelEvent;
import net.wg.gui.components.controls.events.SortableScrollingListEvent;
import net.wg.gui.components.controls.events.UserInfoTextEvent;
import net.wg.gui.components.controls.helpers.ComponentStatesHelper;
import net.wg.gui.components.controls.helpers.IconTextHelper;
import net.wg.gui.components.controls.helpers.ListUtils;
import net.wg.gui.components.controls.helpers.ServerCsisState;
import net.wg.gui.components.controls.helpers.ServerPingState;
import net.wg.gui.components.controls.helpers.TextFieldLoadingContainer;
import net.wg.gui.components.controls.helpers.TextLoadingStyle;
import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
import net.wg.gui.components.controls.helpers.UserNameTextFieldLoadingContainer;
import net.wg.gui.components.controls.interfaces.IArrowButton;
import net.wg.gui.components.controls.interfaces.IDraggableList;
import net.wg.gui.components.controls.interfaces.IServerIndicator;
import net.wg.gui.components.controls.interfaces.ISliderKeyPoint;
import net.wg.gui.components.controls.interfaces.ISortableTable;
import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
import net.wg.gui.components.controls.listselection.ListSelectionDirection;
import net.wg.gui.components.controls.scroller.CollectionEvent;
import net.wg.gui.components.controls.scroller.Ease;
import net.wg.gui.components.controls.scroller.IListViewPort;
import net.wg.gui.components.controls.scroller.IScrollerBase;
import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
import net.wg.gui.components.controls.scroller.IViewPort;
import net.wg.gui.components.controls.scroller.ListRendererEvent;
import net.wg.gui.components.controls.scroller.ScrollerBase;
import net.wg.gui.components.controls.scroller.data.ScrollConfig;
import net.wg.gui.components.crosshair.CircleStepPoints;
import net.wg.gui.components.crosshair.ClipQuantityBar;
import net.wg.gui.components.crosshair.CrosshairCircle;
import net.wg.gui.components.crosshair.CrosshairPanelArcade;
import net.wg.gui.components.crosshair.CrosshairPanelBase;
import net.wg.gui.components.crosshair.CrosshairPanelDAAPI;
import net.wg.gui.components.crosshair.CrosshairPanelPostmortem;
import net.wg.gui.components.crosshair.CrosshairPanelSniper;
import net.wg.gui.components.crosshair.CrosshairPanelStrategic;
import net.wg.gui.components.crosshair.ReloadingTimer;
import net.wg.gui.components.crosshairPanel.CrosshairAmmoCountField;
import net.wg.gui.components.crosshairPanel.CrosshairArcade;
import net.wg.gui.components.crosshairPanel.CrosshairBase;
import net.wg.gui.components.crosshairPanel.CrosshairDistanceContainer;
import net.wg.gui.components.crosshairPanel.CrosshairDistanceField;
import net.wg.gui.components.crosshairPanel.CrosshairPanel;
import net.wg.gui.components.crosshairPanel.CrosshairPostmortem;
import net.wg.gui.components.crosshairPanel.CrosshairReloadingTimeField;
import net.wg.gui.components.crosshairPanel.CrosshairSniper;
import net.wg.gui.components.crosshairPanel.CrosshairStrategic;
import net.wg.gui.components.crosshairPanel.ICrosshair;
import net.wg.gui.components.crosshairPanel.VO.CrosshairSettingsVO;
import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBar;
import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBarContainer;
import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
import net.wg.gui.components.interfaces.ICounterComponent;
import net.wg.gui.components.tooltips.Dssa;
import net.wg.gui.components.tooltips.Separator;
import net.wg.gui.components.tooltips.ToolTipBase;
import net.wg.gui.components.tooltips.ToolTipComplex;
import net.wg.gui.components.tooltips.ToolTipRSSNews;
import net.wg.gui.components.tooltips.ToolTipSpecial;
import net.wg.gui.components.tooltips.VO.SuitableVehicleVO;
import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
import net.wg.gui.components.tooltips.VO.ToolTipStatusColorsVO;
import net.wg.gui.components.tooltips.VO.UnitCommandVO;
import net.wg.gui.components.tooltips.helpers.Utils;
import net.wg.gui.components.tooltips.inblocks.TooltipInBlocks;
import net.wg.gui.components.tooltips.inblocks.TooltipInBlocksUtils;
import net.wg.gui.components.tooltips.inblocks.blocks.BaseTextBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.BaseTooltipBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.BuildUpBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.ImageTextBlockInBlocks;
import net.wg.gui.components.tooltips.inblocks.blocks.TextBlock;
import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
import net.wg.gui.components.tooltips.inblocks.data.BlocksVO;
import net.wg.gui.components.tooltips.inblocks.data.BuildUpBlockVO;
import net.wg.gui.components.tooltips.inblocks.data.ImageBlockVO;
import net.wg.gui.components.tooltips.inblocks.data.ImageTextBlockVO;
import net.wg.gui.components.tooltips.inblocks.data.TextBlockVO;
import net.wg.gui.components.tooltips.inblocks.data.TooltipInBlocksVO;
import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
import net.wg.gui.components.tooltips.inblocks.interfaces.IPoolTooltipBlock;
import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
import net.wg.gui.components.windows.Window;
import net.wg.gui.components.windows.WindowEvent;
import net.wg.gui.data.WaitingPointcutItemVO;
import net.wg.gui.data.WaitingPointcutsVO;
import net.wg.gui.data.WaitingQueueCounterMessageVO;
import net.wg.gui.data.WaitingQueueWindowVO;
import net.wg.gui.dialogs.ItemStatusData;
import net.wg.gui.dialogs.SimpleDialog;
import net.wg.gui.events.AccordionRendererEvent;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.events.NumericStepperEvent;
import net.wg.gui.events.SortingEvent;
import net.wg.gui.events.StateManagerEvent;
import net.wg.gui.events.TimelineEvent;
import net.wg.gui.events.UILoaderEvent;
import net.wg.gui.events.ViewStackContentEvent;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.gameloading.GameLoading;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.interfaces.IButtonIconTextTransparent;
import net.wg.gui.interfaces.IContentSize;
import net.wg.gui.interfaces.IGroupedControl;
import net.wg.gui.interfaces.ISettingsBase;
import net.wg.gui.interfaces.ISoundButton;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.interfaces.IUserVO;
import net.wg.gui.lobby.battleResults.components.CustomAchievement;
import net.wg.gui.lobby.profile.data.ProgressSimpleInfo;
import net.wg.gui.lobby.settings.AdvancedGraphicContentForm;
import net.wg.gui.lobby.settings.AdvancedGraphicSettingsForm;
import net.wg.gui.lobby.settings.AimSettings;
import net.wg.gui.lobby.settings.AimSettingsBase;
import net.wg.gui.lobby.settings.ControlsSettings;
import net.wg.gui.lobby.settings.ControlsSettingsBase;
import net.wg.gui.lobby.settings.GameSettings;
import net.wg.gui.lobby.settings.GameSettingsContent;
import net.wg.gui.lobby.settings.GraphicSettings;
import net.wg.gui.lobby.settings.GraphicSettingsBase;
import net.wg.gui.lobby.settings.MarkerSettings;
import net.wg.gui.lobby.settings.MarkerSettingsBase;
import net.wg.gui.lobby.settings.OtherSettings;
import net.wg.gui.lobby.settings.OtherSettingsBase;
import net.wg.gui.lobby.settings.ScreenSettingsForm;
import net.wg.gui.lobby.settings.SettingsArcadeForm;
import net.wg.gui.lobby.settings.SettingsBaseView;
import net.wg.gui.lobby.settings.SettingsChangesMap;
import net.wg.gui.lobby.settings.SettingsMarkersForm;
import net.wg.gui.lobby.settings.SettingsSniperForm;
import net.wg.gui.lobby.settings.SettingsWindow;
import net.wg.gui.lobby.settings.SoundCommonForm;
import net.wg.gui.lobby.settings.SoundSettings;
import net.wg.gui.lobby.settings.SoundSettingsBase;
import net.wg.gui.lobby.settings.SoundSpecialForm;
import net.wg.gui.lobby.settings.SoundVivoxForm;
import net.wg.gui.lobby.settings.components.KeyInput;
import net.wg.gui.lobby.settings.components.KeysItemRenderer;
import net.wg.gui.lobby.settings.components.KeysScrollingList;
import net.wg.gui.lobby.settings.components.RadioButtonBar;
import net.wg.gui.lobby.settings.components.SettingsStepSlider;
import net.wg.gui.lobby.settings.components.SettingsTabButton;
import net.wg.gui.lobby.settings.components.SoundVoiceWaves;
import net.wg.gui.lobby.settings.components.TabButtonBar;
import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
import net.wg.gui.lobby.settings.config.ControlsFactory;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.counter.SettingsCounterDelegate;
import net.wg.gui.lobby.settings.counter.data.TabCounterVO;
import net.wg.gui.lobby.settings.counter.events.CounterEvent;
import net.wg.gui.lobby.settings.events.AlternativeVoiceEvent;
import net.wg.gui.lobby.settings.events.SettingViewEvent;
import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
import net.wg.gui.lobby.settings.feedback.BaseForm;
import net.wg.gui.lobby.settings.feedback.BattleEventsInfoForm;
import net.wg.gui.lobby.settings.feedback.DamageIndicatorForm;
import net.wg.gui.lobby.settings.feedback.DamageIndicatorsContainer;
import net.wg.gui.lobby.settings.feedback.DamageLogPanelForm;
import net.wg.gui.lobby.settings.feedback.FeedbackSettings;
import net.wg.gui.lobby.settings.feedback.SettingsDamageLogContainer;
import net.wg.gui.lobby.settings.feedback.SettingsDetailsDamageLog;
import net.wg.gui.lobby.settings.feedback.SettingsRibbonContainer;
import net.wg.gui.lobby.settings.feedback.SettingsRibbonItem;
import net.wg.gui.lobby.settings.feedback.SettingsSummaryDamageLog;
import net.wg.gui.lobby.settings.feedback.damageIndicator.DamageIndicatorArrow;
import net.wg.gui.lobby.settings.feedback.damageIndicator.DamageIndicatorExtended;
import net.wg.gui.lobby.settings.feedback.damageIndicator.DamageIndicatorVehicleInfo;
import net.wg.gui.lobby.settings.feedback.data.RibbonItemData;
import net.wg.gui.lobby.settings.interfaces.IViewWithCounteredBar;
import net.wg.gui.lobby.settings.vo.CursorTabsDataVo;
import net.wg.gui.lobby.settings.vo.IncreasedZoomVO;
import net.wg.gui.lobby.settings.vo.MarkerTabsDataVo;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
import net.wg.gui.lobby.settings.vo.TabsDataVo;
import net.wg.gui.lobby.settings.vo.base.SettingsDataIncomeVo;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.ControlsSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.FeedbackSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.GameSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.GraphicSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.OtherSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.SettingConfigDataVo;
import net.wg.gui.lobby.settings.vo.config.SoundSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.aim.AimSettingsArcadeDataVo;
import net.wg.gui.lobby.settings.vo.config.aim.AimSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.aim.AimSettingsSniperDataVo;
import net.wg.gui.lobby.settings.vo.config.feedback.BattleEventInfoDataVo;
import net.wg.gui.lobby.settings.vo.config.feedback.DamageIndicatorDataVo;
import net.wg.gui.lobby.settings.vo.config.feedback.DamageLogPanelDataVo;
import net.wg.gui.lobby.settings.vo.config.marker.MarkerAllySettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.marker.MarkerDeadSettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.marker.MarkerEnemySettingsDataVo;
import net.wg.gui.lobby.settings.vo.config.marker.MarkerSettingsDataVo;
import net.wg.gui.rally.vo.VehicleVO;
import net.wg.gui.tutorial.data.BonusItemVO;
import net.wg.gui.tutorial.data.BonusValuesVO;
import net.wg.gui.tutorial.data.TutorialDialogVO;
import net.wg.gui.tutorial.windows.TutorialDialog;
import net.wg.gui.utils.ExcludeTweenManager;
import net.wg.gui.utils.FrameWalker;
import net.wg.gui.utils.IFrameWalker;
import net.wg.gui.utils.PercentFrameWalker;
import net.wg.gui.utils.RootSWFAtlasManager;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.base.AbstractWrapperView;
import net.wg.infrastructure.base.DefaultWindowGeometry;
import net.wg.infrastructure.base.SimpleContainer;
import net.wg.infrastructure.base.StoredWindowGeometry;
import net.wg.infrastructure.base.interfaces.IWaiting;
import net.wg.infrastructure.base.meta.IAimMeta;
import net.wg.infrastructure.base.meta.ICrosshairPanelMeta;
import net.wg.infrastructure.base.meta.ICursorMeta;
import net.wg.infrastructure.base.meta.IReportBugPanelMeta;
import net.wg.infrastructure.base.meta.IServerStatsMeta;
import net.wg.infrastructure.base.meta.ISettingsWindowMeta;
import net.wg.infrastructure.base.meta.ISimpleDialogMeta;
import net.wg.infrastructure.base.meta.ITickerMeta;
import net.wg.infrastructure.base.meta.ITutorialDialogMeta;
import net.wg.infrastructure.constants.WindowViewInvalidationType;
import net.wg.infrastructure.events.ColorSchemeEvent;
import net.wg.infrastructure.events.IconLoaderEvent;
import net.wg.infrastructure.events.ListDataProviderEvent;
import net.wg.infrastructure.events.PoolItemEvent;
import net.wg.infrastructure.events.VoiceChatEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IListDAAPIDataProvider;
import net.wg.infrastructure.managers.counter.CounterManager;
import net.wg.infrastructure.managers.counter.CounterProps;
import net.wg.infrastructure.managers.pool.ComponentsPool;
import net.wg.infrastructure.managers.pool.Pool;
import net.wg.infrastructure.managers.pool.PoolManager;

public class ClassManagerBaseMeta {

    public static const NET_WG_DATA_COLORS:Class = Colors;

    public static const NET_WG_DATA_LISTDAAPIDATAPROVIDER:Class = ListDAAPIDataProvider;

    public static const NET_WG_DATA_VO_ACHIEVEMENTCOUNTERVO:Class = AchievementCounterVO;

    public static const NET_WG_DATA_VO_ACHIEVEMENTITEMVO:Class = AchievementItemVO;

    public static const NET_WG_DATA_VO_ACHIEVEMENTPROFILEVO:Class = AchievementProfileVO;

    public static const NET_WG_DATA_VO_ACHIEVEMENTPROGRESSVO:Class = AchievementProgressVO;

    public static const NET_WG_DATA_VO_ATLASITEMVO:Class = AtlasItemVO;

    public static const NET_WG_DATA_VO_COLORSCHEME:Class = ColorScheme;

    public static const NET_WG_DATA_VO_CONTEXTITEM:Class = ContextItem;

    public static const NET_WG_DATA_VO_ICONVO:Class = IconVO;

    public static const NET_WG_DATA_VO_PADDINGVO:Class = PaddingVO;

    public static const NET_WG_DATA_VO_SEPARATEITEM:Class = SeparateItem;

    public static const NET_WG_DATA_VO_TWEENPROPERTIESVO:Class = TweenPropertiesVO;

    public static const NET_WG_DATA_VO_USERVO:Class = UserVO;

    public static const NET_WG_DATA_COMPONENTS_ACCORDIONRENDERERDATA:Class = AccordionRendererData;

    public static const NET_WG_DATA_CONSTANTS_ACHIEVEMENTSECTION:Class = AchievementSection;

    public static const NET_WG_DATA_CONSTANTS_BASETOOLTIPS:Class = BaseTooltips;

    public static const NET_WG_DATA_CONSTANTS_COMPONENTSTATE:Class = ComponentState;

    public static const NET_WG_DATA_CONSTANTS_CONTEXTMENUCONSTANTS:Class = ContextMenuConstants;

    public static const NET_WG_DATA_CONSTANTS_CURSORS:Class = Cursors;

    public static const NET_WG_DATA_CONSTANTS_DRAGTYPE:Class = DragType;

    public static const NET_WG_DATA_CONSTANTS_ICONTEXTPOSITION:Class = IconTextPosition;

    public static const NET_WG_DATA_CONSTANTS_LOCALES:Class = Locales;

    public static const NET_WG_DATA_CONSTANTS_MARKERSTATE:Class = MarkerState;

    public static const NET_WG_DATA_CONSTANTS_ROLESSTATE:Class = RolesState;

    public static const NET_WG_DATA_CONSTANTS_SORTINGINFO:Class = SortingInfo;

    public static const NET_WG_DATA_CONSTANTS_SOUNDMANAGERSTATESLOBBY:Class = SoundManagerStatesLobby;

    public static const NET_WG_DATA_CONSTANTS_SOUNDTYPES:Class = SoundTypes;

    public static const NET_WG_DATA_CONSTANTS_USERTAGS:Class = UserTags;

    public static const NET_WG_DATA_CONSTANTS_VEHICLEMODULES:Class = VehicleModules;

    public static const NET_WG_DATA_CONSTANTS_VEHICLETYPES:Class = VehicleTypes;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLEDAMAGELOG_IMAGES:Class = BATTLEDAMAGELOG_IMAGES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_EFFICIENCY_TYPES:Class = BATTLE_EFFICIENCY_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BLOCKS_TOOLTIP_TYPES:Class = BLOCKS_TOOLTIP_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_DAMAGE_INDICATOR_ATLAS_ITEMS:Class = DAMAGE_INDICATOR_ATLAS_ITEMS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_DAMAGE_INDICATOR_TYPES:Class = DAMAGE_INDICATOR_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_TANK_TYPES:Class = TANK_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_TOOLTIPS_CONSTANTS:Class = TOOLTIPS_CONSTANTS;

    public static const NET_WG_DATA_MANAGERS_IMPL_FLASHTWEEN:Class = FlashTween;

    public static const NET_WG_DATA_MANAGERS_IMPL_PYTHONTWEEN:Class = PythonTween;

    public static const NET_WG_DATA_MANAGERS_IMPL_TOOLTIPPARAMS:Class = ToolTipParams;

    public static const NET_WG_DATA_MANAGERS_IMPL_TOOLTIPPROPS:Class = TooltipProps;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_BUTTONBAREX:Class = ButtonBarEx;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_CONTENTTABBAR:Class = ContentTabBar;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_FIELDSET:Class = FieldSet;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INVITEINDICATOR:Class = InviteIndicator;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCALABLEICONBUTTON:Class = ScalableIconButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCALABLEICONWRAPPER:Class = ScalableIconWrapper;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTINGBUTTONVO:Class = SortingButtonVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VIEWSTACK:Class = ViewStack;

    public static const NET_WG_GUI_COMPONENTS_COMMON_BASELOGOVIEW:Class = BaseLogoView;

    public static const NET_WG_GUI_COMPONENTS_COMMON_COUNTER:Class = Counter;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VEHICLEMARKERALLY:Class = VehicleMarkerAlly;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VEHICLEMARKERENEMY:Class = VehicleMarkerEnemy;

    public static const NET_WG_GUI_COMPONENTS_COMMON_BUGREPORT_REPORTBUGPANEL:Class = ReportBugPanel;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CURSOR_CURSOR:Class = Cursor;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CURSOR_BASE_BASEINFO:Class = BaseInfo;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CURSOR_BASE_DROPPINGCURSOR:Class = DroppingCursor;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_ANIMATEEXPLOSION:Class = AnimateExplosion;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DAMAGELABEL:Class = DamageLabel;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_HEALTHBAR:Class = HealthBar;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_HEALTHBARANIMATEDLABEL:Class = HealthBarAnimatedLabel;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_HEALTHBARANIMATEDPART:Class = HealthBarAnimatedPart;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_VEHICLEACTIONMARKER:Class = VehicleActionMarker;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_VEHICLEMARKER:Class = VehicleMarker;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_HPDISPLAYMODE:Class = HPDisplayMode;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_VEHICLEMARKERFLAGS:Class = VehicleMarkerFlags;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_VEHICLEMARKERSETTINGS:Class = VehicleMarkerSettings;

    public static const NET_WG_GUI_COMPONENTS_COMMON_MARKERS_DATA_VEHICLEMARKERVO:Class = VehicleMarkerVO;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERDROPDOWN:Class = ServerDropDown;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERHELPER:Class = ServerHelper;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERINFO:Class = ServerInfo;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERSTATS:Class = ServerStats;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERVO:Class = ServerVO;

    public static const NET_WG_GUI_COMPONENTS_COMMON_TICKER_RSSENTRYVO:Class = RSSEntryVO;

    public static const NET_WG_GUI_COMPONENTS_COMMON_TICKER_TICKER:Class = Ticker;

    public static const NET_WG_GUI_COMPONENTS_COMMON_TICKER_TICKERITEM:Class = TickerItem;

    public static const NET_WG_GUI_COMPONENTS_COMMON_TICKER_EVENTS_BATTLETICKEREVENT:Class = BattleTickerEvent;

    public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITING:Class = Waiting;

    public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITINGCOMPONENT:Class = WaitingComponent;

    public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITINGMC:Class = WaitingMc;

    public static const NET_WG_GUI_COMPONENTS_COMMON_WAITING_WAITINGVIEW:Class = WaitingView;

    public static const NET_WG_GUI_COMPONENTS_CONTAINERS_ATLAS:Class = Atlas;

    public static const NET_WG_GUI_COMPONENTS_CONTAINERS_CURSORMANAGEDCONTAINER:Class = CursorManagedContainer;

    public static const NET_WG_GUI_COMPONENTS_CONTAINERS_MAINVIEWCONTAINER:Class = MainViewContainer;

    public static const NET_WG_GUI_COMPONENTS_CONTAINERS_MANAGEDCONTAINER:Class = ManagedContainer;

    public static const NET_WG_GUI_COMPONENTS_CONTAINERS_WAITINGMANAGEDCONTAINER:Class = WaitingManagedContainer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACTIONPRICEBG:Class = ActionPriceBg;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ALERTICO:Class = AlertIco;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ANIMATIONICON:Class = AnimationIcon;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ARROWBUTTON:Class = ArrowButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BITMAPFILL:Class = BitmapFill;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BLACKBUTTON:Class = BlackButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BORDERSHADOWSCROLLPANE:Class = BorderShadowScrollPane;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BUTTONICONBLACK:Class = ButtonIconBlack;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BUTTONICONLOADER:Class = ButtonIconLoader;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BUTTONICONNORMAL:Class = ButtonIconNormal;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BUTTONICONTEXTTRANSPARENT:Class = ButtonIconTextTransparent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BUTTONICONTRANSPARENT:Class = ButtonIconTransparent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CHECKBOX:Class = CheckBox;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CLOSEBUTTON:Class = CloseButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CLOSEBUTTONTEXT:Class = CloseButtonText;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_COMPACTCHECKBOX:Class = CompactCheckBox;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CONTENTTABRENDERER:Class = ContentTabRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CONTEXTMENU:Class = ContextMenu;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CONTEXTMENUITEM:Class = ContextMenuItem;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CONTEXTMENUITEMSEPARATE:Class = ContextMenuItemSeparate;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CORELISTEX:Class = CoreListEx;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_CREWOPERATIONBTN:Class = CrewOperationBtn;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_DRAGABLELISTITEMRENDERER:Class = DragableListItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNIMAGETEXT:Class = DropDownImageText;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNLISTITEMRENDERERSOUND:Class = DropDownListItemRendererSound;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_DROPDOWNMENU:Class = DropdownMenu;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_DYNAMICSCROLLINGLISTEX:Class = DynamicScrollingListEx;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_GLOWARROWASSET:Class = GlowArrowAsset;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPBUTTON:Class = HelpButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HYPERLINK:Class = HyperLink;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_IPROGRESSBAR:Class = IProgressBar;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ITABLERENDERER:Class = ITableRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ICONBUTTON:Class = IconButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ICONTEXT:Class = IconText;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ICONTEXTBIGBUTTON:Class = IconTextBigButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ICONTEXTBUTTON:Class = IconTextButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_IMAGE:Class = Image;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_INFOICON:Class = InfoIcon;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_LABELCONTROL:Class = LabelControl;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_LISTITEMREDERERIMAGETEXT:Class = ListItemRedererImageText;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_LISTITEMRENDERERWITHFOCUSONDIS:Class = ListItemRendererWithFocusOnDis;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_MAINMENUBUTTON:Class = MainMenuButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_NATIONDROPDOWNMENU:Class = NationDropDownMenu;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_NORMALSORTINGBTNVO:Class = NormalSortingBtnVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_NORMALSORTINGBUTTON:Class = NormalSortingButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_NUMERICSTEPPER:Class = NumericStepper;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_PROGRESSBAR:Class = ProgressBar;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_RADIOBUTTON:Class = RadioButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_RANGESLIDER:Class = RangeSlider;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_READONLYSCROLLINGLIST:Class = ReadOnlyScrollingList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_RESIZABLESCROLLPANE:Class = ResizableScrollPane;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_RESIZABLETILELIST:Class = ResizableTileList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLBAR:Class = ScrollBar;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLPANE:Class = ScrollPane;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLTHUMB:Class = ScrollThumb;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLINGLISTEX:Class = ScrollingListEx;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLINGLISTPX:Class = ScrollingListPx;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLINGLISTWITHDISRENDERERS:Class = ScrollingListWithDisRenderers;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SERVERINDICATOR:Class = ServerIndicator;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SERVERRENDERER:Class = ServerRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SIMPLETILELIST:Class = SimpleTileList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLIDER:Class = Slider;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLIDERBG:Class = SliderBg;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLIDERKEYPOINT:Class = SliderKeyPoint;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLIDERLEVELKEYPOINT:Class = SliderLevelKeyPoint;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTBUTTON:Class = SortButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTABLESCROLLINGLIST:Class = SortableScrollingList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SOUNDBUTTON:Class = SoundButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SOUNDBUTTONEX:Class = SoundButtonEx;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SOUNDLISTITEMRENDERER:Class = SoundListItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_STATUSINDICATORANIM:Class = StatusIndicatorAnim;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_STATUSINDICATOREX:Class = StatusIndicatorEx;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_STEPSLIDER:Class = StepSlider;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TABBUTTON:Class = TabButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAINIGBUTTONVO:Class = TankmanTrainigButtonVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TEXTFIELDSHORT:Class = TextFieldShort;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TEXTINPUT:Class = TextInput;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TEXTLOADING:Class = TextLoading;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TILELIST:Class = TileList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TOGGLEINDICATOR:Class = ToggleIndicator;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TOGGLERENDERER:Class = ToggleRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_UILOADERALT:Class = UILoaderAlt;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_UILOADERCUT:Class = UILoaderCut;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_UNITCOMMANDERSTATS:Class = UnitCommanderStats;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_USERNAMEFIELD:Class = UserNameField;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_USERNAMEFIELDSHADOWCOLOR:Class = UserNameFieldShadowColor;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VO_ACTIONPRICEVO:Class = ActionPriceVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VO_SIMPLERENDERERVO:Class = SimpleRendererVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VO_SLOTVO:Class = SlotVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VO_SLOTSPANELPROPSVO:Class = SlotsPanelPropsVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VO_TANKMANTRAININGSMALLBUTTONVO:Class = TankmanTrainingSmallButtonVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VOICE:Class = Voice;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VOICEWAVE:Class = VoiceWave;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_WALLETRESOURCESSTATUS:Class = WalletResourcesStatus;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_WGSCROLLINGLIST:Class = WgScrollingList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTCOMMON:Class = AchievementCommon;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTCOMMONVEHICLE:Class = AchievementCommonVehicle;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTCOUNTER:Class = AchievementCounter;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTDIVISION:Class = AchievementDivision;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTPROGRESS:Class = AchievementProgress;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTPROGRESSBAR:Class = AchievementProgressBar;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_ACHIEVEMENTPROGRESSCOMPONENT:Class = AchievementProgressComponent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_BEIGECOUNTER:Class = BeigeCounter;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_BIGACHIEVEMENT:Class = BigAchievement;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_COUNTERCOMPONENT:Class = CounterComponent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_GREYRIBBONCOUNTER:Class = GreyRibbonCounter;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_REDCOUNTER:Class = RedCounter;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_SMALLCOUNTER:Class = SmallCounter;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACHIEVEMENTS_YELLOWRIBBONCOUNTER:Class = YellowRibbonCounter;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_DATA_ACTIONPRICEBGCONSTANTS:Class = ActionPriceBgConstants;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_DATA_CONSTANTS_TRAININGTYPE:Class = TrainingType;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_DROPDOWNMENUEVENT:Class = DropdownMenuEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_ITEMSELECTORRENDEREREVENT:Class = ItemSelectorRendererEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_RANGESLIDEREVENT:Class = RangeSliderEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_RENDEREREVENT:Class = RendererEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_SCROLLBAREVENT:Class = ScrollBarEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_SCROLLEVENT:Class = ScrollEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_SCROLLPANEEVENT:Class = ScrollPaneEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_SLOTSPANELEVENT:Class = SlotsPanelEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_SORTABLESCROLLINGLISTEVENT:Class = SortableScrollingListEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_USERINFOTEXTEVENT:Class = UserInfoTextEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_COMPONENTSTATESHELPER:Class = ComponentStatesHelper;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_ICONTEXTHELPER:Class = IconTextHelper;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_LISTUTILS:Class = ListUtils;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_SERVERCSISSTATE:Class = ServerCsisState;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_SERVERPINGSTATE:Class = ServerPingState;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_TEXTFIELDLOADINGCONTAINER:Class = TextFieldLoadingContainer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_TEXTLOADINGSTYLE:Class = TextLoadingStyle;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_USERINFOTEXTLOADINGCONTROLLER:Class = UserInfoTextLoadingController;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HELPERS_USERNAMETEXTFIELDLOADINGCONTAINER:Class = UserNameTextFieldLoadingContainer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_INTERFACES_IARROWBUTTON:Class = IArrowButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_INTERFACES_IDRAGGABLELIST:Class = IDraggableList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_INTERFACES_ISERVERINDICATOR:Class = IServerIndicator;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_INTERFACES_ISLIDERKEYPOINT:Class = ISliderKeyPoint;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_INTERFACES_ISORTABLETABLE:Class = ISortableTable;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_LISTSELECTION_ABSTRACTLISTSELECTIONNAVIGATOR:Class = AbstractListSelectionNavigator;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_LISTSELECTION_LISTSELECTIONDIRECTION:Class = ListSelectionDirection;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_COLLECTIONEVENT:Class = CollectionEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_EASE:Class = Ease;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_ILISTVIEWPORT:Class = IListViewPort;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_ISCROLLERBASE:Class = IScrollerBase;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_ISCROLLERITEMRENDERER:Class = IScrollerItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_IVIEWPORT:Class = IViewPort;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_LISTRENDEREREVENT:Class = ListRendererEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_SCROLLERBASE:Class = ScrollerBase;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SCROLLER_DATA_SCROLLCONFIG:Class = ScrollConfig;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRAMMOCOUNTFIELD:Class = CrosshairAmmoCountField;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRARCADE:Class = CrosshairArcade;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRBASE:Class = CrosshairBase;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRDISTANCECONTAINER:Class = CrosshairDistanceContainer;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRDISTANCEFIELD:Class = CrosshairDistanceField;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRPANEL:Class = CrosshairPanel;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRPOSTMORTEM:Class = CrosshairPostmortem;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRRELOADINGTIMEFIELD:Class = CrosshairReloadingTimeField;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRSNIPER:Class = CrosshairSniper;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRSTRATEGIC:Class = CrosshairStrategic;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_ICROSSHAIR:Class = ICrosshair;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_VO_CROSSHAIRSETTINGSVO:Class = CrosshairSettingsVO;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_CROSSHAIRCLIPQUANTITYBAR:Class = CrosshairClipQuantityBar;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_CROSSHAIRCLIPQUANTITYBARCONTAINER:Class = CrosshairClipQuantityBarContainer;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CONSTANTS_CROSSHAIRCONSTS:Class = CrosshairConsts;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CIRCLESTEPPOINTS:Class = CircleStepPoints;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CLIPQUANTITYBAR:Class = ClipQuantityBar;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRBASE:Class = net.wg.gui.components.crosshair.CrosshairBase;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRCIRCLE:Class = CrosshairCircle;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRPANELARCADE:Class = CrosshairPanelArcade;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRPANELBASE:Class = CrosshairPanelBase;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRPANELDAAPI:Class = CrosshairPanelDAAPI;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRPANELPOSTMORTEM:Class = CrosshairPanelPostmortem;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRPANELSNIPER:Class = CrosshairPanelSniper;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRPANELSTRATEGIC:Class = CrosshairPanelStrategic;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRSNIPER:Class = net.wg.gui.components.crosshair.CrosshairSniper;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_CROSSHAIRSTRATEGIC:Class = net.wg.gui.components.crosshair.CrosshairStrategic;

    public static const NET_WG_GUI_COMPONENTS_CROSSHAIR_RELOADINGTIMER:Class = ReloadingTimer;

    public static const NET_WG_GUI_COMPONENTS_INTERFACES_ICOUNTERCOMPONENT:Class = ICounterComponent;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_DSSA:Class = Dssa;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_SEPARATOR:Class = Separator;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPBASE:Class = ToolTipBase;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCOMPLEX:Class = ToolTipComplex;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPRSSNEWS:Class = ToolTipRSSNews;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSPECIAL:Class = ToolTipSpecial;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SUITABLEVEHICLEVO:Class = SuitableVehicleVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBLOCKRESULTVO:Class = ToolTipBlockResultVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBLOCKRIGHTLISTITEMVO:Class = ToolTipBlockRightListItemVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBLOCKVO:Class = ToolTipBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPSTATUSCOLORSVO:Class = ToolTipStatusColorsVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_UNITCOMMANDVO:Class = UnitCommandVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_HELPERS_UTILS:Class = Utils;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_TOOLTIPINBLOCKS:Class = TooltipInBlocks;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_TOOLTIPINBLOCKSUTILS:Class = TooltipInBlocksUtils;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_BASETEXTBLOCK:Class = BaseTextBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_BASETOOLTIPBLOCK:Class = BaseTooltipBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_BUILDUPBLOCK:Class = BuildUpBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_IMAGETEXTBLOCKINBLOCKS:Class = ImageTextBlockInBlocks;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TEXTBLOCK:Class = TextBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_BLOCKDATAITEMVO:Class = BlockDataItemVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_BLOCKSVO:Class = BlocksVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_BUILDUPBLOCKVO:Class = BuildUpBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_IMAGEBLOCKVO:Class = ImageBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_IMAGETEXTBLOCKVO:Class = ImageTextBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TEXTBLOCKVO:Class = TextBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TOOLTIPINBLOCKSVO:Class = TooltipInBlocksVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_EVENTS_TOOLTIPBLOCKEVENT:Class = ToolTipBlockEvent;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_INTERFACES_IPOOLTOOLTIPBLOCK:Class = IPoolTooltipBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_INTERFACES_ITOOLTIPBLOCK:Class = ITooltipBlock;

    public static const NET_WG_GUI_COMPONENTS_WINDOWS_WINDOW:Class = Window;

    public static const NET_WG_GUI_COMPONENTS_WINDOWS_WINDOWEVENT:Class = WindowEvent;

    public static const NET_WG_GUI_DATA_WAITINGPOINTCUTITEMVO:Class = WaitingPointcutItemVO;

    public static const NET_WG_GUI_DATA_WAITINGPOINTCUTSVO:Class = WaitingPointcutsVO;

    public static const NET_WG_GUI_DATA_WAITINGQUEUECOUNTERMESSAGEVO:Class = WaitingQueueCounterMessageVO;

    public static const NET_WG_GUI_DATA_WAITINGQUEUEWINDOWVO:Class = WaitingQueueWindowVO;

    public static const NET_WG_GUI_DIALOGS_ITEMSTATUSDATA:Class = ItemStatusData;

    public static const NET_WG_GUI_DIALOGS_SIMPLEDIALOG:Class = SimpleDialog;

    public static const NET_WG_GUI_EVENTS_ACCORDIONRENDEREREVENT:Class = AccordionRendererEvent;

    public static const NET_WG_GUI_EVENTS_LISTEVENTEX:Class = ListEventEx;

    public static const NET_WG_GUI_EVENTS_NUMERICSTEPPEREVENT:Class = NumericStepperEvent;

    public static const NET_WG_GUI_EVENTS_SORTINGEVENT:Class = SortingEvent;

    public static const NET_WG_GUI_EVENTS_STATEMANAGEREVENT:Class = StateManagerEvent;

    public static const NET_WG_GUI_EVENTS_TIMELINEEVENT:Class = TimelineEvent;

    public static const NET_WG_GUI_EVENTS_UILOADEREVENT:Class = UILoaderEvent;

    public static const NET_WG_GUI_EVENTS_VIEWSTACKCONTENTEVENT:Class = ViewStackContentEvent;

    public static const NET_WG_GUI_EVENTS_VIEWSTACKEVENT:Class = ViewStackEvent;

    public static const NET_WG_GUI_GAMELOADING_GAMELOADING:Class = GameLoading;

    public static const NET_WG_GUI_INTERFACES_IBUTTONICONLOADER:Class = IButtonIconLoader;

    public static const NET_WG_GUI_INTERFACES_IBUTTONICONTEXTTRANSPARENT:Class = IButtonIconTextTransparent;

    public static const NET_WG_GUI_INTERFACES_ICONTENTSIZE:Class = IContentSize;

    public static const NET_WG_GUI_INTERFACES_IGROUPEDCONTROL:Class = IGroupedControl;

    public static const NET_WG_GUI_INTERFACES_ISETTINGSBASE:Class = ISettingsBase;

    public static const NET_WG_GUI_INTERFACES_ISOUNDBUTTON:Class = ISoundButton;

    public static const NET_WG_GUI_INTERFACES_ISOUNDBUTTONEX:Class = ISoundButtonEx;

    public static const NET_WG_GUI_INTERFACES_IUSERVO:Class = IUserVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_CUSTOMACHIEVEMENT:Class = CustomAchievement;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROGRESSSIMPLEINFO:Class = ProgressSimpleInfo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_ADVANCEDGRAPHICCONTENTFORM:Class = AdvancedGraphicContentForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_ADVANCEDGRAPHICSETTINGSFORM:Class = AdvancedGraphicSettingsForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_AIMSETTINGS:Class = AimSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_AIMSETTINGSBASE:Class = AimSettingsBase;

    public static const NET_WG_GUI_LOBBY_SETTINGS_CONTROLSSETTINGS:Class = ControlsSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_CONTROLSSETTINGSBASE:Class = ControlsSettingsBase;

    public static const NET_WG_GUI_LOBBY_SETTINGS_GAMESETTINGS:Class = GameSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_GAMESETTINGSCONTENT:Class = GameSettingsContent;

    public static const NET_WG_GUI_LOBBY_SETTINGS_GRAPHICSETTINGS:Class = GraphicSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_GRAPHICSETTINGSBASE:Class = GraphicSettingsBase;

    public static const NET_WG_GUI_LOBBY_SETTINGS_MARKERSETTINGS:Class = MarkerSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_MARKERSETTINGSBASE:Class = MarkerSettingsBase;

    public static const NET_WG_GUI_LOBBY_SETTINGS_OTHERSETTINGS:Class = OtherSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_OTHERSETTINGSBASE:Class = OtherSettingsBase;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SCREENSETTINGSFORM:Class = ScreenSettingsForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSARCADEFORM:Class = SettingsArcadeForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSBASEVIEW:Class = SettingsBaseView;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSCHANGESMAP:Class = SettingsChangesMap;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSMARKERSFORM:Class = SettingsMarkersForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSSNIPERFORM:Class = SettingsSniperForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SETTINGSWINDOW:Class = SettingsWindow;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SOUNDCOMMONFORM:Class = SoundCommonForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SOUNDSETTINGS:Class = SoundSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SOUNDSETTINGSBASE:Class = SoundSettingsBase;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SOUNDSPECIALFORM:Class = SoundSpecialForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_SOUNDVIVOXFORM:Class = SoundVivoxForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_KEYINPUT:Class = KeyInput;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_KEYSITEMRENDERER:Class = KeysItemRenderer;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_KEYSSCROLLINGLIST:Class = KeysScrollingList;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_RADIOBUTTONBAR:Class = RadioButtonBar;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_SETTINGSSTEPSLIDER:Class = SettingsStepSlider;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_SETTINGSTABBUTTON:Class = SettingsTabButton;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_SOUNDVOICEWAVES:Class = SoundVoiceWaves;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_TABBUTTONBAR:Class = TabButtonBar;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COMPONENTS_EVNTS_KEYINPUTEVENTS:Class = KeyInputEvents;

    public static const NET_WG_GUI_LOBBY_SETTINGS_CONFIG_CONTROLSFACTORY:Class = ControlsFactory;

    public static const NET_WG_GUI_LOBBY_SETTINGS_CONFIG_SETTINGSCONFIGHELPER:Class = SettingsConfigHelper;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COUNTER_SETTINGSCOUNTERDELEGATE:Class = SettingsCounterDelegate;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COUNTER_DATA_TABCOUNTERVO:Class = TabCounterVO;

    public static const NET_WG_GUI_LOBBY_SETTINGS_COUNTER_EVENTS_COUNTEREVENT:Class = CounterEvent;

    public static const NET_WG_GUI_LOBBY_SETTINGS_EVENTS_ALTERNATIVEVOICEEVENT:Class = AlternativeVoiceEvent;

    public static const NET_WG_GUI_LOBBY_SETTINGS_EVENTS_SETTINGVIEWEVENT:Class = SettingViewEvent;

    public static const NET_WG_GUI_LOBBY_SETTINGS_EVENTS_SETTINGSSUBVEWEVENT:Class = SettingsSubVewEvent;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_BASEFORM:Class = BaseForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_BATTLEEVENTSINFOFORM:Class = BattleEventsInfoForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_DAMAGEINDICATORFORM:Class = DamageIndicatorForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_DAMAGEINDICATORSCONTAINER:Class = DamageIndicatorsContainer;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_DAMAGELOGPANELFORM:Class = DamageLogPanelForm;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_FEEDBACKSETTINGS:Class = FeedbackSettings;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_SETTINGSDAMAGELOGCONTAINER:Class = SettingsDamageLogContainer;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_SETTINGSDETAILSDAMAGELOG:Class = SettingsDetailsDamageLog;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_SETTINGSRIBBONCONTAINER:Class = SettingsRibbonContainer;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_SETTINGSRIBBONITEM:Class = SettingsRibbonItem;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_SETTINGSSUMMARYDAMAGELOG:Class = SettingsSummaryDamageLog;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_DAMAGEINDICATOR_DAMAGEINDICATORARROW:Class = DamageIndicatorArrow;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_DAMAGEINDICATOR_DAMAGEINDICATOREXTENDED:Class = DamageIndicatorExtended;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_DAMAGEINDICATOR_DAMAGEINDICATORVEHICLEINFO:Class = DamageIndicatorVehicleInfo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_FEEDBACK_DATA_RIBBONITEMDATA:Class = RibbonItemData;

    public static const NET_WG_GUI_LOBBY_SETTINGS_INTERFACES_IVIEWWITHCOUNTEREDBAR:Class = IViewWithCounteredBar;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CURSORTABSDATAVO:Class = CursorTabsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_INCREASEDZOOMVO:Class = IncreasedZoomVO;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_MARKERTABSDATAVO:Class = MarkerTabsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_SETTINGSCONTROLPROP:Class = SettingsControlProp;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_SETTINGSKEYPROP:Class = SettingsKeyProp;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_TABSDATAVO:Class = TabsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_BASE_SETTINGSDATAINCOMEVO:Class = SettingsDataIncomeVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_BASE_SETTINGSDATAVO:Class = SettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_CONTROLSSETTINGSDATAVO:Class = ControlsSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_FEEDBACKSETTINGSDATAVO:Class = FeedbackSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_GAMESETTINGSDATAVO:Class = GameSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_GRAPHICSETTINGSDATAVO:Class = GraphicSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_OTHERSETTINGSDATAVO:Class = OtherSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_SETTINGCONFIGDATAVO:Class = SettingConfigDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_SOUNDSETTINGSDATAVO:Class = SoundSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_AIM_AIMSETTINGSARCADEDATAVO:Class = AimSettingsArcadeDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_AIM_AIMSETTINGSDATAVO:Class = AimSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_AIM_AIMSETTINGSSNIPERDATAVO:Class = AimSettingsSniperDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_FEEDBACK_BATTLEEVENTINFODATAVO:Class = BattleEventInfoDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_FEEDBACK_DAMAGEINDICATORDATAVO:Class = DamageIndicatorDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_FEEDBACK_DAMAGELOGPANELDATAVO:Class = DamageLogPanelDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_MARKER_MARKERALLYSETTINGSDATAVO:Class = MarkerAllySettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_MARKER_MARKERDEADSETTINGSDATAVO:Class = MarkerDeadSettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_MARKER_MARKERENEMYSETTINGSDATAVO:Class = MarkerEnemySettingsDataVo;

    public static const NET_WG_GUI_LOBBY_SETTINGS_VO_CONFIG_MARKER_MARKERSETTINGSDATAVO:Class = MarkerSettingsDataVo;

    public static const NET_WG_GUI_RALLY_VO_VEHICLEVO:Class = VehicleVO;

    public static const NET_WG_GUI_TUTORIAL_DATA_BONUSITEMVO:Class = BonusItemVO;

    public static const NET_WG_GUI_TUTORIAL_DATA_BONUSVALUESVO:Class = BonusValuesVO;

    public static const NET_WG_GUI_TUTORIAL_DATA_TUTORIALDIALOGVO:Class = TutorialDialogVO;

    public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALDIALOG:Class = TutorialDialog;

    public static const NET_WG_GUI_UTILS_EXCLUDETWEENMANAGER:Class = ExcludeTweenManager;

    public static const NET_WG_GUI_UTILS_FRAMEWALKER:Class = FrameWalker;

    public static const NET_WG_GUI_UTILS_IFRAMEWALKER:Class = IFrameWalker;

    public static const NET_WG_GUI_UTILS_PERCENTFRAMEWALKER:Class = PercentFrameWalker;

    public static const NET_WG_GUI_UTILS_ROOTSWFATLASMANAGER:Class = RootSWFAtlasManager;

    public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTVIEW:Class = AbstractView;

    public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTWINDOWVIEW:Class = AbstractWindowView;

    public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTWRAPPERVIEW:Class = AbstractWrapperView;

    public static const NET_WG_INFRASTRUCTURE_BASE_DEFAULTWINDOWGEOMETRY:Class = DefaultWindowGeometry;

    public static const NET_WG_INFRASTRUCTURE_BASE_SIMPLECONTAINER:Class = SimpleContainer;

    public static const NET_WG_INFRASTRUCTURE_BASE_STOREDWINDOWGEOMETRY:Class = StoredWindowGeometry;

    public static const NET_WG_INFRASTRUCTURE_BASE_INTERFACES_IWAITING:Class = IWaiting;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IAIMMETA:Class = IAimMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICROSSHAIRPANELMETA:Class = ICrosshairPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICURSORMETA:Class = ICursorMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IREPORTBUGPANELMETA:Class = IReportBugPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISERVERSTATSMETA:Class = IServerStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISETTINGSWINDOWMETA:Class = ISettingsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISIMPLEDIALOGMETA:Class = ISimpleDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITICKERMETA:Class = ITickerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITUTORIALDIALOGMETA:Class = ITutorialDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AIMMETA:Class = AimMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CROSSHAIRPANELMETA:Class = CrosshairPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CURSORMETA:Class = CursorMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_REPORTBUGPANELMETA:Class = ReportBugPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SERVERSTATSMETA:Class = ServerStatsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SETTINGSWINDOWMETA:Class = SettingsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SIMPLEDIALOGMETA:Class = SimpleDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TICKERMETA:Class = TickerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TUTORIALDIALOGMETA:Class = TutorialDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WAITINGVIEWMETA:Class = WaitingViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WINDOWVIEWMETA:Class = WindowViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WRAPPERVIEWMETA:Class = WrapperViewMeta;

    public static const NET_WG_INFRASTRUCTURE_CONSTANTS_WINDOWVIEWINVALIDATIONTYPE:Class = WindowViewInvalidationType;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_COLORSCHEMEEVENT:Class = ColorSchemeEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_ICONLOADEREVENT:Class = IconLoaderEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_LISTDATAPROVIDEREVENT:Class = ListDataProviderEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_POOLITEMEVENT:Class = PoolItemEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_VOICECHATEVENT:Class = VoiceChatEvent;

    public static const NET_WG_INFRASTRUCTURE_INTERFACES_IFOCUSCHAINCONTAINER:Class = IFocusChainContainer;

    public static const NET_WG_INFRASTRUCTURE_INTERFACES_ILISTDAAPIDATAPROVIDER:Class = IListDAAPIDataProvider;

    public static const NET_WG_INFRASTRUCTURE_MANAGERS_COUNTER_COUNTERMANAGER:Class = CounterManager;

    public static const NET_WG_INFRASTRUCTURE_MANAGERS_COUNTER_COUNTERPROPS:Class = CounterProps;

    public static const NET_WG_INFRASTRUCTURE_MANAGERS_POOL_COMPONENTSPOOL:Class = ComponentsPool;

    public static const NET_WG_INFRASTRUCTURE_MANAGERS_POOL_POOL:Class = Pool;

    public static const NET_WG_INFRASTRUCTURE_MANAGERS_POOL_POOLMANAGER:Class = PoolManager;

    public function ClassManagerBaseMeta() {
        super();
    }
}
}
