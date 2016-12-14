package net.wg.infrastructure.base.meta.impl {
import net.wg.data.ContainerConstants;
import net.wg.data.FilterDAAPIDataProvider;
import net.wg.data.InspectableDataProvider;
import net.wg.data.SortableVoDAAPIDataProvider;
import net.wg.data.VO.AnimationObject;
import net.wg.data.VO.AwardsItemVO;
import net.wg.data.VO.BattleResultsQuestVO;
import net.wg.data.VO.ButtonPropertiesVO;
import net.wg.data.VO.ConfirmDialogVO;
import net.wg.data.VO.ConfirmExchangeBlockVO;
import net.wg.data.VO.ConfirmExchangeDialogVO;
import net.wg.data.VO.DialogSettingsVO;
import net.wg.data.VO.ExtendedUserVO;
import net.wg.data.VO.ILditInfo;
import net.wg.data.VO.PointVO;
import net.wg.data.VO.ProgressElementVO;
import net.wg.data.VO.RefSysReferralsIntroVO;
import net.wg.data.VO.ReferralReferrerIntroVO;
import net.wg.data.VO.ReferralTextBlockVO;
import net.wg.data.VO.SellDialogElement;
import net.wg.data.VO.SellDialogItem;
import net.wg.data.VO.ShopSubFilterData;
import net.wg.data.VO.ShopVehicleFilterElementData;
import net.wg.data.VO.StoreTableData;
import net.wg.data.VO.StoreTableVO;
import net.wg.data.VO.TankmanAchievementVO;
import net.wg.data.VO.TankmanCardVO;
import net.wg.data.VO.TrainingFormRendererVO;
import net.wg.data.VO.TrainingFormVO;
import net.wg.data.VO.TrainingRoomInfoVO;
import net.wg.data.VO.TrainingRoomListVO;
import net.wg.data.VO.TrainingRoomRendererVO;
import net.wg.data.VO.TrainingRoomTeamVO;
import net.wg.data.VO.TrainingWindowVO;
import net.wg.data.VO.WalletStatusVO;
import net.wg.data.VO.generated.ShopNationFilterData;
import net.wg.data.VoDAAPIDataProvider;
import net.wg.data.components.StoreMenuViewData;
import net.wg.data.components.UserContextItem;
import net.wg.data.components.VehicleContextMenuGenerator;
import net.wg.data.constants.ArenaBonusTypes;
import net.wg.data.constants.Currencies;
import net.wg.data.constants.Dialogs;
import net.wg.data.constants.Directions;
import net.wg.data.constants.GunTypes;
import net.wg.data.constants.ItemTypes;
import net.wg.data.constants.LobbyShared;
import net.wg.data.constants.ProgressIndicatorStates;
import net.wg.data.constants.QuestsStates;
import net.wg.data.constants.RolesState;
import net.wg.data.constants.ValObject;
import net.wg.data.constants.VehicleState;
import net.wg.data.constants.VehicleTypes;
import net.wg.data.constants.generated.ACHIEVEMENTS_ALIASES;
import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
import net.wg.data.constants.generated.AWARDWINDOW_CONSTANTS;
import net.wg.data.constants.generated.BARRACKS_CONSTANTS;
import net.wg.data.constants.generated.BATTLE_RESULT_TYPES;
import net.wg.data.constants.generated.BATTLE_SELECTOR_TYPES;
import net.wg.data.constants.generated.BOOSTER_CONSTANTS;
import net.wg.data.constants.generated.BROWSER_CONSTANTS;
import net.wg.data.constants.generated.CHRISTMAS_ALIASES;
import net.wg.data.constants.generated.CLANS_ALIASES;
import net.wg.data.constants.generated.COMPANY_ALIASES;
import net.wg.data.constants.generated.CONFIRM_DIALOG_ALIASES;
import net.wg.data.constants.generated.CONFIRM_EXCHANGE_DIALOG_TYPES;
import net.wg.data.constants.generated.CONTACTS_ALIASES;
import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.data.constants.generated.CUSTOMIZATION_BONUS_ANIMATION_TYPES;
import net.wg.data.constants.generated.CUSTOMIZATION_ITEM_TYPE;
import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
import net.wg.data.constants.generated.CYBER_SPORT_HELP_IDS;
import net.wg.data.constants.generated.FALLOUT_ALIASES;
import net.wg.data.constants.generated.FITTING_TYPES;
import net.wg.data.constants.generated.FORMATION_MEMBER_TYPE;
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
import net.wg.data.constants.generated.GE_ALIASES;
import net.wg.data.constants.generated.HANGAR_ALIASES;
import net.wg.data.constants.generated.LADDER_STATES;
import net.wg.data.constants.generated.MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES;
import net.wg.data.constants.generated.NODE_STATE_FLAGS;
import net.wg.data.constants.generated.ORDER_TYPES;
import net.wg.data.constants.generated.PREBATTLE_ALIASES;
import net.wg.data.constants.generated.PROFILE_DROPDOWN_KEYS;
import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.data.constants.generated.QUEST_TASKS_STATES;
import net.wg.data.constants.generated.QUEST_TASK_FILTERS_TYPES;
import net.wg.data.constants.generated.SKILLS_CONSTANTS;
import net.wg.data.constants.generated.SQUADTYPES;
import net.wg.data.constants.generated.STORE_CONSTANTS;
import net.wg.data.constants.generated.STORE_TYPES;
import net.wg.data.constants.generated.TEXT_ALIGN;
import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
import net.wg.data.managers.impl.DialogDispatcher;
import net.wg.data.managers.impl.NotifyProperties;
import net.wg.data.utilData.ItemPrice;
import net.wg.data.utilData.TankmanRoleLevel;
import net.wg.gui.components.advanced.Accordion;
import net.wg.gui.components.advanced.AdvancedLineDescrIconText;
import net.wg.gui.components.advanced.AmmunitionButton;
import net.wg.gui.components.advanced.BackButton;
import net.wg.gui.components.advanced.BlinkingButton;
import net.wg.gui.components.advanced.ButtonToggleIndicator;
import net.wg.gui.components.advanced.Calendar;
import net.wg.gui.components.advanced.ClanEmblem;
import net.wg.gui.components.advanced.ComplexProgressIndicator;
import net.wg.gui.components.advanced.CooldownAnimationController;
import net.wg.gui.components.advanced.CooldownSlot;
import net.wg.gui.components.advanced.CounterEx;
import net.wg.gui.components.advanced.DashLine;
import net.wg.gui.components.advanced.DashLineTextItem;
import net.wg.gui.components.advanced.DoubleProgressBar;
import net.wg.gui.components.advanced.Dummy;
import net.wg.gui.components.advanced.ExtraModuleIcon;
import net.wg.gui.components.advanced.HelpLayoutControl;
import net.wg.gui.components.advanced.IndicationOfStatus;
import net.wg.gui.components.advanced.InteractiveSortingButton;
import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.gui.components.advanced.LineDescrIconText;
import net.wg.gui.components.advanced.LineIconText;
import net.wg.gui.components.advanced.ModuleIcon;
import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
import net.wg.gui.components.advanced.NormalButtonToggleWG;
import net.wg.gui.components.advanced.PortraitItemRenderer;
import net.wg.gui.components.advanced.RecruitParametersComponent;
import net.wg.gui.components.advanced.ScalableIconWrapper;
import net.wg.gui.components.advanced.SearchInput;
import net.wg.gui.components.advanced.ShellButton;
import net.wg.gui.components.advanced.ShellsSet;
import net.wg.gui.components.advanced.SkillsItemRenderer;
import net.wg.gui.components.advanced.SkillsLevelItemRenderer;
import net.wg.gui.components.advanced.SortableHeaderButtonBar;
import net.wg.gui.components.advanced.SortingButton;
import net.wg.gui.components.advanced.StatisticItem;
import net.wg.gui.components.advanced.StatusDeltaIndicatorAnim;
import net.wg.gui.components.advanced.TankIcon;
import net.wg.gui.components.advanced.TankmanCard;
import net.wg.gui.components.advanced.TextArea;
import net.wg.gui.components.advanced.TextAreaSimple;
import net.wg.gui.components.advanced.ToggleButton;
import net.wg.gui.components.advanced.UnderlinedText;
import net.wg.gui.components.advanced.backButton.BackButtonHelper;
import net.wg.gui.components.advanced.backButton.BackButtonStates;
import net.wg.gui.components.advanced.backButton.BackButtonText;
import net.wg.gui.components.advanced.calendar.DayRenderer;
import net.wg.gui.components.advanced.calendar.WeekDayRenderer;
import net.wg.gui.components.advanced.events.CalendarEvent;
import net.wg.gui.components.advanced.events.DummyEvent;
import net.wg.gui.components.advanced.events.RecruitParamsEvent;
import net.wg.gui.components.advanced.events.TutorialHelpBtnEvent;
import net.wg.gui.components.advanced.events.TutorialHintEvent;
import net.wg.gui.components.advanced.interfaces.IBackButton;
import net.wg.gui.components.advanced.interfaces.IComplexProgressStepRenderer;
import net.wg.gui.components.advanced.interfaces.ICooldownSlot;
import net.wg.gui.components.advanced.interfaces.IDashLineTextItem;
import net.wg.gui.components.advanced.interfaces.IDummy;
import net.wg.gui.components.advanced.interfaces.ISearchInput;
import net.wg.gui.components.advanced.interfaces.IStatusDeltaIndicatorAnim;
import net.wg.gui.components.advanced.interfaces.ITutorialHintAnimation;
import net.wg.gui.components.advanced.interfaces.ITutorialHintArrowAnimation;
import net.wg.gui.components.advanced.interfaces.ITutorialHintTextAnimation;
import net.wg.gui.components.advanced.screenTab.ScreenTabButton;
import net.wg.gui.components.advanced.screenTab.ScreenTabButtonBar;
import net.wg.gui.components.advanced.screenTab.ScreenTabButtonBg;
import net.wg.gui.components.advanced.tutorial.TutorialContextHint;
import net.wg.gui.components.advanced.tutorial.TutorialContextOverlay;
import net.wg.gui.components.advanced.tutorial.TutorialHint;
import net.wg.gui.components.advanced.tutorial.TutorialHintAnimation;
import net.wg.gui.components.advanced.tutorial.TutorialHintArrowAnimation;
import net.wg.gui.components.advanced.tutorial.TutorialHintText;
import net.wg.gui.components.advanced.tutorial.TutorialHintTextAnimation;
import net.wg.gui.components.advanced.tutorial.TutorialHintTextAnimationMc;
import net.wg.gui.components.advanced.vo.ComplexProgressIndicatorVO;
import net.wg.gui.components.advanced.vo.DummyVO;
import net.wg.gui.components.advanced.vo.NormalSortingTableHeaderVO;
import net.wg.gui.components.advanced.vo.RecruitParametersVO;
import net.wg.gui.components.advanced.vo.StatisticItemVo;
import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;
import net.wg.gui.components.advanced.vo.TruncateHtmlTextVO;
import net.wg.gui.components.advanced.vo.TutorialBtnControllerVO;
import net.wg.gui.components.advanced.vo.TutorialContextHintVO;
import net.wg.gui.components.advanced.vo.TutorialContextOverlayVO;
import net.wg.gui.components.advanced.vo.TutorialContextVO;
import net.wg.gui.components.advanced.vo.TutorialHintVO;
import net.wg.gui.components.carousels.AchievementCarousel;
import net.wg.gui.components.carousels.CarouselBase;
import net.wg.gui.components.carousels.HorizontalScroller;
import net.wg.gui.components.carousels.HorizontalScrollerCursorManager;
import net.wg.gui.components.carousels.HorizontalScrollerViewPort;
import net.wg.gui.components.carousels.PortraitsCarousel;
import net.wg.gui.components.carousels.ScrollCarousel;
import net.wg.gui.components.carousels.SkillsCarousel;
import net.wg.gui.components.carousels.TooltipDecorator;
import net.wg.gui.components.carousels.interfaces.ICarouselItemRenderer;
import net.wg.gui.components.carousels.interfaces.IHorizontalScrollerCursorManager;
import net.wg.gui.components.common.ConfirmComponent;
import net.wg.gui.components.common.ConfirmItemComponent;
import net.wg.gui.components.common.InputChecker;
import net.wg.gui.components.common.containers.EqualGapsHorizontalLayout;
import net.wg.gui.components.common.containers.EqualWidthHorizontalLayout;
import net.wg.gui.components.common.containers.Group;
import net.wg.gui.components.common.containers.GroupEx;
import net.wg.gui.components.common.containers.GroupLayout;
import net.wg.gui.components.common.containers.HorizontalGroupLayout;
import net.wg.gui.components.common.containers.IGroupEx;
import net.wg.gui.components.common.containers.Vertical100PercWidthLayout;
import net.wg.gui.components.common.containers.VerticalGroupLayout;
import net.wg.gui.components.common.serverStats.ServerDropDown;
import net.wg.gui.components.common.serverStats.ServerHelper;
import net.wg.gui.components.common.serverStats.ServerInfo;
import net.wg.gui.components.common.serverStats.ServerStats;
import net.wg.gui.components.common.serverStats.ServerVO;
import net.wg.gui.components.common.video.NetStreamStatusCode;
import net.wg.gui.components.common.video.NetStreamStatusLevel;
import net.wg.gui.components.common.video.SimpleVideoPlayer;
import net.wg.gui.components.common.video.VideoPlayerEvent;
import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
import net.wg.gui.components.controls.AccordionSoundRenderer;
import net.wg.gui.components.controls.ActionPrice;
import net.wg.gui.components.controls.BaseDropList;
import net.wg.gui.components.controls.GlowArrowAsset;
import net.wg.gui.components.controls.HangarQuestsButton;
import net.wg.gui.components.controls.NormalSortingBtnVO;
import net.wg.gui.components.controls.NormalSortingButton;
import net.wg.gui.components.controls.ProgressBar;
import net.wg.gui.components.controls.SortButton;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.components.controls.SortableTableList;
import net.wg.gui.components.controls.TableRenderer;
import net.wg.gui.components.controls.TankmanTrainigButtonVO;
import net.wg.gui.components.controls.TankmanTrainingButton;
import net.wg.gui.components.controls.TankmanTrainingSmallButton;
import net.wg.gui.components.controls.TileList;
import net.wg.gui.components.controls.UnitCommanderStats;
import net.wg.gui.components.controls.VerticalListViewPort;
import net.wg.gui.components.controls.Voice;
import net.wg.gui.components.controls.VoiceWave;
import net.wg.gui.components.controls.WalletResourcesStatus;
import net.wg.gui.components.controls.WgScrollingList;
import net.wg.gui.components.controls.events.VerticalListViewportEvent;
import net.wg.gui.components.controls.slotsPanel.ISlotsPanel;
import net.wg.gui.components.controls.slotsPanel.impl.BaseSlotsPanel;
import net.wg.gui.components.interfaces.IAccordionItemRenderer;
import net.wg.gui.components.interfaces.IHangarQuestsButton;
import net.wg.gui.components.interfaces.IReusableListItemRenderer;
import net.wg.gui.components.interfaces.IToolTipRefSysAwardsBlock;
import net.wg.gui.components.interfaces.IToolTipRefSysXPMultiplierBlock;
import net.wg.gui.components.miniclient.BattleTypeMiniClientComponent;
import net.wg.gui.components.miniclient.HangarMiniClientComponent;
import net.wg.gui.components.miniclient.LinkedMiniClientComponent;
import net.wg.gui.components.miniclient.TechTreeMiniClientComponent;
import net.wg.gui.components.tooltips.AchievementsCustomBlockItem;
import net.wg.gui.components.tooltips.ExtraModuleInfo;
import net.wg.gui.components.tooltips.IgrPremVehQuestBlock;
import net.wg.gui.components.tooltips.IgrQuestBlock;
import net.wg.gui.components.tooltips.IgrQuestProgressBlock;
import net.wg.gui.components.tooltips.ModuleItem;
import net.wg.gui.components.tooltips.Status;
import net.wg.gui.components.tooltips.SuitableVehicleBlockItem;
import net.wg.gui.components.tooltips.ToolTipAchievement;
import net.wg.gui.components.tooltips.ToolTipActionPrice;
import net.wg.gui.components.tooltips.ToolTipBuySkill;
import net.wg.gui.components.tooltips.ToolTipClanCommonInfo;
import net.wg.gui.components.tooltips.ToolTipClanInfo;
import net.wg.gui.components.tooltips.ToolTipColumnFields;
import net.wg.gui.components.tooltips.ToolTipCustomizationItem;
import net.wg.gui.components.tooltips.ToolTipFortDivision;
import net.wg.gui.components.tooltips.ToolTipFortSortie;
import net.wg.gui.components.tooltips.ToolTipIGR;
import net.wg.gui.components.tooltips.ToolTipLadder;
import net.wg.gui.components.tooltips.ToolTipLadderRegulations;
import net.wg.gui.components.tooltips.ToolTipMap;
import net.wg.gui.components.tooltips.ToolTipMapSmall;
import net.wg.gui.components.tooltips.ToolTipMarkOfMastery;
import net.wg.gui.components.tooltips.ToolTipMarksOnGun;
import net.wg.gui.components.tooltips.ToolTipPrivateQuests;
import net.wg.gui.components.tooltips.ToolTipRefSysAwards;
import net.wg.gui.components.tooltips.ToolTipRefSysAwardsBlock;
import net.wg.gui.components.tooltips.ToolTipRefSysDescription;
import net.wg.gui.components.tooltips.ToolTipRefSysXPMultiplier;
import net.wg.gui.components.tooltips.ToolTipRefSysXPMultiplierBlock;
import net.wg.gui.components.tooltips.ToolTipSelectedVehicle;
import net.wg.gui.components.tooltips.ToolTipSkill;
import net.wg.gui.components.tooltips.ToolTipSortieDivision;
import net.wg.gui.components.tooltips.ToolTipSuitableVehicle;
import net.wg.gui.components.tooltips.ToolTipTankmen;
import net.wg.gui.components.tooltips.ToolTipUnitLevel;
import net.wg.gui.components.tooltips.TooltipContact;
import net.wg.gui.components.tooltips.TooltipEnvironment;
import net.wg.gui.components.tooltips.TooltipUnitCommand;
import net.wg.gui.components.tooltips.VO.AchievementVO;
import net.wg.gui.components.tooltips.VO.ColumnFieldsVo;
import net.wg.gui.components.tooltips.VO.ContactTooltipVO;
import net.wg.gui.components.tooltips.VO.CustomizationItemVO;
import net.wg.gui.components.tooltips.VO.Dimension;
import net.wg.gui.components.tooltips.VO.DivisionVO;
import net.wg.gui.components.tooltips.VO.EquipmentParamVO;
import net.wg.gui.components.tooltips.VO.ExtraModuleInfoVO;
import net.wg.gui.components.tooltips.VO.FortClanCommonInfoVO;
import net.wg.gui.components.tooltips.VO.FortClanInfoVO;
import net.wg.gui.components.tooltips.VO.FortDivisionVO;
import net.wg.gui.components.tooltips.VO.IgrVO;
import net.wg.gui.components.tooltips.VO.LadderVO;
import net.wg.gui.components.tooltips.VO.MapVO;
import net.wg.gui.components.tooltips.VO.ModuleVO;
import net.wg.gui.components.tooltips.VO.PersonalCaseBlockItemVO;
import net.wg.gui.components.tooltips.VO.PremDaysVo;
import net.wg.gui.components.tooltips.VO.PrivateQuestsVO;
import net.wg.gui.components.tooltips.VO.SettingsControlVO;
import net.wg.gui.components.tooltips.VO.SortieDivisionVO;
import net.wg.gui.components.tooltips.VO.SuitableVehicleVO;
import net.wg.gui.components.tooltips.VO.TankmenVO;
import net.wg.gui.components.tooltips.VO.ToolTipActionPriceVO;
import net.wg.gui.components.tooltips.VO.ToolTipBuySkillVO;
import net.wg.gui.components.tooltips.VO.ToolTipFortSortieVO;
import net.wg.gui.components.tooltips.VO.ToolTipLadderRegulationsVO;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysAwardsBlockVO;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysAwardsVO;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysDescriptionVO;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysXPMultiplierBlockVO;
import net.wg.gui.components.tooltips.VO.ToolTipRefSysXPMultiplierVO;
import net.wg.gui.components.tooltips.VO.ToolTipSkillVO;
import net.wg.gui.components.tooltips.VO.ToolTipTankClassVO;
import net.wg.gui.components.tooltips.VO.ToolTipUnitLevelVO;
import net.wg.gui.components.tooltips.VO.TooltipEnvironmentVO;
import net.wg.gui.components.tooltips.VO.finalStats.HeadBlockData;
import net.wg.gui.components.tooltips.VO.finalStats.TotalItemsBlockData;
import net.wg.gui.components.tooltips.finstats.EfficiencyBlock;
import net.wg.gui.components.tooltips.finstats.HeadBlock;
import net.wg.gui.components.tooltips.finstats.TotalItemsBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.AbstractTextParameterBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.ImageBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.ImageListBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.SaleTextParameterBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.StatusDeltaParameterBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.TextParameterBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.TextParameterWithIconBlock;
import net.wg.gui.components.tooltips.inblocks.blocks.XmasEventProgressBlock;
import net.wg.gui.components.tooltips.inblocks.components.ImageRenderer;
import net.wg.gui.components.tooltips.inblocks.data.ImageListBlockVO;
import net.wg.gui.components.tooltips.inblocks.data.SaleTextParameterVO;
import net.wg.gui.components.tooltips.inblocks.data.StatusDeltaParameterBlockVO;
import net.wg.gui.components.tooltips.inblocks.data.TextParameterVO;
import net.wg.gui.components.tooltips.inblocks.data.TextParameterWithIconVO;
import net.wg.gui.components.tooltips.inblocks.data.XmasEventProgressBlockVO;
import net.wg.gui.components.tooltips.sortie.SortieDivisionBlock;
import net.wg.gui.components.waitingQueue.WaitingQueueMessageHelper;
import net.wg.gui.components.waitingQueue.WaitingQueueMessageUpdater;
import net.wg.gui.components.windows.ScreenBg;
import net.wg.gui.components.windows.SimpleWindow;
import net.wg.gui.components.windows.vo.SimpleWindowBtnVo;
import net.wg.gui.crewOperations.CrewOperationEvent;
import net.wg.gui.crewOperations.CrewOperationInfoVO;
import net.wg.gui.crewOperations.CrewOperationWarningVO;
import net.wg.gui.crewOperations.CrewOperationsIRFooter;
import net.wg.gui.crewOperations.CrewOperationsIRenderer;
import net.wg.gui.crewOperations.CrewOperationsInitVO;
import net.wg.gui.crewOperations.CrewOperationsPopOver;
import net.wg.gui.cyberSport.CSConstants;
import net.wg.gui.cyberSport.CSInvalidationType;
import net.wg.gui.cyberSport.CyberSportMainWindow;
import net.wg.gui.cyberSport.controls.CSAnimation;
import net.wg.gui.cyberSport.controls.CSAnimationIcon;
import net.wg.gui.cyberSport.controls.CSCandidatesScrollingList;
import net.wg.gui.cyberSport.controls.CSLadderIconButton;
import net.wg.gui.cyberSport.controls.CSRallyInfo;
import net.wg.gui.cyberSport.controls.CSVehicleButton;
import net.wg.gui.cyberSport.controls.CSVehicleButtonLevels;
import net.wg.gui.cyberSport.controls.CandidateHeaderItemRender;
import net.wg.gui.cyberSport.controls.CandidateItemRenderer;
import net.wg.gui.cyberSport.controls.CommandRenderer;
import net.wg.gui.cyberSport.controls.DynamicRangeVehicles;
import net.wg.gui.cyberSport.controls.ManualSearchRenderer;
import net.wg.gui.cyberSport.controls.MedalVehicleVO;
import net.wg.gui.cyberSport.controls.NavigationBlock;
import net.wg.gui.cyberSport.controls.RangeViewComponent;
import net.wg.gui.cyberSport.controls.RosterButtonGroup;
import net.wg.gui.cyberSport.controls.RosterSettingsNumerationBlock;
import net.wg.gui.cyberSport.controls.SelectedVehiclesMsg;
import net.wg.gui.cyberSport.controls.SettingsIcons;
import net.wg.gui.cyberSport.controls.VehicleSelector;
import net.wg.gui.cyberSport.controls.VehicleSelectorItemRenderer;
import net.wg.gui.cyberSport.controls.VehicleSelectorNavigator;
import net.wg.gui.cyberSport.controls.WaitingAlert;
import net.wg.gui.cyberSport.controls.data.CSAnimationVO;
import net.wg.gui.cyberSport.controls.data.CSRallyInfoVO;
import net.wg.gui.cyberSport.controls.data.CSVehicleButtonSelectionVO;
import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
import net.wg.gui.cyberSport.controls.events.CSRallyInfoEvent;
import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
import net.wg.gui.cyberSport.data.CandidatesDataProvider;
import net.wg.gui.cyberSport.data.RosterSlotSettingsWindowStaticVO;
import net.wg.gui.cyberSport.interfaces.IAutoSearchFormView;
import net.wg.gui.cyberSport.interfaces.ICSAutoSearchMainView;
import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
import net.wg.gui.cyberSport.interfaces.IManualSearchDataProvider;
import net.wg.gui.cyberSport.popups.VehicleSelectorPopup;
import net.wg.gui.cyberSport.staticFormation.InvitesAndRequestsWindow;
import net.wg.gui.cyberSport.staticFormation.StaticFormationProfileWindow;
import net.wg.gui.cyberSport.staticFormation.components.BestTanksMapsItem;
import net.wg.gui.cyberSport.staticFormation.components.FormationAppointmentComponent;
import net.wg.gui.cyberSport.staticFormation.components.LadderIconMessage;
import net.wg.gui.cyberSport.staticFormation.components.StaticFormationAwardsContainer;
import net.wg.gui.cyberSport.staticFormation.components.StaticFormationConstants;
import net.wg.gui.cyberSport.staticFormation.components.StaticFormationProfileEmblem;
import net.wg.gui.cyberSport.staticFormation.components.StaticFormationStatsContainer;
import net.wg.gui.cyberSport.staticFormation.components.StaticFormationStatsItem;
import net.wg.gui.cyberSport.staticFormation.components.renderers.InvitesAndRequestsItemRenderer;
import net.wg.gui.cyberSport.staticFormation.components.renderers.StaticFormationLadderTableRenderer;
import net.wg.gui.cyberSport.staticFormation.components.renderers.StaticFormationStaffTableRenderer;
import net.wg.gui.cyberSport.staticFormation.data.FormationAppointmentVO;
import net.wg.gui.cyberSport.staticFormation.data.InvitesAndRequestsDataProvider;
import net.wg.gui.cyberSport.staticFormation.data.InvitesAndRequestsItemVO;
import net.wg.gui.cyberSport.staticFormation.data.InvitesAndRequestsVO;
import net.wg.gui.cyberSport.staticFormation.data.LadderIconMessageVO;
import net.wg.gui.cyberSport.staticFormation.data.LadderStateDataVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLDITVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderTableRendererVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewHeaderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewIconsVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationLadderViewLadderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileButtonInfoVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileEmblemVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationProfileWindowVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffContextMenuVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffTableRendererVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewHeaderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewStaffVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStaffViewStaticHeaderVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsItemVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationStatsViewVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationSummaryVO;
import net.wg.gui.cyberSport.staticFormation.data.StaticFormationUnitViewHeaderVO;
import net.wg.gui.cyberSport.staticFormation.events.FormationAppointmentEvent;
import net.wg.gui.cyberSport.staticFormation.events.FormationLadderEvent;
import net.wg.gui.cyberSport.staticFormation.events.FormationStaffEvent;
import net.wg.gui.cyberSport.staticFormation.events.InvitesAndRequestsAcceptEvent;
import net.wg.gui.cyberSport.staticFormation.events.StaticFormationStatsEvent;
import net.wg.gui.cyberSport.staticFormation.interfaces.ITextClickDelegate;
import net.wg.gui.cyberSport.staticFormation.views.IStaticFormationProfileEmblem;
import net.wg.gui.cyberSport.staticFormation.views.IStaticFormationStatsView;
import net.wg.gui.cyberSport.staticFormation.views.IStaticFormationSummaryView;
import net.wg.gui.cyberSport.staticFormation.views.StaticFormationLadderView;
import net.wg.gui.cyberSport.staticFormation.views.StaticFormationStaffView;
import net.wg.gui.cyberSport.staticFormation.views.StaticFormationUnitView;
import net.wg.gui.cyberSport.staticFormation.views.impl.StaticFormationStatsView;
import net.wg.gui.cyberSport.staticFormation.views.impl.StaticFormationSummaryView;
import net.wg.gui.cyberSport.views.AnimatedRosterSettingsView;
import net.wg.gui.cyberSport.views.IntroView;
import net.wg.gui.cyberSport.views.RangeRosterSettingsView;
import net.wg.gui.cyberSport.views.RosterSettingsView;
import net.wg.gui.cyberSport.views.RosterSlotSettingsWindow;
import net.wg.gui.cyberSport.views.UnitView;
import net.wg.gui.cyberSport.views.UnitsListView;
import net.wg.gui.cyberSport.views.autoSearch.CSAutoSearchMainView;
import net.wg.gui.cyberSport.views.autoSearch.ConfirmationReadinessStatus;
import net.wg.gui.cyberSport.views.autoSearch.ErrorState;
import net.wg.gui.cyberSport.views.autoSearch.SearchCommands;
import net.wg.gui.cyberSport.views.autoSearch.SearchEnemy;
import net.wg.gui.cyberSport.views.autoSearch.SearchEnemyRespawn;
import net.wg.gui.cyberSport.views.autoSearch.StateViewBase;
import net.wg.gui.cyberSport.views.autoSearch.WaitingPlayers;
import net.wg.gui.cyberSport.views.events.CSShowHelpEvent;
import net.wg.gui.cyberSport.views.events.CyberSportEvent;
import net.wg.gui.cyberSport.views.events.RosterSettingsEvent;
import net.wg.gui.cyberSport.views.events.SCUpdateFocusEvent;
import net.wg.gui.cyberSport.views.respawn.RespawnChatSection;
import net.wg.gui.cyberSport.views.respawn.RespawnForm;
import net.wg.gui.cyberSport.views.respawn.RespawnSlotHelper;
import net.wg.gui.cyberSport.views.respawn.RespawnTeamSection;
import net.wg.gui.cyberSport.views.respawn.RespawnTeamSlot;
import net.wg.gui.cyberSport.views.respawn.RespawnView;
import net.wg.gui.cyberSport.views.respawn.UnitSlotButtonProperties;
import net.wg.gui.cyberSport.views.unit.ChatSection;
import net.wg.gui.cyberSport.views.unit.CyberSportTeamSectionBase;
import net.wg.gui.cyberSport.views.unit.IStaticRallyDetailsSection;
import net.wg.gui.cyberSport.views.unit.JoinUnitSection;
import net.wg.gui.cyberSport.views.unit.SimpleSlotRenderer;
import net.wg.gui.cyberSport.views.unit.SlotRenderer;
import net.wg.gui.cyberSport.views.unit.StaticFormationSlotRenderer;
import net.wg.gui.cyberSport.views.unit.StaticFormationTeamSection;
import net.wg.gui.cyberSport.views.unit.StaticFormationUnitSlotHelper;
import net.wg.gui.cyberSport.views.unit.StaticFormationUnitViewHeader;
import net.wg.gui.cyberSport.views.unit.StaticFormationWaitListSection;
import net.wg.gui.cyberSport.views.unit.StaticRallyAsLegionaryDetailsSection;
import net.wg.gui.cyberSport.views.unit.StaticRallyDetailsSection;
import net.wg.gui.cyberSport.views.unit.StaticRallyUnitSlotHelper;
import net.wg.gui.cyberSport.views.unit.TeamSection;
import net.wg.gui.cyberSport.views.unit.UnitSlotHelper;
import net.wg.gui.cyberSport.views.unit.WaitListSection;
import net.wg.gui.cyberSport.vo.AutoSearchVO;
import net.wg.gui.cyberSport.vo.CSCommadDetailsVO;
import net.wg.gui.cyberSport.vo.CSCommandVO;
import net.wg.gui.cyberSport.vo.CSIndicatorData;
import net.wg.gui.cyberSport.vo.CSIntroViewStaticTeamVO;
import net.wg.gui.cyberSport.vo.CSIntroViewTextsVO;
import net.wg.gui.cyberSport.vo.CSStaticLegionaryRallyVO;
import net.wg.gui.cyberSport.vo.CSStaticRallyVO;
import net.wg.gui.cyberSport.vo.IUnit;
import net.wg.gui.cyberSport.vo.IUnitSlot;
import net.wg.gui.cyberSport.vo.NavigationBlockVO;
import net.wg.gui.cyberSport.vo.RosterLimitsVO;
import net.wg.gui.cyberSport.vo.UnitListViewHeaderVO;
import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
import net.wg.gui.cyberSport.vo.WaitingPlayersVO;
import net.wg.gui.data.AwardWindowAnimationVO;
import net.wg.gui.data.AwardWindowTakeNextBtnVO;
import net.wg.gui.data.AwardWindowVO;
import net.wg.gui.data.BaseAwardsBlockVO;
import net.wg.gui.data.ButtonBarDataVO;
import net.wg.gui.data.ButtonBarItemVO;
import net.wg.gui.data.DataClassItemVO;
import net.wg.gui.data.MissionAwardWindowVO;
import net.wg.gui.data.TabDataVO;
import net.wg.gui.data.TabsVO;
import net.wg.gui.data.TaskAwardsBlockVO;
import net.wg.gui.data.VehCompareEntrypointVO;
import net.wg.gui.data.VersionMessageVO;
import net.wg.gui.events.ArenaVoipSettingsEvent;
import net.wg.gui.events.CSAnimationEvent;
import net.wg.gui.events.ConfirmExchangeBlockEvent;
import net.wg.gui.events.CooldownEvent;
import net.wg.gui.events.CrewEvent;
import net.wg.gui.events.DeviceEvent;
import net.wg.gui.events.EquipmentEvent;
import net.wg.gui.events.FinalStatisticEvent;
import net.wg.gui.events.HeaderButtonBarEvent;
import net.wg.gui.events.HeaderEvent;
import net.wg.gui.events.LobbyEvent;
import net.wg.gui.events.LobbyTDispatcherEvent;
import net.wg.gui.events.MessengerBarEvent;
import net.wg.gui.events.ModuleInfoEvent;
import net.wg.gui.events.PersonalCaseEvent;
import net.wg.gui.events.QuestEvent;
import net.wg.gui.events.ResizableBlockEvent;
import net.wg.gui.events.ShellRendererEvent;
import net.wg.gui.events.ShowDialogEvent;
import net.wg.gui.events.SortableTableListEvent;
import net.wg.gui.events.TrainingEvent;
import net.wg.gui.events.VehicleSellDialogEvent;
import net.wg.gui.events.WaitingQueueMessageEvent;
import net.wg.gui.fortBase.IArrowWithNut;
import net.wg.gui.fortBase.IBattleNotifierVO;
import net.wg.gui.fortBase.IBuildingBaseVO;
import net.wg.gui.fortBase.IBuildingToolTipDataProvider;
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.fortBase.IBuildingsComponentVO;
import net.wg.gui.fortBase.ICommonModeClient;
import net.wg.gui.fortBase.IDirectionModeClient;
import net.wg.gui.fortBase.IFortBuilding;
import net.wg.gui.fortBase.IFortBuildingUIBase;
import net.wg.gui.fortBase.IFortBuildingsContainer;
import net.wg.gui.fortBase.IFortDirectionsContainer;
import net.wg.gui.fortBase.IFortLandscapeCmp;
import net.wg.gui.fortBase.IFortModeVO;
import net.wg.gui.fortBase.ITransportModeClient;
import net.wg.gui.fortBase.ITransportingHandler;
import net.wg.gui.fortBase.ITransportingStepper;
import net.wg.gui.fortBase.events.FortInitEvent;
import net.wg.gui.interfaces.ICalendarDayVO;
import net.wg.gui.interfaces.IDate;
import net.wg.gui.interfaces.IDropList;
import net.wg.gui.interfaces.IExtendedUserVO;
import net.wg.gui.interfaces.IHeaderButtonContentItem;
import net.wg.gui.interfaces.IPersonalCaseBlockTitle;
import net.wg.gui.interfaces.IRallyCandidateVO;
import net.wg.gui.interfaces.IReferralTextBlockCmp;
import net.wg.gui.interfaces.IResettable;
import net.wg.gui.interfaces.ISaleItemBlockRenderer;
import net.wg.gui.interfaces.IUpdatableComponent;
import net.wg.gui.interfaces.IWaitingQueueMessageHelper;
import net.wg.gui.interfaces.IWaitingQueueMessageUpdater;
import net.wg.gui.intro.IntroInfoVO;
import net.wg.gui.intro.IntroPage;
import net.wg.gui.lobby.LobbyPage;
import net.wg.gui.lobby.academy.AcademyView;
import net.wg.gui.lobby.barracks.Barracks;
import net.wg.gui.lobby.barracks.BarracksForm;
import net.wg.gui.lobby.barracks.BarracksItemRenderer;
import net.wg.gui.lobby.barracks.data.BarracksTankmanVO;
import net.wg.gui.lobby.barracks.data.BarracksTankmenVO;
import net.wg.gui.lobby.battleResults.BattleResults;
import net.wg.gui.lobby.battleResults.CommonStats;
import net.wg.gui.lobby.battleResults.DetailsStatsView;
import net.wg.gui.lobby.battleResults.GetPremiumPopover;
import net.wg.gui.lobby.battleResults.IEmblemLoadedDelegate;
import net.wg.gui.lobby.battleResults.MultiteamStats;
import net.wg.gui.lobby.battleResults.TeamStats;
import net.wg.gui.lobby.battleResults.components.AlertMessage;
import net.wg.gui.lobby.battleResults.components.BattleResultsEventRenderer;
import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
import net.wg.gui.lobby.battleResults.components.BattleResultsPersonalQuest;
import net.wg.gui.lobby.battleResults.components.DetailsBlock;
import net.wg.gui.lobby.battleResults.components.DetailsStats;
import net.wg.gui.lobby.battleResults.components.DetailsStatsScrollPane;
import net.wg.gui.lobby.battleResults.components.EfficiencyHeader;
import net.wg.gui.lobby.battleResults.components.EfficiencyIconRenderer;
import net.wg.gui.lobby.battleResults.components.EfficiencyRenderer;
import net.wg.gui.lobby.battleResults.components.IncomeDetails;
import net.wg.gui.lobby.battleResults.components.IncomeDetailsBase;
import net.wg.gui.lobby.battleResults.components.IncomeDetailsShort;
import net.wg.gui.lobby.battleResults.components.MedalsList;
import net.wg.gui.lobby.battleResults.components.ProgressElement;
import net.wg.gui.lobby.battleResults.components.SortieTeamStatsController;
import net.wg.gui.lobby.battleResults.components.SpecialAchievement;
import net.wg.gui.lobby.battleResults.components.TankStatsView;
import net.wg.gui.lobby.battleResults.components.TeamMemberItemRenderer;
import net.wg.gui.lobby.battleResults.components.TeamMemberRendererBase;
import net.wg.gui.lobby.battleResults.components.TeamMemberStatsView;
import net.wg.gui.lobby.battleResults.components.TeamStatsList;
import net.wg.gui.lobby.battleResults.components.TotalIncomeDetails;
import net.wg.gui.lobby.battleResults.components.VehicleDetails;
import net.wg.gui.lobby.battleResults.controller.ColumnConstants;
import net.wg.gui.lobby.battleResults.controller.CybersportTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.DefaultMultiteamStatsController;
import net.wg.gui.lobby.battleResults.controller.DefaultTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.FFAMultiteamStatsController;
import net.wg.gui.lobby.battleResults.controller.FalloutTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.FortTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.MultiteamStatsControllerAbstract;
import net.wg.gui.lobby.battleResults.controller.RatedCybersportTeamStatsController;
import net.wg.gui.lobby.battleResults.controller.TeamStatsControllerAbstract;
import net.wg.gui.lobby.battleResults.cs.CsTeamEmblemEvent;
import net.wg.gui.lobby.battleResults.cs.CsTeamEvent;
import net.wg.gui.lobby.battleResults.cs.CsTeamStats;
import net.wg.gui.lobby.battleResults.cs.CsTeamStatsBg;
import net.wg.gui.lobby.battleResults.cs.CsTeamStatsVo;
import net.wg.gui.lobby.battleResults.data.AlertMessageVO;
import net.wg.gui.lobby.battleResults.data.BattleResultsMedalsListVO;
import net.wg.gui.lobby.battleResults.data.BattleResultsTextData;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.ColumnCollection;
import net.wg.gui.lobby.battleResults.data.ColumnData;
import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
import net.wg.gui.lobby.battleResults.data.EfficiencyHeaderVO;
import net.wg.gui.lobby.battleResults.data.EfficiencyRendererVO;
import net.wg.gui.lobby.battleResults.data.GetPremiumPopoverVO;
import net.wg.gui.lobby.battleResults.data.IconEfficiencyTooltipData;
import net.wg.gui.lobby.battleResults.data.OvertimeVO;
import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
import net.wg.gui.lobby.battleResults.data.StatItemVO;
import net.wg.gui.lobby.battleResults.data.TabInfoVO;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
import net.wg.gui.lobby.battleResults.data.VehicleItemVO;
import net.wg.gui.lobby.battleResults.data.VehicleStatsVO;
import net.wg.gui.lobby.battleResults.data.VictoryPanelVO;
import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
import net.wg.gui.lobby.battleResults.event.ClanEmblemRequestEvent;
import net.wg.gui.lobby.battleResults.event.TeamTableSortEvent;
import net.wg.gui.lobby.battleResults.fallout.DetailsVehicleSelection;
import net.wg.gui.lobby.battleResults.fallout.FFATeamMemberRenderer;
import net.wg.gui.lobby.battleResults.fallout.FalloutTeamMemberItemRenderer;
import net.wg.gui.lobby.battleResults.fallout.FalloutTeamMemberItemRendererBase;
import net.wg.gui.lobby.battleResults.fallout.MultiteamMemberItemRenderer;
import net.wg.gui.lobby.battleResults.fallout.VictoryScorePanel;
import net.wg.gui.lobby.battleResults.managers.IStatsUtilsManager;
import net.wg.gui.lobby.battleResults.managers.impl.StatsUtilsManager;
import net.wg.gui.lobby.battleResults.progressReport.BattleResultUnlockItem;
import net.wg.gui.lobby.battleResults.progressReport.BattleResultUnlockItemVO;
import net.wg.gui.lobby.battleResults.progressReport.ProgressReportLinkageSelector;
import net.wg.gui.lobby.battleResults.progressReport.UnlockLinkEvent;
import net.wg.gui.lobby.battlequeue.BattleQueue;
import net.wg.gui.lobby.battlequeue.BattleQueueItemRenderer;
import net.wg.gui.lobby.battlequeue.BattleQueueItemVO;
import net.wg.gui.lobby.battlequeue.BattleQueueListDataVO;
import net.wg.gui.lobby.battlequeue.BattleQueueTypeInfoVO;
import net.wg.gui.lobby.boosters.BoostersTableRenderer;
import net.wg.gui.lobby.boosters.components.BoostersWindowFilters;
import net.wg.gui.lobby.boosters.data.BoostersTableRendererVO;
import net.wg.gui.lobby.boosters.data.BoostersWindowFiltersVO;
import net.wg.gui.lobby.boosters.data.BoostersWindowStaticVO;
import net.wg.gui.lobby.boosters.data.BoostersWindowVO;
import net.wg.gui.lobby.boosters.data.ConfirmBoostersWindowVO;
import net.wg.gui.lobby.boosters.events.BoostersWindowEvent;
import net.wg.gui.lobby.boosters.windows.ConfirmBoostersWindow;
import net.wg.gui.lobby.browser.Browser;
import net.wg.gui.lobby.browser.BrowserActionBtn;
import net.wg.gui.lobby.browser.ServiceView;
import net.wg.gui.lobby.browser.events.BrowserActionBtnEvent;
import net.wg.gui.lobby.browser.events.BrowserEvent;
import net.wg.gui.lobby.christmas.ChristmasButton;
import net.wg.gui.lobby.christmas.ChristmasChestsView;
import net.wg.gui.lobby.christmas.ChristmasCustomizationView;
import net.wg.gui.lobby.christmas.ChristmasDecorationsFilters;
import net.wg.gui.lobby.christmas.ChristmasDecorationsFiltersList;
import net.wg.gui.lobby.christmas.ChristmasDecorationsList;
import net.wg.gui.lobby.christmas.ChristmasMainView;
import net.wg.gui.lobby.christmas.ChristmasProgressBar;
import net.wg.gui.lobby.christmas.controls.ChestAwardHeader;
import net.wg.gui.lobby.christmas.controls.ChestAwardRibbon;
import net.wg.gui.lobby.christmas.controls.ChristmasAnimationItem;
import net.wg.gui.lobby.christmas.controls.ChristmasAwardAnimRenderer;
import net.wg.gui.lobby.christmas.controls.ChristmasAwardRenderer;
import net.wg.gui.lobby.christmas.controls.ChristmasAwardWindowAnimation;
import net.wg.gui.lobby.christmas.controls.ChristmasDecorationItem;
import net.wg.gui.lobby.christmas.controls.ChristmasDecorationSlot;
import net.wg.gui.lobby.christmas.controls.ChristmasDecorationSlotBack;
import net.wg.gui.lobby.christmas.controls.ChristmasHeaderBackground;
import net.wg.gui.lobby.christmas.controls.ChristmasItemsAnimation;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasConversionSlots;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasCustomizationSlots;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasDroppableSlot;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasSlot;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasSlots;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasTankSlots;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasTreeSlotHitArea;
import net.wg.gui.lobby.christmas.controls.slots.ChristmasTreeSlots;
import net.wg.gui.lobby.christmas.controls.slots.ConversionResultSlot;
import net.wg.gui.lobby.christmas.data.BaseDecorationVO;
import net.wg.gui.lobby.christmas.data.ChestsViewVO;
import net.wg.gui.lobby.christmas.data.ChristmasAnimationItemVO;
import net.wg.gui.lobby.christmas.data.ChristmasAwardAnimationLoaderVO;
import net.wg.gui.lobby.christmas.data.ChristmasButtonVO;
import net.wg.gui.lobby.christmas.data.ChristmasFiltersVO;
import net.wg.gui.lobby.christmas.data.ConvertDecorationsDialogVO;
import net.wg.gui.lobby.christmas.data.DecorationInfoVO;
import net.wg.gui.lobby.christmas.data.DecorationVO;
import net.wg.gui.lobby.christmas.data.EmptyListVO;
import net.wg.gui.lobby.christmas.data.MainViewStaticDataVO;
import net.wg.gui.lobby.christmas.data.ProgressBarVO;
import net.wg.gui.lobby.christmas.data.slots.ConversionDataVO;
import net.wg.gui.lobby.christmas.data.slots.ConversionStaticDataVO;
import net.wg.gui.lobby.christmas.data.slots.CustomizationStaticDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataClassVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsDataVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataClassVO;
import net.wg.gui.lobby.christmas.data.slots.SlotsStaticDataVO;
import net.wg.gui.lobby.christmas.dragDrop.ChristmasDragDropController;
import net.wg.gui.lobby.christmas.dragDrop.ChristmasDragDropUtils;
import net.wg.gui.lobby.christmas.dragDrop.ChristmasDropDelegate;
import net.wg.gui.lobby.christmas.event.ChristmasAwardRendererEvent;
import net.wg.gui.lobby.christmas.event.ChristmasConversionEvent;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationEvent;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationFilterEvent;
import net.wg.gui.lobby.christmas.event.ChristmasCustomizationTabEvent;
import net.wg.gui.lobby.christmas.event.ChristmasDecorationsListEvent;
import net.wg.gui.lobby.christmas.event.ChristmasDropEvent;
import net.wg.gui.lobby.christmas.event.ChristmasFilterEvent;
import net.wg.gui.lobby.christmas.event.ChristmasProgressBarEvent;
import net.wg.gui.lobby.christmas.event.ChristmasSlotsEvent;
import net.wg.gui.lobby.christmas.interfaces.IChestAwardRibbon;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItem;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItemVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationVO;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAwardAnimRenderer;
import net.wg.gui.lobby.christmas.interfaces.IChristmasButton;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropActor;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropDelegate;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDropItem;
import net.wg.gui.lobby.christmas.interfaces.IChristmasDroppableSlot;
import net.wg.gui.lobby.christmas.interfaces.IChristmasItemsAnimation;
import net.wg.gui.lobby.christmas.interfaces.IChristmasMainView;
import net.wg.gui.lobby.christmas.interfaces.IChristmasProgressBar;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlot;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlotHitArea;
import net.wg.gui.lobby.christmas.interfaces.IChristmasSlots;
import net.wg.gui.lobby.christmas.interfaces.ICustomizationStaticDataVO;
import net.wg.gui.lobby.christmas.interfaces.ISlotsStaticDataMap;
import net.wg.gui.lobby.christmas.interfaces.IToggleRenderer;
import net.wg.gui.lobby.clans.common.ClanBaseInfoVO;
import net.wg.gui.lobby.clans.common.ClanNameField;
import net.wg.gui.lobby.clans.common.ClanTabDataProviderVO;
import net.wg.gui.lobby.clans.common.ClanVO;
import net.wg.gui.lobby.clans.common.ClanViewWithVariableContent;
import net.wg.gui.lobby.clans.common.IClanHeaderComponent;
import net.wg.gui.lobby.clans.common.IClanNameField;
import net.wg.gui.lobby.clans.invites.ClanInvitesWindow;
import net.wg.gui.lobby.clans.invites.ClanPersonalInvitesWindow;
import net.wg.gui.lobby.clans.invites.VOs.AcceptActionsVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInviteVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesViewVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowAbstractItemVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowHeaderStateVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowTabViewVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowTableFilterVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesWindowVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanRequestActionsVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanRequestStatusVO;
import net.wg.gui.lobby.clans.invites.VOs.ClanRequestVO;
import net.wg.gui.lobby.clans.invites.VOs.DummyTextVO;
import net.wg.gui.lobby.clans.invites.VOs.PersonalInviteVO;
import net.wg.gui.lobby.clans.invites.VOs.UserInvitesWindowItemVO;
import net.wg.gui.lobby.clans.invites.components.AcceptActions;
import net.wg.gui.lobby.clans.invites.components.TextValueBlock;
import net.wg.gui.lobby.clans.invites.renderers.ClanInviteItemRenderer;
import net.wg.gui.lobby.clans.invites.renderers.ClanInvitesWindowAbstractTableItemRenderer;
import net.wg.gui.lobby.clans.invites.renderers.ClanPersonalInvitesItemRenderer;
import net.wg.gui.lobby.clans.invites.renderers.ClanRequestItemRenderer;
import net.wg.gui.lobby.clans.invites.renderers.ClanTableRendererItemEvent;
import net.wg.gui.lobby.clans.invites.renderers.UserAbstractTableItemRenderer;
import net.wg.gui.lobby.clans.invites.views.ClanInvitesView;
import net.wg.gui.lobby.clans.invites.views.ClanInvitesViewWithTable;
import net.wg.gui.lobby.clans.invites.views.ClanInvitesWindowAbstractTabView;
import net.wg.gui.lobby.clans.invites.views.ClanPersonalInvitesView;
import net.wg.gui.lobby.clans.invites.views.ClanRequestsView;
import net.wg.gui.lobby.clans.profile.ClanProfileEvent;
import net.wg.gui.lobby.clans.profile.ClanProfileMainWindow;
import net.wg.gui.lobby.clans.profile.ClanProfileMainWindowBaseHeader;
import net.wg.gui.lobby.clans.profile.ClanProfileMainWindowHeader;
import net.wg.gui.lobby.clans.profile.ClanProfileSummaryViewHeader;
import net.wg.gui.lobby.clans.profile.VOs.ClanMemberVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationStatsViewVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewInitVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationViewVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationsSchemaViewVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileFortificationsTextsVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapInfoVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapPromoVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapViewVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileHeaderStateVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileMainWindowVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfilePersonnelViewVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileProvinceVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSelfProvinceVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileStatsLineVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryBlockVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryViewStatusVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryViewVO;
import net.wg.gui.lobby.clans.profile.VOs.ClanProfileTableStatisticsDataVO;
import net.wg.gui.lobby.clans.profile.VOs.GlobalMapStatisticsBodyVO;
import net.wg.gui.lobby.clans.profile.cmp.BuildingShape;
import net.wg.gui.lobby.clans.profile.cmp.ClanProfileFortStatsGroup;
import net.wg.gui.lobby.clans.profile.cmp.ClanProfileSummaryBlock;
import net.wg.gui.lobby.clans.profile.cmp.TextFieldFrame;
import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileFortificationTabView;
import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileFortificationTabbedView;
import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileSummaryBlock;
import net.wg.gui.lobby.clans.profile.interfaces.ITextFieldFrame;
import net.wg.gui.lobby.clans.profile.renderers.ClanProfileMemberItemRenderer;
import net.wg.gui.lobby.clans.profile.renderers.ClanProfileProvinceItemRenderer;
import net.wg.gui.lobby.clans.profile.renderers.ClanProfileSelfProvinceItemRenderer;
import net.wg.gui.lobby.clans.profile.views.ClanProfileBaseView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileFortificationAbstractTabView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileFortificationInfoView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileFortificationPromoView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileFortificationSchemaView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileFortificationStatsView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileFortificationView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileGlobalMapInfoView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileGlobalMapPromoView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileGlobalMapView;
import net.wg.gui.lobby.clans.profile.views.ClanProfilePersonnelView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileSummaryView;
import net.wg.gui.lobby.clans.profile.views.ClanProfileTableStatisticsView;
import net.wg.gui.lobby.clans.search.ClanSearchInfo;
import net.wg.gui.lobby.clans.search.ClanSearchItemRenderer;
import net.wg.gui.lobby.clans.search.ClanSearchWindow;
import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoDataVO;
import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoInitDataVO;
import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoStateDataVO;
import net.wg.gui.lobby.clans.search.VOs.ClanSearchItemVO;
import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowInitDataVO;
import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowStateDataVO;
import net.wg.gui.lobby.clans.utils.ClanHelper;
import net.wg.gui.lobby.components.AwardWindowAnimationController;
import net.wg.gui.lobby.components.BaseAwardWindowAnimation;
import net.wg.gui.lobby.components.BaseAwardsBlock;
import net.wg.gui.lobby.components.BaseBoosterSlot;
import net.wg.gui.lobby.components.BoosterAddSlot;
import net.wg.gui.lobby.components.BoosterSlot;
import net.wg.gui.lobby.components.BoostersPanel;
import net.wg.gui.lobby.components.ButtonFilters;
import net.wg.gui.lobby.components.ButtonFiltersGroup;
import net.wg.gui.lobby.components.DataViewStack;
import net.wg.gui.lobby.components.DetailedStatisticsGroupEx;
import net.wg.gui.lobby.components.DetailedStatisticsRootUnit;
import net.wg.gui.lobby.components.DetailedStatisticsUnit;
import net.wg.gui.lobby.components.DetailedStatisticsView;
import net.wg.gui.lobby.components.ExplosionAwardWindowAnimation;
import net.wg.gui.lobby.components.ExplosionAwardWindowAnimationIcon;
import net.wg.gui.lobby.components.HeaderBackground;
import net.wg.gui.lobby.components.IResizableContent;
import net.wg.gui.lobby.components.IStatisticsBodyContainerData;
import net.wg.gui.lobby.components.InfoMessageComponent;
import net.wg.gui.lobby.components.ProfileDashLineTextItem;
import net.wg.gui.lobby.components.ProgressIndicator;
import net.wg.gui.lobby.components.ResizableViewStack;
import net.wg.gui.lobby.components.SmallSkillGroupIcons;
import net.wg.gui.lobby.components.SmallSkillItemRenderer;
import net.wg.gui.lobby.components.SmallSkillsList;
import net.wg.gui.lobby.components.StatisticsBodyContainer;
import net.wg.gui.lobby.components.StatisticsDashLineTextItemIRenderer;
import net.wg.gui.lobby.components.StoppableAnimationLoader;
import net.wg.gui.lobby.components.VehicleSelectorFilter;
import net.wg.gui.lobby.components.data.BaseTankmanVO;
import net.wg.gui.lobby.components.data.BoosterSlotVO;
import net.wg.gui.lobby.components.data.ButtonFiltersItemVO;
import net.wg.gui.lobby.components.data.ButtonFiltersVO;
import net.wg.gui.lobby.components.data.DetailedLabelDataVO;
import net.wg.gui.lobby.components.data.DetailedStatisticsLabelDataVO;
import net.wg.gui.lobby.components.data.DetailedStatisticsUnitVO;
import net.wg.gui.lobby.components.data.InfoMessageVO;
import net.wg.gui.lobby.components.data.SkillsVO;
import net.wg.gui.lobby.components.data.StatisticsBodyVO;
import net.wg.gui.lobby.components.data.StatisticsLabelDataVO;
import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;
import net.wg.gui.lobby.components.data.StatisticsTooltipDataVO;
import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
import net.wg.gui.lobby.components.data.TruncateDetailedStatisticsLabelDataVO;
import net.wg.gui.lobby.components.data.VehParamVO;
import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
import net.wg.gui.lobby.components.events.BoosterPanelEvent;
import net.wg.gui.lobby.components.events.FiltersEvent;
import net.wg.gui.lobby.components.events.StoppableAnimationLoaderEvent;
import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
import net.wg.gui.lobby.components.interfaces.IAwardWindow;
import net.wg.gui.lobby.components.interfaces.IAwardWindowAnimationController;
import net.wg.gui.lobby.components.interfaces.IAwardWindowAnimationWrapper;
import net.wg.gui.lobby.components.interfaces.IBoosterSlot;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimation;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationItem;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoader;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoaderVO;
import net.wg.gui.lobby.components.interfaces.IStoppableAnimationVO;
import net.wg.gui.lobby.confirmModuleWindow.ConfirmModuleWindow;
import net.wg.gui.lobby.confirmModuleWindow.ModuleInfoVo;
import net.wg.gui.lobby.demonstration.DemonstratorWindow;
import net.wg.gui.lobby.demonstration.MapItemRenderer;
import net.wg.gui.lobby.demonstration.data.DemonstratorVO;
import net.wg.gui.lobby.demonstration.data.MapItemVO;
import net.wg.gui.lobby.dialogs.CheckBoxDialog;
import net.wg.gui.lobby.dialogs.ConfirmDialog;
import net.wg.gui.lobby.dialogs.DemountDeviceDialog;
import net.wg.gui.lobby.dialogs.DestroyDeviceDialog;
import net.wg.gui.lobby.dialogs.FreeXPInfoWindow;
import net.wg.gui.lobby.dialogs.IconDialog;
import net.wg.gui.lobby.dialogs.IconPriceDialog;
import net.wg.gui.lobby.dialogs.PriceMc;
import net.wg.gui.lobby.dialogs.TankmanOperationDialog;
import net.wg.gui.lobby.dialogs.data.TankmanOperationDialogVO;
import net.wg.gui.lobby.eliteWindow.EliteWindow;
import net.wg.gui.lobby.eventInfoPanel.EventInfoPanel;
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelItemVO;
import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;
import net.wg.gui.lobby.eventInfoPanel.interfaces.IEventInfoPanel;
import net.wg.gui.lobby.fallout.FalloutBattleSelectorWindow;
import net.wg.gui.lobby.fallout.data.FalloutBattleSelectorTooltipVO;
import net.wg.gui.lobby.fallout.data.SelectorWindowBtnStatesVO;
import net.wg.gui.lobby.fallout.data.SelectorWindowStaticDataVO;
import net.wg.gui.lobby.fortifications.FortBattleRoomWindow;
import net.wg.gui.lobby.fortifications.FortChoiceDivisionWindow;
import net.wg.gui.lobby.fortifications.FortDisableDefencePeriodWindow;
import net.wg.gui.lobby.fortifications.FortificationsView;
import net.wg.gui.lobby.fortifications.IFortWelcomeInfoView;
import net.wg.gui.lobby.fortifications.battleRoom.FortBattleRoomSections;
import net.wg.gui.lobby.fortifications.battleRoom.FortBattleRoomWaitListSection;
import net.wg.gui.lobby.fortifications.battleRoom.FortIntroView;
import net.wg.gui.lobby.fortifications.battleRoom.FortListView;
import net.wg.gui.lobby.fortifications.battleRoom.FortRoomView;
import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieDetailsSection;
import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieDetailsSectionAlertView;
import net.wg.gui.lobby.fortifications.battleRoom.JoinSortieSection;
import net.wg.gui.lobby.fortifications.battleRoom.LegionariesCandidateItemRenderer;
import net.wg.gui.lobby.fortifications.battleRoom.LegionariesDataProvider;
import net.wg.gui.lobby.fortifications.battleRoom.LegionariesSortieSlot;
import net.wg.gui.lobby.fortifications.battleRoom.SortieChatSection;
import net.wg.gui.lobby.fortifications.battleRoom.SortieListRenderer;
import net.wg.gui.lobby.fortifications.battleRoom.SortieSlotHelper;
import net.wg.gui.lobby.fortifications.battleRoom.SortieTeamSection;
import net.wg.gui.lobby.fortifications.battleRoom.SortieWaitListSection;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.AdvancedClanBattleTimer;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.ClanBattleCreatorView;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.ClanBattleTableRenderer;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.ClanBattleTimer;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortClanBattleList;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortClanBattleRoom;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortClanBattleTeamSection;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.FortListViewHelper;
import net.wg.gui.lobby.fortifications.battleRoom.clanBattle.JoinClanBattleSection;
import net.wg.gui.lobby.fortifications.cmp.IFortDisconnectView;
import net.wg.gui.lobby.fortifications.cmp.IFortMainView;
import net.wg.gui.lobby.fortifications.cmp.IFortWelcomeView;
import net.wg.gui.lobby.fortifications.cmp.base.IFilledBar;
import net.wg.gui.lobby.fortifications.cmp.base.impl.FortBuildingBase;
import net.wg.gui.lobby.fortifications.cmp.battleResults.FortBattleResultsTableRenderer;
import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicator;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingIndicatorsCmp;
import net.wg.gui.lobby.fortifications.cmp.build.IBuildingTexture;
import net.wg.gui.lobby.fortifications.cmp.build.ICooldownIcon;
import net.wg.gui.lobby.fortifications.cmp.build.impl.ArrowWithNut;
import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingBlinkingBtn;
import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingIndicator;
import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingIndicatorsCmp;
import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingOrderProcessing;
import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingTexture;
import net.wg.gui.lobby.fortifications.cmp.build.impl.BuildingThumbnail;
import net.wg.gui.lobby.fortifications.cmp.build.impl.CooldownIcon;
import net.wg.gui.lobby.fortifications.cmp.build.impl.CooldownIconLoaderCtnr;
import net.wg.gui.lobby.fortifications.cmp.build.impl.FortBuilding;
import net.wg.gui.lobby.fortifications.cmp.build.impl.FortBuildingBtn;
import net.wg.gui.lobby.fortifications.cmp.build.impl.FortBuildingUIBase;
import net.wg.gui.lobby.fortifications.cmp.build.impl.FortBuildingsContainer;
import net.wg.gui.lobby.fortifications.cmp.build.impl.FortBuildingsContainerHelper;
import net.wg.gui.lobby.fortifications.cmp.build.impl.FortLandscapeCmpnt;
import net.wg.gui.lobby.fortifications.cmp.build.impl.HitAreaControl;
import net.wg.gui.lobby.fortifications.cmp.build.impl.IndicatorLabels;
import net.wg.gui.lobby.fortifications.cmp.build.impl.ModernizationCmp;
import net.wg.gui.lobby.fortifications.cmp.build.impl.OrderInfoCmp;
import net.wg.gui.lobby.fortifications.cmp.build.impl.OrderInfoIconCmp;
import net.wg.gui.lobby.fortifications.cmp.build.impl.ProgressTotalLabels;
import net.wg.gui.lobby.fortifications.cmp.build.impl.TrowelCmp;
import net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl.BuildingsAnimationController;
import net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl.DemountBuildingsAnimation;
import net.wg.gui.lobby.fortifications.cmp.build.impl.animationImpl.FortBuildingAnimationBase;
import net.wg.gui.lobby.fortifications.cmp.build.impl.base.BuildingsWizardCmpnt;
import net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl.BuildingProcessInfo;
import net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl.BuildingProcessItemRenderer;
import net.wg.gui.lobby.fortifications.cmp.calendar.impl.CalendarEventListRenderer;
import net.wg.gui.lobby.fortifications.cmp.calendar.impl.CalendarPreviewBlock;
import net.wg.gui.lobby.fortifications.cmp.clan.impl.ClanInfoCmp;
import net.wg.gui.lobby.fortifications.cmp.clanList.ClanListItemRenderer;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.ClanStatDashLineTextItem;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.ClanStatsGroup;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.FortClanStatisticBaseForm;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.FortStatisticsLDIT;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.PeriodDefenceStatisticForm;
import net.wg.gui.lobby.fortifications.cmp.clanStatistics.impl.SortieStatisticsForm;
import net.wg.gui.lobby.fortifications.cmp.combatReservesIntro.CombatReservesIntroItem;
import net.wg.gui.lobby.fortifications.cmp.division.impl.ChoiceDivisionSelector;
import net.wg.gui.lobby.fortifications.cmp.drctn.IDirectionCmp;
import net.wg.gui.lobby.fortifications.cmp.drctn.IDirectionListRenderer;
import net.wg.gui.lobby.fortifications.cmp.drctn.IFortBattleNotifier;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.AnimatedIcon;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.BuildingAttackIndicator;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.BuildingDirection;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.ConnectedDirctns;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionButtonRenderer;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionCmp;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionListRenderer;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionRadioRenderer;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.FortBattleNotifier;
import net.wg.gui.lobby.fortifications.cmp.drctn.impl.FortDirectionsContainer;
import net.wg.gui.lobby.fortifications.cmp.impl.FortDisconnectView;
import net.wg.gui.lobby.fortifications.cmp.impl.FortMainView;
import net.wg.gui.lobby.fortifications.cmp.impl.FortWelcomeCommanderContent;
import net.wg.gui.lobby.fortifications.cmp.impl.FortWelcomeCommanderView;
import net.wg.gui.lobby.fortifications.cmp.impl.FortWelcomeInfoView;
import net.wg.gui.lobby.fortifications.cmp.impl.FortWelcomeView;
import net.wg.gui.lobby.fortifications.cmp.main.IFortHeaderClanInfo;
import net.wg.gui.lobby.fortifications.cmp.main.IMainFooter;
import net.wg.gui.lobby.fortifications.cmp.main.IMainHeader;
import net.wg.gui.lobby.fortifications.cmp.main.impl.FortHeaderClanInfo;
import net.wg.gui.lobby.fortifications.cmp.main.impl.FortMainFooter;
import net.wg.gui.lobby.fortifications.cmp.main.impl.FortMainHeader;
import net.wg.gui.lobby.fortifications.cmp.main.impl.FortTimeAlertIcon;
import net.wg.gui.lobby.fortifications.cmp.main.impl.VignetteYellow;
import net.wg.gui.lobby.fortifications.cmp.orders.ICheckBoxIcon;
import net.wg.gui.lobby.fortifications.cmp.orders.IOrdersPanel;
import net.wg.gui.lobby.fortifications.cmp.orders.impl.CheckBoxIcon;
import net.wg.gui.lobby.fortifications.cmp.orders.impl.OrdersPanel;
import net.wg.gui.lobby.fortifications.cmp.tankIcon.impl.FortTankIcon;
import net.wg.gui.lobby.fortifications.data.BattleDirectionPopoverVO;
import net.wg.gui.lobby.fortifications.data.BattleDirectionRendererVO;
import net.wg.gui.lobby.fortifications.data.BattleNotifierVO;
import net.wg.gui.lobby.fortifications.data.BattleNotifiersDataVO;
import net.wg.gui.lobby.fortifications.data.BuildingCardPopoverVO;
import net.wg.gui.lobby.fortifications.data.BuildingIndicatorsVO;
import net.wg.gui.lobby.fortifications.data.BuildingModernizationVO;
import net.wg.gui.lobby.fortifications.data.BuildingPopoverActionVO;
import net.wg.gui.lobby.fortifications.data.BuildingPopoverBaseVO;
import net.wg.gui.lobby.fortifications.data.BuildingPopoverHeaderVO;
import net.wg.gui.lobby.fortifications.data.BuildingProgressLblVO;
import net.wg.gui.lobby.fortifications.data.BuildingVO;
import net.wg.gui.lobby.fortifications.data.BuildingsComponentVO;
import net.wg.gui.lobby.fortifications.data.CheckBoxIconVO;
import net.wg.gui.lobby.fortifications.data.ClanDescriptionVO;
import net.wg.gui.lobby.fortifications.data.ClanInfoVO;
import net.wg.gui.lobby.fortifications.data.ClanListRendererVO;
import net.wg.gui.lobby.fortifications.data.ClanStatItemVO;
import net.wg.gui.lobby.fortifications.data.ClanStatsVO;
import net.wg.gui.lobby.fortifications.data.CombatReservesIntroItemVO;
import net.wg.gui.lobby.fortifications.data.CombatReservesIntroVO;
import net.wg.gui.lobby.fortifications.data.ConfirmOrderVO;
import net.wg.gui.lobby.fortifications.data.ConnectedDirectionsVO;
import net.wg.gui.lobby.fortifications.data.DirectionVO;
import net.wg.gui.lobby.fortifications.data.FortBattleTimerVO;
import net.wg.gui.lobby.fortifications.data.FortBuildingConstants;
import net.wg.gui.lobby.fortifications.data.FortCalendarDayVO;
import net.wg.gui.lobby.fortifications.data.FortCalendarEventVO;
import net.wg.gui.lobby.fortifications.data.FortCalendarPreviewBlockVO;
import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionSelectorVO;
import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionVO;
import net.wg.gui.lobby.fortifications.data.FortClanListWindowVO;
import net.wg.gui.lobby.fortifications.data.FortClanMemberVO;
import net.wg.gui.lobby.fortifications.data.FortConstants;
import net.wg.gui.lobby.fortifications.data.FortCurfewTimeVO;
import net.wg.gui.lobby.fortifications.data.FortFixedPlayersVO;
import net.wg.gui.lobby.fortifications.data.FortIntelFilterVO;
import net.wg.gui.lobby.fortifications.data.FortInvalidationType;
import net.wg.gui.lobby.fortifications.data.FortModeElementProperty;
import net.wg.gui.lobby.fortifications.data.FortModeStateStringsVO;
import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
import net.wg.gui.lobby.fortifications.data.FortModeVO;
import net.wg.gui.lobby.fortifications.data.FortRegulationInfoVO;
import net.wg.gui.lobby.fortifications.data.FortWaitingVO;
import net.wg.gui.lobby.fortifications.data.FortWelcomeViewVO;
import net.wg.gui.lobby.fortifications.data.FortificationVO;
import net.wg.gui.lobby.fortifications.data.FunctionalStates;
import net.wg.gui.lobby.fortifications.data.IntelligenceClanFilterVO;
import net.wg.gui.lobby.fortifications.data.IntelligenceRendererVO;
import net.wg.gui.lobby.fortifications.data.ModernizationCmpVO;
import net.wg.gui.lobby.fortifications.data.OrderInfoVO;
import net.wg.gui.lobby.fortifications.data.OrderPopoverVO;
import net.wg.gui.lobby.fortifications.data.OrderSelectPopoverVO;
import net.wg.gui.lobby.fortifications.data.OrderSelectRendererVO;
import net.wg.gui.lobby.fortifications.data.OrderVO;
import net.wg.gui.lobby.fortifications.data.PeriodDefenceInitVO;
import net.wg.gui.lobby.fortifications.data.PeriodDefenceVO;
import net.wg.gui.lobby.fortifications.data.RosterIntroVO;
import net.wg.gui.lobby.fortifications.data.TransportingVO;
import net.wg.gui.lobby.fortifications.data.base.BaseFortificationVO;
import net.wg.gui.lobby.fortifications.data.base.BuildingBaseVO;
import net.wg.gui.lobby.fortifications.data.battleResults.BattleResultsRendererVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.IntroViewVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesCandidateVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSlotsVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.SortieAlertViewVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.SortieVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleDetailsVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleListVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleRenderListVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessInfoVO;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessListItemVO;
import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessVO;
import net.wg.gui.lobby.fortifications.data.demountBuilding.FortDemountBuildingVO;
import net.wg.gui.lobby.fortifications.data.orderInfo.FortOrderInfoTitleVO;
import net.wg.gui.lobby.fortifications.data.orderInfo.FortOrderInfoWindowVO;
import net.wg.gui.lobby.fortifications.data.orderInfo.OrderParamsVO;
import net.wg.gui.lobby.fortifications.data.settings.DayOffPopoverVO;
import net.wg.gui.lobby.fortifications.data.settings.DefenceHourPopoverVO;
import net.wg.gui.lobby.fortifications.data.settings.DisableDefencePeriodVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsActivatedViewVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsBlockVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsClanInfoVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsConditionsBlockVO;
import net.wg.gui.lobby.fortifications.data.settings.FortSettingsNotActivatedViewVO;
import net.wg.gui.lobby.fortifications.data.settings.PeripheryContainerVO;
import net.wg.gui.lobby.fortifications.data.settings.PeripheryPopoverVO;
import net.wg.gui.lobby.fortifications.data.settings.VacationPopoverVO;
import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
import net.wg.gui.lobby.fortifications.data.tankIcon.FortTankIconVO;
import net.wg.gui.lobby.fortifications.events.ClanBattleTimerEvent;
import net.wg.gui.lobby.fortifications.events.DirectionEvent;
import net.wg.gui.lobby.fortifications.events.FortBattleResultsEvent;
import net.wg.gui.lobby.fortifications.events.FortBuildingAnimationEvent;
import net.wg.gui.lobby.fortifications.events.FortBuildingCardPopoverEvent;
import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
import net.wg.gui.lobby.fortifications.events.FortIntelClanDescriptionEvent;
import net.wg.gui.lobby.fortifications.events.FortSettingsEvent;
import net.wg.gui.lobby.fortifications.events.JoinFortBattleEvent;
import net.wg.gui.lobby.fortifications.events.OrderSelectEvent;
import net.wg.gui.lobby.fortifications.intelligence.FortIntelligenceClanFilterPopover;
import net.wg.gui.lobby.fortifications.intelligence.FortIntelligenceWindowHelper;
import net.wg.gui.lobby.fortifications.intelligence.IFortIntelFilter;
import net.wg.gui.lobby.fortifications.intelligence.impl.FortIntelClanDescriptionFooter;
import net.wg.gui.lobby.fortifications.intelligence.impl.FortIntelClanDescriptionHeader;
import net.wg.gui.lobby.fortifications.intelligence.impl.FortIntelClanDescriptionLIT;
import net.wg.gui.lobby.fortifications.intelligence.impl.FortIntelFilter;
import net.wg.gui.lobby.fortifications.intelligence.impl.FortIntelligenceClanDescription;
import net.wg.gui.lobby.fortifications.intelligence.impl.FortIntelligenceNotAvailableWindow;
import net.wg.gui.lobby.fortifications.intelligence.impl.FortIntelligenceWindow;
import net.wg.gui.lobby.fortifications.intelligence.impl.cmp.IntelligenceRenderer;
import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
import net.wg.gui.lobby.fortifications.interfaces.IConsumablesOrderParams;
import net.wg.gui.lobby.fortifications.interfaces.IFortWelcomeViewVO;
import net.wg.gui.lobby.fortifications.orderInfo.ConsumablesOrderDescrElement;
import net.wg.gui.lobby.fortifications.orderInfo.ConsumablesOrderInfoCmp;
import net.wg.gui.lobby.fortifications.orderInfo.ConsumablesOrderValuesElement;
import net.wg.gui.lobby.fortifications.popovers.IBuildingCardCmp;
import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
import net.wg.gui.lobby.fortifications.popovers.impl.BattleDirectionRenderer;
import net.wg.gui.lobby.fortifications.popovers.impl.FortBattleDirectionPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortBuildingCardPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortDatePickerPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortOrderPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortOrderSelectPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortPopoverAssignPlayer;
import net.wg.gui.lobby.fortifications.popovers.impl.FortPopoverBody;
import net.wg.gui.lobby.fortifications.popovers.impl.FortPopoverControlPanel;
import net.wg.gui.lobby.fortifications.popovers.impl.FortPopoverHeader;
import net.wg.gui.lobby.fortifications.popovers.impl.FortSettingsDayoffPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortSettingsDefenceHourPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortSettingsPeripheryPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.FortSettingsVacationPopover;
import net.wg.gui.lobby.fortifications.popovers.impl.PopoverBuildingTexture;
import net.wg.gui.lobby.fortifications.popovers.orderPopover.OrderInfoBlock;
import net.wg.gui.lobby.fortifications.popovers.orderSelectPopover.OrderSelectRenderer;
import net.wg.gui.lobby.fortifications.settings.IFortSettingsActivatedContainer;
import net.wg.gui.lobby.fortifications.settings.impl.FortSettingBlock;
import net.wg.gui.lobby.fortifications.settings.impl.FortSettingPeripheryContainer;
import net.wg.gui.lobby.fortifications.settings.impl.FortSettingsActivatedContainer;
import net.wg.gui.lobby.fortifications.settings.impl.FortSettingsClanInfo;
import net.wg.gui.lobby.fortifications.settings.impl.FortSettingsConditionsBlock;
import net.wg.gui.lobby.fortifications.settings.impl.FortSettingsNotActivatedContainer;
import net.wg.gui.lobby.fortifications.utils.IFortCommonUtils;
import net.wg.gui.lobby.fortifications.utils.IFortModeSwitcher;
import net.wg.gui.lobby.fortifications.utils.IFortsControlsAligner;
import net.wg.gui.lobby.fortifications.utils.ITransportingHelper;
import net.wg.gui.lobby.fortifications.utils.impl.FortCommonUtils;
import net.wg.gui.lobby.fortifications.utils.impl.FortModeSwitcher;
import net.wg.gui.lobby.fortifications.utils.impl.FortsControlsAligner;
import net.wg.gui.lobby.fortifications.utils.impl.TransportingHelper;
import net.wg.gui.lobby.fortifications.windows.FortBattleResultsWindow;
import net.wg.gui.lobby.fortifications.windows.FortBuildingProcessWindow;
import net.wg.gui.lobby.fortifications.windows.FortCalendarWindow;
import net.wg.gui.lobby.fortifications.windows.FortClanListWindow;
import net.wg.gui.lobby.fortifications.windows.FortClanStatisticsWindow;
import net.wg.gui.lobby.fortifications.windows.FortCombatReservesIntroWindow;
import net.wg.gui.lobby.fortifications.windows.FortCreateDirectionWindow;
import net.wg.gui.lobby.fortifications.windows.FortCreationCongratulationsWindow;
import net.wg.gui.lobby.fortifications.windows.FortDeclarationOfWarWindow;
import net.wg.gui.lobby.fortifications.windows.FortDemountBuildingWindow;
import net.wg.gui.lobby.fortifications.windows.FortFixedPlayersWindow;
import net.wg.gui.lobby.fortifications.windows.FortModernizationWindow;
import net.wg.gui.lobby.fortifications.windows.FortNotCommanderFirstEnterWindow;
import net.wg.gui.lobby.fortifications.windows.FortOrderConfirmationWindow;
import net.wg.gui.lobby.fortifications.windows.FortOrderInfoWindow;
import net.wg.gui.lobby.fortifications.windows.FortPeriodDefenceWindow;
import net.wg.gui.lobby.fortifications.windows.FortRosterIntroWindow;
import net.wg.gui.lobby.fortifications.windows.FortSettingsWindow;
import net.wg.gui.lobby.fortifications.windows.FortTransportConfirmationWindow;
import net.wg.gui.lobby.goldFishEvent.GoldFishWindow;
import net.wg.gui.lobby.hangar.CrewDropDownEvent;
import net.wg.gui.lobby.hangar.Hangar;
import net.wg.gui.lobby.hangar.HangarHeader;
import net.wg.gui.lobby.hangar.QuestsControl;
import net.wg.gui.lobby.hangar.ResearchPanel;
import net.wg.gui.lobby.hangar.SwitchModePanel;
import net.wg.gui.lobby.hangar.TmenXpPanel;
import net.wg.gui.lobby.hangar.VehicleParameters;
import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
import net.wg.gui.lobby.hangar.ammunitionPanel.EquipmentSlot;
import net.wg.gui.lobby.hangar.ammunitionPanel.IAmmunitionPanel;
import net.wg.gui.lobby.hangar.ammunitionPanel.VehicleStateMsg;
import net.wg.gui.lobby.hangar.ammunitionPanel.data.ShellButtonVO;
import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleMessageVO;
import net.wg.gui.lobby.hangar.ammunitionPanel.events.AmmunitionPanelEvents;
import net.wg.gui.lobby.hangar.crew.Crew;
import net.wg.gui.lobby.hangar.crew.CrewDogItem;
import net.wg.gui.lobby.hangar.crew.CrewItemLabel;
import net.wg.gui.lobby.hangar.crew.CrewItemRenderer;
import net.wg.gui.lobby.hangar.crew.CrewScrollingList;
import net.wg.gui.lobby.hangar.crew.ICrew;
import net.wg.gui.lobby.hangar.crew.IconsProps;
import net.wg.gui.lobby.hangar.crew.RecruitItemRenderer;
import net.wg.gui.lobby.hangar.crew.TankmanRoleVO;
import net.wg.gui.lobby.hangar.crew.TankmanTextCreator;
import net.wg.gui.lobby.hangar.crew.TankmanVO;
import net.wg.gui.lobby.hangar.crew.TankmenIcons;
import net.wg.gui.lobby.hangar.crew.TankmenResponseVO;
import net.wg.gui.lobby.hangar.crew.ev.CrewDogEvent;
import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
import net.wg.gui.lobby.hangar.data.ModuleInfoActionVO;
import net.wg.gui.lobby.hangar.data.ResearchPanelVO;
import net.wg.gui.lobby.hangar.data.SwitchModePanelVO;
import net.wg.gui.lobby.hangar.interfaces.IHangar;
import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
import net.wg.gui.lobby.hangar.maintenance.EquipmentItem;
import net.wg.gui.lobby.hangar.maintenance.EquipmentListItemRenderer;
import net.wg.gui.lobby.hangar.maintenance.FittingSelectDropDown;
import net.wg.gui.lobby.hangar.maintenance.MaintenanceDropDown;
import net.wg.gui.lobby.hangar.maintenance.MaintenanceStatusIndicator;
import net.wg.gui.lobby.hangar.maintenance.ShellItemRenderer;
import net.wg.gui.lobby.hangar.maintenance.ShellListItemRenderer;
import net.wg.gui.lobby.hangar.maintenance.TechnicalMaintenance;
import net.wg.gui.lobby.hangar.maintenance.data.HistoricalAmmoVO;
import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceShellVO;
import net.wg.gui.lobby.hangar.maintenance.data.MaintenanceVO;
import net.wg.gui.lobby.hangar.maintenance.events.OnEquipmentRendererOver;
import net.wg.gui.lobby.hangar.tcarousel.BaseTankIcon;
import net.wg.gui.lobby.hangar.tcarousel.ClanLockUI;
import net.wg.gui.lobby.hangar.tcarousel.FalloutTankCarousel;
import net.wg.gui.lobby.hangar.tcarousel.FalloutTankCarouselItemRenderer;
import net.wg.gui.lobby.hangar.tcarousel.FilterPopoverView;
import net.wg.gui.lobby.hangar.tcarousel.ITankCarousel;
import net.wg.gui.lobby.hangar.tcarousel.MultiselectionInfoBlock;
import net.wg.gui.lobby.hangar.tcarousel.MultiselectionSlotRenderer;
import net.wg.gui.lobby.hangar.tcarousel.MultiselectionSlots;
import net.wg.gui.lobby.hangar.tcarousel.SmallTankIcon;
import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
import net.wg.gui.lobby.hangar.tcarousel.TankCarouselFilters;
import net.wg.gui.lobby.hangar.tcarousel.TankCarouselItemRenderer;
import net.wg.gui.lobby.hangar.tcarousel.TankFilterCounter;
import net.wg.gui.lobby.hangar.tcarousel.controls.CheckBoxRenderer;
import net.wg.gui.lobby.hangar.tcarousel.controls.CounterLabel;
import net.wg.gui.lobby.hangar.tcarousel.controls.CounterTFContainer;
import net.wg.gui.lobby.hangar.tcarousel.controls.ToggleImageAlphaRenderer;
import net.wg.gui.lobby.hangar.tcarousel.data.CheckBoxRendererVO;
import net.wg.gui.lobby.hangar.tcarousel.data.FalloutVehicleCarouselVO;
import net.wg.gui.lobby.hangar.tcarousel.data.FilterCarouseInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.FilterComponentViewVO;
import net.wg.gui.lobby.hangar.tcarousel.data.FiltersStateVO;
import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionInfoVO;
import net.wg.gui.lobby.hangar.tcarousel.data.MultiselectionSlotVO;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterInitVO;
import net.wg.gui.lobby.hangar.tcarousel.data.TankCarouselFilterSelectedVO;
import net.wg.gui.lobby.hangar.tcarousel.data.VehicleCarouselVO;
import net.wg.gui.lobby.hangar.tcarousel.event.SlotEvent;
import net.wg.gui.lobby.hangar.tcarousel.event.TankFiltersEvents;
import net.wg.gui.lobby.hangar.tcarousel.event.TankItemEvent;
import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import net.wg.gui.lobby.hangar.tcarousel.helper.TankCarouselStatsFormatter;
import net.wg.gui.lobby.hangar.vehicleParameters.components.VehParamRenderer;
import net.wg.gui.lobby.hangar.vehicleParameters.components.VehParamRendererBase;
import net.wg.gui.lobby.header.AccountClanPopoverBlock;
import net.wg.gui.lobby.header.AccountPopover;
import net.wg.gui.lobby.header.AccountPopoverBlock;
import net.wg.gui.lobby.header.AccountPopoverBlockBase;
import net.wg.gui.lobby.header.AccountPopoverReferralBlock;
import net.wg.gui.lobby.header.FightButton;
import net.wg.gui.lobby.header.IAccountClanPopOverBlock;
import net.wg.gui.lobby.header.LobbyHeader;
import net.wg.gui.lobby.header.OnlineCounter;
import net.wg.gui.lobby.header.TankPanel;
import net.wg.gui.lobby.header.events.AccountPopoverEvent;
import net.wg.gui.lobby.header.events.BattleTypeSelectorEvent;
import net.wg.gui.lobby.header.events.HeaderEvents;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Account;
import net.wg.gui.lobby.header.headerButtonBar.HBC_AccountUpper;
import net.wg.gui.lobby.header.headerButtonBar.HBC_ActionItem;
import net.wg.gui.lobby.header.headerButtonBar.HBC_ArrowDown;
import net.wg.gui.lobby.header.headerButtonBar.HBC_BattleSelector;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Finance;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Prem;
import net.wg.gui.lobby.header.headerButtonBar.HBC_PremShop;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Settings;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Squad;
import net.wg.gui.lobby.header.headerButtonBar.HBC_Upper;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonActionContent;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonBar;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonContentItem;
import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
import net.wg.gui.lobby.header.itemSelectorPopover.BattleTypeSelectPopoverDemonstrator;
import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorList;
import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorPopover;
import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorRenderer;
import net.wg.gui.lobby.header.itemSelectorPopover.ItemSelectorRendererVO;
import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuButtonBar;
import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;
import net.wg.gui.lobby.header.vo.AccountDataVo;
import net.wg.gui.lobby.header.vo.AccountPopoverBlockVO;
import net.wg.gui.lobby.header.vo.AccountPopoverMainVO;
import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
import net.wg.gui.lobby.header.vo.HBC_AbstractVO;
import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
import net.wg.gui.lobby.header.vo.HangarMenuVO;
import net.wg.gui.lobby.header.vo.HeaderButtonVo;
import net.wg.gui.lobby.header.vo.IHBC_VO;
import net.wg.gui.lobby.header.vo.QuestsControlBtnVO;
import net.wg.gui.lobby.interfaces.ISubtaskComponent;
import net.wg.gui.lobby.invites.SendInvitesWindow;
import net.wg.gui.lobby.invites.controls.CandidatesList;
import net.wg.gui.lobby.invites.controls.CandidatesListItemRenderer;
import net.wg.gui.lobby.invites.controls.SearchListDragController;
import net.wg.gui.lobby.invites.controls.SearchListDropDelegate;
import net.wg.gui.lobby.invites.controls.TreeDragController;
import net.wg.gui.lobby.invites.controls.TreeDropDelegate;
import net.wg.gui.lobby.menu.LobbyMenu;
import net.wg.gui.lobby.messengerBar.ButtonWithCounter;
import net.wg.gui.lobby.messengerBar.MessegerBarInitVO;
import net.wg.gui.lobby.messengerBar.MessengerBar;
import net.wg.gui.lobby.messengerBar.MessengerChannelCarouselItem;
import net.wg.gui.lobby.messengerBar.MessengerIconButton;
import net.wg.gui.lobby.messengerBar.NotificationListButton;
import net.wg.gui.lobby.messengerBar.PrebattleChannelCarouselItem;
import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
import net.wg.gui.lobby.messengerBar.WindowOffsetsInBar;
import net.wg.gui.lobby.messengerBar.carousel.BaseChannelCarouselItem;
import net.wg.gui.lobby.messengerBar.carousel.BaseChannelRenderer;
import net.wg.gui.lobby.messengerBar.carousel.ChannelButton;
import net.wg.gui.lobby.messengerBar.carousel.ChannelCarousel;
import net.wg.gui.lobby.messengerBar.carousel.ChannelCarouselScrollBar;
import net.wg.gui.lobby.messengerBar.carousel.ChannelList;
import net.wg.gui.lobby.messengerBar.carousel.ChannelRenderer;
import net.wg.gui.lobby.messengerBar.carousel.FlexibleTileList;
import net.wg.gui.lobby.messengerBar.carousel.PreBattleChannelRenderer;
import net.wg.gui.lobby.messengerBar.carousel.data.ChannelListItemVO;
import net.wg.gui.lobby.messengerBar.carousel.data.IToolTipData;
import net.wg.gui.lobby.messengerBar.carousel.data.MessengerBarConstants;
import net.wg.gui.lobby.messengerBar.carousel.data.ReadyDataVO;
import net.wg.gui.lobby.messengerBar.carousel.data.TooltipDataVO;
import net.wg.gui.lobby.messengerBar.carousel.events.ChannelListEvent;
import net.wg.gui.lobby.messengerBar.carousel.events.MessengerBarChannelCarouselEvent;
import net.wg.gui.lobby.messengerBar.interfaces.IBaseChannelCarouselItem;
import net.wg.gui.lobby.messengerBar.interfaces.INotificationListButton;
import net.wg.gui.lobby.moduleInfo.ModuleEffects;
import net.wg.gui.lobby.moduleInfo.ModuleParameters;
import net.wg.gui.lobby.modulesPanel.FittingSelectPopover;
import net.wg.gui.lobby.modulesPanel.ModulesPanel;
import net.wg.gui.lobby.modulesPanel.components.DeviceSlot;
import net.wg.gui.lobby.modulesPanel.components.ExtraIcon;
import net.wg.gui.lobby.modulesPanel.components.FittingListItemRenderer;
import net.wg.gui.lobby.modulesPanel.components.FittingListSelectionNavigator;
import net.wg.gui.lobby.modulesPanel.components.ModuleFittingItemRenderer;
import net.wg.gui.lobby.modulesPanel.components.ModuleSlot;
import net.wg.gui.lobby.modulesPanel.components.OptDeviceFittingItemRenderer;
import net.wg.gui.lobby.modulesPanel.data.DeviceSlotVO;
import net.wg.gui.lobby.modulesPanel.data.DeviceVO;
import net.wg.gui.lobby.modulesPanel.data.DevicesDataVO;
import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverParams;
import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverVO;
import net.wg.gui.lobby.modulesPanel.data.OptionalDeviceVO;
import net.wg.gui.lobby.modulesPanel.interfaces.IDeviceSlot;
import net.wg.gui.lobby.modulesPanel.interfaces.IModulesPanel;
import net.wg.gui.lobby.premiumWindow.PremiumBody;
import net.wg.gui.lobby.premiumWindow.PremiumItemRenderer;
import net.wg.gui.lobby.premiumWindow.PremiumWindow;
import net.wg.gui.lobby.premiumWindow.data.PremiumItemRendererVo;
import net.wg.gui.lobby.premiumWindow.data.PremiumWindowRatesVO;
import net.wg.gui.lobby.premiumWindow.events.PremiumWindowEvent;
import net.wg.gui.lobby.profile.LinkageUtils;
import net.wg.gui.lobby.profile.Profile;
import net.wg.gui.lobby.profile.ProfileConstants;
import net.wg.gui.lobby.profile.ProfileInvalidationTypes;
import net.wg.gui.lobby.profile.ProfileMenuInfoVO;
import net.wg.gui.lobby.profile.ProfileOpenInfoEvent;
import net.wg.gui.lobby.profile.ProfileTabNavigator;
import net.wg.gui.lobby.profile.SectionInfo;
import net.wg.gui.lobby.profile.SectionViewInfo;
import net.wg.gui.lobby.profile.UserInfoForm;
import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
import net.wg.gui.lobby.profile.components.BattlesTypeDropdown;
import net.wg.gui.lobby.profile.components.CenteredLineIconText;
import net.wg.gui.lobby.profile.components.ColoredDeshLineTextItem;
import net.wg.gui.lobby.profile.components.GradientLineButtonBar;
import net.wg.gui.lobby.profile.components.HidableScrollBar;
import net.wg.gui.lobby.profile.components.ICounter;
import net.wg.gui.lobby.profile.components.LditBattles;
import net.wg.gui.lobby.profile.components.LditMarksOfMastery;
import net.wg.gui.lobby.profile.components.LditValued;
import net.wg.gui.lobby.profile.components.LineButtonBar;
import net.wg.gui.lobby.profile.components.LineTextComponent;
import net.wg.gui.lobby.profile.components.PersonalScoreComponent;
import net.wg.gui.lobby.profile.components.ProfileFooter;
import net.wg.gui.lobby.profile.components.ProfileGroupBlock;
import net.wg.gui.lobby.profile.components.ProfileMedalsList;
import net.wg.gui.lobby.profile.components.ProfilePageFooter;
import net.wg.gui.lobby.profile.components.ProfileWindowFooter;
import net.wg.gui.lobby.profile.components.ResizableContent;
import net.wg.gui.lobby.profile.components.ResizableInvalidationTypes;
import net.wg.gui.lobby.profile.components.SimpleLoader;
import net.wg.gui.lobby.profile.components.TechMasteryIcon;
import net.wg.gui.lobby.profile.components.TestTrack;
import net.wg.gui.lobby.profile.components.chart.AxisChart;
import net.wg.gui.lobby.profile.components.chart.BarItem;
import net.wg.gui.lobby.profile.components.chart.ChartBase;
import net.wg.gui.lobby.profile.components.chart.ChartItem;
import net.wg.gui.lobby.profile.components.chart.ChartItemBase;
import net.wg.gui.lobby.profile.components.chart.FrameChartItem;
import net.wg.gui.lobby.profile.components.chart.IChartItem;
import net.wg.gui.lobby.profile.components.chart.axis.AxisBase;
import net.wg.gui.lobby.profile.components.chart.axis.IChartAxis;
import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
import net.wg.gui.lobby.profile.components.chart.layout.LayoutBase;
import net.wg.gui.lobby.profile.data.LayoutItemInfo;
import net.wg.gui.lobby.profile.data.ProfileBaseInfoVO;
import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
import net.wg.gui.lobby.profile.data.ProfileCommonInfoVO;
import net.wg.gui.lobby.profile.data.ProfileDossierInfoVO;
import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
import net.wg.gui.lobby.profile.data.ProfileUserVO;
import net.wg.gui.lobby.profile.data.SectionLayoutManager;
import net.wg.gui.lobby.profile.pages.ProfileAchievementsSection;
import net.wg.gui.lobby.profile.pages.ProfileSection;
import net.wg.gui.lobby.profile.pages.ProfiletabInfo;
import net.wg.gui.lobby.profile.pages.SectionsShowAnimationManager;
import net.wg.gui.lobby.profile.pages.awards.AwardsBlock;
import net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer;
import net.wg.gui.lobby.profile.pages.awards.ProfileAwards;
import net.wg.gui.lobby.profile.pages.awards.StageAwardsBlock;
import net.wg.gui.lobby.profile.pages.awards.data.AchievementFilterVO;
import net.wg.gui.lobby.profile.pages.awards.data.AwardsBlockDataVO;
import net.wg.gui.lobby.profile.pages.awards.data.ProfileAwardsInitVO;
import net.wg.gui.lobby.profile.pages.awards.data.ReceivedRareVO;
import net.wg.gui.lobby.profile.pages.formations.ClanInfo;
import net.wg.gui.lobby.profile.pages.formations.ErrorInfo;
import net.wg.gui.lobby.profile.pages.formations.FormationHeader;
import net.wg.gui.lobby.profile.pages.formations.FormationInfoAbstract;
import net.wg.gui.lobby.profile.pages.formations.FortInfo;
import net.wg.gui.lobby.profile.pages.formations.LinkNavigationEvent;
import net.wg.gui.lobby.profile.pages.formations.NoClan;
import net.wg.gui.lobby.profile.pages.formations.PreviousTeamRenderer;
import net.wg.gui.lobby.profile.pages.formations.ProfileFormationsPage;
import net.wg.gui.lobby.profile.pages.formations.ShowTeamEvent;
import net.wg.gui.lobby.profile.pages.formations.TeamInfo;
import net.wg.gui.lobby.profile.pages.formations.data.FormationHeaderVO;
import net.wg.gui.lobby.profile.pages.formations.data.FormationStatVO;
import net.wg.gui.lobby.profile.pages.formations.data.PreviousTeamsItemVO;
import net.wg.gui.lobby.profile.pages.formations.data.ProfileFormationsVO;
import net.wg.gui.lobby.profile.pages.statistics.LevelBarChartItem;
import net.wg.gui.lobby.profile.pages.statistics.NationBarChartItem;
import net.wg.gui.lobby.profile.pages.statistics.ProfileStatistics;
import net.wg.gui.lobby.profile.pages.statistics.ProfileStatisticsBodyVO;
import net.wg.gui.lobby.profile.pages.statistics.ProfileStatisticsVO;
import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartAxisPoint;
import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartInitializer;
import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartItem;
import net.wg.gui.lobby.profile.pages.statistics.StatisticBarChartLayout;
import net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo;
import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChart;
import net.wg.gui.lobby.profile.pages.statistics.StatisticsBarChartAxis;
import net.wg.gui.lobby.profile.pages.statistics.StatisticsChartItemAnimClient;
import net.wg.gui.lobby.profile.pages.statistics.StatisticsLayoutManager;
import net.wg.gui.lobby.profile.pages.statistics.TfContainer;
import net.wg.gui.lobby.profile.pages.statistics.TypeBarChartItem;
import net.wg.gui.lobby.profile.pages.statistics.body.ChartsStatisticsGroup;
import net.wg.gui.lobby.profile.pages.statistics.body.ChartsStatisticsView;
import net.wg.gui.lobby.profile.pages.statistics.body.ProfileStatisticsDetailedVO;
import net.wg.gui.lobby.profile.pages.statistics.body.StatisticsChartsTabDataVO;
import net.wg.gui.lobby.profile.pages.statistics.header.HeaderBGImage;
import net.wg.gui.lobby.profile.pages.statistics.header.HeaderContainer;
import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
import net.wg.gui.lobby.profile.pages.summary.AwardsListComponent;
import net.wg.gui.lobby.profile.pages.summary.LineTextFieldsLayout;
import net.wg.gui.lobby.profile.pages.summary.ProfileSummary;
import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryPage;
import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryVO;
import net.wg.gui.lobby.profile.pages.summary.ProfileSummaryWindow;
import net.wg.gui.lobby.profile.pages.summary.SummaryCommonScoresVO;
import net.wg.gui.lobby.profile.pages.summary.SummaryInitVO;
import net.wg.gui.lobby.profile.pages.summary.SummaryPageInitVO;
import net.wg.gui.lobby.profile.pages.summary.SummaryViewVO;
import net.wg.gui.lobby.profile.pages.technique.AchievementSmall;
import net.wg.gui.lobby.profile.pages.technique.ProfileSortingButton;
import net.wg.gui.lobby.profile.pages.technique.ProfileTechnique;
import net.wg.gui.lobby.profile.pages.technique.ProfileTechniqueEmptyScreen;
import net.wg.gui.lobby.profile.pages.technique.ProfileTechniquePage;
import net.wg.gui.lobby.profile.pages.technique.ProfileTechniqueWindow;
import net.wg.gui.lobby.profile.pages.technique.TechAwardsMainContainer;
import net.wg.gui.lobby.profile.pages.technique.TechDetailedUnitGroup;
import net.wg.gui.lobby.profile.pages.technique.TechStatisticsInitVO;
import net.wg.gui.lobby.profile.pages.technique.TechStatisticsPageInitVO;
import net.wg.gui.lobby.profile.pages.technique.TechnicsDashLineTextItemIRenderer;
import net.wg.gui.lobby.profile.pages.technique.TechniqueAchievementTab;
import net.wg.gui.lobby.profile.pages.technique.TechniqueAchievementsBlock;
import net.wg.gui.lobby.profile.pages.technique.TechniqueList;
import net.wg.gui.lobby.profile.pages.technique.TechniqueListComponent;
import net.wg.gui.lobby.profile.pages.technique.TechniqueRenderer;
import net.wg.gui.lobby.profile.pages.technique.TechniqueStackComponent;
import net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab;
import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
import net.wg.gui.lobby.profile.pages.technique.data.SortingSettingVO;
import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
import net.wg.gui.lobby.profile.pages.technique.data.TechniqueStatisticVO;
import net.wg.gui.lobby.quests.components.AwardCarousel;
import net.wg.gui.lobby.quests.components.BaseQuestsProgress;
import net.wg.gui.lobby.quests.components.IconTitleDescSeasonAward;
import net.wg.gui.lobby.quests.components.QuestSlotRenderer;
import net.wg.gui.lobby.quests.components.QuestTaskDescription;
import net.wg.gui.lobby.quests.components.QuestTaskListSelectionNavigator;
import net.wg.gui.lobby.quests.components.QuestTileRenderer;
import net.wg.gui.lobby.quests.components.QuestsContentTabs;
import net.wg.gui.lobby.quests.components.QuestsProgress;
import net.wg.gui.lobby.quests.components.QuestsProgressFallout;
import net.wg.gui.lobby.quests.components.QuestsTileChainsViewFilters;
import net.wg.gui.lobby.quests.components.QuestsTileChainsViewHeader;
import net.wg.gui.lobby.quests.components.RadioButtonScrollBar;
import net.wg.gui.lobby.quests.components.SeasonAwardsList;
import net.wg.gui.lobby.quests.components.SeasonViewRenderer;
import net.wg.gui.lobby.quests.components.SeasonsListView;
import net.wg.gui.lobby.quests.components.SlotsGroup;
import net.wg.gui.lobby.quests.components.SlotsLayout;
import net.wg.gui.lobby.quests.components.SlotsPanel;
import net.wg.gui.lobby.quests.components.TaskAwardsBlock;
import net.wg.gui.lobby.quests.components.TextBlockWelcomeView;
import net.wg.gui.lobby.quests.components.VehicleSeasonAward;
import net.wg.gui.lobby.quests.components.interfaces.IQuestSlotRenderer;
import net.wg.gui.lobby.quests.components.interfaces.IQuestsPersonalWelcomeView;
import net.wg.gui.lobby.quests.components.interfaces.IQuestsSeasonsView;
import net.wg.gui.lobby.quests.components.interfaces.IQuestsTileChainsView;
import net.wg.gui.lobby.quests.components.interfaces.ITaskAwardItemRenderer;
import net.wg.gui.lobby.quests.components.interfaces.ITasksProgressComponent;
import net.wg.gui.lobby.quests.components.interfaces.ITextBlockWelcomeView;
import net.wg.gui.lobby.quests.components.renderers.AwardCarouselItemRenderer;
import net.wg.gui.lobby.quests.components.renderers.ISeasonAwardListRenderer;
import net.wg.gui.lobby.quests.components.renderers.QuestTaskListItemRenderer;
import net.wg.gui.lobby.quests.components.renderers.SeasonAwardListRenderer;
import net.wg.gui.lobby.quests.components.renderers.TaskAwardItemRenderer;
import net.wg.gui.lobby.quests.data.AwardCarouselItemRendererVO;
import net.wg.gui.lobby.quests.data.ChainProgressItemVO;
import net.wg.gui.lobby.quests.data.ChainProgressVO;
import net.wg.gui.lobby.quests.data.QuestSlotVO;
import net.wg.gui.lobby.quests.data.QuestSlotsDataVO;
import net.wg.gui.lobby.quests.data.QuestsSeasonsViewVO;
import net.wg.gui.lobby.quests.data.SeasonTileVO;
import net.wg.gui.lobby.quests.data.SeasonVO;
import net.wg.gui.lobby.quests.data.SeasonsDataVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestChainVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskDetailsVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskListRendererVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileStatisticsVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewFiltersVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewHeaderVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewVO;
import net.wg.gui.lobby.quests.data.seasonAwards.IconTitleDescSeasonAwardVO;
import net.wg.gui.lobby.quests.data.seasonAwards.QuestsPersonalWelcomeViewVO;
import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardListRendererVO;
import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardsVO;
import net.wg.gui.lobby.quests.data.seasonAwards.TextBlockWelcomeViewVO;
import net.wg.gui.lobby.quests.data.seasonAwards.VehicleSeasonAwardVO;
import net.wg.gui.lobby.quests.events.AwardWindowEvent;
import net.wg.gui.lobby.quests.events.ChainProgressEvent;
import net.wg.gui.lobby.quests.events.PersonalQuestEvent;
import net.wg.gui.lobby.quests.events.QuestTaskDetailsViewEvent;
import net.wg.gui.lobby.quests.events.QuestsTileChainViewFiltersEvent;
import net.wg.gui.lobby.quests.events.QuestsTileChainViewHeaderEvent;
import net.wg.gui.lobby.quests.events.SeasonAwardWindowEvent;
import net.wg.gui.lobby.quests.views.QuestTaskDetailsView;
import net.wg.gui.lobby.quests.views.QuestsPersonalWelcomeView;
import net.wg.gui.lobby.quests.views.QuestsSeasonsView;
import net.wg.gui.lobby.quests.views.QuestsTileChainsView;
import net.wg.gui.lobby.quests.windows.QuestsSeasonAwardsWindow;
import net.wg.gui.lobby.questsWindow.ConditionBlock;
import net.wg.gui.lobby.questsWindow.ConditionElement;
import net.wg.gui.lobby.questsWindow.DescriptionBlock;
import net.wg.gui.lobby.questsWindow.HeaderBlock;
import net.wg.gui.lobby.questsWindow.IQuestsTab;
import net.wg.gui.lobby.questsWindow.ISubtaskListLinkageSelector;
import net.wg.gui.lobby.questsWindow.QuestAwardsBlock;
import net.wg.gui.lobby.questsWindow.QuestBattleTaskRenderer;
import net.wg.gui.lobby.questsWindow.QuestBlock;
import net.wg.gui.lobby.questsWindow.QuestCarouselAwardsBlock;
import net.wg.gui.lobby.questsWindow.QuestContent;
import net.wg.gui.lobby.questsWindow.QuestDetailsSeparatorBlock;
import net.wg.gui.lobby.questsWindow.QuestDetailsSpacingBlock;
import net.wg.gui.lobby.questsWindow.QuestListSelectionNavigator;
import net.wg.gui.lobby.questsWindow.QuestRenderer;
import net.wg.gui.lobby.questsWindow.QuestWindowUtils;
import net.wg.gui.lobby.questsWindow.QuestsBaseTab;
import net.wg.gui.lobby.questsWindow.QuestsBeginnerTab;
import net.wg.gui.lobby.questsWindow.QuestsCurrentTab;
import net.wg.gui.lobby.questsWindow.QuestsFutureTab;
import net.wg.gui.lobby.questsWindow.QuestsList;
import net.wg.gui.lobby.questsWindow.QuestsTasksNavigator;
import net.wg.gui.lobby.questsWindow.QuestsWindow;
import net.wg.gui.lobby.questsWindow.RequirementBlock;
import net.wg.gui.lobby.questsWindow.SubtaskComponent;
import net.wg.gui.lobby.questsWindow.SubtasksList;
import net.wg.gui.lobby.questsWindow.VehicleBlock;
import net.wg.gui.lobby.questsWindow.components.AbstractResizableContent;
import net.wg.gui.lobby.questsWindow.components.AnimResizableContent;
import net.wg.gui.lobby.questsWindow.components.BaseResizableContentHeader;
import net.wg.gui.lobby.questsWindow.components.CommonConditionsBlock;
import net.wg.gui.lobby.questsWindow.components.ConditionSeparator;
import net.wg.gui.lobby.questsWindow.components.ConditionsGroup;
import net.wg.gui.lobby.questsWindow.components.CounterTextElement;
import net.wg.gui.lobby.questsWindow.components.CustomizationItemRenderer;
import net.wg.gui.lobby.questsWindow.components.CustomizationsBlock;
import net.wg.gui.lobby.questsWindow.components.EventsResizableContent;
import net.wg.gui.lobby.questsWindow.components.InnerResizableContent;
import net.wg.gui.lobby.questsWindow.components.MovableBlocksContainer;
import net.wg.gui.lobby.questsWindow.components.ProgressBlock;
import net.wg.gui.lobby.questsWindow.components.QuestIconAwardsBlock;
import net.wg.gui.lobby.questsWindow.components.QuestIconElement;
import net.wg.gui.lobby.questsWindow.components.QuestStatusComponent;
import net.wg.gui.lobby.questsWindow.components.QuestTextAwardBlock;
import net.wg.gui.lobby.questsWindow.components.QuestsCounter;
import net.wg.gui.lobby.questsWindow.components.QuestsDashlineItem;
import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
import net.wg.gui.lobby.questsWindow.components.ResizableContentHeader;
import net.wg.gui.lobby.questsWindow.components.SortingPanel;
import net.wg.gui.lobby.questsWindow.components.TextFieldMessageComponent;
import net.wg.gui.lobby.questsWindow.components.TextProgressElement;
import net.wg.gui.lobby.questsWindow.components.TreeHeader;
import net.wg.gui.lobby.questsWindow.components.TutorialHangarDetailsBlock;
import net.wg.gui.lobby.questsWindow.components.TutorialHangarMotiveDetailsBlock;
import net.wg.gui.lobby.questsWindow.components.TutorialHangarQuestDetailsBase;
import net.wg.gui.lobby.questsWindow.components.TutorialMotiveQuestDescriptionContainer;
import net.wg.gui.lobby.questsWindow.components.TutorialQuestConditionRenderer;
import net.wg.gui.lobby.questsWindow.components.TutorialQuestDescriptionContainer;
import net.wg.gui.lobby.questsWindow.components.VehicleBonusTextElement;
import net.wg.gui.lobby.questsWindow.components.VehicleItemRenderer;
import net.wg.gui.lobby.questsWindow.components.VehiclesSortingBlock;
import net.wg.gui.lobby.questsWindow.components.interfaces.IBeginnerQuestDetails;
import net.wg.gui.lobby.questsWindow.components.interfaces.IComplexViewStackItem;
import net.wg.gui.lobby.questsWindow.components.interfaces.IConditionRenderer;
import net.wg.gui.lobby.questsWindow.components.interfaces.IQuestsCurrentTabDAAPI;
import net.wg.gui.lobby.questsWindow.components.interfaces.IQuestsWindow;
import net.wg.gui.lobby.questsWindow.components.interfaces.ITutorialHangarQuestDetails;
import net.wg.gui.lobby.questsWindow.data.BaseResizableContentVO;
import net.wg.gui.lobby.questsWindow.data.ComplexTooltipVO;
import net.wg.gui.lobby.questsWindow.data.ConditionElementVO;
import net.wg.gui.lobby.questsWindow.data.ConditionSeparatorVO;
import net.wg.gui.lobby.questsWindow.data.CounterTextElementVO;
import net.wg.gui.lobby.questsWindow.data.DescriptionVO;
import net.wg.gui.lobby.questsWindow.data.EventsResizableContentVO;
import net.wg.gui.lobby.questsWindow.data.HeaderDataVO;
import net.wg.gui.lobby.questsWindow.data.InfoDataVO;
import net.wg.gui.lobby.questsWindow.data.PaddingsVO;
import net.wg.gui.lobby.questsWindow.data.PersonalInfoVO;
import net.wg.gui.lobby.questsWindow.data.ProgressBlockVO;
import net.wg.gui.lobby.questsWindow.data.QuestDashlineItemVO;
import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
import net.wg.gui.lobby.questsWindow.data.QuestDetailsSeparatorVO;
import net.wg.gui.lobby.questsWindow.data.QuestDetailsSpacingVO;
import net.wg.gui.lobby.questsWindow.data.QuestDetailsVO;
import net.wg.gui.lobby.questsWindow.data.QuestIconAwardsBlockVO;
import net.wg.gui.lobby.questsWindow.data.QuestIconElementVO;
import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
import net.wg.gui.lobby.questsWindow.data.QuestVehicleRendererVO;
import net.wg.gui.lobby.questsWindow.data.QuestsDataVO;
import net.wg.gui.lobby.questsWindow.data.RequirementBlockVO;
import net.wg.gui.lobby.questsWindow.data.SortedBtnVO;
import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
import net.wg.gui.lobby.questsWindow.data.TextBlockVO;
import net.wg.gui.lobby.questsWindow.data.TreeContentVO;
import net.wg.gui.lobby.questsWindow.data.TutorialHangarQuestDetailsVO;
import net.wg.gui.lobby.questsWindow.data.TutorialQuestConditionRendererVO;
import net.wg.gui.lobby.questsWindow.data.TutorialQuestDescVO;
import net.wg.gui.lobby.questsWindow.data.VehicleBlockVO;
import net.wg.gui.lobby.questsWindow.data.VehicleBonusTextElementVO;
import net.wg.gui.lobby.questsWindow.data.VehiclesSortingBlockVO;
import net.wg.gui.lobby.questsWindow.events.IQuestRenderer;
import net.wg.gui.lobby.questsWindow.events.TutorialQuestConditionEvent;
import net.wg.gui.lobby.recruitWindow.QuestRecruitWindow;
import net.wg.gui.lobby.recruitWindow.RecruitWindow;
import net.wg.gui.lobby.referralSystem.AwardReceivedBlock;
import net.wg.gui.lobby.referralSystem.ProgressStepRenderer;
import net.wg.gui.lobby.referralSystem.ReferralManagementEvent;
import net.wg.gui.lobby.referralSystem.ReferralsTableRenderer;
import net.wg.gui.lobby.referralSystem.ReferralsTableRendererVO;
import net.wg.gui.lobby.referralSystem.data.AwardDataDataVO;
import net.wg.gui.lobby.referralSystem.data.ProgressStepVO;
import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewBlockVO;
import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewBlockVOBase;
import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewMainButtons;
import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewOperationVO;
import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewRoleIR;
import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewWindow;
import net.wg.gui.lobby.retrainCrewWindow.RetrainTankmanVO;
import net.wg.gui.lobby.retrainCrewWindow.RetrainVehicleBlockVO;
import net.wg.gui.lobby.retrainCrewWindow.TankmanCrewRetrainingSmallButton;
import net.wg.gui.lobby.sellDialog.ControlQuestionComponent;
import net.wg.gui.lobby.sellDialog.MovingResult;
import net.wg.gui.lobby.sellDialog.SaleItemBlockRenderer;
import net.wg.gui.lobby.sellDialog.SellDevicesComponent;
import net.wg.gui.lobby.sellDialog.SellDialogListItemRenderer;
import net.wg.gui.lobby.sellDialog.SellHeaderComponent;
import net.wg.gui.lobby.sellDialog.SellSlidingComponent;
import net.wg.gui.lobby.sellDialog.SettingsButton;
import net.wg.gui.lobby.sellDialog.SlidingScrollingList;
import net.wg.gui.lobby.sellDialog.TotalResult;
import net.wg.gui.lobby.sellDialog.UserInputControl;
import net.wg.gui.lobby.sellDialog.VO.SellDialogVO;
import net.wg.gui.lobby.sellDialog.VO.SellInInventoryModuleVo;
import net.wg.gui.lobby.sellDialog.VO.SellInInventoryShellVo;
import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleEquipmentVo;
import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleOptionalDeviceVo;
import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleShellVo;
import net.wg.gui.lobby.sellDialog.VO.SellVehicleItemBaseVo;
import net.wg.gui.lobby.sellDialog.VO.SellVehicleVo;
import net.wg.gui.lobby.sellDialog.VehicleSellDialog;
import net.wg.gui.lobby.store.ComplexListItemRenderer;
import net.wg.gui.lobby.store.ModuleRendererCredits;
import net.wg.gui.lobby.store.STORE_STATUS_COLOR;
import net.wg.gui.lobby.store.StoreComponent;
import net.wg.gui.lobby.store.StoreEvent;
import net.wg.gui.lobby.store.StoreForm;
import net.wg.gui.lobby.store.StoreHelper;
import net.wg.gui.lobby.store.StoreList;
import net.wg.gui.lobby.store.StoreListItemRenderer;
import net.wg.gui.lobby.store.StoreTable;
import net.wg.gui.lobby.store.StoreTableDataProvider;
import net.wg.gui.lobby.store.StoreView;
import net.wg.gui.lobby.store.StoreViewsEvent;
import net.wg.gui.lobby.store.TableHeader;
import net.wg.gui.lobby.store.TableHeaderInfo;
import net.wg.gui.lobby.store.data.ButtonBarVO;
import net.wg.gui.lobby.store.data.FiltersDataVO;
import net.wg.gui.lobby.store.data.StoreTooltipMapVO;
import net.wg.gui.lobby.store.data.StoreViewInitVO;
import net.wg.gui.lobby.store.interfaces.IStoreTable;
import net.wg.gui.lobby.store.inventory.Inventory;
import net.wg.gui.lobby.store.inventory.InventoryModuleListItemRenderer;
import net.wg.gui.lobby.store.inventory.InventoryVehicleListItemRdr;
import net.wg.gui.lobby.store.inventory.base.InventoryListItemRenderer;
import net.wg.gui.lobby.store.shop.Shop;
import net.wg.gui.lobby.store.shop.ShopModuleListItemRenderer;
import net.wg.gui.lobby.store.shop.ShopRent;
import net.wg.gui.lobby.store.shop.ShopVehicleListItemRenderer;
import net.wg.gui.lobby.store.shop.base.ACTION_CREDITS_STATES;
import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
import net.wg.gui.lobby.store.views.EquipmentView;
import net.wg.gui.lobby.store.views.InventoryVehicleView;
import net.wg.gui.lobby.store.views.ModuleView;
import net.wg.gui.lobby.store.views.OptionalDeviceView;
import net.wg.gui.lobby.store.views.ShellView;
import net.wg.gui.lobby.store.views.ShopVehicleView;
import net.wg.gui.lobby.store.views.VehicleView;
import net.wg.gui.lobby.store.views.base.BaseStoreMenuView;
import net.wg.gui.lobby.store.views.base.FitsSelectableStoreMenuView;
import net.wg.gui.lobby.store.views.base.SimpleStoreMenuView;
import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
import net.wg.gui.lobby.store.views.base.interfaces.IStoreMenuView;
import net.wg.gui.lobby.store.views.data.DropDownItemData;
import net.wg.gui.lobby.store.views.data.ExtFitItemsFiltersVO;
import net.wg.gui.lobby.store.views.data.FiltersVO;
import net.wg.gui.lobby.store.views.data.FitItemsFiltersVO;
import net.wg.gui.lobby.store.views.data.ShopVehiclesFiltersVO;
import net.wg.gui.lobby.store.views.data.VehiclesFiltersVO;
import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
import net.wg.gui.lobby.tankman.CrewTankmanRetraining;
import net.wg.gui.lobby.tankman.DropSkillsCost;
import net.wg.gui.lobby.tankman.PersonalCase;
import net.wg.gui.lobby.tankman.PersonalCaseBase;
import net.wg.gui.lobby.tankman.PersonalCaseBlockItem;
import net.wg.gui.lobby.tankman.PersonalCaseBlockTitle;
import net.wg.gui.lobby.tankman.PersonalCaseBlocksArea;
import net.wg.gui.lobby.tankman.PersonalCaseCurrentVehicle;
import net.wg.gui.lobby.tankman.PersonalCaseDocs;
import net.wg.gui.lobby.tankman.PersonalCaseDocsModel;
import net.wg.gui.lobby.tankman.PersonalCaseInputList;
import net.wg.gui.lobby.tankman.PersonalCaseModel;
import net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel;
import net.wg.gui.lobby.tankman.PersonalCaseSkills;
import net.wg.gui.lobby.tankman.PersonalCaseSkillsItemRenderer;
import net.wg.gui.lobby.tankman.PersonalCaseSkillsModel;
import net.wg.gui.lobby.tankman.PersonalCaseSpecialization;
import net.wg.gui.lobby.tankman.PersonalCaseStats;
import net.wg.gui.lobby.tankman.PersonalCaseTabName;
import net.wg.gui.lobby.tankman.RankElement;
import net.wg.gui.lobby.tankman.RoleChangeItem;
import net.wg.gui.lobby.tankman.RoleChangeItems;
import net.wg.gui.lobby.tankman.RoleChangeVehicleSelection;
import net.wg.gui.lobby.tankman.RoleChangeWindow;
import net.wg.gui.lobby.tankman.SkillDropModel;
import net.wg.gui.lobby.tankman.SkillDropWindow;
import net.wg.gui.lobby.tankman.SkillItemViewMini;
import net.wg.gui.lobby.tankman.SkillsItemsRendererRankIcon;
import net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;
import net.wg.gui.lobby.tankman.VehicleTypeButton;
import net.wg.gui.lobby.tankman.vo.RoleChangeItemVO;
import net.wg.gui.lobby.tankman.vo.RoleChangeVO;
import net.wg.gui.lobby.tankman.vo.TankmanSkillsInfoBlockVO;
import net.wg.gui.lobby.tankman.vo.VehicleSelectionItemVO;
import net.wg.gui.lobby.tankman.vo.VehicleSelectionVO;
import net.wg.gui.lobby.techtree.ResearchPage;
import net.wg.gui.lobby.techtree.TechTreeEvent;
import net.wg.gui.lobby.techtree.TechTreePage;
import net.wg.gui.lobby.techtree.constants.ActionName;
import net.wg.gui.lobby.techtree.constants.ColorIndex;
import net.wg.gui.lobby.techtree.constants.IconTextResolver;
import net.wg.gui.lobby.techtree.constants.NamedLabels;
import net.wg.gui.lobby.techtree.constants.NavIndicator;
import net.wg.gui.lobby.techtree.constants.NodeEntityType;
import net.wg.gui.lobby.techtree.constants.NodeName;
import net.wg.gui.lobby.techtree.constants.NodeRendererState;
import net.wg.gui.lobby.techtree.constants.OutLiteral;
import net.wg.gui.lobby.techtree.constants.TTInvalidationType;
import net.wg.gui.lobby.techtree.constants.TTSoundID;
import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
import net.wg.gui.lobby.techtree.controls.ActionButton;
import net.wg.gui.lobby.techtree.controls.ExperienceInformation;
import net.wg.gui.lobby.techtree.controls.ExperienceLabel;
import net.wg.gui.lobby.techtree.controls.LevelDelimiter;
import net.wg.gui.lobby.techtree.controls.LevelsContainer;
import net.wg.gui.lobby.techtree.controls.NameAndXpField;
import net.wg.gui.lobby.techtree.controls.NationButton;
import net.wg.gui.lobby.techtree.controls.NationsButtonBar;
import net.wg.gui.lobby.techtree.controls.NodeComponent;
import net.wg.gui.lobby.techtree.controls.PremiumDescription;
import net.wg.gui.lobby.techtree.controls.PremiumLayout;
import net.wg.gui.lobby.techtree.controls.ResearchTitleBar;
import net.wg.gui.lobby.techtree.controls.ReturnToTTButton;
import net.wg.gui.lobby.techtree.controls.TreeNodeSelector;
import net.wg.gui.lobby.techtree.controls.TypeAndLevelField;
import net.wg.gui.lobby.techtree.controls.XPIcon;
import net.wg.gui.lobby.techtree.data.AbstractDataProvider;
import net.wg.gui.lobby.techtree.data.NationVODataProvider;
import net.wg.gui.lobby.techtree.data.NationXMLDataProvider;
import net.wg.gui.lobby.techtree.data.ResearchVODataProvider;
import net.wg.gui.lobby.techtree.data.ResearchXMLDataProvider;
import net.wg.gui.lobby.techtree.data.state.AnimationProperties;
import net.wg.gui.lobby.techtree.data.state.InventoryStateItem;
import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
import net.wg.gui.lobby.techtree.data.state.NodeStateItem;
import net.wg.gui.lobby.techtree.data.state.ResearchStateItem;
import net.wg.gui.lobby.techtree.data.state.StateProperties;
import net.wg.gui.lobby.techtree.data.state.UnlockedStateItem;
import net.wg.gui.lobby.techtree.data.vo.ExtraInformation;
import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
import net.wg.gui.lobby.techtree.data.vo.NodeData;
import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
import net.wg.gui.lobby.techtree.data.vo.ShopPrice;
import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
import net.wg.gui.lobby.techtree.data.vo.VehCompareEntrypointTreeNodeVO;
import net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;
import net.wg.gui.lobby.techtree.helpers.Distance;
import net.wg.gui.lobby.techtree.helpers.LinesGraphics;
import net.wg.gui.lobby.techtree.helpers.ModulesGraphics;
import net.wg.gui.lobby.techtree.helpers.NTGraphics;
import net.wg.gui.lobby.techtree.helpers.NodeIndexFilter;
import net.wg.gui.lobby.techtree.helpers.ResearchGraphics;
import net.wg.gui.lobby.techtree.helpers.TitleAppearance;
import net.wg.gui.lobby.techtree.interfaces.IHasRendererAsOwner;
import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
import net.wg.gui.lobby.techtree.interfaces.INodesDataProvider;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;
import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
import net.wg.gui.lobby.techtree.interfaces.IResearchDataProvider;
import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
import net.wg.gui.lobby.techtree.interfaces.IValueObject;
import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
import net.wg.gui.lobby.techtree.math.HungarianAlgorithm;
import net.wg.gui.lobby.techtree.math.MatrixPosition;
import net.wg.gui.lobby.techtree.math.MatrixUtils;
import net.wg.gui.lobby.techtree.nodes.FakeNode;
import net.wg.gui.lobby.techtree.nodes.NationTreeNode;
import net.wg.gui.lobby.techtree.nodes.Renderer;
import net.wg.gui.lobby.techtree.nodes.ResearchItem;
import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
import net.wg.gui.lobby.techtree.sub.ModulesTree;
import net.wg.gui.lobby.techtree.sub.NationTree;
import net.wg.gui.lobby.techtree.sub.ResearchItems;
import net.wg.gui.lobby.training.ArenaVoipSettings;
import net.wg.gui.lobby.training.DropList;
import net.wg.gui.lobby.training.DropTileList;
import net.wg.gui.lobby.training.ObserverButtonComponent;
import net.wg.gui.lobby.training.PlayerElement;
import net.wg.gui.lobby.training.TooltipViewer;
import net.wg.gui.lobby.training.TrainingConstants;
import net.wg.gui.lobby.training.TrainingDragController;
import net.wg.gui.lobby.training.TrainingDragDelegate;
import net.wg.gui.lobby.training.TrainingForm;
import net.wg.gui.lobby.training.TrainingListItemRenderer;
import net.wg.gui.lobby.training.TrainingPlayerItemRenderer;
import net.wg.gui.lobby.training.TrainingRoom;
import net.wg.gui.lobby.training.TrainingWindow;
import net.wg.gui.lobby.vehicleBuyWindow.BodyMc;
import net.wg.gui.lobby.vehicleBuyWindow.BuyingVehicleVO;
import net.wg.gui.lobby.vehicleBuyWindow.ExpandButton;
import net.wg.gui.lobby.vehicleBuyWindow.FooterMc;
import net.wg.gui.lobby.vehicleBuyWindow.HeaderMc;
import net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyRentItemVO;
import net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindow;
import net.wg.gui.lobby.vehicleBuyWindow.VehicleBuyWindowAnimManager;
import net.wg.gui.lobby.vehicleCompare.VehicleCompareCartItemRenderer;
import net.wg.gui.lobby.vehicleCompare.VehicleCompareCartPopover;
import net.wg.gui.lobby.vehicleCompare.VehicleCompareView;
import net.wg.gui.lobby.vehicleCompare.VehicleModulesTree;
import net.wg.gui.lobby.vehicleCompare.VehicleModulesWindow;
import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAddVehiclePopover;
import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAddVehicleRenderer;
import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAnim;
import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareAnimRenderer;
import net.wg.gui.lobby.vehicleCompare.controls.VehicleCompareVehicleSelector;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareBubble;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareCrewDropDownItemRenderer;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareGridLine;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareHeader;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareHeaderBackground;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareMainPanel;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareParamRenderer;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareParamsDelta;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareParamsViewPort;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTableContent;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTableGrid;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTankCarousel;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareTopPanel;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareVehParamRenderer;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehCompareVehicleRenderer;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehParamsListDataProvider;
import net.wg.gui.lobby.vehicleCompare.controls.view.VehParamsScroller;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareCrewLevelVO;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareDataProvider;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareHeaderVO;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareStaticDataVO;
import net.wg.gui.lobby.vehicleCompare.data.VehCompareVehicleVO;
import net.wg.gui.lobby.vehicleCompare.data.VehParamsDataVO;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAddVehiclePopoverVO;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartItemVO;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareCartPopoverInitDataVO;
import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareVehicleSelectorItemVO;
import net.wg.gui.lobby.vehicleCompare.data.VehicleModulesWindowInitDataVO;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareParamsListEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareScrollEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehParamRendererEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehicleRendererEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehicleCompareAddVehicleRendererEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehicleCompareCartEvent;
import net.wg.gui.lobby.vehicleCompare.events.VehicleModuleItemEvent;
import net.wg.gui.lobby.vehicleCompare.interfaces.IMainPanel;
import net.wg.gui.lobby.vehicleCompare.interfaces.ITableGridLine;
import net.wg.gui.lobby.vehicleCompare.interfaces.ITopPanel;
import net.wg.gui.lobby.vehicleCompare.interfaces.IVehCompareViewHeader;
import net.wg.gui.lobby.vehicleCompare.interfaces.IVehParamRenderer;
import net.wg.gui.lobby.vehicleCompare.nodes.ModuleItemNode;
import net.wg.gui.lobby.vehicleCompare.nodes.ModuleRenderer;
import net.wg.gui.lobby.vehicleCompare.nodes.ModulesRootNode;
import net.wg.gui.lobby.vehicleCompare.nodes.ModulesTreeDataProvider;
import net.wg.gui.lobby.vehicleCustomization.BottomPanel;
import net.wg.gui.lobby.vehicleCustomization.CustomizationBonusPanel;
import net.wg.gui.lobby.vehicleCustomization.CustomizationBonusRenderer;
import net.wg.gui.lobby.vehicleCustomization.CustomizationBuyWindow;
import net.wg.gui.lobby.vehicleCustomization.CustomizationBuyingPanel;
import net.wg.gui.lobby.vehicleCustomization.CustomizationCarousel;
import net.wg.gui.lobby.vehicleCustomization.CustomizationFiltersPopover;
import net.wg.gui.lobby.vehicleCustomization.CustomizationGroupRenderer;
import net.wg.gui.lobby.vehicleCustomization.CustomizationGroupsSlotPanel;
import net.wg.gui.lobby.vehicleCustomization.CustomizationHeader;
import net.wg.gui.lobby.vehicleCustomization.CustomizationHelper;
import net.wg.gui.lobby.vehicleCustomization.CustomizationMainView;
import net.wg.gui.lobby.vehicleCustomization.CustomizationPurchasesListItemRenderer;
import net.wg.gui.lobby.vehicleCustomization.CustomizationSlotBubble;
import net.wg.gui.lobby.vehicleCustomization.CustomizationSlotRenderer;
import net.wg.gui.lobby.vehicleCustomization.CustomizationSlotsPanel;
import net.wg.gui.lobby.vehicleCustomization.CustomizationSlotsPanelView;
import net.wg.gui.lobby.vehicleCustomization.ISlotsPanelRenderer;
import net.wg.gui.lobby.vehicleCustomization.controls.AnimatedBonus;
import net.wg.gui.lobby.vehicleCustomization.controls.CarouselItemRenderer;
import net.wg.gui.lobby.vehicleCustomization.controls.CarouselItemSlot;
import net.wg.gui.lobby.vehicleCustomization.controls.DropDownPriceItemRenderer;
import net.wg.gui.lobby.vehicleCustomization.controls.LabelBonus;
import net.wg.gui.lobby.vehicleCustomization.controls.PurchaseTableRenderer;
import net.wg.gui.lobby.vehicleCustomization.controls.RadioButtonListSelectionNavigator;
import net.wg.gui.lobby.vehicleCustomization.controls.RadioRenderer;
import net.wg.gui.lobby.vehicleCustomization.data.BottomPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBottomPanelInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPurchasesPopoverInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPurchasesPopoverVO;
import net.wg.gui.lobby.vehicleCustomization.data.CustomizationRadioRendererVO;
import net.wg.gui.lobby.vehicleCustomization.data.DDPriceRendererVO;
import net.wg.gui.lobby.vehicleCustomization.data.FiltersPopoverVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselDataVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CarouselRendererVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselFilterVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotUpdateVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotsGroupVO;
import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationSlotsPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.AnimationBonusVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBonusPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBonusRendererVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBuyingPanelInitVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationBuyingPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.panels.CustomizationTotalBonusPanelVO;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.InitBuyWindowVO;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchaseVO;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesPopoverRendererVO;
import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesTotalVO;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSlotEvent;
import net.wg.gui.lobby.vehicleInfo.BaseBlock;
import net.wg.gui.lobby.vehicleInfo.CrewBlock;
import net.wg.gui.lobby.vehicleInfo.IVehicleInfoBlock;
import net.wg.gui.lobby.vehicleInfo.PropBlock;
import net.wg.gui.lobby.vehicleInfo.VehicleInfo;
import net.wg.gui.lobby.vehicleInfo.VehicleInfoBase;
import net.wg.gui.lobby.vehicleInfo.VehicleInfoCrew;
import net.wg.gui.lobby.vehicleInfo.VehicleInfoProps;
import net.wg.gui.lobby.vehicleInfo.VehicleInfoViewContent;
import net.wg.gui.lobby.vehicleInfo.data.VehCompareButtonDataVO;
import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoCrewBlockVO;
import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoDataVO;
import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoPropBlockVO;
import net.wg.gui.lobby.vehiclePreview.VehiclePreview;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewBottomPanel;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewBuyingPanel;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewCrewInfo;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewCrewListRenderer;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewFactSheet;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewHeader;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoPanel;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoPanelTab;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoTabButton;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewInfoViewStack;
import net.wg.gui.lobby.vehiclePreview.controls.VehPreviewVehicleInfoPanel;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBottomPanelVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewCrewInfoVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewCrewListRendererVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewFactSheetVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewHeaderVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoTabDataItemVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewPriceDataVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewStaticDataVO;
import net.wg.gui.lobby.vehiclePreview.data.VehPreviewVehicleInfoPanelVO;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
import net.wg.gui.lobby.vehiclePreview.events.VehPreviewInfoPanelEvent;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBottomPanel;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBuyingPanel;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewHeader;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanel;
import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanelTab;
import net.wg.gui.lobby.wgnc.WGNCDialog;
import net.wg.gui.lobby.wgnc.WGNCDialogModal;
import net.wg.gui.lobby.wgnc.WGNCPollWindow;
import net.wg.gui.lobby.window.AwardWindow;
import net.wg.gui.lobby.window.BaseExchangeWindow;
import net.wg.gui.lobby.window.BaseExchangeWindowRateVO;
import net.wg.gui.lobby.window.BoostersWindow;
import net.wg.gui.lobby.window.BrowserWindow;
import net.wg.gui.lobby.window.ConfirmExchangeBlock;
import net.wg.gui.lobby.window.ConfirmExchangeDialog;
import net.wg.gui.lobby.window.ConfirmItemWindow;
import net.wg.gui.lobby.window.ConfirmItemWindowBaseVO;
import net.wg.gui.lobby.window.ConfirmItemWindowVO;
import net.wg.gui.lobby.window.ExchangeCurrencyWindow;
import net.wg.gui.lobby.window.ExchangeFreeToTankmanInitVO;
import net.wg.gui.lobby.window.ExchangeFreeToTankmanXpWarning;
import net.wg.gui.lobby.window.ExchangeFreeToTankmanXpWindow;
import net.wg.gui.lobby.window.ExchangeHeader;
import net.wg.gui.lobby.window.ExchangeHeaderVO;
import net.wg.gui.lobby.window.ExchangeUtils;
import net.wg.gui.lobby.window.ExchangeWindow;
import net.wg.gui.lobby.window.ExchangeXPFromVehicleIR;
import net.wg.gui.lobby.window.ExchangeXPList;
import net.wg.gui.lobby.window.ExchangeXPTankmanSkillsModel;
import net.wg.gui.lobby.window.ExchangeXPVehicleVO;
import net.wg.gui.lobby.window.ExchangeXPWarningScreen;
import net.wg.gui.lobby.window.ExchangeXPWindow;
import net.wg.gui.lobby.window.ExchangeXPWindowVO;
import net.wg.gui.lobby.window.ExtendedIconText;
import net.wg.gui.lobby.window.IExchangeHeader;
import net.wg.gui.lobby.window.MissionAwardWindow;
import net.wg.gui.lobby.window.ModuleInfo;
import net.wg.gui.lobby.window.ProfileWindow;
import net.wg.gui.lobby.window.ProfileWindowInitVO;
import net.wg.gui.lobby.window.PromoPremiumIgrWindow;
import net.wg.gui.lobby.window.PunishmentDialog;
import net.wg.gui.lobby.window.PvESandboxQueueWindow;
import net.wg.gui.lobby.window.RefManagementWindowVO;
import net.wg.gui.lobby.window.ReferralManagementWindow;
import net.wg.gui.lobby.window.ReferralReferralsIntroWindow;
import net.wg.gui.lobby.window.ReferralReferrerIntroWindow;
import net.wg.gui.lobby.window.ReferralTextBlockCmp;
import net.wg.gui.lobby.window.SwitchPeripheryWindow;
import net.wg.gui.lobby.window.VcoinExchangeDataVO;
import net.wg.gui.login.EULA.EULADlg;
import net.wg.gui.login.EULA.EULAFullDlg;
import net.wg.gui.login.IFormBaseVo;
import net.wg.gui.login.ILoginForm;
import net.wg.gui.login.ILoginFormView;
import net.wg.gui.login.IRssNewsFeedRenderer;
import net.wg.gui.login.ISparksManager;
import net.wg.gui.login.impl.LoginPage;
import net.wg.gui.login.impl.LoginQueueWindow;
import net.wg.gui.login.impl.LoginViewStack;
import net.wg.gui.login.impl.RudimentarySwfOnLoginCheckingHelper;
import net.wg.gui.login.impl.Spark;
import net.wg.gui.login.impl.SparksManager;
import net.wg.gui.login.impl.components.CapsLockIndicator;
import net.wg.gui.login.impl.components.Copyright;
import net.wg.gui.login.impl.components.CopyrightEvent;
import net.wg.gui.login.impl.components.LoginIgrWarning;
import net.wg.gui.login.impl.components.LoginLogos;
import net.wg.gui.login.impl.components.RssItemEvent;
import net.wg.gui.login.impl.components.RssNewsFeed;
import net.wg.gui.login.impl.components.RssNewsFeedRenderer;
import net.wg.gui.login.impl.components.SocialGroup;
import net.wg.gui.login.impl.components.SocialIconsList;
import net.wg.gui.login.impl.components.SocialItemRenderer;
import net.wg.gui.login.impl.ev.LoginEvent;
import net.wg.gui.login.impl.ev.LoginEventTextLink;
import net.wg.gui.login.impl.ev.LoginLogosEv;
import net.wg.gui.login.impl.ev.LoginServerDDEvent;
import net.wg.gui.login.impl.ev.LoginViewStackEvent;
import net.wg.gui.login.impl.views.LoginFormView;
import net.wg.gui.login.impl.views.SimpleForm;
import net.wg.gui.login.impl.views.SocialForm;
import net.wg.gui.login.impl.vo.FormBaseVo;
import net.wg.gui.login.impl.vo.RssItemVo;
import net.wg.gui.login.impl.vo.SimpleFormVo;
import net.wg.gui.login.impl.vo.SocialFormVo;
import net.wg.gui.login.impl.vo.SocialIconVo;
import net.wg.gui.login.impl.vo.SubmitDataVo;
import net.wg.gui.login.legal.LegalContent;
import net.wg.gui.login.legal.LegalInfoWindow;
import net.wg.gui.messenger.ChannelComponent;
import net.wg.gui.messenger.ContactsListPopover;
import net.wg.gui.messenger.IChannelComponent;
import net.wg.gui.messenger.SmileyMap;
import net.wg.gui.messenger.controls.BaseContactsScrollingList;
import net.wg.gui.messenger.controls.ChannelItemRenderer;
import net.wg.gui.messenger.controls.ContactAttributesGroup;
import net.wg.gui.messenger.controls.ContactGroupItem;
import net.wg.gui.messenger.controls.ContactItem;
import net.wg.gui.messenger.controls.ContactItemRenderer;
import net.wg.gui.messenger.controls.ContactListHeaderCheckBox;
import net.wg.gui.messenger.controls.ContactScrollingList;
import net.wg.gui.messenger.controls.ContactsBaseDropListDelegate;
import net.wg.gui.messenger.controls.ContactsBtnBar;
import net.wg.gui.messenger.controls.ContactsDropListDelegate;
import net.wg.gui.messenger.controls.ContactsListBaseController;
import net.wg.gui.messenger.controls.ContactsListDragDropDelegate;
import net.wg.gui.messenger.controls.ContactsListDtagController;
import net.wg.gui.messenger.controls.ContactsListHighlightArea;
import net.wg.gui.messenger.controls.ContactsListItemRenderer;
import net.wg.gui.messenger.controls.ContactsListSelectionNavigator;
import net.wg.gui.messenger.controls.ContactsTreeComponent;
import net.wg.gui.messenger.controls.ContactsTreeItemRenderer;
import net.wg.gui.messenger.controls.ContactsWindowViewBG;
import net.wg.gui.messenger.controls.DashedHighlightArea;
import net.wg.gui.messenger.controls.EmptyHighlightArea;
import net.wg.gui.messenger.controls.ImgDropListDelegate;
import net.wg.gui.messenger.controls.InfoMessageView;
import net.wg.gui.messenger.controls.MainGroupItem;
import net.wg.gui.messenger.controls.MemberItemRenderer;
import net.wg.gui.messenger.data.ChannelMemberVO;
import net.wg.gui.messenger.data.ContactEvent;
import net.wg.gui.messenger.data.ContactItemVO;
import net.wg.gui.messenger.data.ContactListMainInfo;
import net.wg.gui.messenger.data.ContactUserPropVO;
import net.wg.gui.messenger.data.ContactVO;
import net.wg.gui.messenger.data.ContactsConstants;
import net.wg.gui.messenger.data.ContactsGroupEvent;
import net.wg.gui.messenger.data.ContactsListGroupVO;
import net.wg.gui.messenger.data.ContactsListTreeItemInfo;
import net.wg.gui.messenger.data.ContactsSettingsDataVO;
import net.wg.gui.messenger.data.ContactsSettingsViewInitDataVO;
import net.wg.gui.messenger.data.ContactsShared;
import net.wg.gui.messenger.data.ContactsTreeDataProvider;
import net.wg.gui.messenger.data.ContactsViewInitDataVO;
import net.wg.gui.messenger.data.ContactsWindowInitVO;
import net.wg.gui.messenger.data.ExtContactsViewInitVO;
import net.wg.gui.messenger.data.GroupRulesVO;
import net.wg.gui.messenger.data.IContactItemRenderer;
import net.wg.gui.messenger.data.ITreeItemInfo;
import net.wg.gui.messenger.data.TreeDAAPIDataProvider;
import net.wg.gui.messenger.data.TreeItemInfo;
import net.wg.gui.messenger.evnts.ChannelsFormEvent;
import net.wg.gui.messenger.evnts.ContactsFormEvent;
import net.wg.gui.messenger.evnts.ContactsScrollingListEvent;
import net.wg.gui.messenger.evnts.ContactsTreeEvent;
import net.wg.gui.messenger.forms.ChannelsCreateForm;
import net.wg.gui.messenger.forms.ChannelsSearchForm;
import net.wg.gui.messenger.forms.ContactsListForm;
import net.wg.gui.messenger.forms.ContactsSearchForm;
import net.wg.gui.messenger.meta.IBaseContactViewMeta;
import net.wg.gui.messenger.meta.IBaseManageContactViewMeta;
import net.wg.gui.messenger.meta.IChannelComponentMeta;
import net.wg.gui.messenger.meta.IChannelWindowMeta;
import net.wg.gui.messenger.meta.IChannelsManagementWindowMeta;
import net.wg.gui.messenger.meta.IConnectToSecureChannelWindowMeta;
import net.wg.gui.messenger.meta.IContactNoteManageViewMeta;
import net.wg.gui.messenger.meta.IContactsListPopoverMeta;
import net.wg.gui.messenger.meta.IContactsSettingsViewMeta;
import net.wg.gui.messenger.meta.IContactsWindowMeta;
import net.wg.gui.messenger.meta.IFAQWindowMeta;
import net.wg.gui.messenger.meta.IGroupDeleteViewMeta;
import net.wg.gui.messenger.meta.ILobbyChannelWindowMeta;
import net.wg.gui.messenger.meta.ISearchContactViewMeta;
import net.wg.gui.messenger.meta.impl.BaseContactViewMeta;
import net.wg.gui.messenger.meta.impl.BaseManageContactViewMeta;
import net.wg.gui.messenger.meta.impl.ChannelComponentMeta;
import net.wg.gui.messenger.meta.impl.ChannelWindowMeta;
import net.wg.gui.messenger.meta.impl.ChannelsManagementWindowMeta;
import net.wg.gui.messenger.meta.impl.ConnectToSecureChannelWindowMeta;
import net.wg.gui.messenger.meta.impl.ContactNoteManageViewMeta;
import net.wg.gui.messenger.meta.impl.ContactsListPopoverMeta;
import net.wg.gui.messenger.meta.impl.ContactsSettingsViewMeta;
import net.wg.gui.messenger.meta.impl.ContactsWindowMeta;
import net.wg.gui.messenger.meta.impl.FAQWindowMeta;
import net.wg.gui.messenger.meta.impl.GroupDeleteViewMeta;
import net.wg.gui.messenger.meta.impl.LobbyChannelWindowMeta;
import net.wg.gui.messenger.meta.impl.SearchContactViewMeta;
import net.wg.gui.messenger.views.BaseContactView;
import net.wg.gui.messenger.views.BaseManageContactView;
import net.wg.gui.messenger.views.ContactNoteManageView;
import net.wg.gui.messenger.views.ContactsSettingsView;
import net.wg.gui.messenger.views.GroupDeleteView;
import net.wg.gui.messenger.views.SearchContactView;
import net.wg.gui.messenger.windows.ChannelWindow;
import net.wg.gui.messenger.windows.ChannelsManagementWindow;
import net.wg.gui.messenger.windows.ConnectToSecureChannelWindow;
import net.wg.gui.messenger.windows.FAQWindow;
import net.wg.gui.messenger.windows.LazyChannelWindow;
import net.wg.gui.messenger.windows.LobbyChannelWindow;
import net.wg.gui.notification.NotificationListView;
import net.wg.gui.notification.NotificationPopUpViewer;
import net.wg.gui.notification.NotificationTimeComponent;
import net.wg.gui.notification.NotificationsList;
import net.wg.gui.notification.ServiceMessage;
import net.wg.gui.notification.ServiceMessageItemRenderer;
import net.wg.gui.notification.ServiceMessagePopUp;
import net.wg.gui.notification.SystemMessageDialog;
import net.wg.gui.notification.constants.ButtonState;
import net.wg.gui.notification.constants.ButtonType;
import net.wg.gui.notification.constants.MessageMetrics;
import net.wg.gui.notification.events.NotificationLayoutEvent;
import net.wg.gui.notification.events.NotificationListEvent;
import net.wg.gui.notification.events.ServiceMessageEvent;
import net.wg.gui.notification.vo.ButtonVO;
import net.wg.gui.notification.vo.MessageInfoVO;
import net.wg.gui.notification.vo.NotificationDialogInitInfoVO;
import net.wg.gui.notification.vo.NotificationInfoVO;
import net.wg.gui.notification.vo.NotificationMessagesListVO;
import net.wg.gui.notification.vo.NotificationSettingsVO;
import net.wg.gui.notification.vo.NotificationViewInitVO;
import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
import net.wg.gui.prebattle.abstract.PrebattleWindowAbstract;
import net.wg.gui.prebattle.abstract.PrequeueWindow;
import net.wg.gui.prebattle.base.BasePrebattleListView;
import net.wg.gui.prebattle.base.BasePrebattleRoomView;
import net.wg.gui.prebattle.battleSession.BSFlagRenderer;
import net.wg.gui.prebattle.battleSession.BSFlagRendererVO;
import net.wg.gui.prebattle.battleSession.BSListRendererVO;
import net.wg.gui.prebattle.battleSession.BattleSessionList;
import net.wg.gui.prebattle.battleSession.BattleSessionListRenderer;
import net.wg.gui.prebattle.battleSession.BattleSessionWindow;
import net.wg.gui.prebattle.battleSession.FlagsList;
import net.wg.gui.prebattle.battleSession.RequirementInfo;
import net.wg.gui.prebattle.battleSession.TopInfo;
import net.wg.gui.prebattle.battleSession.TopStats;
import net.wg.gui.prebattle.company.CompaniesListWindow;
import net.wg.gui.prebattle.company.CompaniesScrollingList;
import net.wg.gui.prebattle.company.CompanyDropItemRenderer;
import net.wg.gui.prebattle.company.CompanyDropList;
import net.wg.gui.prebattle.company.CompanyHelper;
import net.wg.gui.prebattle.company.CompanyListItemRenderer;
import net.wg.gui.prebattle.company.CompanyListView;
import net.wg.gui.prebattle.company.CompanyMainWindow;
import net.wg.gui.prebattle.company.CompanyRoomHeader;
import net.wg.gui.prebattle.company.CompanyRoomView;
import net.wg.gui.prebattle.company.CompanyWindow;
import net.wg.gui.prebattle.company.GroupPlayersDropDownMenu;
import net.wg.gui.prebattle.company.VO.CompanyHeaderClassLimitsVO;
import net.wg.gui.prebattle.company.VO.CompanyRoomHeaderBaseVO;
import net.wg.gui.prebattle.company.VO.CompanyRoomHeaderVO;
import net.wg.gui.prebattle.company.VO.CompanyRoomInvalidVehiclesVO;
import net.wg.gui.prebattle.company.events.CompanyDropDownEvent;
import net.wg.gui.prebattle.company.events.CompanyEvent;
import net.wg.gui.prebattle.company.interfaces.ICompanyRoomHeader;
import net.wg.gui.prebattle.constants.PrebattleStateFlags;
import net.wg.gui.prebattle.constants.PrebattleStateString;
import net.wg.gui.prebattle.controls.TeamMemberRenderer;
import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
import net.wg.gui.prebattle.data.ReceivedInviteVO;
import net.wg.gui.prebattle.invites.InviteStackContainerBase;
import net.wg.gui.prebattle.invites.PrbInviteSearchUsersForm;
import net.wg.gui.prebattle.invites.ReceivedInviteWindow;
import net.wg.gui.prebattle.invites.SendInvitesEvent;
import net.wg.gui.prebattle.invites.UserRosterItemRenderer;
import net.wg.gui.prebattle.invites.UserRosterView;
import net.wg.gui.prebattle.meta.IBattleSessionListMeta;
import net.wg.gui.prebattle.meta.IBattleSessionWindowMeta;
import net.wg.gui.prebattle.meta.ICompaniesWindowMeta;
import net.wg.gui.prebattle.meta.ICompanyMainWindowMeta;
import net.wg.gui.prebattle.meta.ICompanyWindowMeta;
import net.wg.gui.prebattle.meta.IPrebattleWindowMeta;
import net.wg.gui.prebattle.meta.IPrequeueWindowMeta;
import net.wg.gui.prebattle.meta.IReceivedInviteWindowMeta;
import net.wg.gui.prebattle.meta.impl.BattleSessionListMeta;
import net.wg.gui.prebattle.meta.impl.BattleSessionWindowMeta;
import net.wg.gui.prebattle.meta.impl.CompaniesWindowMeta;
import net.wg.gui.prebattle.meta.impl.CompanyMainWindowMeta;
import net.wg.gui.prebattle.meta.impl.CompanyWindowMeta;
import net.wg.gui.prebattle.meta.impl.PrebattleWindowMeta;
import net.wg.gui.prebattle.meta.impl.PrequeueWindowMeta;
import net.wg.gui.prebattle.meta.impl.ReceivedInviteWindowMeta;
import net.wg.gui.prebattle.squads.SquadAbstractFactory;
import net.wg.gui.prebattle.squads.SquadChatSectionBase;
import net.wg.gui.prebattle.squads.SquadPromoWindow;
import net.wg.gui.prebattle.squads.SquadTeamSectionBase;
import net.wg.gui.prebattle.squads.SquadView;
import net.wg.gui.prebattle.squads.SquadWindow;
import net.wg.gui.prebattle.squads.ev.SquadViewEvent;
import net.wg.gui.prebattle.squads.fallout.FalloutSlotHelper;
import net.wg.gui.prebattle.squads.fallout.FalloutSlotRenderer;
import net.wg.gui.prebattle.squads.fallout.FalloutTeamSection;
import net.wg.gui.prebattle.squads.fallout.vo.FalloutRallySlotVO;
import net.wg.gui.prebattle.squads.fallout.vo.FalloutRallyVO;
import net.wg.gui.prebattle.squads.interfaces.ISquadAbstractFactory;
import net.wg.gui.prebattle.squads.simple.SimpleSquadChatSection;
import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotHelper;
import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotRenderer;
import net.wg.gui.prebattle.squads.simple.SimpleSquadTeamSection;
import net.wg.gui.prebattle.squads.simple.SquadViewHeaderVO;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallyVO;
import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadTeamSectionVO;
import net.wg.gui.rally.AbstractRallyView;
import net.wg.gui.rally.AbstractRallyWindow;
import net.wg.gui.rally.BaseRallyMainWindow;
import net.wg.gui.rally.BaseRallyView;
import net.wg.gui.rally.RallyMainWindowWithSearch;
import net.wg.gui.rally.constants.PlayerStatus;
import net.wg.gui.rally.controls.BaseRallySlotHelper;
import net.wg.gui.rally.controls.CandidatesScrollingList;
import net.wg.gui.rally.controls.ManualSearchScrollingList;
import net.wg.gui.rally.controls.RallyInvalidationType;
import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
import net.wg.gui.rally.controls.RallySlotRenderer;
import net.wg.gui.rally.controls.SlotDropIndicator;
import net.wg.gui.rally.controls.SlotRendererHelper;
import net.wg.gui.rally.controls.VoiceRallySlotRenderer;
import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
import net.wg.gui.rally.controls.interfaces.IRallySlotWithRating;
import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
import net.wg.gui.rally.data.ManualSearchDataProvider;
import net.wg.gui.rally.events.RallyViewsEvent;
import net.wg.gui.rally.helpers.RallyDragDropDelegate;
import net.wg.gui.rally.helpers.RallyDragDropListDelegateController;
import net.wg.gui.rally.interfaces.IBaseChatSection;
import net.wg.gui.rally.interfaces.IBaseTeamSection;
import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
import net.wg.gui.rally.interfaces.IManualSearchRenderer;
import net.wg.gui.rally.interfaces.IManualSearchScrollingList;
import net.wg.gui.rally.interfaces.IRallyListItemVO;
import net.wg.gui.rally.interfaces.IRallyNoSortieScreen;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.gui.rally.interfaces.IRallyVO;
import net.wg.gui.rally.interfaces.ITeamSectionWithDropIndicators;
import net.wg.gui.rally.views.intro.BaseRallyIntroView;
import net.wg.gui.rally.views.list.AbtractRallyDetailsSection;
import net.wg.gui.rally.views.list.BaseRallyDetailsSection;
import net.wg.gui.rally.views.list.BaseRallyListView;
import net.wg.gui.rally.views.list.RallyNoSortieScreen;
import net.wg.gui.rally.views.list.SimpleRallyDetailsSection;
import net.wg.gui.rally.views.room.BaseChatSection;
import net.wg.gui.rally.views.room.BaseRallyRoomView;
import net.wg.gui.rally.views.room.BaseRallyRoomViewWithOrdersPanel;
import net.wg.gui.rally.views.room.BaseRallyRoomViewWithWaiting;
import net.wg.gui.rally.views.room.BaseTeamSection;
import net.wg.gui.rally.views.room.BaseWaitListSection;
import net.wg.gui.rally.views.room.ChatSectionWithDescription;
import net.wg.gui.rally.views.room.TeamSectionWithDropIndicators;
import net.wg.gui.rally.vo.ActionButtonVO;
import net.wg.gui.rally.vo.IntroVehicleVO;
import net.wg.gui.rally.vo.RallyCandidateVO;
import net.wg.gui.rally.vo.RallyShortVO;
import net.wg.gui.rally.vo.RallySlotVO;
import net.wg.gui.rally.vo.RallyVO;
import net.wg.gui.rally.vo.SettingRosterVO;
import net.wg.gui.rally.vo.VehicleAlertVO;
import net.wg.gui.tutorial.constants.HintItemType;
import net.wg.gui.tutorial.constants.PlayerXPLevel;
import net.wg.gui.tutorial.controls.BattleBonusItem;
import net.wg.gui.tutorial.controls.BattleProgress;
import net.wg.gui.tutorial.controls.ChapterProgressItemRenderer;
import net.wg.gui.tutorial.controls.FinalStatisticProgress;
import net.wg.gui.tutorial.controls.HintBaseItemRenderer;
import net.wg.gui.tutorial.controls.HintList;
import net.wg.gui.tutorial.controls.HintTextItemRenderer;
import net.wg.gui.tutorial.controls.HintVideoItemRenderer;
import net.wg.gui.tutorial.controls.ProgressItem;
import net.wg.gui.tutorial.controls.ProgressSeparator;
import net.wg.gui.tutorial.meta.ITutorialBattleNoResultsMeta;
import net.wg.gui.tutorial.meta.ITutorialBattleStatisticMeta;
import net.wg.gui.tutorial.meta.ITutorialConfirmRefuseDialogMeta;
import net.wg.gui.tutorial.meta.impl.TutorialBattleNoResultsMeta;
import net.wg.gui.tutorial.meta.impl.TutorialBattleStatisticMeta;
import net.wg.gui.tutorial.meta.impl.TutorialConfirmRefuseDialogMeta;
import net.wg.gui.tutorial.windows.TutorialBattleNoResultsWindow;
import net.wg.gui.tutorial.windows.TutorialBattleStatisticWindow;
import net.wg.gui.tutorial.windows.TutorialConfirmRefuseDialog;
import net.wg.gui.tutorial.windows.TutorialGreetingDialog;
import net.wg.gui.tutorial.windows.TutorialQueueDialog;
import net.wg.gui.utils.ImageSubstitution;
import net.wg.gui.utils.VO.PriceVO;
import net.wg.gui.utils.VO.UnitSlotProperties;
import net.wg.infrastructure.base.AbstractConfirmItemDialog;
import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
import net.wg.infrastructure.base.meta.IAbstractRallyWindowMeta;
import net.wg.infrastructure.base.meta.IAcademyViewMeta;
import net.wg.infrastructure.base.meta.IAccountPopoverMeta;
import net.wg.infrastructure.base.meta.IAmmunitionPanelMeta;
import net.wg.infrastructure.base.meta.IAwardWindowMeta;
import net.wg.infrastructure.base.meta.IBarracksMeta;
import net.wg.infrastructure.base.meta.IBaseExchangeWindowMeta;
import net.wg.infrastructure.base.meta.IBasePrebattleListViewMeta;
import net.wg.infrastructure.base.meta.IBasePrebattleRoomViewMeta;
import net.wg.infrastructure.base.meta.IBaseRallyIntroViewMeta;
import net.wg.infrastructure.base.meta.IBaseRallyListViewMeta;
import net.wg.infrastructure.base.meta.IBaseRallyMainWindowMeta;
import net.wg.infrastructure.base.meta.IBaseRallyRoomViewMeta;
import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
import net.wg.infrastructure.base.meta.IBattleQueueMeta;
import net.wg.infrastructure.base.meta.IBattleResultsMeta;
import net.wg.infrastructure.base.meta.IBattleTypeSelectPopoverMeta;
import net.wg.infrastructure.base.meta.IBoostersWindowMeta;
import net.wg.infrastructure.base.meta.IBrowserMeta;
import net.wg.infrastructure.base.meta.IBrowserWindowMeta;
import net.wg.infrastructure.base.meta.IButtonWithCounterMeta;
import net.wg.infrastructure.base.meta.ICalendarMeta;
import net.wg.infrastructure.base.meta.IChannelCarouselMeta;
import net.wg.infrastructure.base.meta.ICheckBoxDialogMeta;
import net.wg.infrastructure.base.meta.IChristmasChestsViewMeta;
import net.wg.infrastructure.base.meta.IChristmasMainViewMeta;
import net.wg.infrastructure.base.meta.IClanInvitesViewMeta;
import net.wg.infrastructure.base.meta.IClanInvitesViewWithTableMeta;
import net.wg.infrastructure.base.meta.IClanInvitesWindowAbstractTabViewMeta;
import net.wg.infrastructure.base.meta.IClanInvitesWindowMeta;
import net.wg.infrastructure.base.meta.IClanPersonalInvitesViewMeta;
import net.wg.infrastructure.base.meta.IClanPersonalInvitesWindowMeta;
import net.wg.infrastructure.base.meta.IClanProfileBaseViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileFortificationInfoViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileFortificationPromoViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileFortificationViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileGlobalMapInfoViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileGlobalMapPromoViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileMainWindowMeta;
import net.wg.infrastructure.base.meta.IClanProfilePersonnelViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileSummaryViewMeta;
import net.wg.infrastructure.base.meta.IClanProfileTableStatisticsViewMeta;
import net.wg.infrastructure.base.meta.IClanRequestsViewMeta;
import net.wg.infrastructure.base.meta.IClanSearchInfoMeta;
import net.wg.infrastructure.base.meta.IClanSearchWindowMeta;
import net.wg.infrastructure.base.meta.ICompanyListMeta;
import net.wg.infrastructure.base.meta.ICompanyRoomMeta;
import net.wg.infrastructure.base.meta.IConfirmDialogMeta;
import net.wg.infrastructure.base.meta.IConfirmExchangeDialogMeta;
import net.wg.infrastructure.base.meta.IConfirmItemWindowMeta;
import net.wg.infrastructure.base.meta.IContactsTreeComponentMeta;
import net.wg.infrastructure.base.meta.ICrewMeta;
import net.wg.infrastructure.base.meta.ICrewOperationsPopOverMeta;
import net.wg.infrastructure.base.meta.ICustomizationBuyWindowMeta;
import net.wg.infrastructure.base.meta.ICustomizationConfigurationWindowMeta;
import net.wg.infrastructure.base.meta.ICustomizationFiltersPopoverMeta;
import net.wg.infrastructure.base.meta.ICustomizationMainViewMeta;
import net.wg.infrastructure.base.meta.ICyberSportIntroMeta;
import net.wg.infrastructure.base.meta.ICyberSportMainWindowMeta;
import net.wg.infrastructure.base.meta.ICyberSportRespawnFormMeta;
import net.wg.infrastructure.base.meta.ICyberSportRespawnViewMeta;
import net.wg.infrastructure.base.meta.ICyberSportUnitMeta;
import net.wg.infrastructure.base.meta.ICyberSportUnitsListMeta;
import net.wg.infrastructure.base.meta.IDemonstratorWindowMeta;
import net.wg.infrastructure.base.meta.IEULAMeta;
import net.wg.infrastructure.base.meta.IEliteWindowMeta;
import net.wg.infrastructure.base.meta.IExchangeFreeToTankmanXpWindowMeta;
import net.wg.infrastructure.base.meta.IExchangeWindowMeta;
import net.wg.infrastructure.base.meta.IExchangeXpWindowMeta;
import net.wg.infrastructure.base.meta.IFalloutBattleSelectorWindowMeta;
import net.wg.infrastructure.base.meta.IFalloutTankCarouselMeta;
import net.wg.infrastructure.base.meta.IFittingSelectPopoverMeta;
import net.wg.infrastructure.base.meta.IFortBattleDirectionPopoverMeta;
import net.wg.infrastructure.base.meta.IFortBattleResultsWindowMeta;
import net.wg.infrastructure.base.meta.IFortBattleRoomWindowMeta;
import net.wg.infrastructure.base.meta.IFortBuildingCardPopoverMeta;
import net.wg.infrastructure.base.meta.IFortBuildingComponentMeta;
import net.wg.infrastructure.base.meta.IFortBuildingProcessWindowMeta;
import net.wg.infrastructure.base.meta.IFortCalendarWindowMeta;
import net.wg.infrastructure.base.meta.IFortChoiceDivisionWindowMeta;
import net.wg.infrastructure.base.meta.IFortClanBattleListMeta;
import net.wg.infrastructure.base.meta.IFortClanBattleRoomMeta;
import net.wg.infrastructure.base.meta.IFortClanListWindowMeta;
import net.wg.infrastructure.base.meta.IFortClanStatisticsWindowMeta;
import net.wg.infrastructure.base.meta.IFortCombatReservesIntroMeta;
import net.wg.infrastructure.base.meta.IFortCreateDirectionWindowMeta;
import net.wg.infrastructure.base.meta.IFortCreationCongratulationsWindowMeta;
import net.wg.infrastructure.base.meta.IFortDatePickerPopoverMeta;
import net.wg.infrastructure.base.meta.IFortDeclarationOfWarWindowMeta;
import net.wg.infrastructure.base.meta.IFortDemountBuildingWindowMeta;
import net.wg.infrastructure.base.meta.IFortDisableDefencePeriodWindowMeta;
import net.wg.infrastructure.base.meta.IFortDisconnectViewMeta;
import net.wg.infrastructure.base.meta.IFortFixedPlayersWindowMeta;
import net.wg.infrastructure.base.meta.IFortIntelFilterMeta;
import net.wg.infrastructure.base.meta.IFortIntelligenceClanDescriptionMeta;
import net.wg.infrastructure.base.meta.IFortIntelligenceClanFilterPopoverMeta;
import net.wg.infrastructure.base.meta.IFortIntelligenceNotAvailableWindowMeta;
import net.wg.infrastructure.base.meta.IFortIntelligenceWindowMeta;
import net.wg.infrastructure.base.meta.IFortIntroMeta;
import net.wg.infrastructure.base.meta.IFortListMeta;
import net.wg.infrastructure.base.meta.IFortMainViewMeta;
import net.wg.infrastructure.base.meta.IFortModernizationWindowMeta;
import net.wg.infrastructure.base.meta.IFortNotCommanderFirstEnterWindowMeta;
import net.wg.infrastructure.base.meta.IFortOrderConfirmationWindowMeta;
import net.wg.infrastructure.base.meta.IFortOrderInfoWindowMeta;
import net.wg.infrastructure.base.meta.IFortOrderPopoverMeta;
import net.wg.infrastructure.base.meta.IFortOrderSelectPopoverMeta;
import net.wg.infrastructure.base.meta.IFortPeriodDefenceWindowMeta;
import net.wg.infrastructure.base.meta.IFortRoomMeta;
import net.wg.infrastructure.base.meta.IFortRosterIntroWindowMeta;
import net.wg.infrastructure.base.meta.IFortSettingsDayoffPopoverMeta;
import net.wg.infrastructure.base.meta.IFortSettingsDefenceHourPopoverMeta;
import net.wg.infrastructure.base.meta.IFortSettingsPeripheryPopoverMeta;
import net.wg.infrastructure.base.meta.IFortSettingsVacationPopoverMeta;
import net.wg.infrastructure.base.meta.IFortSettingsWindowMeta;
import net.wg.infrastructure.base.meta.IFortTransportConfirmationWindowMeta;
import net.wg.infrastructure.base.meta.IFortWelcomeInfoViewMeta;
import net.wg.infrastructure.base.meta.IFortWelcomeViewMeta;
import net.wg.infrastructure.base.meta.IFortificationsViewMeta;
import net.wg.infrastructure.base.meta.IFreeXPInfoWindowMeta;
import net.wg.infrastructure.base.meta.IGetPremiumPopoverMeta;
import net.wg.infrastructure.base.meta.IGoldFishWindowMeta;
import net.wg.infrastructure.base.meta.IHangarHeaderMeta;
import net.wg.infrastructure.base.meta.IHangarMeta;
import net.wg.infrastructure.base.meta.IIconDialogMeta;
import net.wg.infrastructure.base.meta.IIconPriceDialogMeta;
import net.wg.infrastructure.base.meta.IInputCheckerMeta;
import net.wg.infrastructure.base.meta.IIntroPageMeta;
import net.wg.infrastructure.base.meta.IInventoryMeta;
import net.wg.infrastructure.base.meta.ILegalInfoWindowMeta;
import net.wg.infrastructure.base.meta.ILobbyHeaderMeta;
import net.wg.infrastructure.base.meta.ILobbyMenuMeta;
import net.wg.infrastructure.base.meta.ILobbyPageMeta;
import net.wg.infrastructure.base.meta.ILoginPageMeta;
import net.wg.infrastructure.base.meta.ILoginQueueWindowMeta;
import net.wg.infrastructure.base.meta.IMessengerBarMeta;
import net.wg.infrastructure.base.meta.IMiniClientComponentMeta;
import net.wg.infrastructure.base.meta.IMissionAwardWindowMeta;
import net.wg.infrastructure.base.meta.IModuleInfoMeta;
import net.wg.infrastructure.base.meta.IModulesPanelMeta;
import net.wg.infrastructure.base.meta.INotificationListButtonMeta;
import net.wg.infrastructure.base.meta.INotificationPopUpViewerMeta;
import net.wg.infrastructure.base.meta.INotificationsListMeta;
import net.wg.infrastructure.base.meta.IPersonalCaseMeta;
import net.wg.infrastructure.base.meta.IPremiumWindowMeta;
import net.wg.infrastructure.base.meta.IProfileAchievementSectionMeta;
import net.wg.infrastructure.base.meta.IProfileAwardsMeta;
import net.wg.infrastructure.base.meta.IProfileFormationsPageMeta;
import net.wg.infrastructure.base.meta.IProfileMeta;
import net.wg.infrastructure.base.meta.IProfileSectionMeta;
import net.wg.infrastructure.base.meta.IProfileStatisticsMeta;
import net.wg.infrastructure.base.meta.IProfileSummaryMeta;
import net.wg.infrastructure.base.meta.IProfileSummaryWindowMeta;
import net.wg.infrastructure.base.meta.IProfileTabNavigatorMeta;
import net.wg.infrastructure.base.meta.IProfileTechniqueMeta;
import net.wg.infrastructure.base.meta.IProfileTechniquePageMeta;
import net.wg.infrastructure.base.meta.IProfileWindowMeta;
import net.wg.infrastructure.base.meta.IPromoPremiumIgrWindowMeta;
import net.wg.infrastructure.base.meta.IPunishmentDialogMeta;
import net.wg.infrastructure.base.meta.IPvESandboxQueueWindowMeta;
import net.wg.infrastructure.base.meta.IQuestRecruitWindowMeta;
import net.wg.infrastructure.base.meta.IQuestsContentTabsMeta;
import net.wg.infrastructure.base.meta.IQuestsControlMeta;
import net.wg.infrastructure.base.meta.IQuestsCurrentTabMeta;
import net.wg.infrastructure.base.meta.IQuestsPersonalWelcomeViewMeta;
import net.wg.infrastructure.base.meta.IQuestsSeasonAwardsWindowMeta;
import net.wg.infrastructure.base.meta.IQuestsSeasonsViewMeta;
import net.wg.infrastructure.base.meta.IQuestsTabMeta;
import net.wg.infrastructure.base.meta.IQuestsTileChainsViewMeta;
import net.wg.infrastructure.base.meta.IQuestsWindowMeta;
import net.wg.infrastructure.base.meta.IRallyMainWindowWithSearchMeta;
import net.wg.infrastructure.base.meta.IRecruitParametersMeta;
import net.wg.infrastructure.base.meta.IRecruitWindowMeta;
import net.wg.infrastructure.base.meta.IReferralManagementWindowMeta;
import net.wg.infrastructure.base.meta.IReferralReferralsIntroWindowMeta;
import net.wg.infrastructure.base.meta.IReferralReferrerIntroWindowMeta;
import net.wg.infrastructure.base.meta.IResearchMeta;
import net.wg.infrastructure.base.meta.IResearchPanelMeta;
import net.wg.infrastructure.base.meta.IResearchViewMeta;
import net.wg.infrastructure.base.meta.IRetrainCrewWindowMeta;
import net.wg.infrastructure.base.meta.IRoleChangeMeta;
import net.wg.infrastructure.base.meta.IRosterSlotSettingsWindowMeta;
import net.wg.infrastructure.base.meta.IRssNewsFeedMeta;
import net.wg.infrastructure.base.meta.ISendInvitesWindowMeta;
import net.wg.infrastructure.base.meta.IShopMeta;
import net.wg.infrastructure.base.meta.ISimpleWindowMeta;
import net.wg.infrastructure.base.meta.ISkillDropMeta;
import net.wg.infrastructure.base.meta.ISlotsPanelMeta;
import net.wg.infrastructure.base.meta.ISquadPromoWindowMeta;
import net.wg.infrastructure.base.meta.ISquadViewMeta;
import net.wg.infrastructure.base.meta.ISquadWindowMeta;
import net.wg.infrastructure.base.meta.IStaticFormationInvitesAndRequestsMeta;
import net.wg.infrastructure.base.meta.IStaticFormationLadderViewMeta;
import net.wg.infrastructure.base.meta.IStaticFormationProfileWindowMeta;
import net.wg.infrastructure.base.meta.IStaticFormationStaffViewMeta;
import net.wg.infrastructure.base.meta.IStaticFormationStatsViewMeta;
import net.wg.infrastructure.base.meta.IStaticFormationSummaryViewMeta;
import net.wg.infrastructure.base.meta.IStaticFormationUnitMeta;
import net.wg.infrastructure.base.meta.IStoreComponentMeta;
import net.wg.infrastructure.base.meta.IStoreTableMeta;
import net.wg.infrastructure.base.meta.IStoreViewMeta;
import net.wg.infrastructure.base.meta.ISwitchModePanelMeta;
import net.wg.infrastructure.base.meta.ISwitchPeripheryWindowMeta;
import net.wg.infrastructure.base.meta.ISystemMessageDialogMeta;
import net.wg.infrastructure.base.meta.ITankCarouselFilterPopoverMeta;
import net.wg.infrastructure.base.meta.ITankCarouselMeta;
import net.wg.infrastructure.base.meta.ITankmanOperationDialogMeta;
import net.wg.infrastructure.base.meta.ITechTreeMeta;
import net.wg.infrastructure.base.meta.ITechnicalMaintenanceMeta;
import net.wg.infrastructure.base.meta.ITmenXpPanelMeta;
import net.wg.infrastructure.base.meta.ITrainingFormMeta;
import net.wg.infrastructure.base.meta.ITrainingRoomMeta;
import net.wg.infrastructure.base.meta.ITrainingWindowMeta;
import net.wg.infrastructure.base.meta.ITutorialHangarQuestDetailsMeta;
import net.wg.infrastructure.base.meta.IVehicleBuyWindowMeta;
import net.wg.infrastructure.base.meta.IVehicleCompareAddVehiclePopoverMeta;
import net.wg.infrastructure.base.meta.IVehicleCompareCartPopoverMeta;
import net.wg.infrastructure.base.meta.IVehicleCompareViewMeta;
import net.wg.infrastructure.base.meta.IVehicleInfoMeta;
import net.wg.infrastructure.base.meta.IVehicleModulesWindowMeta;
import net.wg.infrastructure.base.meta.IVehicleParametersMeta;
import net.wg.infrastructure.base.meta.IVehiclePreviewMeta;
import net.wg.infrastructure.base.meta.IVehicleSelectorPopupMeta;
import net.wg.infrastructure.base.meta.IVehicleSellDialogMeta;
import net.wg.infrastructure.base.meta.IWGNCDialogMeta;
import net.wg.infrastructure.base.meta.IWGNCPollWindowMeta;
import net.wg.infrastructure.events.DragEvent;
import net.wg.infrastructure.events.DropEvent;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.events.FocusedViewEvent;
import net.wg.infrastructure.events.GameEvent;
import net.wg.infrastructure.helpers.DragDelegate;
import net.wg.infrastructure.helpers.DragDelegateController;
import net.wg.infrastructure.helpers.DropListDelegate;
import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
import net.wg.infrastructure.helpers.LoaderEx;
import net.wg.infrastructure.helpers.interfaces.IDragDelegate;
import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
import net.wg.infrastructure.interfaces.ISortable;
import net.wg.infrastructure.tutorial.builders.TutorialBuilder;
import net.wg.infrastructure.tutorial.builders.TutorialCustomHintBuilder;
import net.wg.infrastructure.tutorial.builders.TutorialHintBuilder;
import net.wg.infrastructure.tutorial.builders.TutorialOverlayBuilder;
import net.wg.infrastructure.tutorial.builders.TutorialResearchOverlayBldr;
import net.wg.infrastructure.tutorial.builders.TutorialTechTreeOverlayBldr;
import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialHelpBtnController;
import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialResearchHelpBtnCtrllr;
import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialTechTreeHelpBtnCtrllr;
import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialViewHelpBtnCtrllr;
import net.wg.infrastructure.tutorial.helpBtnControllers.TutorialWindowHelpBtnCtrllr;
import net.wg.infrastructure.tutorial.helpBtnControllers.interfaces.ITutorialHelpBtnController;

public class ClassManagerMeta {

    public static const NET_WG_DATA_CONTAINERCONSTANTS:Class = ContainerConstants;

    public static const NET_WG_DATA_FILTERDAAPIDATAPROVIDER:Class = FilterDAAPIDataProvider;

    public static const NET_WG_DATA_INSPECTABLEDATAPROVIDER:Class = InspectableDataProvider;

    public static const NET_WG_DATA_SORTABLEVODAAPIDATAPROVIDER:Class = SortableVoDAAPIDataProvider;

    public static const NET_WG_DATA_VO_ANIMATIONOBJECT:Class = AnimationObject;

    public static const NET_WG_DATA_VO_AWARDSITEMVO:Class = AwardsItemVO;

    public static const NET_WG_DATA_VO_BATTLERESULTSQUESTVO:Class = BattleResultsQuestVO;

    public static const NET_WG_DATA_VO_BUTTONPROPERTIESVO:Class = ButtonPropertiesVO;

    public static const NET_WG_DATA_VO_CONFIRMDIALOGVO:Class = ConfirmDialogVO;

    public static const NET_WG_DATA_VO_CONFIRMEXCHANGEBLOCKVO:Class = ConfirmExchangeBlockVO;

    public static const NET_WG_DATA_VO_CONFIRMEXCHANGEDIALOGVO:Class = ConfirmExchangeDialogVO;

    public static const NET_WG_DATA_VO_DIALOGSETTINGSVO:Class = DialogSettingsVO;

    public static const NET_WG_DATA_VO_EXTENDEDUSERVO:Class = ExtendedUserVO;

    public static const NET_WG_DATA_VO_ILDITINFO:Class = ILditInfo;

    public static const NET_WG_DATA_VO_POINTVO:Class = PointVO;

    public static const NET_WG_DATA_VO_PROGRESSELEMENTVO:Class = ProgressElementVO;

    public static const NET_WG_DATA_VO_REFSYSREFERRALSINTROVO:Class = RefSysReferralsIntroVO;

    public static const NET_WG_DATA_VO_REFERRALREFERRERINTROVO:Class = ReferralReferrerIntroVO;

    public static const NET_WG_DATA_VO_REFERRALTEXTBLOCKVO:Class = ReferralTextBlockVO;

    public static const NET_WG_DATA_VO_SELLDIALOGELEMENT:Class = SellDialogElement;

    public static const NET_WG_DATA_VO_SELLDIALOGITEM:Class = SellDialogItem;

    public static const NET_WG_DATA_VO_SHOPSUBFILTERDATA:Class = ShopSubFilterData;

    public static const NET_WG_DATA_VO_SHOPVEHICLEFILTERELEMENTDATA:Class = ShopVehicleFilterElementData;

    public static const NET_WG_DATA_VO_STORETABLEDATA:Class = StoreTableData;

    public static const NET_WG_DATA_VO_STORETABLEVO:Class = StoreTableVO;

    public static const NET_WG_DATA_VO_TANKMANACHIEVEMENTVO:Class = TankmanAchievementVO;

    public static const NET_WG_DATA_VO_TANKMANCARDVO:Class = TankmanCardVO;

    public static const NET_WG_DATA_VO_TRAININGFORMRENDERERVO:Class = TrainingFormRendererVO;

    public static const NET_WG_DATA_VO_TRAININGFORMVO:Class = TrainingFormVO;

    public static const NET_WG_DATA_VO_TRAININGROOMINFOVO:Class = TrainingRoomInfoVO;

    public static const NET_WG_DATA_VO_TRAININGROOMLISTVO:Class = TrainingRoomListVO;

    public static const NET_WG_DATA_VO_TRAININGROOMRENDERERVO:Class = TrainingRoomRendererVO;

    public static const NET_WG_DATA_VO_TRAININGROOMTEAMVO:Class = TrainingRoomTeamVO;

    public static const NET_WG_DATA_VO_TRAININGWINDOWVO:Class = TrainingWindowVO;

    public static const NET_WG_DATA_VO_WALLETSTATUSVO:Class = WalletStatusVO;

    public static const NET_WG_DATA_VO_GENERATED_SHOPNATIONFILTERDATA:Class = ShopNationFilterData;

    public static const NET_WG_DATA_VODAAPIDATAPROVIDER:Class = VoDAAPIDataProvider;

    public static const NET_WG_DATA_COMPONENTS_STOREMENUVIEWDATA:Class = StoreMenuViewData;

    public static const NET_WG_DATA_COMPONENTS_USERCONTEXTITEM:Class = UserContextItem;

    public static const NET_WG_DATA_COMPONENTS_VEHICLECONTEXTMENUGENERATOR:Class = VehicleContextMenuGenerator;

    public static const NET_WG_DATA_CONSTANTS_ARENABONUSTYPES:Class = ArenaBonusTypes;

    public static const NET_WG_DATA_CONSTANTS_CURRENCIES:Class = Currencies;

    public static const NET_WG_DATA_CONSTANTS_DIALOGS:Class = Dialogs;

    public static const NET_WG_DATA_CONSTANTS_DIRECTIONS:Class = Directions;

    public static const NET_WG_DATA_CONSTANTS_GUNTYPES:Class = GunTypes;

    public static const NET_WG_DATA_CONSTANTS_ITEMTYPES:Class = ItemTypes;

    public static const NET_WG_DATA_CONSTANTS_LOBBYSHARED:Class = LobbyShared;

    public static const NET_WG_DATA_CONSTANTS_PROGRESSINDICATORSTATES:Class = ProgressIndicatorStates;

    public static const NET_WG_DATA_CONSTANTS_QUESTSSTATES:Class = QuestsStates;

    public static const NET_WG_DATA_CONSTANTS_ROLESSTATE:Class = RolesState;

    public static const NET_WG_DATA_CONSTANTS_VALOBJECT:Class = ValObject;

    public static const NET_WG_DATA_CONSTANTS_VEHICLESTATE:Class = VehicleState;

    public static const NET_WG_DATA_CONSTANTS_VEHICLETYPES:Class = VehicleTypes;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_ACHIEVEMENTS_ALIASES:Class = ACHIEVEMENTS_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_ACTION_PRICE_CONSTANTS:Class = ACTION_PRICE_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_AWARDWINDOW_CONSTANTS:Class = AWARDWINDOW_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BARRACKS_CONSTANTS:Class = BARRACKS_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_RESULT_TYPES:Class = BATTLE_RESULT_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BATTLE_SELECTOR_TYPES:Class = BATTLE_SELECTOR_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BOOSTER_CONSTANTS:Class = BOOSTER_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_BROWSER_CONSTANTS:Class = BROWSER_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CHRISTMAS_ALIASES:Class = CHRISTMAS_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CLANS_ALIASES:Class = CLANS_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_COMPANY_ALIASES:Class = COMPANY_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CONFIRM_DIALOG_ALIASES:Class = CONFIRM_DIALOG_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CONFIRM_EXCHANGE_DIALOG_TYPES:Class = CONFIRM_EXCHANGE_DIALOG_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CONTACTS_ALIASES:Class = CONTACTS_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CONTEXT_MENU_HANDLER_TYPE:Class = CONTEXT_MENU_HANDLER_TYPE;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CURRENCIES_CONSTANTS:Class = CURRENCIES_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CUSTOMIZATION_BONUS_ANIMATION_TYPES:Class = CUSTOMIZATION_BONUS_ANIMATION_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CUSTOMIZATION_ITEM_TYPE:Class = CUSTOMIZATION_ITEM_TYPE;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CYBER_SPORT_ALIASES:Class = CYBER_SPORT_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_CYBER_SPORT_HELP_IDS:Class = CYBER_SPORT_HELP_IDS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_FALLOUT_ALIASES:Class = FALLOUT_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_FITTING_TYPES:Class = FITTING_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_FORMATION_MEMBER_TYPE:Class = FORMATION_MEMBER_TYPE;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_FORTIFICATION_ALIASES:Class = FORTIFICATION_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_GE_ALIASES:Class = GE_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_HANGAR_ALIASES:Class = HANGAR_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_LADDER_STATES:Class = LADDER_STATES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES:Class = MESSENGER_CHANNEL_CAROUSEL_ITEM_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_NODE_STATE_FLAGS:Class = NODE_STATE_FLAGS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_ORDER_TYPES:Class = ORDER_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_PREBATTLE_ALIASES:Class = PREBATTLE_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_PROFILE_DROPDOWN_KEYS:Class = PROFILE_DROPDOWN_KEYS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_QUESTS_ALIASES:Class = QUESTS_ALIASES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_QUEST_TASKS_STATES:Class = QUEST_TASKS_STATES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_QUEST_TASK_FILTERS_TYPES:Class = QUEST_TASK_FILTERS_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_SKILLS_CONSTANTS:Class = SKILLS_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_SQUADTYPES:Class = SQUADTYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_STORE_CONSTANTS:Class = STORE_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_STORE_TYPES:Class = STORE_TYPES;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_TEXT_ALIGN:Class = TEXT_ALIGN;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_VEHICLE_COMPARE_CONSTANTS:Class = VEHICLE_COMPARE_CONSTANTS;

    public static const NET_WG_DATA_CONSTANTS_GENERATED_VEHPREVIEW_CONSTANTS:Class = VEHPREVIEW_CONSTANTS;

    public static const NET_WG_DATA_MANAGERS_IMPL_DIALOGDISPATCHER:Class = DialogDispatcher;

    public static const NET_WG_DATA_MANAGERS_IMPL_NOTIFYPROPERTIES:Class = NotifyProperties;

    public static const NET_WG_DATA_UTILDATA_ITEMPRICE:Class = ItemPrice;

    public static const NET_WG_DATA_UTILDATA_TANKMANROLELEVEL:Class = TankmanRoleLevel;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_ACCORDION:Class = Accordion;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_ADVANCEDLINEDESCRICONTEXT:Class = AdvancedLineDescrIconText;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_AMMUNITIONBUTTON:Class = AmmunitionButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON:Class = BackButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_BLINKINGBUTTON:Class = BlinkingButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_BUTTONTOGGLEINDICATOR:Class = ButtonToggleIndicator;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_CALENDAR:Class = Calendar;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_CLANEMBLEM:Class = ClanEmblem;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_COMPLEXPROGRESSINDICATOR:Class = ComplexProgressIndicator;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_COOLDOWNANIMATIONCONTROLLER:Class = CooldownAnimationController;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_COOLDOWNSLOT:Class = CooldownSlot;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_COUNTEREX:Class = CounterEx;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_DASHLINE:Class = DashLine;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_DASHLINETEXTITEM:Class = DashLineTextItem;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_DOUBLEPROGRESSBAR:Class = DoubleProgressBar;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_DUMMY:Class = Dummy;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_EXTRAMODULEICON:Class = ExtraModuleIcon;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_HELPLAYOUTCONTROL:Class = HelpLayoutControl;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INDICATIONOFSTATUS:Class = IndicationOfStatus;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERACTIVESORTINGBUTTON:Class = InteractiveSortingButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INVITEINDICATOR:Class = InviteIndicator;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_LINEDESCRICONTEXT:Class = LineDescrIconText;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_LINEICONTEXT:Class = LineIconText;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_MODULEICON:Class = ModuleIcon;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_MODULETYPESUIWITHFILL:Class = ModuleTypesUIWithFill;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_NORMALBUTTONTOGGLEWG:Class = NormalButtonToggleWG;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_PORTRAITITEMRENDERER:Class = PortraitItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_RECRUITPARAMETERSCOMPONENT:Class = RecruitParametersComponent;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCALABLEICONWRAPPER:Class = ScalableIconWrapper;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SEARCHINPUT:Class = SearchInput;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SHELLBUTTON:Class = ShellButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SHELLSSET:Class = ShellsSet;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SKILLSITEMRENDERER:Class = SkillsItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SKILLSLEVELITEMRENDERER:Class = SkillsLevelItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTABLEHEADERBUTTONBAR:Class = SortableHeaderButtonBar;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SORTINGBUTTON:Class = SortingButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_STATISTICITEM:Class = StatisticItem;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_STATUSDELTAINDICATORANIM:Class = StatusDeltaIndicatorAnim;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TANKICON:Class = net.wg.gui.components.advanced.TankIcon;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TANKMANCARD:Class = TankmanCard;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TEXTAREA:Class = TextArea;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TEXTAREASIMPLE:Class = TextAreaSimple;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TOGGLEBUTTON:Class = ToggleButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_UNDERLINEDTEXT:Class = UnderlinedText;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON_BACKBUTTONHELPER:Class = BackButtonHelper;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON_BACKBUTTONSTATES:Class = BackButtonStates;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_BACKBUTTON_BACKBUTTONTEXT:Class = BackButtonText;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_CALENDAR_DAYRENDERER:Class = DayRenderer;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_CALENDAR_WEEKDAYRENDERER:Class = WeekDayRenderer;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_CALENDAREVENT:Class = CalendarEvent;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_DUMMYEVENT:Class = DummyEvent;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_RECRUITPARAMSEVENT:Class = RecruitParamsEvent;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_TUTORIALHELPBTNEVENT:Class = TutorialHelpBtnEvent;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_EVENTS_TUTORIALHINTEVENT:Class = TutorialHintEvent;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_IBACKBUTTON:Class = IBackButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ICOMPLEXPROGRESSSTEPRENDERER:Class = IComplexProgressStepRenderer;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ICOOLDOWNSLOT:Class = ICooldownSlot;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_IDASHLINETEXTITEM:Class = IDashLineTextItem;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_IDUMMY:Class = IDummy;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ISEARCHINPUT:Class = ISearchInput;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ISTATUSDELTAINDICATORANIM:Class = IStatusDeltaIndicatorAnim;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ITUTORIALHINTANIMATION:Class = ITutorialHintAnimation;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ITUTORIALHINTARROWANIMATION:Class = ITutorialHintArrowAnimation;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_INTERFACES_ITUTORIALHINTTEXTANIMATION:Class = ITutorialHintTextAnimation;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCREENTAB_SCREENTABBUTTON:Class = ScreenTabButton;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCREENTAB_SCREENTABBUTTONBAR:Class = ScreenTabButtonBar;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_SCREENTAB_SCREENTABBUTTONBG:Class = ScreenTabButtonBg;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALCONTEXTHINT:Class = TutorialContextHint;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALCONTEXTOVERLAY:Class = TutorialContextOverlay;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINT:Class = TutorialHint;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTANIMATION:Class = TutorialHintAnimation;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTARROWANIMATION:Class = TutorialHintArrowAnimation;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTTEXT:Class = TutorialHintText;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTTEXTANIMATION:Class = TutorialHintTextAnimation;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_TUTORIAL_TUTORIALHINTTEXTANIMATIONMC:Class = TutorialHintTextAnimationMc;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_COMPLEXPROGRESSINDICATORVO:Class = ComplexProgressIndicatorVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_DUMMYVO:Class = DummyVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_NORMALSORTINGTABLEHEADERVO:Class = NormalSortingTableHeaderVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_RECRUITPARAMETERSVO:Class = RecruitParametersVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_STATISTICITEMVO:Class = StatisticItemVo;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_STATUSDELTAINDICATORVO:Class = StatusDeltaIndicatorVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TRUNCATEHTMLTEXTVO:Class = TruncateHtmlTextVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALBTNCONTROLLERVO:Class = TutorialBtnControllerVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALCONTEXTHINTVO:Class = TutorialContextHintVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALCONTEXTOVERLAYVO:Class = TutorialContextOverlayVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALCONTEXTVO:Class = TutorialContextVO;

    public static const NET_WG_GUI_COMPONENTS_ADVANCED_VO_TUTORIALHINTVO:Class = TutorialHintVO;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_ACHIEVEMENTCAROUSEL:Class = AchievementCarousel;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_CAROUSELBASE:Class = CarouselBase;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_HORIZONTALSCROLLER:Class = HorizontalScroller;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_HORIZONTALSCROLLERCURSORMANAGER:Class = HorizontalScrollerCursorManager;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_HORIZONTALSCROLLERVIEWPORT:Class = HorizontalScrollerViewPort;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_PORTRAITSCAROUSEL:Class = PortraitsCarousel;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_SCROLLCAROUSEL:Class = ScrollCarousel;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_SKILLSCAROUSEL:Class = SkillsCarousel;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_TOOLTIPDECORATOR:Class = TooltipDecorator;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_INTERFACES_ICAROUSELITEMRENDERER:Class = ICarouselItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_CAROUSELS_INTERFACES_IHORIZONTALSCROLLERCURSORMANAGER:Class = IHorizontalScrollerCursorManager;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONFIRMCOMPONENT:Class = ConfirmComponent;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONFIRMITEMCOMPONENT:Class = ConfirmItemComponent;

    public static const NET_WG_GUI_COMPONENTS_COMMON_INPUTCHECKER:Class = InputChecker;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_EQUALGAPSHORIZONTALLAYOUT:Class = EqualGapsHorizontalLayout;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_EQUALWIDTHHORIZONTALLAYOUT:Class = EqualWidthHorizontalLayout;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUP:Class = Group;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUPEX:Class = GroupEx;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_GROUPLAYOUT:Class = GroupLayout;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_HORIZONTALGROUPLAYOUT:Class = HorizontalGroupLayout;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_IGROUPEX:Class = IGroupEx;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_VERTICAL100PERCWIDTHLAYOUT:Class = Vertical100PercWidthLayout;

    public static const NET_WG_GUI_COMPONENTS_COMMON_CONTAINERS_VERTICALGROUPLAYOUT:Class = VerticalGroupLayout;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERDROPDOWN:Class = ServerDropDown;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERHELPER:Class = ServerHelper;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERINFO:Class = ServerInfo;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERSTATS:Class = ServerStats;

    public static const NET_WG_GUI_COMPONENTS_COMMON_SERVERSTATS_SERVERVO:Class = ServerVO;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_NETSTREAMSTATUSCODE:Class = NetStreamStatusCode;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_NETSTREAMSTATUSLEVEL:Class = NetStreamStatusLevel;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_PLAYERSTATUS:Class = net.wg.gui.components.common.video.PlayerStatus;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_SIMPLEVIDEOPLAYER:Class = SimpleVideoPlayer;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_VIDEOPLAYEREVENT:Class = VideoPlayerEvent;

    public static const NET_WG_GUI_COMPONENTS_COMMON_VIDEO_VIDEOPLAYERSTATUSEVENT:Class = VideoPlayerStatusEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACCORDIONSOUNDRENDERER:Class = AccordionSoundRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_ACTIONPRICE:Class = ActionPrice;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_BASEDROPLIST:Class = BaseDropList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_GLOWARROWASSET:Class = GlowArrowAsset;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_HANGARQUESTSBUTTON:Class = HangarQuestsButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_NORMALSORTINGBTNVO:Class = NormalSortingBtnVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_NORMALSORTINGBUTTON:Class = NormalSortingButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_PROGRESSBAR:Class = ProgressBar;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTBUTTON:Class = SortButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTABLETABLE:Class = SortableTable;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SORTABLETABLELIST:Class = SortableTableList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TABLERENDERER:Class = TableRenderer;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAINIGBUTTONVO:Class = TankmanTrainigButtonVO;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAININGBUTTON:Class = TankmanTrainingButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TANKMANTRAININGSMALLBUTTON:Class = TankmanTrainingSmallButton;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_TILELIST:Class = TileList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_UNITCOMMANDERSTATS:Class = UnitCommanderStats;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VERTICALLISTVIEWPORT:Class = VerticalListViewPort;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VOICE:Class = Voice;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_VOICEWAVE:Class = VoiceWave;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_WALLETRESOURCESSTATUS:Class = WalletResourcesStatus;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_WGSCROLLINGLIST:Class = WgScrollingList;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_EVENTS_VERTICALLISTVIEWPORTEVENT:Class = VerticalListViewportEvent;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLOTSPANEL_ISLOTSPANEL:Class = ISlotsPanel;

    public static const NET_WG_GUI_COMPONENTS_CONTROLS_SLOTSPANEL_IMPL_BASESLOTSPANEL:Class = BaseSlotsPanel;

    public static const NET_WG_GUI_COMPONENTS_INTERFACES_IACCORDIONITEMRENDERER:Class = IAccordionItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_INTERFACES_IHANGARQUESTSBUTTON:Class = IHangarQuestsButton;

    public static const NET_WG_GUI_COMPONENTS_INTERFACES_IREUSABLELISTITEMRENDERER:Class = IReusableListItemRenderer;

    public static const NET_WG_GUI_COMPONENTS_INTERFACES_ITOOLTIPREFSYSAWARDSBLOCK:Class = IToolTipRefSysAwardsBlock;

    public static const NET_WG_GUI_COMPONENTS_INTERFACES_ITOOLTIPREFSYSXPMULTIPLIERBLOCK:Class = IToolTipRefSysXPMultiplierBlock;

    public static const NET_WG_GUI_COMPONENTS_MINICLIENT_BATTLETYPEMINICLIENTCOMPONENT:Class = BattleTypeMiniClientComponent;

    public static const NET_WG_GUI_COMPONENTS_MINICLIENT_HANGARMINICLIENTCOMPONENT:Class = HangarMiniClientComponent;

    public static const NET_WG_GUI_COMPONENTS_MINICLIENT_LINKEDMINICLIENTCOMPONENT:Class = LinkedMiniClientComponent;

    public static const NET_WG_GUI_COMPONENTS_MINICLIENT_TECHTREEMINICLIENTCOMPONENT:Class = TechTreeMiniClientComponent;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_ACHIEVEMENTSCUSTOMBLOCKITEM:Class = AchievementsCustomBlockItem;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_EXTRAMODULEINFO:Class = ExtraModuleInfo;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRPREMVEHQUESTBLOCK:Class = IgrPremVehQuestBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRQUESTBLOCK:Class = IgrQuestBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_IGRQUESTPROGRESSBLOCK:Class = IgrQuestProgressBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_MODULEITEM:Class = ModuleItem;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_STATUS:Class = Status;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_SUITABLEVEHICLEBLOCKITEM:Class = SuitableVehicleBlockItem;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPACHIEVEMENT:Class = ToolTipAchievement;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPACTIONPRICE:Class = ToolTipActionPrice;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPBUYSKILL:Class = ToolTipBuySkill;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCLANCOMMONINFO:Class = ToolTipClanCommonInfo;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCLANINFO:Class = ToolTipClanInfo;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCOLUMNFIELDS:Class = ToolTipColumnFields;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCUSTOMIZATIONITEM:Class = ToolTipCustomizationItem;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPFORTDIVISION:Class = ToolTipFortDivision;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPFORTSORTIE:Class = ToolTipFortSortie;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPIGR:Class = ToolTipIGR;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPLADDER:Class = ToolTipLadder;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPLADDERREGULATIONS:Class = ToolTipLadderRegulations;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMAP:Class = ToolTipMap;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMAPSMALL:Class = ToolTipMapSmall;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMARKOFMASTERY:Class = ToolTipMarkOfMastery;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPMARKSONGUN:Class = ToolTipMarksOnGun;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPPRIVATEQUESTS:Class = ToolTipPrivateQuests;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPREFSYSAWARDS:Class = ToolTipRefSysAwards;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPREFSYSAWARDSBLOCK:Class = ToolTipRefSysAwardsBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPREFSYSDESCRIPTION:Class = ToolTipRefSysDescription;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPREFSYSXPMULTIPLIER:Class = ToolTipRefSysXPMultiplier;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPREFSYSXPMULTIPLIERBLOCK:Class = ToolTipRefSysXPMultiplierBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSELECTEDVEHICLE:Class = ToolTipSelectedVehicle;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSKILL:Class = ToolTipSkill;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSORTIEDIVISION:Class = ToolTipSortieDivision;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPSUITABLEVEHICLE:Class = ToolTipSuitableVehicle;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPTANKMEN:Class = ToolTipTankmen;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPUNITLEVEL:Class = ToolTipUnitLevel;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPCONTACT:Class = TooltipContact;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPENVIRONMENT:Class = TooltipEnvironment;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_TOOLTIPUNITCOMMAND:Class = TooltipUnitCommand;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_ACHIEVEMENTVO:Class = AchievementVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_COLUMNFIELDSVO:Class = ColumnFieldsVo;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_CONTACTTOOLTIPVO:Class = ContactTooltipVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_CUSTOMIZATIONITEMVO:Class = CustomizationItemVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_DIMENSION:Class = Dimension;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_DIVISIONVO:Class = DivisionVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_EQUIPMENTPARAMVO:Class = EquipmentParamVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_EXTRAMODULEINFOVO:Class = ExtraModuleInfoVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FORTCLANCOMMONINFOVO:Class = FortClanCommonInfoVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FORTCLANINFOVO:Class = FortClanInfoVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FORTDIVISIONVO:Class = FortDivisionVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_IGRVO:Class = IgrVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_LADDERVO:Class = LadderVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_MAPVO:Class = MapVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_MODULEVO:Class = ModuleVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_PERSONALCASEBLOCKITEMVO:Class = PersonalCaseBlockItemVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_PREMDAYSVO:Class = PremDaysVo;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_PRIVATEQUESTSVO:Class = PrivateQuestsVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SETTINGSCONTROLVO:Class = SettingsControlVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SORTIEDIVISIONVO:Class = SortieDivisionVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_SUITABLEVEHICLEVO:Class = SuitableVehicleVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TANKMENVO:Class = TankmenVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPACTIONPRICEVO:Class = ToolTipActionPriceVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPBUYSKILLVO:Class = ToolTipBuySkillVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPFORTSORTIEVO:Class = ToolTipFortSortieVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPLADDERREGULATIONSVO:Class = ToolTipLadderRegulationsVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPREFSYSAWARDSBLOCKVO:Class = ToolTipRefSysAwardsBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPREFSYSAWARDSVO:Class = ToolTipRefSysAwardsVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPREFSYSDESCRIPTIONVO:Class = ToolTipRefSysDescriptionVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPREFSYSXPMULTIPLIERBLOCKVO:Class = ToolTipRefSysXPMultiplierBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPREFSYSXPMULTIPLIERVO:Class = ToolTipRefSysXPMultiplierVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPSKILLVO:Class = ToolTipSkillVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPTANKCLASSVO:Class = ToolTipTankClassVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPUNITLEVELVO:Class = ToolTipUnitLevelVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_TOOLTIPENVIRONMENTVO:Class = TooltipEnvironmentVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FINALSTATS_HEADBLOCKDATA:Class = HeadBlockData;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_VO_FINALSTATS_TOTALITEMSBLOCKDATA:Class = TotalItemsBlockData;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_FINSTATS_EFFICIENCYBLOCK:Class = EfficiencyBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_FINSTATS_HEADBLOCK:Class = HeadBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_FINSTATS_TOTALITEMSBLOCK:Class = TotalItemsBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_ABSTRACTTEXTPARAMETERBLOCK:Class = AbstractTextParameterBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_IMAGEBLOCK:Class = ImageBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_IMAGELISTBLOCK:Class = ImageListBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_SALETEXTPARAMETERBLOCK:Class = SaleTextParameterBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_STATUSDELTAPARAMETERBLOCK:Class = StatusDeltaParameterBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TEXTPARAMETERBLOCK:Class = TextParameterBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_TEXTPARAMETERWITHICONBLOCK:Class = TextParameterWithIconBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_BLOCKS_XMASEVENTPROGRESSBLOCK:Class = XmasEventProgressBlock;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_COMPONENTS_IMAGERENDERER:Class = ImageRenderer;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_IMAGELISTBLOCKVO:Class = ImageListBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_SALETEXTPARAMETERVO:Class = SaleTextParameterVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_STATUSDELTAPARAMETERBLOCKVO:Class = StatusDeltaParameterBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TEXTPARAMETERVO:Class = TextParameterVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_TEXTPARAMETERWITHICONVO:Class = TextParameterWithIconVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_INBLOCKS_DATA_XMASEVENTPROGRESSBLOCKVO:Class = XmasEventProgressBlockVO;

    public static const NET_WG_GUI_COMPONENTS_TOOLTIPS_SORTIE_SORTIEDIVISIONBLOCK:Class = SortieDivisionBlock;

    public static const NET_WG_GUI_COMPONENTS_WAITINGQUEUE_WAITINGQUEUEMESSAGEHELPER:Class = WaitingQueueMessageHelper;

    public static const NET_WG_GUI_COMPONENTS_WAITINGQUEUE_WAITINGQUEUEMESSAGEUPDATER:Class = WaitingQueueMessageUpdater;

    public static const NET_WG_GUI_COMPONENTS_WINDOWS_SCREENBG:Class = ScreenBg;

    public static const NET_WG_GUI_COMPONENTS_WINDOWS_SIMPLEWINDOW:Class = SimpleWindow;

    public static const NET_WG_GUI_COMPONENTS_WINDOWS_VO_SIMPLEWINDOWBTNVO:Class = SimpleWindowBtnVo;

    public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONEVENT:Class = CrewOperationEvent;

    public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONINFOVO:Class = CrewOperationInfoVO;

    public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONWARNINGVO:Class = CrewOperationWarningVO;

    public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSIRFOOTER:Class = CrewOperationsIRFooter;

    public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSIRENDERER:Class = CrewOperationsIRenderer;

    public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSINITVO:Class = CrewOperationsInitVO;

    public static const NET_WG_GUI_CREWOPERATIONS_CREWOPERATIONSPOPOVER:Class = CrewOperationsPopOver;

    public static const NET_WG_GUI_CYBERSPORT_CSCONSTANTS:Class = CSConstants;

    public static const NET_WG_GUI_CYBERSPORT_CSINVALIDATIONTYPE:Class = CSInvalidationType;

    public static const NET_WG_GUI_CYBERSPORT_CYBERSPORTMAINWINDOW:Class = CyberSportMainWindow;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSANIMATION:Class = CSAnimation;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSANIMATIONICON:Class = CSAnimationIcon;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSCANDIDATESSCROLLINGLIST:Class = CSCandidatesScrollingList;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSLADDERICONBUTTON:Class = CSLadderIconButton;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSRALLYINFO:Class = CSRallyInfo;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSVEHICLEBUTTON:Class = CSVehicleButton;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CSVEHICLEBUTTONLEVELS:Class = CSVehicleButtonLevels;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CANDIDATEHEADERITEMRENDER:Class = CandidateHeaderItemRender;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_CANDIDATEITEMRENDERER:Class = CandidateItemRenderer;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_COMMANDRENDERER:Class = CommandRenderer;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DYNAMICRANGEVEHICLES:Class = DynamicRangeVehicles;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_MANUALSEARCHRENDERER:Class = ManualSearchRenderer;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_MEDALVEHICLEVO:Class = MedalVehicleVO;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_NAVIGATIONBLOCK:Class = NavigationBlock;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_RANGEVIEWCOMPONENT:Class = RangeViewComponent;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_ROSTERBUTTONGROUP:Class = RosterButtonGroup;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_ROSTERSETTINGSNUMERATIONBLOCK:Class = RosterSettingsNumerationBlock;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SELECTEDVEHICLESMSG:Class = SelectedVehiclesMsg;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_SETTINGSICONS:Class = SettingsIcons;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTOR:Class = VehicleSelector;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTORITEMRENDERER:Class = VehicleSelectorItemRenderer;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_VEHICLESELECTORNAVIGATOR:Class = VehicleSelectorNavigator;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_WAITINGALERT:Class = WaitingAlert;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DATA_CSANIMATIONVO:Class = CSAnimationVO;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DATA_CSRALLYINFOVO:Class = CSRallyInfoVO;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_DATA_CSVEHICLEBUTTONSELECTIONVO:Class = CSVehicleButtonSelectionVO;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_CSCOMPONENTEVENT:Class = CSComponentEvent;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_CSRALLYINFOEVENT:Class = CSRallyInfoEvent;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_MANUALSEARCHEVENT:Class = ManualSearchEvent;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_VEHICLESELECTOREVENT:Class = VehicleSelectorEvent;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_EVENTS_VEHICLESELECTORITEMEVENT:Class = VehicleSelectorItemEvent;

    public static const NET_WG_GUI_CYBERSPORT_CONTROLS_INTERFACES_IVEHICLEBUTTON:Class = IVehicleButton;

    public static const NET_WG_GUI_CYBERSPORT_DATA_CANDIDATESDATAPROVIDER:Class = CandidatesDataProvider;

    public static const NET_WG_GUI_CYBERSPORT_DATA_ROSTERSLOTSETTINGSWINDOWSTATICVO:Class = RosterSlotSettingsWindowStaticVO;

    public static const NET_WG_GUI_CYBERSPORT_INTERFACES_IAUTOSEARCHFORMVIEW:Class = IAutoSearchFormView;

    public static const NET_WG_GUI_CYBERSPORT_INTERFACES_ICSAUTOSEARCHMAINVIEW:Class = ICSAutoSearchMainView;

    public static const NET_WG_GUI_CYBERSPORT_INTERFACES_ICHANNELCOMPONENTHOLDER:Class = IChannelComponentHolder;

    public static const NET_WG_GUI_CYBERSPORT_INTERFACES_IMANUALSEARCHDATAPROVIDER:Class = IManualSearchDataProvider;

    public static const NET_WG_GUI_CYBERSPORT_POPUPS_VEHICLESELECTORPOPUP:Class = VehicleSelectorPopup;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_INVITESANDREQUESTSWINDOW:Class = InvitesAndRequestsWindow;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_STATICFORMATIONPROFILEWINDOW:Class = StaticFormationProfileWindow;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_BESTTANKSMAPSITEM:Class = BestTanksMapsItem;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_FORMATIONAPPOINTMENTCOMPONENT:Class = FormationAppointmentComponent;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_LADDERICONMESSAGE:Class = LadderIconMessage;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_STATICFORMATIONAWARDSCONTAINER:Class = StaticFormationAwardsContainer;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_STATICFORMATIONCONSTANTS:Class = StaticFormationConstants;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_STATICFORMATIONPROFILEEMBLEM:Class = StaticFormationProfileEmblem;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_STATICFORMATIONSTATSCONTAINER:Class = StaticFormationStatsContainer;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_STATICFORMATIONSTATSITEM:Class = StaticFormationStatsItem;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_RENDERERS_INVITESANDREQUESTSITEMRENDERER:Class = InvitesAndRequestsItemRenderer;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_RENDERERS_STATICFORMATIONLADDERTABLERENDERER:Class = StaticFormationLadderTableRenderer;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_COMPONENTS_RENDERERS_STATICFORMATIONSTAFFTABLERENDERER:Class = StaticFormationStaffTableRenderer;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_FORMATIONAPPOINTMENTVO:Class = FormationAppointmentVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_INVITESANDREQUESTSDATAPROVIDER:Class = InvitesAndRequestsDataProvider;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_INVITESANDREQUESTSITEMVO:Class = InvitesAndRequestsItemVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_INVITESANDREQUESTSVO:Class = InvitesAndRequestsVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_LADDERICONMESSAGEVO:Class = LadderIconMessageVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_LADDERSTATEDATAVO:Class = LadderStateDataVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONLDITVO:Class = StaticFormationLDITVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONLADDERTABLERENDERERVO:Class = StaticFormationLadderTableRendererVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONLADDERVIEWHEADERVO:Class = StaticFormationLadderViewHeaderVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONLADDERVIEWICONSVO:Class = StaticFormationLadderViewIconsVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONLADDERVIEWLADDERVO:Class = StaticFormationLadderViewLadderVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONPROFILEBUTTONINFOVO:Class = StaticFormationProfileButtonInfoVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONPROFILEEMBLEMVO:Class = StaticFormationProfileEmblemVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONPROFILEWINDOWVO:Class = StaticFormationProfileWindowVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTAFFCONTEXTMENUVO:Class = StaticFormationStaffContextMenuVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTAFFTABLERENDERERVO:Class = StaticFormationStaffTableRendererVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTAFFVIEWHEADERVO:Class = StaticFormationStaffViewHeaderVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTAFFVIEWSTAFFVO:Class = StaticFormationStaffViewStaffVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTAFFVIEWSTATICHEADERVO:Class = StaticFormationStaffViewStaticHeaderVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTATSITEMVO:Class = StaticFormationStatsItemVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTATSVO:Class = StaticFormationStatsVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSTATSVIEWVO:Class = StaticFormationStatsViewVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONSUMMARYVO:Class = StaticFormationSummaryVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_DATA_STATICFORMATIONUNITVIEWHEADERVO:Class = StaticFormationUnitViewHeaderVO;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_EVENTS_FORMATIONAPPOINTMENTEVENT:Class = FormationAppointmentEvent;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_EVENTS_FORMATIONLADDEREVENT:Class = FormationLadderEvent;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_EVENTS_FORMATIONSTAFFEVENT:Class = FormationStaffEvent;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_EVENTS_INVITESANDREQUESTSACCEPTEVENT:Class = InvitesAndRequestsAcceptEvent;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_EVENTS_STATICFORMATIONSTATSEVENT:Class = StaticFormationStatsEvent;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_INTERFACES_ITEXTCLICKDELEGATE:Class = ITextClickDelegate;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_ISTATICFORMATIONPROFILEEMBLEM:Class = IStaticFormationProfileEmblem;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_ISTATICFORMATIONSTATSVIEW:Class = IStaticFormationStatsView;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_ISTATICFORMATIONSUMMARYVIEW:Class = IStaticFormationSummaryView;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_STATICFORMATIONLADDERVIEW:Class = StaticFormationLadderView;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_STATICFORMATIONSTAFFVIEW:Class = StaticFormationStaffView;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_STATICFORMATIONUNITVIEW:Class = StaticFormationUnitView;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_IMPL_STATICFORMATIONSTATSVIEW:Class = StaticFormationStatsView;

    public static const NET_WG_GUI_CYBERSPORT_STATICFORMATION_VIEWS_IMPL_STATICFORMATIONSUMMARYVIEW:Class = StaticFormationSummaryView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_ANIMATEDROSTERSETTINGSVIEW:Class = AnimatedRosterSettingsView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_INTROVIEW:Class = IntroView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RANGEROSTERSETTINGSVIEW:Class = RangeRosterSettingsView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_ROSTERSETTINGSVIEW:Class = RosterSettingsView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_ROSTERSLOTSETTINGSWINDOW:Class = RosterSlotSettingsWindow;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNITVIEW:Class = UnitView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNITSLISTVIEW:Class = UnitsListView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_CSAUTOSEARCHMAINVIEW:Class = CSAutoSearchMainView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_CONFIRMATIONREADINESSSTATUS:Class = ConfirmationReadinessStatus;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_ERRORSTATE:Class = ErrorState;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHCOMMANDS:Class = SearchCommands;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHENEMY:Class = SearchEnemy;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_SEARCHENEMYRESPAWN:Class = SearchEnemyRespawn;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_STATEVIEWBASE:Class = StateViewBase;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_AUTOSEARCH_WAITINGPLAYERS:Class = WaitingPlayers;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_CSSHOWHELPEVENT:Class = CSShowHelpEvent;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_CYBERSPORTEVENT:Class = CyberSportEvent;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_ROSTERSETTINGSEVENT:Class = RosterSettingsEvent;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_EVENTS_SCUPDATEFOCUSEVENT:Class = SCUpdateFocusEvent;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNCHATSECTION:Class = RespawnChatSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNFORM:Class = RespawnForm;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNSLOTHELPER:Class = RespawnSlotHelper;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNTEAMSECTION:Class = RespawnTeamSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNTEAMSLOT:Class = RespawnTeamSlot;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_RESPAWNVIEW:Class = RespawnView;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_RESPAWN_UNITSLOTBUTTONPROPERTIES:Class = UnitSlotButtonProperties;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_CHATSECTION:Class = ChatSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_CYBERSPORTTEAMSECTIONBASE:Class = CyberSportTeamSectionBase;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_ISTATICRALLYDETAILSSECTION:Class = IStaticRallyDetailsSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_JOINUNITSECTION:Class = JoinUnitSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_SIMPLESLOTRENDERER:Class = SimpleSlotRenderer;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_SLOTRENDERER:Class = SlotRenderer;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICFORMATIONSLOTRENDERER:Class = StaticFormationSlotRenderer;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICFORMATIONTEAMSECTION:Class = StaticFormationTeamSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICFORMATIONUNITSLOTHELPER:Class = StaticFormationUnitSlotHelper;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICFORMATIONUNITVIEWHEADER:Class = StaticFormationUnitViewHeader;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICFORMATIONWAITLISTSECTION:Class = StaticFormationWaitListSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICRALLYASLEGIONARYDETAILSSECTION:Class = StaticRallyAsLegionaryDetailsSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICRALLYDETAILSSECTION:Class = StaticRallyDetailsSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_STATICRALLYUNITSLOTHELPER:Class = StaticRallyUnitSlotHelper;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_TEAMSECTION:Class = TeamSection;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_UNITSLOTHELPER:Class = UnitSlotHelper;

    public static const NET_WG_GUI_CYBERSPORT_VIEWS_UNIT_WAITLISTSECTION:Class = WaitListSection;

    public static const NET_WG_GUI_CYBERSPORT_VO_AUTOSEARCHVO:Class = AutoSearchVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_CSCOMMADDETAILSVO:Class = CSCommadDetailsVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_CSCOMMANDVO:Class = CSCommandVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_CSINDICATORDATA:Class = CSIndicatorData;

    public static const NET_WG_GUI_CYBERSPORT_VO_CSINTROVIEWSTATICTEAMVO:Class = CSIntroViewStaticTeamVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_CSINTROVIEWTEXTSVO:Class = CSIntroViewTextsVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_CSSTATICLEGIONARYRALLYVO:Class = CSStaticLegionaryRallyVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_CSSTATICRALLYVO:Class = CSStaticRallyVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_IUNIT:Class = IUnit;

    public static const NET_WG_GUI_CYBERSPORT_VO_IUNITSLOT:Class = IUnitSlot;

    public static const NET_WG_GUI_CYBERSPORT_VO_NAVIGATIONBLOCKVO:Class = NavigationBlockVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_ROSTERLIMITSVO:Class = RosterLimitsVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_UNITLISTVIEWHEADERVO:Class = UnitListViewHeaderVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_VEHICLESELECTORITEMVO:Class = VehicleSelectorItemVO;

    public static const NET_WG_GUI_CYBERSPORT_VO_WAITINGPLAYERSVO:Class = WaitingPlayersVO;

    public static const NET_WG_GUI_DATA_AWARDWINDOWANIMATIONVO:Class = AwardWindowAnimationVO;

    public static const NET_WG_GUI_DATA_AWARDWINDOWTAKENEXTBTNVO:Class = AwardWindowTakeNextBtnVO;

    public static const NET_WG_GUI_DATA_AWARDWINDOWVO:Class = AwardWindowVO;

    public static const NET_WG_GUI_DATA_BASEAWARDSBLOCKVO:Class = BaseAwardsBlockVO;

    public static const NET_WG_GUI_DATA_BUTTONBARDATAVO:Class = ButtonBarDataVO;

    public static const NET_WG_GUI_DATA_BUTTONBARITEMVO:Class = ButtonBarItemVO;

    public static const NET_WG_GUI_DATA_DATACLASSITEMVO:Class = DataClassItemVO;

    public static const NET_WG_GUI_DATA_MISSIONAWARDWINDOWVO:Class = MissionAwardWindowVO;

    public static const NET_WG_GUI_DATA_TABDATAVO:Class = TabDataVO;

    public static const NET_WG_GUI_DATA_TABSVO:Class = TabsVO;

    public static const NET_WG_GUI_DATA_TASKAWARDSBLOCKVO:Class = TaskAwardsBlockVO;

    public static const NET_WG_GUI_DATA_VEHCOMPAREENTRYPOINTVO:Class = VehCompareEntrypointVO;

    public static const NET_WG_GUI_DATA_VERSIONMESSAGEVO:Class = VersionMessageVO;

    public static const NET_WG_GUI_EVENTS_ARENAVOIPSETTINGSEVENT:Class = ArenaVoipSettingsEvent;

    public static const NET_WG_GUI_EVENTS_CSANIMATIONEVENT:Class = CSAnimationEvent;

    public static const NET_WG_GUI_EVENTS_CONFIRMEXCHANGEBLOCKEVENT:Class = ConfirmExchangeBlockEvent;

    public static const NET_WG_GUI_EVENTS_COOLDOWNEVENT:Class = CooldownEvent;

    public static const NET_WG_GUI_EVENTS_CREWEVENT:Class = CrewEvent;

    public static const NET_WG_GUI_EVENTS_DEVICEEVENT:Class = DeviceEvent;

    public static const NET_WG_GUI_EVENTS_EQUIPMENTEVENT:Class = EquipmentEvent;

    public static const NET_WG_GUI_EVENTS_FINALSTATISTICEVENT:Class = FinalStatisticEvent;

    public static const NET_WG_GUI_EVENTS_HEADERBUTTONBAREVENT:Class = HeaderButtonBarEvent;

    public static const NET_WG_GUI_EVENTS_HEADEREVENT:Class = HeaderEvent;

    public static const NET_WG_GUI_EVENTS_LOBBYEVENT:Class = LobbyEvent;

    public static const NET_WG_GUI_EVENTS_LOBBYTDISPATCHEREVENT:Class = LobbyTDispatcherEvent;

    public static const NET_WG_GUI_EVENTS_MESSENGERBAREVENT:Class = MessengerBarEvent;

    public static const NET_WG_GUI_EVENTS_MODULEINFOEVENT:Class = ModuleInfoEvent;

    public static const NET_WG_GUI_EVENTS_PERSONALCASEEVENT:Class = PersonalCaseEvent;

    public static const NET_WG_GUI_EVENTS_QUESTEVENT:Class = QuestEvent;

    public static const NET_WG_GUI_EVENTS_RESIZABLEBLOCKEVENT:Class = ResizableBlockEvent;

    public static const NET_WG_GUI_EVENTS_SHELLRENDEREREVENT:Class = ShellRendererEvent;

    public static const NET_WG_GUI_EVENTS_SHOWDIALOGEVENT:Class = ShowDialogEvent;

    public static const NET_WG_GUI_EVENTS_SORTABLETABLELISTEVENT:Class = SortableTableListEvent;

    public static const NET_WG_GUI_EVENTS_TRAININGEVENT:Class = TrainingEvent;

    public static const NET_WG_GUI_EVENTS_VEHICLESELLDIALOGEVENT:Class = VehicleSellDialogEvent;

    public static const NET_WG_GUI_EVENTS_WAITINGQUEUEMESSAGEEVENT:Class = WaitingQueueMessageEvent;

    public static const NET_WG_GUI_FORTBASE_IARROWWITHNUT:Class = IArrowWithNut;

    public static const NET_WG_GUI_FORTBASE_IBATTLENOTIFIERVO:Class = IBattleNotifierVO;

    public static const NET_WG_GUI_FORTBASE_IBUILDINGBASEVO:Class = IBuildingBaseVO;

    public static const NET_WG_GUI_FORTBASE_IBUILDINGTOOLTIPDATAPROVIDER:Class = IBuildingToolTipDataProvider;

    public static const NET_WG_GUI_FORTBASE_IBUILDINGVO:Class = IBuildingVO;

    public static const NET_WG_GUI_FORTBASE_IBUILDINGSCOMPONENTVO:Class = IBuildingsComponentVO;

    public static const NET_WG_GUI_FORTBASE_ICOMMONMODECLIENT:Class = ICommonModeClient;

    public static const NET_WG_GUI_FORTBASE_IDIRECTIONMODECLIENT:Class = IDirectionModeClient;

    public static const NET_WG_GUI_FORTBASE_IFORTBUILDING:Class = IFortBuilding;

    public static const NET_WG_GUI_FORTBASE_IFORTBUILDINGUIBASE:Class = IFortBuildingUIBase;

    public static const NET_WG_GUI_FORTBASE_IFORTBUILDINGSCONTAINER:Class = IFortBuildingsContainer;

    public static const NET_WG_GUI_FORTBASE_IFORTDIRECTIONSCONTAINER:Class = IFortDirectionsContainer;

    public static const NET_WG_GUI_FORTBASE_IFORTLANDSCAPECMP:Class = IFortLandscapeCmp;

    public static const NET_WG_GUI_FORTBASE_IFORTMODEVO:Class = IFortModeVO;

    public static const NET_WG_GUI_FORTBASE_ITRANSPORTMODECLIENT:Class = ITransportModeClient;

    public static const NET_WG_GUI_FORTBASE_ITRANSPORTINGHANDLER:Class = ITransportingHandler;

    public static const NET_WG_GUI_FORTBASE_ITRANSPORTINGSTEPPER:Class = ITransportingStepper;

    public static const NET_WG_GUI_FORTBASE_EVENTS_FORTINITEVENT:Class = FortInitEvent;

    public static const NET_WG_GUI_INTERFACES_ICALENDARDAYVO:Class = ICalendarDayVO;

    public static const NET_WG_GUI_INTERFACES_IDATE:Class = IDate;

    public static const NET_WG_GUI_INTERFACES_IDROPLIST:Class = IDropList;

    public static const NET_WG_GUI_INTERFACES_IEXTENDEDUSERVO:Class = IExtendedUserVO;

    public static const NET_WG_GUI_INTERFACES_IHEADERBUTTONCONTENTITEM:Class = IHeaderButtonContentItem;

    public static const NET_WG_GUI_INTERFACES_IPERSONALCASEBLOCKTITLE:Class = IPersonalCaseBlockTitle;

    public static const NET_WG_GUI_INTERFACES_IRALLYCANDIDATEVO:Class = IRallyCandidateVO;

    public static const NET_WG_GUI_INTERFACES_IREFERRALTEXTBLOCKCMP:Class = IReferralTextBlockCmp;

    public static const NET_WG_GUI_INTERFACES_IRESETTABLE:Class = IResettable;

    public static const NET_WG_GUI_INTERFACES_ISALEITEMBLOCKRENDERER:Class = ISaleItemBlockRenderer;

    public static const NET_WG_GUI_INTERFACES_IUPDATABLECOMPONENT:Class = IUpdatableComponent;

    public static const NET_WG_GUI_INTERFACES_IWAITINGQUEUEMESSAGEHELPER:Class = IWaitingQueueMessageHelper;

    public static const NET_WG_GUI_INTERFACES_IWAITINGQUEUEMESSAGEUPDATER:Class = IWaitingQueueMessageUpdater;

    public static const NET_WG_GUI_INTRO_INTROINFOVO:Class = IntroInfoVO;

    public static const NET_WG_GUI_INTRO_INTROPAGE:Class = IntroPage;

    public static const NET_WG_GUI_LOBBY_LOBBYPAGE:Class = LobbyPage;

    public static const NET_WG_GUI_LOBBY_ACADEMY_ACADEMYVIEW:Class = AcademyView;

    public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKS:Class = Barracks;

    public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKSFORM:Class = BarracksForm;

    public static const NET_WG_GUI_LOBBY_BARRACKS_BARRACKSITEMRENDERER:Class = BarracksItemRenderer;

    public static const NET_WG_GUI_LOBBY_BARRACKS_DATA_BARRACKSTANKMANVO:Class = BarracksTankmanVO;

    public static const NET_WG_GUI_LOBBY_BARRACKS_DATA_BARRACKSTANKMENVO:Class = BarracksTankmenVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_BATTLERESULTS:Class = BattleResults;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMMONSTATS:Class = CommonStats;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DETAILSSTATSVIEW:Class = DetailsStatsView;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_GETPREMIUMPOPOVER:Class = GetPremiumPopover;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_IEMBLEMLOADEDDELEGATE:Class = IEmblemLoadedDelegate;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_MULTITEAMSTATS:Class = MultiteamStats;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_TEAMSTATS:Class = TeamStats;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_ALERTMESSAGE:Class = AlertMessage;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_BATTLERESULTSEVENTRENDERER:Class = BattleResultsEventRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_BATTLERESULTSMEDALSLIST:Class = BattleResultsMedalsList;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_BATTLERESULTSPERSONALQUEST:Class = BattleResultsPersonalQuest;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSBLOCK:Class = DetailsBlock;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSSTATS:Class = DetailsStats;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_DETAILSSTATSSCROLLPANE:Class = DetailsStatsScrollPane;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_EFFICIENCYHEADER:Class = EfficiencyHeader;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_EFFICIENCYICONRENDERER:Class = EfficiencyIconRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_EFFICIENCYRENDERER:Class = EfficiencyRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_INCOMEDETAILS:Class = IncomeDetails;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_INCOMEDETAILSBASE:Class = IncomeDetailsBase;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_INCOMEDETAILSSHORT:Class = IncomeDetailsShort;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_MEDALSLIST:Class = MedalsList;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_PROGRESSELEMENT:Class = ProgressElement;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_SORTIETEAMSTATSCONTROLLER:Class = SortieTeamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_SPECIALACHIEVEMENT:Class = SpecialAchievement;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TANKSTATSVIEW:Class = TankStatsView;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMMEMBERITEMRENDERER:Class = TeamMemberItemRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMMEMBERRENDERERBASE:Class = TeamMemberRendererBase;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMMEMBERSTATSVIEW:Class = TeamMemberStatsView;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TEAMSTATSLIST:Class = TeamStatsList;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_TOTALINCOMEDETAILS:Class = TotalIncomeDetails;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_COMPONENTS_VEHICLEDETAILS:Class = VehicleDetails;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_COLUMNCONSTANTS:Class = ColumnConstants;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_CYBERSPORTTEAMSTATSCONTROLLER:Class = CybersportTeamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_DEFAULTMULTITEAMSTATSCONTROLLER:Class = DefaultMultiteamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_DEFAULTTEAMSTATSCONTROLLER:Class = DefaultTeamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_FFAMULTITEAMSTATSCONTROLLER:Class = FFAMultiteamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_FALLOUTTEAMSTATSCONTROLLER:Class = FalloutTeamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_FORTTEAMSTATSCONTROLLER:Class = FortTeamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_MULTITEAMSTATSCONTROLLERABSTRACT:Class = MultiteamStatsControllerAbstract;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_RATEDCYBERSPORTTEAMSTATSCONTROLLER:Class = RatedCybersportTeamStatsController;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CONTROLLER_TEAMSTATSCONTROLLERABSTRACT:Class = TeamStatsControllerAbstract;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMEMBLEMEVENT:Class = CsTeamEmblemEvent;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMEVENT:Class = CsTeamEvent;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMSTATS:Class = CsTeamStats;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMSTATSBG:Class = CsTeamStatsBg;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_CS_CSTEAMSTATSVO:Class = CsTeamStatsVo;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_ALERTMESSAGEVO:Class = AlertMessageVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_BATTLERESULTSMEDALSLISTVO:Class = BattleResultsMedalsListVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_BATTLERESULTSTEXTDATA:Class = BattleResultsTextData;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_BATTLERESULTSVO:Class = BattleResultsVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_COLUMNCOLLECTION:Class = ColumnCollection;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_COLUMNDATA:Class = ColumnData;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_COMMONSTATSVO:Class = CommonStatsVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_DETAILEDSTATSITEMVO:Class = DetailedStatsItemVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_EFFICIENCYHEADERVO:Class = EfficiencyHeaderVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_EFFICIENCYRENDERERVO:Class = EfficiencyRendererVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_GETPREMIUMPOPOVERVO:Class = GetPremiumPopoverVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_ICONEFFICIENCYTOOLTIPDATA:Class = IconEfficiencyTooltipData;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_OVERTIMEVO:Class = OvertimeVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_PERSONALDATAVO:Class = PersonalDataVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_STATITEMVO:Class = StatItemVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_TABINFOVO:Class = TabInfoVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_TEAMMEMBERITEMVO:Class = TeamMemberItemVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_VEHICLEITEMVO:Class = VehicleItemVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_VEHICLESTATSVO:Class = VehicleStatsVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_DATA_VICTORYPANELVO:Class = VictoryPanelVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EVENT_BATTLERESULTSVIEWEVENT:Class = BattleResultsViewEvent;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EVENT_CLANEMBLEMREQUESTEVENT:Class = ClanEmblemRequestEvent;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_EVENT_TEAMTABLESORTEVENT:Class = TeamTableSortEvent;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_FALLOUT_DETAILSVEHICLESELECTION:Class = DetailsVehicleSelection;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_FALLOUT_FFATEAMMEMBERRENDERER:Class = FFATeamMemberRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_FALLOUT_FALLOUTTEAMMEMBERITEMRENDERER:Class = FalloutTeamMemberItemRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_FALLOUT_FALLOUTTEAMMEMBERITEMRENDERERBASE:Class = FalloutTeamMemberItemRendererBase;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_FALLOUT_MULTITEAMMEMBERITEMRENDERER:Class = MultiteamMemberItemRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_FALLOUT_VICTORYSCOREPANEL:Class = VictoryScorePanel;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_MANAGERS_ISTATSUTILSMANAGER:Class = IStatsUtilsManager;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_MANAGERS_IMPL_STATSUTILSMANAGER:Class = StatsUtilsManager;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_BATTLERESULTUNLOCKITEM:Class = BattleResultUnlockItem;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_BATTLERESULTUNLOCKITEMVO:Class = BattleResultUnlockItemVO;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_PROGRESSREPORTLINKAGESELECTOR:Class = ProgressReportLinkageSelector;

    public static const NET_WG_GUI_LOBBY_BATTLERESULTS_PROGRESSREPORT_UNLOCKLINKEVENT:Class = UnlockLinkEvent;

    public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUE:Class = BattleQueue;

    public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUEITEMRENDERER:Class = BattleQueueItemRenderer;

    public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUEITEMVO:Class = BattleQueueItemVO;

    public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUELISTDATAVO:Class = BattleQueueListDataVO;

    public static const NET_WG_GUI_LOBBY_BATTLEQUEUE_BATTLEQUEUETYPEINFOVO:Class = BattleQueueTypeInfoVO;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_BOOSTERSTABLERENDERER:Class = BoostersTableRenderer;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_COMPONENTS_BOOSTERSWINDOWFILTERS:Class = BoostersWindowFilters;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSTABLERENDERERVO:Class = BoostersTableRendererVO;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSWINDOWFILTERSVO:Class = BoostersWindowFiltersVO;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSWINDOWSTATICVO:Class = BoostersWindowStaticVO;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_BOOSTERSWINDOWVO:Class = BoostersWindowVO;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_DATA_CONFIRMBOOSTERSWINDOWVO:Class = ConfirmBoostersWindowVO;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_EVENTS_BOOSTERSWINDOWEVENT:Class = BoostersWindowEvent;

    public static const NET_WG_GUI_LOBBY_BOOSTERS_WINDOWS_CONFIRMBOOSTERSWINDOW:Class = ConfirmBoostersWindow;

    public static const NET_WG_GUI_LOBBY_BROWSER_BROWSER:Class = Browser;

    public static const NET_WG_GUI_LOBBY_BROWSER_BROWSERACTIONBTN:Class = BrowserActionBtn;

    public static const NET_WG_GUI_LOBBY_BROWSER_SERVICEVIEW:Class = ServiceView;

    public static const NET_WG_GUI_LOBBY_BROWSER_EVENTS_BROWSERACTIONBTNEVENT:Class = BrowserActionBtnEvent;

    public static const NET_WG_GUI_LOBBY_BROWSER_EVENTS_BROWSEREVENT:Class = BrowserEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASBUTTON:Class = ChristmasButton;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASCHESTSVIEW:Class = ChristmasChestsView;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASCUSTOMIZATIONVIEW:Class = ChristmasCustomizationView;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASDECORATIONSFILTERS:Class = ChristmasDecorationsFilters;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASDECORATIONSFILTERSLIST:Class = ChristmasDecorationsFiltersList;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASDECORATIONSLIST:Class = ChristmasDecorationsList;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASMAINVIEW:Class = ChristmasMainView;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CHRISTMASPROGRESSBAR:Class = ChristmasProgressBar;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHESTAWARDHEADER:Class = ChestAwardHeader;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHESTAWARDRIBBON:Class = ChestAwardRibbon;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASANIMATIONITEM:Class = ChristmasAnimationItem;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASAWARDANIMRENDERER:Class = ChristmasAwardAnimRenderer;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASAWARDRENDERER:Class = ChristmasAwardRenderer;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASAWARDWINDOWANIMATION:Class = ChristmasAwardWindowAnimation;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASDECORATIONITEM:Class = ChristmasDecorationItem;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASDECORATIONSLOT:Class = ChristmasDecorationSlot;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASDECORATIONSLOTBACK:Class = ChristmasDecorationSlotBack;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASHEADERBACKGROUND:Class = ChristmasHeaderBackground;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_CHRISTMASITEMSANIMATION:Class = ChristmasItemsAnimation;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASCONVERSIONSLOTS:Class = ChristmasConversionSlots;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASCUSTOMIZATIONSLOTS:Class = ChristmasCustomizationSlots;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASDROPPABLESLOT:Class = ChristmasDroppableSlot;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASSLOT:Class = ChristmasSlot;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASSLOTS:Class = ChristmasSlots;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASTANKSLOTS:Class = ChristmasTankSlots;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASTREESLOTHITAREA:Class = ChristmasTreeSlotHitArea;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CHRISTMASTREESLOTS:Class = ChristmasTreeSlots;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_CONTROLS_SLOTS_CONVERSIONRESULTSLOT:Class = ConversionResultSlot;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_BASEDECORATIONVO:Class = BaseDecorationVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_CHESTSVIEWVO:Class = ChestsViewVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_CHRISTMASANIMATIONITEMVO:Class = ChristmasAnimationItemVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_CHRISTMASAWARDANIMATIONLOADERVO:Class = ChristmasAwardAnimationLoaderVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_CHRISTMASBUTTONVO:Class = ChristmasButtonVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_CHRISTMASFILTERSVO:Class = ChristmasFiltersVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_CONVERTDECORATIONSDIALOGVO:Class = ConvertDecorationsDialogVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_DECORATIONINFOVO:Class = DecorationInfoVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_DECORATIONVO:Class = DecorationVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_EMPTYLISTVO:Class = EmptyListVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_MAINVIEWSTATICDATAVO:Class = MainViewStaticDataVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_PROGRESSBARVO:Class = ProgressBarVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_CONVERSIONDATAVO:Class = ConversionDataVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_CONVERSIONSTATICDATAVO:Class = ConversionStaticDataVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_CUSTOMIZATIONSTATICDATAVO:Class = CustomizationStaticDataVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_SLOTVO:Class = SlotVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_SLOTSDATACLASSVO:Class = SlotsDataClassVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_SLOTSDATAVO:Class = SlotsDataVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_SLOTSSTATICDATACLASSVO:Class = SlotsStaticDataClassVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DATA_SLOTS_SLOTSSTATICDATAVO:Class = SlotsStaticDataVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DRAGDROP_CHRISTMASDRAGDROPCONTROLLER:Class = ChristmasDragDropController;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DRAGDROP_CHRISTMASDRAGDROPUTILS:Class = ChristmasDragDropUtils;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_DRAGDROP_CHRISTMASDROPDELEGATE:Class = ChristmasDropDelegate;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASAWARDRENDEREREVENT:Class = ChristmasAwardRendererEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASCONVERSIONEVENT:Class = ChristmasConversionEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASCUSTOMIZATIONEVENT:Class = ChristmasCustomizationEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASCUSTOMIZATIONFILTEREVENT:Class = ChristmasCustomizationFilterEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASCUSTOMIZATIONTABEVENT:Class = ChristmasCustomizationTabEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASDECORATIONSLISTEVENT:Class = ChristmasDecorationsListEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASDROPEVENT:Class = ChristmasDropEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASFILTEREVENT:Class = ChristmasFilterEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASPROGRESSBAREVENT:Class = ChristmasProgressBarEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_EVENT_CHRISTMASSLOTSEVENT:Class = ChristmasSlotsEvent;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHESTAWARDRIBBON:Class = IChestAwardRibbon;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASANIMATIONITEM:Class = IChristmasAnimationItem;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASANIMATIONITEMVO:Class = IChristmasAnimationItemVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASANIMATIONVO:Class = IChristmasAnimationVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASAWARDANIMRENDERER:Class = IChristmasAwardAnimRenderer;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASBUTTON:Class = IChristmasButton;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASDROPACTOR:Class = IChristmasDropActor;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASDROPDELEGATE:Class = IChristmasDropDelegate;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASDROPITEM:Class = IChristmasDropItem;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASDROPPABLESLOT:Class = IChristmasDroppableSlot;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASITEMSANIMATION:Class = IChristmasItemsAnimation;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASMAINVIEW:Class = IChristmasMainView;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASPROGRESSBAR:Class = IChristmasProgressBar;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASSLOT:Class = IChristmasSlot;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASSLOTHITAREA:Class = IChristmasSlotHitArea;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICHRISTMASSLOTS:Class = IChristmasSlots;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ICUSTOMIZATIONSTATICDATAVO:Class = ICustomizationStaticDataVO;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ISLOTSSTATICDATAMAP:Class = ISlotsStaticDataMap;

    public static const NET_WG_GUI_LOBBY_CHRISTMAS_INTERFACES_ITOGGLERENDERER:Class = IToggleRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANBASEINFOVO:Class = ClanBaseInfoVO;

    public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANNAMEFIELD:Class = ClanNameField;

    public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANTABDATAPROVIDERVO:Class = ClanTabDataProviderVO;

    public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANVO:Class = ClanVO;

    public static const NET_WG_GUI_LOBBY_CLANS_COMMON_CLANVIEWWITHVARIABLECONTENT:Class = ClanViewWithVariableContent;

    public static const NET_WG_GUI_LOBBY_CLANS_COMMON_ICLANHEADERCOMPONENT:Class = IClanHeaderComponent;

    public static const NET_WG_GUI_LOBBY_CLANS_COMMON_ICLANNAMEFIELD:Class = IClanNameField;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_CLANINVITESWINDOW:Class = ClanInvitesWindow;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_CLANPERSONALINVITESWINDOW:Class = ClanPersonalInvitesWindow;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_ACCEPTACTIONSVO:Class = AcceptActionsVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITEVO:Class = ClanInviteVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESVIEWVO:Class = ClanInvitesViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWABSTRACTITEMVO:Class = ClanInvitesWindowAbstractItemVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWHEADERSTATEVO:Class = ClanInvitesWindowHeaderStateVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWTABVIEWVO:Class = ClanInvitesWindowTabViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWTABLEFILTERVO:Class = ClanInvitesWindowTableFilterVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANINVITESWINDOWVO:Class = ClanInvitesWindowVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANREQUESTACTIONSVO:Class = ClanRequestActionsVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANREQUESTSTATUSVO:Class = ClanRequestStatusVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_CLANREQUESTVO:Class = ClanRequestVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_DUMMYTEXTVO:Class = DummyTextVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_PERSONALINVITEVO:Class = PersonalInviteVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VOS_USERINVITESWINDOWITEMVO:Class = UserInvitesWindowItemVO;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_COMPONENTS_ACCEPTACTIONS:Class = AcceptActions;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_COMPONENTS_TEXTVALUEBLOCK:Class = TextValueBlock;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANINVITEITEMRENDERER:Class = ClanInviteItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANINVITESWINDOWABSTRACTTABLEITEMRENDERER:Class = ClanInvitesWindowAbstractTableItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANPERSONALINVITESITEMRENDERER:Class = ClanPersonalInvitesItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANREQUESTITEMRENDERER:Class = ClanRequestItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_CLANTABLERENDERERITEMEVENT:Class = ClanTableRendererItemEvent;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_RENDERERS_USERABSTRACTTABLEITEMRENDERER:Class = UserAbstractTableItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANINVITESVIEW:Class = ClanInvitesView;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANINVITESVIEWWITHTABLE:Class = ClanInvitesViewWithTable;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANINVITESWINDOWABSTRACTTABVIEW:Class = ClanInvitesWindowAbstractTabView;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANPERSONALINVITESVIEW:Class = ClanPersonalInvitesView;

    public static const NET_WG_GUI_LOBBY_CLANS_INVITES_VIEWS_CLANREQUESTSVIEW:Class = ClanRequestsView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEEVENT:Class = ClanProfileEvent;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEMAINWINDOW:Class = ClanProfileMainWindow;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEMAINWINDOWBASEHEADER:Class = ClanProfileMainWindowBaseHeader;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILEMAINWINDOWHEADER:Class = ClanProfileMainWindowHeader;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CLANPROFILESUMMARYVIEWHEADER:Class = ClanProfileSummaryViewHeader;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANMEMBERVO:Class = ClanMemberVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEFORTIFICATIONSTATSVIEWVO:Class = ClanProfileFortificationStatsViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEFORTIFICATIONVIEWINITVO:Class = ClanProfileFortificationViewInitVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEFORTIFICATIONVIEWVO:Class = ClanProfileFortificationViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEFORTIFICATIONSSCHEMAVIEWVO:Class = ClanProfileFortificationsSchemaViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEFORTIFICATIONSTEXTSVO:Class = ClanProfileFortificationsTextsVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEGLOBALMAPINFOVO:Class = ClanProfileGlobalMapInfoVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEGLOBALMAPPROMOVO:Class = ClanProfileGlobalMapPromoVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEGLOBALMAPVIEWVO:Class = ClanProfileGlobalMapViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEHEADERSTATEVO:Class = ClanProfileHeaderStateVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEMAINWINDOWVO:Class = ClanProfileMainWindowVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEPERSONNELVIEWVO:Class = ClanProfilePersonnelViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILEPROVINCEVO:Class = ClanProfileProvinceVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESELFPROVINCEVO:Class = ClanProfileSelfProvinceVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESTATSLINEVO:Class = ClanProfileStatsLineVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESUMMARYBLOCKVO:Class = ClanProfileSummaryBlockVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESUMMARYVIEWSTATUSVO:Class = ClanProfileSummaryViewStatusVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILESUMMARYVIEWVO:Class = ClanProfileSummaryViewVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_CLANPROFILETABLESTATISTICSDATAVO:Class = ClanProfileTableStatisticsDataVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VOS_GLOBALMAPSTATISTICSBODYVO:Class = GlobalMapStatisticsBodyVO;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CMP_BUILDINGSHAPE:Class = BuildingShape;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CMP_CLANPROFILEFORTSTATSGROUP:Class = ClanProfileFortStatsGroup;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CMP_CLANPROFILESUMMARYBLOCK:Class = ClanProfileSummaryBlock;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_CMP_TEXTFIELDFRAME:Class = TextFieldFrame;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_INTERFACES_ICLANPROFILEFORTIFICATIONTABVIEW:Class = IClanProfileFortificationTabView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_INTERFACES_ICLANPROFILEFORTIFICATIONTABBEDVIEW:Class = IClanProfileFortificationTabbedView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_INTERFACES_ICLANPROFILESUMMARYBLOCK:Class = IClanProfileSummaryBlock;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_INTERFACES_ITEXTFIELDFRAME:Class = ITextFieldFrame;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_RENDERERS_CLANPROFILEMEMBERITEMRENDERER:Class = ClanProfileMemberItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_RENDERERS_CLANPROFILEPROVINCEITEMRENDERER:Class = ClanProfileProvinceItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_RENDERERS_CLANPROFILESELFPROVINCEITEMRENDERER:Class = ClanProfileSelfProvinceItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEBASEVIEW:Class = ClanProfileBaseView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEFORTIFICATIONABSTRACTTABVIEW:Class = ClanProfileFortificationAbstractTabView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEFORTIFICATIONINFOVIEW:Class = ClanProfileFortificationInfoView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEFORTIFICATIONPROMOVIEW:Class = ClanProfileFortificationPromoView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEFORTIFICATIONSCHEMAVIEW:Class = ClanProfileFortificationSchemaView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEFORTIFICATIONSTATSVIEW:Class = ClanProfileFortificationStatsView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEFORTIFICATIONVIEW:Class = ClanProfileFortificationView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEGLOBALMAPINFOVIEW:Class = ClanProfileGlobalMapInfoView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEGLOBALMAPPROMOVIEW:Class = ClanProfileGlobalMapPromoView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEGLOBALMAPVIEW:Class = ClanProfileGlobalMapView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILEPERSONNELVIEW:Class = ClanProfilePersonnelView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILESUMMARYVIEW:Class = ClanProfileSummaryView;

    public static const NET_WG_GUI_LOBBY_CLANS_PROFILE_VIEWS_CLANPROFILETABLESTATISTICSVIEW:Class = ClanProfileTableStatisticsView;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_CLANSEARCHINFO:Class = ClanSearchInfo;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_CLANSEARCHITEMRENDERER:Class = ClanSearchItemRenderer;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_CLANSEARCHWINDOW:Class = ClanSearchWindow;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHINFODATAVO:Class = ClanSearchInfoDataVO;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHINFOINITDATAVO:Class = ClanSearchInfoInitDataVO;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHINFOSTATEDATAVO:Class = ClanSearchInfoStateDataVO;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHITEMVO:Class = ClanSearchItemVO;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHWINDOWINITDATAVO:Class = ClanSearchWindowInitDataVO;

    public static const NET_WG_GUI_LOBBY_CLANS_SEARCH_VOS_CLANSEARCHWINDOWSTATEDATAVO:Class = ClanSearchWindowStateDataVO;

    public static const NET_WG_GUI_LOBBY_CLANS_UTILS_CLANHELPER:Class = ClanHelper;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_AWARDWINDOWANIMATIONCONTROLLER:Class = AwardWindowAnimationController;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEAWARDWINDOWANIMATION:Class = BaseAwardWindowAnimation;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEAWARDSBLOCK:Class = BaseAwardsBlock;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BASEBOOSTERSLOT:Class = BaseBoosterSlot;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BOOSTERADDSLOT:Class = BoosterAddSlot;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BOOSTERSLOT:Class = BoosterSlot;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BOOSTERSPANEL:Class = BoostersPanel;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BUTTONFILTERS:Class = ButtonFilters;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_BUTTONFILTERSGROUP:Class = ButtonFiltersGroup;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATAVIEWSTACK:Class = DataViewStack;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSGROUPEX:Class = DetailedStatisticsGroupEx;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSROOTUNIT:Class = DetailedStatisticsRootUnit;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSUNIT:Class = DetailedStatisticsUnit;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DETAILEDSTATISTICSVIEW:Class = DetailedStatisticsView;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_EXPLOSIONAWARDWINDOWANIMATION:Class = ExplosionAwardWindowAnimation;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_EXPLOSIONAWARDWINDOWANIMATIONICON:Class = ExplosionAwardWindowAnimationIcon;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_HEADERBACKGROUND:Class = HeaderBackground;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_IRESIZABLECONTENT:Class = IResizableContent;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_ISTATISTICSBODYCONTAINERDATA:Class = IStatisticsBodyContainerData;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INFOMESSAGECOMPONENT:Class = InfoMessageComponent;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_PROFILEDASHLINETEXTITEM:Class = ProfileDashLineTextItem;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_PROGRESSINDICATOR:Class = ProgressIndicator;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_RESIZABLEVIEWSTACK:Class = ResizableViewStack;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_SMALLSKILLGROUPICONS:Class = SmallSkillGroupIcons;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_SMALLSKILLITEMRENDERER:Class = SmallSkillItemRenderer;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_SMALLSKILLSLIST:Class = SmallSkillsList;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_STATISTICSBODYCONTAINER:Class = StatisticsBodyContainer;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_STATISTICSDASHLINETEXTITEMIRENDERER:Class = StatisticsDashLineTextItemIRenderer;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_STOPPABLEANIMATIONLOADER:Class = StoppableAnimationLoader;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_VEHICLESELECTORFILTER:Class = VehicleSelectorFilter;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BASETANKMANVO:Class = BaseTankmanVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BOOSTERSLOTVO:Class = BoosterSlotVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BUTTONFILTERSITEMVO:Class = ButtonFiltersItemVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_BUTTONFILTERSVO:Class = ButtonFiltersVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_DETAILEDLABELDATAVO:Class = DetailedLabelDataVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_DETAILEDSTATISTICSLABELDATAVO:Class = DetailedStatisticsLabelDataVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_DETAILEDSTATISTICSUNITVO:Class = DetailedStatisticsUnitVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_INFOMESSAGEVO:Class = InfoMessageVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_SKILLSVO:Class = SkillsVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSBODYVO:Class = StatisticsBodyVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSLABELDATAVO:Class = StatisticsLabelDataVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSLABELLINKAGEDATAVO:Class = StatisticsLabelLinkageDataVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STATISTICSTOOLTIPDATAVO:Class = StatisticsTooltipDataVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_STOPPABLEANIMATIONLOADERVO:Class = StoppableAnimationLoaderVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_TRUNCATEDETAILEDSTATISTICSLABELDATAVO:Class = TruncateDetailedStatisticsLabelDataVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_VEHPARAMVO:Class = VehParamVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_DATA_VEHICLESELECTORFILTERVO:Class = VehicleSelectorFilterVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_BOOSTERPANELEVENT:Class = BoosterPanelEvent;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_FILTERSEVENT:Class = FiltersEvent;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_STOPPABLEANIMATIONLOADEREVENT:Class = StoppableAnimationLoaderEvent;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_EVENTS_VEHICLESELECTORFILTEREVENT:Class = VehicleSelectorFilterEvent;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IAWARDWINDOW:Class = IAwardWindow;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IAWARDWINDOWANIMATIONCONTROLLER:Class = IAwardWindowAnimationController;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IAWARDWINDOWANIMATIONWRAPPER:Class = IAwardWindowAnimationWrapper;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_IBOOSTERSLOT:Class = IBoosterSlot;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATION:Class = IStoppableAnimation;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATIONITEM:Class = IStoppableAnimationItem;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATIONLOADER:Class = IStoppableAnimationLoader;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATIONLOADERVO:Class = IStoppableAnimationLoaderVO;

    public static const NET_WG_GUI_LOBBY_COMPONENTS_INTERFACES_ISTOPPABLEANIMATIONVO:Class = IStoppableAnimationVO;

    public static const NET_WG_GUI_LOBBY_CONFIRMMODULEWINDOW_CONFIRMMODULEWINDOW:Class = ConfirmModuleWindow;

    public static const NET_WG_GUI_LOBBY_CONFIRMMODULEWINDOW_MODULEINFOVO:Class = ModuleInfoVo;

    public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DEMONSTRATORWINDOW:Class = DemonstratorWindow;

    public static const NET_WG_GUI_LOBBY_DEMONSTRATION_MAPITEMRENDERER:Class = MapItemRenderer;

    public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DATA_DEMONSTRATORVO:Class = DemonstratorVO;

    public static const NET_WG_GUI_LOBBY_DEMONSTRATION_DATA_MAPITEMVO:Class = MapItemVO;

    public static const NET_WG_GUI_LOBBY_DIALOGS_CHECKBOXDIALOG:Class = CheckBoxDialog;

    public static const NET_WG_GUI_LOBBY_DIALOGS_CONFIRMDIALOG:Class = ConfirmDialog;

    public static const NET_WG_GUI_LOBBY_DIALOGS_DEMOUNTDEVICEDIALOG:Class = DemountDeviceDialog;

    public static const NET_WG_GUI_LOBBY_DIALOGS_DESTROYDEVICEDIALOG:Class = DestroyDeviceDialog;

    public static const NET_WG_GUI_LOBBY_DIALOGS_FREEXPINFOWINDOW:Class = FreeXPInfoWindow;

    public static const NET_WG_GUI_LOBBY_DIALOGS_ICONDIALOG:Class = IconDialog;

    public static const NET_WG_GUI_LOBBY_DIALOGS_ICONPRICEDIALOG:Class = IconPriceDialog;

    public static const NET_WG_GUI_LOBBY_DIALOGS_PRICEMC:Class = PriceMc;

    public static const NET_WG_GUI_LOBBY_DIALOGS_TANKMANOPERATIONDIALOG:Class = TankmanOperationDialog;

    public static const NET_WG_GUI_LOBBY_DIALOGS_DATA_TANKMANOPERATIONDIALOGVO:Class = TankmanOperationDialogVO;

    public static const NET_WG_GUI_LOBBY_ELITEWINDOW_ELITEWINDOW:Class = EliteWindow;

    public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_EVENTINFOPANEL:Class = EventInfoPanel;

    public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_DATA_EVENTINFOPANELITEMVO:Class = EventInfoPanelItemVO;

    public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_DATA_EVENTINFOPANELVO:Class = EventInfoPanelVO;

    public static const NET_WG_GUI_LOBBY_EVENTINFOPANEL_INTERFACES_IEVENTINFOPANEL:Class = IEventInfoPanel;

    public static const NET_WG_GUI_LOBBY_FALLOUT_FALLOUTBATTLESELECTORWINDOW:Class = FalloutBattleSelectorWindow;

    public static const NET_WG_GUI_LOBBY_FALLOUT_DATA_FALLOUTBATTLESELECTORTOOLTIPVO:Class = FalloutBattleSelectorTooltipVO;

    public static const NET_WG_GUI_LOBBY_FALLOUT_DATA_SELECTORWINDOWBTNSTATESVO:Class = SelectorWindowBtnStatesVO;

    public static const NET_WG_GUI_LOBBY_FALLOUT_DATA_SELECTORWINDOWSTATICDATAVO:Class = SelectorWindowStaticDataVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_FORTBATTLEROOMWINDOW:Class = FortBattleRoomWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_FORTCHOICEDIVISIONWINDOW:Class = FortChoiceDivisionWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_FORTDISABLEDEFENCEPERIODWINDOW:Class = FortDisableDefencePeriodWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_FORTIFICATIONSVIEW:Class = FortificationsView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_IFORTWELCOMEINFOVIEW:Class = IFortWelcomeInfoView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_FORTBATTLEROOMSECTIONS:Class = FortBattleRoomSections;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_FORTBATTLEROOMWAITLISTSECTION:Class = FortBattleRoomWaitListSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_FORTINTROVIEW:Class = FortIntroView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_FORTLISTVIEW:Class = FortListView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_FORTROOMVIEW:Class = FortRoomView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_JOINSORTIEDETAILSSECTION:Class = JoinSortieDetailsSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_JOINSORTIEDETAILSSECTIONALERTVIEW:Class = JoinSortieDetailsSectionAlertView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_JOINSORTIESECTION:Class = JoinSortieSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_LEGIONARIESCANDIDATEITEMRENDERER:Class = LegionariesCandidateItemRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_LEGIONARIESDATAPROVIDER:Class = LegionariesDataProvider;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_LEGIONARIESSORTIESLOT:Class = LegionariesSortieSlot;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIECHATSECTION:Class = SortieChatSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIELISTRENDERER:Class = SortieListRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIESLOTHELPER:Class = SortieSlotHelper;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIETEAMSECTION:Class = SortieTeamSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_SORTIEWAITLISTSECTION:Class = SortieWaitListSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_ADVANCEDCLANBATTLETIMER:Class = AdvancedClanBattleTimer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_CLANBATTLECREATORVIEW:Class = ClanBattleCreatorView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_CLANBATTLETABLERENDERER:Class = ClanBattleTableRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_CLANBATTLETIMER:Class = ClanBattleTimer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_FORTCLANBATTLELIST:Class = FortClanBattleList;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_FORTCLANBATTLEROOM:Class = FortClanBattleRoom;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_FORTCLANBATTLETEAMSECTION:Class = FortClanBattleTeamSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_FORTLISTVIEWHELPER:Class = FortListViewHelper;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_BATTLEROOM_CLANBATTLE_JOINCLANBATTLESECTION:Class = JoinClanBattleSection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IFORTDISCONNECTVIEW:Class = IFortDisconnectView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IFORTMAINVIEW:Class = IFortMainView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IFORTWELCOMEVIEW:Class = IFortWelcomeView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BASE_IFILLEDBAR:Class = IFilledBar;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BASE_IMPL_FORTBUILDINGBASE:Class = FortBuildingBase;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BATTLERESULTS_FORTBATTLERESULTSTABLERENDERER:Class = FortBattleResultsTableRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BATTLEROOM_SORTIESIMPLESLOT:Class = SortieSimpleSlot;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BATTLEROOM_SORTIESLOT:Class = SortieSlot;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IBUILDINGINDICATOR:Class = IBuildingIndicator;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IBUILDINGINDICATORSCMP:Class = IBuildingIndicatorsCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IBUILDINGTEXTURE:Class = IBuildingTexture;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_ICOOLDOWNICON:Class = ICooldownIcon;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_ARROWWITHNUT:Class = ArrowWithNut;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_BUILDINGBLINKINGBTN:Class = BuildingBlinkingBtn;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_BUILDINGINDICATOR:Class = BuildingIndicator;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_BUILDINGINDICATORSCMP:Class = BuildingIndicatorsCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_BUILDINGORDERPROCESSING:Class = BuildingOrderProcessing;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_BUILDINGTEXTURE:Class = BuildingTexture;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_BUILDINGTHUMBNAIL:Class = BuildingThumbnail;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_COOLDOWNICON:Class = CooldownIcon;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_COOLDOWNICONLOADERCTNR:Class = CooldownIconLoaderCtnr;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_FORTBUILDING:Class = FortBuilding;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_FORTBUILDINGBTN:Class = FortBuildingBtn;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_FORTBUILDINGUIBASE:Class = FortBuildingUIBase;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_FORTBUILDINGSCONTAINER:Class = FortBuildingsContainer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_FORTBUILDINGSCONTAINERHELPER:Class = FortBuildingsContainerHelper;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_FORTLANDSCAPECMPNT:Class = FortLandscapeCmpnt;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_HITAREACONTROL:Class = HitAreaControl;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_INDICATORLABELS:Class = IndicatorLabels;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_MODERNIZATIONCMP:Class = ModernizationCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_ORDERINFOCMP:Class = OrderInfoCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_ORDERINFOICONCMP:Class = OrderInfoIconCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_PROGRESSTOTALLABELS:Class = ProgressTotalLabels;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_TROWELCMP:Class = TrowelCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_ANIMATIONIMPL_BUILDINGSANIMATIONCONTROLLER:Class = BuildingsAnimationController;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_ANIMATIONIMPL_DEMOUNTBUILDINGSANIMATION:Class = DemountBuildingsAnimation;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_ANIMATIONIMPL_FORTBUILDINGANIMATIONBASE:Class = FortBuildingAnimationBase;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILD_IMPL_BASE_BUILDINGSWIZARDCMPNT:Class = BuildingsWizardCmpnt;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILDINGPROCESS_IMPL_BUILDINGPROCESSINFO:Class = BuildingProcessInfo;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_BUILDINGPROCESS_IMPL_BUILDINGPROCESSITEMRENDERER:Class = BuildingProcessItemRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CALENDAR_IMPL_CALENDAREVENTLISTRENDERER:Class = CalendarEventListRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CALENDAR_IMPL_CALENDARPREVIEWBLOCK:Class = CalendarPreviewBlock;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLANLIST_CLANLISTITEMRENDERER:Class = ClanListItemRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLANSTATISTICS_IMPL_CLANSTATDASHLINETEXTITEM:Class = ClanStatDashLineTextItem;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLANSTATISTICS_IMPL_CLANSTATSGROUP:Class = ClanStatsGroup;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLANSTATISTICS_IMPL_FORTCLANSTATISTICBASEFORM:Class = FortClanStatisticBaseForm;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLANSTATISTICS_IMPL_FORTSTATISTICSLDIT:Class = FortStatisticsLDIT;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLANSTATISTICS_IMPL_PERIODDEFENCESTATISTICFORM:Class = PeriodDefenceStatisticForm;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLANSTATISTICS_IMPL_SORTIESTATISTICSFORM:Class = SortieStatisticsForm;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_CLAN_IMPL_CLANINFOCMP:Class = ClanInfoCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_COMBATRESERVESINTRO_COMBATRESERVESINTROITEM:Class = CombatReservesIntroItem;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DIVISION_IMPL_CHOICEDIVISIONSELECTOR:Class = ChoiceDivisionSelector;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IDIRECTIONCMP:Class = IDirectionCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IDIRECTIONLISTRENDERER:Class = IDirectionListRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IFORTBATTLENOTIFIER:Class = IFortBattleNotifier;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_ANIMATEDICON:Class = AnimatedIcon;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_BUILDINGATTACKINDICATOR:Class = BuildingAttackIndicator;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_BUILDINGDIRECTION:Class = BuildingDirection;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_CONNECTEDDIRCTNS:Class = ConnectedDirctns;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_DIRECTIONBUTTONRENDERER:Class = DirectionButtonRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_DIRECTIONCMP:Class = DirectionCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_DIRECTIONLISTRENDERER:Class = DirectionListRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_DIRECTIONRADIORENDERER:Class = DirectionRadioRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_FORTBATTLENOTIFIER:Class = FortBattleNotifier;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_DRCTN_IMPL_FORTDIRECTIONSCONTAINER:Class = FortDirectionsContainer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IMPL_FORTDISCONNECTVIEW:Class = FortDisconnectView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IMPL_FORTMAINVIEW:Class = FortMainView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IMPL_FORTWELCOMECOMMANDERCONTENT:Class = FortWelcomeCommanderContent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IMPL_FORTWELCOMECOMMANDERVIEW:Class = FortWelcomeCommanderView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IMPL_FORTWELCOMEINFOVIEW:Class = FortWelcomeInfoView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_IMPL_FORTWELCOMEVIEW:Class = FortWelcomeView;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IFORTHEADERCLANINFO:Class = IFortHeaderClanInfo;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IMAINFOOTER:Class = IMainFooter;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IMAINHEADER:Class = IMainHeader;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IMPL_FORTHEADERCLANINFO:Class = FortHeaderClanInfo;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IMPL_FORTMAINFOOTER:Class = FortMainFooter;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IMPL_FORTMAINHEADER:Class = FortMainHeader;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IMPL_FORTTIMEALERTICON:Class = FortTimeAlertIcon;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_MAIN_IMPL_VIGNETTEYELLOW:Class = VignetteYellow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_ORDERS_ICHECKBOXICON:Class = ICheckBoxIcon;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_ORDERS_IORDERSPANEL:Class = IOrdersPanel;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_ORDERS_IMPL_CHECKBOXICON:Class = CheckBoxIcon;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_ORDERS_IMPL_ORDERSPANEL:Class = OrdersPanel;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_CMP_TANKICON_IMPL_FORTTANKICON:Class = FortTankIcon;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEDIRECTIONPOPOVERVO:Class = BattleDirectionPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEDIRECTIONRENDERERVO:Class = BattleDirectionRendererVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLENOTIFIERVO:Class = BattleNotifierVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLENOTIFIERSDATAVO:Class = BattleNotifiersDataVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGCARDPOPOVERVO:Class = BuildingCardPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGINDICATORSVO:Class = BuildingIndicatorsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGMODERNIZATIONVO:Class = BuildingModernizationVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGPOPOVERACTIONVO:Class = BuildingPopoverActionVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGPOPOVERBASEVO:Class = BuildingPopoverBaseVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGPOPOVERHEADERVO:Class = BuildingPopoverHeaderVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGPROGRESSLBLVO:Class = BuildingProgressLblVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGVO:Class = BuildingVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGSCOMPONENTVO:Class = BuildingsComponentVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CHECKBOXICONVO:Class = CheckBoxIconVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CLANDESCRIPTIONVO:Class = ClanDescriptionVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CLANINFOVO:Class = ClanInfoVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CLANLISTRENDERERVO:Class = ClanListRendererVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CLANSTATITEMVO:Class = ClanStatItemVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CLANSTATSVO:Class = ClanStatsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_COMBATRESERVESINTROITEMVO:Class = CombatReservesIntroItemVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_COMBATRESERVESINTROVO:Class = CombatReservesIntroVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CONFIRMORDERVO:Class = ConfirmOrderVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_CONNECTEDDIRECTIONSVO:Class = ConnectedDirectionsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_DIRECTIONVO:Class = DirectionVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTBATTLETIMERVO:Class = FortBattleTimerVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTBUILDINGCONSTANTS:Class = FortBuildingConstants;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCALENDARDAYVO:Class = FortCalendarDayVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCALENDAREVENTVO:Class = FortCalendarEventVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCALENDARPREVIEWBLOCKVO:Class = FortCalendarPreviewBlockVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCHOICEDIVISIONSELECTORVO:Class = FortChoiceDivisionSelectorVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCHOICEDIVISIONVO:Class = FortChoiceDivisionVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCLANLISTWINDOWVO:Class = FortClanListWindowVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCLANMEMBERVO:Class = FortClanMemberVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCONSTANTS:Class = FortConstants;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTCURFEWTIMEVO:Class = FortCurfewTimeVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTFIXEDPLAYERSVO:Class = FortFixedPlayersVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTINTELFILTERVO:Class = FortIntelFilterVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTINVALIDATIONTYPE:Class = FortInvalidationType;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTMODEELEMENTPROPERTY:Class = FortModeElementProperty;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTMODESTATESTRINGSVO:Class = FortModeStateStringsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTMODESTATEVO:Class = FortModeStateVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTMODEVO:Class = FortModeVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTREGULATIONINFOVO:Class = FortRegulationInfoVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTWAITINGVO:Class = FortWaitingVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTWELCOMEVIEWVO:Class = FortWelcomeViewVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FORTIFICATIONVO:Class = FortificationVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_FUNCTIONALSTATES:Class = FunctionalStates;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_INTELLIGENCECLANFILTERVO:Class = IntelligenceClanFilterVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_INTELLIGENCERENDERERVO:Class = IntelligenceRendererVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_MODERNIZATIONCMPVO:Class = ModernizationCmpVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERINFOVO:Class = OrderInfoVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERPOPOVERVO:Class = OrderPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERSELECTPOPOVERVO:Class = OrderSelectPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERSELECTRENDERERVO:Class = OrderSelectRendererVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERVO:Class = OrderVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_PERIODDEFENCEINITVO:Class = PeriodDefenceInitVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_PERIODDEFENCEVO:Class = PeriodDefenceVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ROSTERINTROVO:Class = RosterIntroVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_TRANSPORTINGVO:Class = TransportingVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BASE_BASEFORTIFICATIONVO:Class = BaseFortificationVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BASE_BUILDINGBASEVO:Class = BuildingBaseVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLERESULTS_BATTLERESULTSRENDERERVO:Class = BattleResultsRendererVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLERESULTS_BATTLERESULTSVO:Class = net.wg.gui.lobby.fortifications.data.battleResults.BattleResultsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_INTROVIEWVO:Class = IntroViewVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_LEGIONARIESCANDIDATEVO:Class = LegionariesCandidateVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_LEGIONARIESSLOTSVO:Class = LegionariesSlotsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_LEGIONARIESSORTIEVO:Class = LegionariesSortieVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_SORTIEALERTVIEWVO:Class = SortieAlertViewVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_SORTIEVO:Class = SortieVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_CLANBATTLEDETAILSVO:Class = ClanBattleDetailsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_CLANBATTLELISTVO:Class = ClanBattleListVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_CLANBATTLERENDERLISTVO:Class = ClanBattleRenderListVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_CLANBATTLETIMERVO:Class = ClanBattleTimerVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BATTLEROOM_CLANBATTLE_FORTCLANBATTLEROOMVO:Class = FortClanBattleRoomVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGPROCESS_BUILDINGPROCESSINFOVO:Class = BuildingProcessInfoVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGPROCESS_BUILDINGPROCESSLISTITEMVO:Class = BuildingProcessListItemVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_BUILDINGPROCESS_BUILDINGPROCESSVO:Class = BuildingProcessVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_DEMOUNTBUILDING_FORTDEMOUNTBUILDINGVO:Class = FortDemountBuildingVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERINFO_FORTORDERINFOTITLEVO:Class = FortOrderInfoTitleVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERINFO_FORTORDERINFOWINDOWVO:Class = FortOrderInfoWindowVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_ORDERINFO_ORDERPARAMSVO:Class = OrderParamsVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_DAYOFFPOPOVERVO:Class = DayOffPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_DEFENCEHOURPOPOVERVO:Class = DefenceHourPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_DISABLEDEFENCEPERIODVO:Class = DisableDefencePeriodVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_FORTSETTINGSACTIVATEDVIEWVO:Class = FortSettingsActivatedViewVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_FORTSETTINGSBLOCKVO:Class = FortSettingsBlockVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_FORTSETTINGSCLANINFOVO:Class = FortSettingsClanInfoVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_FORTSETTINGSCONDITIONSBLOCKVO:Class = FortSettingsConditionsBlockVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_FORTSETTINGSNOTACTIVATEDVIEWVO:Class = FortSettingsNotActivatedViewVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_PERIPHERYCONTAINERVO:Class = PeripheryContainerVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_PERIPHERYPOPOVERVO:Class = PeripheryPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SETTINGS_VACATIONPOPOVERVO:Class = VacationPopoverVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_SORTIE_SORTIERENDERVO:Class = SortieRenderVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_DATA_TANKICON_FORTTANKICONVO:Class = FortTankIconVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_CLANBATTLETIMEREVENT:Class = ClanBattleTimerEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_DIRECTIONEVENT:Class = DirectionEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_FORTBATTLERESULTSEVENT:Class = FortBattleResultsEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_FORTBUILDINGANIMATIONEVENT:Class = FortBuildingAnimationEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_FORTBUILDINGCARDPOPOVEREVENT:Class = FortBuildingCardPopoverEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_FORTBUILDINGEVENT:Class = FortBuildingEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_FORTINTELCLANDESCRIPTIONEVENT:Class = FortIntelClanDescriptionEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_FORTSETTINGSEVENT:Class = FortSettingsEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_JOINFORTBATTLEEVENT:Class = JoinFortBattleEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_EVENTS_ORDERSELECTEVENT:Class = OrderSelectEvent;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_FORTINTELLIGENCECLANFILTERPOPOVER:Class = FortIntelligenceClanFilterPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_FORTINTELLIGENCEWINDOWHELPER:Class = FortIntelligenceWindowHelper;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IFORTINTELFILTER:Class = IFortIntelFilter;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_FORTINTELCLANDESCRIPTIONFOOTER:Class = FortIntelClanDescriptionFooter;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_FORTINTELCLANDESCRIPTIONHEADER:Class = FortIntelClanDescriptionHeader;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_FORTINTELCLANDESCRIPTIONLIT:Class = FortIntelClanDescriptionLIT;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_FORTINTELFILTER:Class = FortIntelFilter;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_FORTINTELLIGENCECLANDESCRIPTION:Class = FortIntelligenceClanDescription;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_FORTINTELLIGENCENOTAVAILABLEWINDOW:Class = FortIntelligenceNotAvailableWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_FORTINTELLIGENCEWINDOW:Class = FortIntelligenceWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTELLIGENCE_IMPL_CMP_INTELLIGENCERENDERER:Class = IntelligenceRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTERFACES_ICLANBATTLETIMER:Class = IClanBattleTimer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTERFACES_ICONSUMABLESORDERPARAMS:Class = IConsumablesOrderParams;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_INTERFACES_IFORTWELCOMEVIEWVO:Class = IFortWelcomeViewVO;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_ORDERINFO_CONSUMABLESORDERDESCRELEMENT:Class = ConsumablesOrderDescrElement;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_ORDERINFO_CONSUMABLESORDERINFOCMP:Class = ConsumablesOrderInfoCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_ORDERINFO_CONSUMABLESORDERVALUESELEMENT:Class = ConsumablesOrderValuesElement;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IBUILDINGCARDCMP:Class = IBuildingCardCmp;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_POPOVERWITHDROPDOWN:Class = PopoverWithDropdown;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_BATTLEDIRECTIONRENDERER:Class = BattleDirectionRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTBATTLEDIRECTIONPOPOVER:Class = FortBattleDirectionPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTBUILDINGCARDPOPOVER:Class = FortBuildingCardPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTDATEPICKERPOPOVER:Class = FortDatePickerPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTORDERPOPOVER:Class = FortOrderPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTORDERSELECTPOPOVER:Class = FortOrderSelectPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTPOPOVERASSIGNPLAYER:Class = FortPopoverAssignPlayer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTPOPOVERBODY:Class = FortPopoverBody;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTPOPOVERCONTROLPANEL:Class = FortPopoverControlPanel;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTPOPOVERHEADER:Class = FortPopoverHeader;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTSETTINGSDAYOFFPOPOVER:Class = FortSettingsDayoffPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTSETTINGSDEFENCEHOURPOPOVER:Class = FortSettingsDefenceHourPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTSETTINGSPERIPHERYPOPOVER:Class = FortSettingsPeripheryPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_FORTSETTINGSVACATIONPOPOVER:Class = FortSettingsVacationPopover;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_IMPL_POPOVERBUILDINGTEXTURE:Class = PopoverBuildingTexture;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_ORDERPOPOVER_ORDERINFOBLOCK:Class = OrderInfoBlock;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_POPOVERS_ORDERSELECTPOPOVER_ORDERSELECTRENDERER:Class = OrderSelectRenderer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_SETTINGS_IFORTSETTINGSACTIVATEDCONTAINER:Class = IFortSettingsActivatedContainer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_SETTINGS_IMPL_FORTSETTINGBLOCK:Class = FortSettingBlock;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_SETTINGS_IMPL_FORTSETTINGPERIPHERYCONTAINER:Class = FortSettingPeripheryContainer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_SETTINGS_IMPL_FORTSETTINGSACTIVATEDCONTAINER:Class = FortSettingsActivatedContainer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_SETTINGS_IMPL_FORTSETTINGSCLANINFO:Class = FortSettingsClanInfo;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_SETTINGS_IMPL_FORTSETTINGSCONDITIONSBLOCK:Class = FortSettingsConditionsBlock;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_SETTINGS_IMPL_FORTSETTINGSNOTACTIVATEDCONTAINER:Class = FortSettingsNotActivatedContainer;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_IFORTCOMMONUTILS:Class = IFortCommonUtils;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_IFORTMODESWITCHER:Class = IFortModeSwitcher;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_IFORTSCONTROLSALIGNER:Class = IFortsControlsAligner;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_ITRANSPORTINGHELPER:Class = ITransportingHelper;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_IMPL_FORTCOMMONUTILS:Class = FortCommonUtils;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_IMPL_FORTMODESWITCHER:Class = FortModeSwitcher;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_IMPL_FORTSCONTROLSALIGNER:Class = FortsControlsAligner;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_UTILS_IMPL_TRANSPORTINGHELPER:Class = TransportingHelper;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTBATTLERESULTSWINDOW:Class = FortBattleResultsWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTBUILDINGPROCESSWINDOW:Class = FortBuildingProcessWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTCALENDARWINDOW:Class = FortCalendarWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTCLANLISTWINDOW:Class = FortClanListWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTCLANSTATISTICSWINDOW:Class = FortClanStatisticsWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTCOMBATRESERVESINTROWINDOW:Class = FortCombatReservesIntroWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTCREATEDIRECTIONWINDOW:Class = FortCreateDirectionWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTCREATIONCONGRATULATIONSWINDOW:Class = FortCreationCongratulationsWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTDECLARATIONOFWARWINDOW:Class = FortDeclarationOfWarWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTDEMOUNTBUILDINGWINDOW:Class = FortDemountBuildingWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTFIXEDPLAYERSWINDOW:Class = FortFixedPlayersWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTMODERNIZATIONWINDOW:Class = FortModernizationWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTNOTCOMMANDERFIRSTENTERWINDOW:Class = FortNotCommanderFirstEnterWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTORDERCONFIRMATIONWINDOW:Class = FortOrderConfirmationWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTORDERINFOWINDOW:Class = FortOrderInfoWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTPERIODDEFENCEWINDOW:Class = FortPeriodDefenceWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTROSTERINTROWINDOW:Class = FortRosterIntroWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTSETTINGSWINDOW:Class = FortSettingsWindow;

    public static const NET_WG_GUI_LOBBY_FORTIFICATIONS_WINDOWS_FORTTRANSPORTCONFIRMATIONWINDOW:Class = FortTransportConfirmationWindow;

    public static const NET_WG_GUI_LOBBY_GOLDFISHEVENT_GOLDFISHWINDOW:Class = GoldFishWindow;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREWDROPDOWNEVENT:Class = CrewDropDownEvent;

    public static const NET_WG_GUI_LOBBY_HANGAR_HANGAR:Class = Hangar;

    public static const NET_WG_GUI_LOBBY_HANGAR_HANGARHEADER:Class = HangarHeader;

    public static const NET_WG_GUI_LOBBY_HANGAR_QUESTSCONTROL:Class = QuestsControl;

    public static const NET_WG_GUI_LOBBY_HANGAR_RESEARCHPANEL:Class = ResearchPanel;

    public static const NET_WG_GUI_LOBBY_HANGAR_SWITCHMODEPANEL:Class = SwitchModePanel;

    public static const NET_WG_GUI_LOBBY_HANGAR_TMENXPPANEL:Class = TmenXpPanel;

    public static const NET_WG_GUI_LOBBY_HANGAR_VEHICLEPARAMETERS:Class = VehicleParameters;

    public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_AMMUNITIONPANEL:Class = AmmunitionPanel;

    public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_EQUIPMENTSLOT:Class = EquipmentSlot;

    public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_IAMMUNITIONPANEL:Class = IAmmunitionPanel;

    public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_VEHICLESTATEMSG:Class = VehicleStateMsg;

    public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_DATA_SHELLBUTTONVO:Class = ShellButtonVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_DATA_VEHICLEMESSAGEVO:Class = VehicleMessageVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_AMMUNITIONPANEL_EVENTS_AMMUNITIONPANELEVENTS:Class = AmmunitionPanelEvents;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREW:Class = Crew;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWDOGITEM:Class = CrewDogItem;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWITEMLABEL:Class = CrewItemLabel;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWITEMRENDERER:Class = CrewItemRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_CREWSCROLLINGLIST:Class = CrewScrollingList;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_ICREW:Class = ICrew;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_ICONSPROPS:Class = IconsProps;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_RECRUITITEMRENDERER:Class = RecruitItemRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMANROLEVO:Class = TankmanRoleVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMANTEXTCREATOR:Class = TankmanTextCreator;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMANVO:Class = TankmanVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMENICONS:Class = TankmenIcons;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_TANKMENRESPONSEVO:Class = TankmenResponseVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_CREW_EV_CREWDOGEVENT:Class = CrewDogEvent;

    public static const NET_WG_GUI_LOBBY_HANGAR_DATA_HANGARHEADERVO:Class = HangarHeaderVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_DATA_MODULEINFOACTIONVO:Class = ModuleInfoActionVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_DATA_RESEARCHPANELVO:Class = ResearchPanelVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_DATA_SWITCHMODEPANELVO:Class = SwitchModePanelVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IHANGAR:Class = IHangar;

    public static const NET_WG_GUI_LOBBY_HANGAR_INTERFACES_IVEHICLEPARAMETERS:Class = IVehicleParameters;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EQUIPMENTITEM:Class = EquipmentItem;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EQUIPMENTLISTITEMRENDERER:Class = EquipmentListItemRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_FITTINGSELECTDROPDOWN:Class = FittingSelectDropDown;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_MAINTENANCEDROPDOWN:Class = MaintenanceDropDown;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_MAINTENANCESTATUSINDICATOR:Class = MaintenanceStatusIndicator;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_SHELLITEMRENDERER:Class = ShellItemRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_SHELLLISTITEMRENDERER:Class = ShellListItemRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_TECHNICALMAINTENANCE:Class = TechnicalMaintenance;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_HISTORICALAMMOVO:Class = HistoricalAmmoVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_MAINTENANCESHELLVO:Class = MaintenanceShellVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_MAINTENANCEVO:Class = MaintenanceVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_DATA_MODULEVO:Class = net.wg.gui.lobby.hangar.maintenance.data.ModuleVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_MAINTENANCE_EVENTS_ONEQUIPMENTRENDEREROVER:Class = OnEquipmentRendererOver;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_BASETANKICON:Class = BaseTankIcon;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_CLANLOCKUI:Class = ClanLockUI;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_FALLOUTTANKCAROUSEL:Class = FalloutTankCarousel;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_FALLOUTTANKCAROUSELITEMRENDERER:Class = FalloutTankCarouselItemRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_FILTERPOPOVERVIEW:Class = FilterPopoverView;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_ITANKCAROUSEL:Class = ITankCarousel;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_MULTISELECTIONINFOBLOCK:Class = MultiselectionInfoBlock;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_MULTISELECTIONSLOTRENDERER:Class = MultiselectionSlotRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_MULTISELECTIONSLOTS:Class = MultiselectionSlots;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_SMALLTANKICON:Class = SmallTankIcon;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSEL:Class = TankCarousel;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSELFILTERS:Class = TankCarouselFilters;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKCAROUSELITEMRENDERER:Class = TankCarouselItemRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKFILTERCOUNTER:Class = TankFilterCounter;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_TANKICON:Class = net.wg.gui.lobby.hangar.tcarousel.TankIcon;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_CONTROLS_CHECKBOXRENDERER:Class = CheckBoxRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_CONTROLS_COUNTERLABEL:Class = CounterLabel;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_CONTROLS_COUNTERTFCONTAINER:Class = CounterTFContainer;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_CONTROLS_TOGGLEIMAGEALPHARENDERER:Class = ToggleImageAlphaRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_CHECKBOXRENDERERVO:Class = CheckBoxRendererVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_FALLOUTVEHICLECAROUSELVO:Class = FalloutVehicleCarouselVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_FILTERCAROUSEINITVO:Class = FilterCarouseInitVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_FILTERCOMPONENTVIEWVO:Class = FilterComponentViewVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_FILTERSSTATEVO:Class = FiltersStateVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_MULTISELECTIONINFOVO:Class = MultiselectionInfoVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_MULTISELECTIONSLOTVO:Class = MultiselectionSlotVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_TANKCAROUSELFILTERINITVO:Class = TankCarouselFilterInitVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_TANKCAROUSELFILTERSELECTEDVO:Class = TankCarouselFilterSelectedVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_DATA_VEHICLECAROUSELVO:Class = VehicleCarouselVO;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_EVENT_SLOTEVENT:Class = SlotEvent;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_EVENT_TANKFILTERSEVENTS:Class = TankFiltersEvents;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_EVENT_TANKITEMEVENT:Class = TankItemEvent;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_HELPER_ITANKCAROUSELHELPER:Class = ITankCarouselHelper;

    public static const NET_WG_GUI_LOBBY_HANGAR_TCAROUSEL_HELPER_TANKCAROUSELSTATSFORMATTER:Class = TankCarouselStatsFormatter;

    public static const NET_WG_GUI_LOBBY_HANGAR_VEHICLEPARAMETERS_COMPONENTS_VEHPARAMRENDERER:Class = VehParamRenderer;

    public static const NET_WG_GUI_LOBBY_HANGAR_VEHICLEPARAMETERS_COMPONENTS_VEHPARAMRENDERERBASE:Class = VehParamRendererBase;

    public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTCLANPOPOVERBLOCK:Class = AccountClanPopoverBlock;

    public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVER:Class = AccountPopover;

    public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVERBLOCK:Class = AccountPopoverBlock;

    public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVERBLOCKBASE:Class = AccountPopoverBlockBase;

    public static const NET_WG_GUI_LOBBY_HEADER_ACCOUNTPOPOVERREFERRALBLOCK:Class = AccountPopoverReferralBlock;

    public static const NET_WG_GUI_LOBBY_HEADER_FIGHTBUTTON:Class = FightButton;

    public static const NET_WG_GUI_LOBBY_HEADER_IACCOUNTCLANPOPOVERBLOCK:Class = IAccountClanPopOverBlock;

    public static const NET_WG_GUI_LOBBY_HEADER_LOBBYHEADER:Class = LobbyHeader;

    public static const NET_WG_GUI_LOBBY_HEADER_ONLINECOUNTER:Class = OnlineCounter;

    public static const NET_WG_GUI_LOBBY_HEADER_TANKPANEL:Class = TankPanel;

    public static const NET_WG_GUI_LOBBY_HEADER_EVENTS_ACCOUNTPOPOVEREVENT:Class = AccountPopoverEvent;

    public static const NET_WG_GUI_LOBBY_HEADER_EVENTS_BATTLETYPESELECTOREVENT:Class = BattleTypeSelectorEvent;

    public static const NET_WG_GUI_LOBBY_HEADER_EVENTS_HEADEREVENTS:Class = HeaderEvents;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_ACCOUNT:Class = HBC_Account;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_ACCOUNTUPPER:Class = HBC_AccountUpper;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_ACTIONITEM:Class = HBC_ActionItem;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_ARROWDOWN:Class = HBC_ArrowDown;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_BATTLESELECTOR:Class = HBC_BattleSelector;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_FINANCE:Class = HBC_Finance;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_PREM:Class = HBC_Prem;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_PREMSHOP:Class = HBC_PremShop;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_SETTINGS:Class = HBC_Settings;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_SQUAD:Class = HBC_Squad;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HBC_UPPER:Class = HBC_Upper;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTON:Class = HeaderButton;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONACTIONCONTENT:Class = HeaderButtonActionContent;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONBAR:Class = HeaderButtonBar;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONCONTENTITEM:Class = HeaderButtonContentItem;

    public static const NET_WG_GUI_LOBBY_HEADER_HEADERBUTTONBAR_HEADERBUTTONSHELPER:Class = HeaderButtonsHelper;

    public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_BATTLETYPESELECTPOPOVERDEMONSTRATOR:Class = BattleTypeSelectPopoverDemonstrator;

    public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORLIST:Class = ItemSelectorList;

    public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORPOPOVER:Class = ItemSelectorPopover;

    public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORRENDERER:Class = ItemSelectorRenderer;

    public static const NET_WG_GUI_LOBBY_HEADER_ITEMSELECTORPOPOVER_ITEMSELECTORRENDERERVO:Class = ItemSelectorRendererVO;

    public static const NET_WG_GUI_LOBBY_HEADER_MAINMENUBUTTONBAR_MAINMENUBUTTONBAR:Class = MainMenuButtonBar;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTCLANPOPOVERBLOCKVO:Class = AccountClanPopoverBlockVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTDATAVO:Class = AccountDataVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTPOPOVERBLOCKVO:Class = AccountPopoverBlockVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTPOPOVERMAINVO:Class = AccountPopoverMainVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_ACCOUNTPOPOVERREFERRALBLOCKVO:Class = AccountPopoverReferralBlockVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_ABSTRACTVO:Class = HBC_AbstractVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_ACCOUNTDATAVO:Class = HBC_AccountDataVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_BATTLETYPEVO:Class = HBC_BattleTypeVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_FINANCEVO:Class = HBC_FinanceVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_PREMDATAVO:Class = HBC_PremDataVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_PREMSHOPVO:Class = HBC_PremShopVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_SETTINGSVO:Class = HBC_SettingsVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HBC_SQUADDATAVO:Class = HBC_SquadDataVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HANGARMENUTABITEMVO:Class = HangarMenuTabItemVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HANGARMENUVO:Class = HangarMenuVO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_HEADERBUTTONVO:Class = HeaderButtonVo;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_IHBC_VO:Class = IHBC_VO;

    public static const NET_WG_GUI_LOBBY_HEADER_VO_QUESTSCONTROLBTNVO:Class = QuestsControlBtnVO;

    public static const NET_WG_GUI_LOBBY_INTERFACES_ISUBTASKCOMPONENT:Class = ISubtaskComponent;

    public static const NET_WG_GUI_LOBBY_INVITES_SENDINVITESWINDOW:Class = SendInvitesWindow;

    public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_CANDIDATESLIST:Class = CandidatesList;

    public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_CANDIDATESLISTITEMRENDERER:Class = CandidatesListItemRenderer;

    public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_SEARCHLISTDRAGCONTROLLER:Class = SearchListDragController;

    public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_SEARCHLISTDROPDELEGATE:Class = SearchListDropDelegate;

    public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_TREEDRAGCONTROLLER:Class = TreeDragController;

    public static const NET_WG_GUI_LOBBY_INVITES_CONTROLS_TREEDROPDELEGATE:Class = TreeDropDelegate;

    public static const NET_WG_GUI_LOBBY_MENU_LOBBYMENU:Class = LobbyMenu;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_BUTTONWITHCOUNTER:Class = ButtonWithCounter;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSEGERBARINITVO:Class = MessegerBarInitVO;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSENGERBAR:Class = MessengerBar;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSENGERCHANNELCAROUSELITEM:Class = MessengerChannelCarouselItem;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_MESSENGERICONBUTTON:Class = MessengerIconButton;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_NOTIFICATIONLISTBUTTON:Class = NotificationListButton;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_PREBATTLECHANNELCAROUSELITEM:Class = PrebattleChannelCarouselItem;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_WINDOWGEOMETRYINBAR:Class = WindowGeometryInBar;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_WINDOWOFFSETSINBAR:Class = WindowOffsetsInBar;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_BASECHANNELCAROUSELITEM:Class = BaseChannelCarouselItem;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_BASECHANNELRENDERER:Class = BaseChannelRenderer;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELBUTTON:Class = ChannelButton;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELCAROUSEL:Class = ChannelCarousel;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELCAROUSELSCROLLBAR:Class = ChannelCarouselScrollBar;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELLIST:Class = ChannelList;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_CHANNELRENDERER:Class = ChannelRenderer;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_FLEXIBLETILELIST:Class = FlexibleTileList;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_PREBATTLECHANNELRENDERER:Class = PreBattleChannelRenderer;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_CHANNELLISTITEMVO:Class = ChannelListItemVO;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_ITOOLTIPDATA:Class = IToolTipData;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_MESSENGERBARCONSTANTS:Class = MessengerBarConstants;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_READYDATAVO:Class = ReadyDataVO;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_DATA_TOOLTIPDATAVO:Class = TooltipDataVO;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_EVENTS_CHANNELLISTEVENT:Class = ChannelListEvent;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_CAROUSEL_EVENTS_MESSENGERBARCHANNELCAROUSELEVENT:Class = MessengerBarChannelCarouselEvent;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_INTERFACES_IBASECHANNELCAROUSELITEM:Class = IBaseChannelCarouselItem;

    public static const NET_WG_GUI_LOBBY_MESSENGERBAR_INTERFACES_INOTIFICATIONLISTBUTTON:Class = INotificationListButton;

    public static const NET_WG_GUI_LOBBY_MODULEINFO_MODULEEFFECTS:Class = ModuleEffects;

    public static const NET_WG_GUI_LOBBY_MODULEINFO_MODULEPARAMETERS:Class = ModuleParameters;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_FITTINGSELECTPOPOVER:Class = FittingSelectPopover;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_MODULESPANEL:Class = ModulesPanel;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_DEVICESLOT:Class = DeviceSlot;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_EXTRAICON:Class = ExtraIcon;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_FITTINGLISTITEMRENDERER:Class = FittingListItemRenderer;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_FITTINGLISTSELECTIONNAVIGATOR:Class = FittingListSelectionNavigator;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_MODULEFITTINGITEMRENDERER:Class = ModuleFittingItemRenderer;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_MODULESLOT:Class = ModuleSlot;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_COMPONENTS_OPTDEVICEFITTINGITEMRENDERER:Class = OptDeviceFittingItemRenderer;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_DEVICESLOTVO:Class = DeviceSlotVO;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_DEVICEVO:Class = DeviceVO;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_DEVICESDATAVO:Class = DevicesDataVO;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_FITTINGSELECTPOPOVERPARAMS:Class = FittingSelectPopoverParams;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_FITTINGSELECTPOPOVERVO:Class = FittingSelectPopoverVO;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_MODULEVO:Class = net.wg.gui.lobby.modulesPanel.data.ModuleVO;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_DATA_OPTIONALDEVICEVO:Class = OptionalDeviceVO;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_INTERFACES_IDEVICESLOT:Class = IDeviceSlot;

    public static const NET_WG_GUI_LOBBY_MODULESPANEL_INTERFACES_IMODULESPANEL:Class = IModulesPanel;

    public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_PREMIUMBODY:Class = PremiumBody;

    public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_PREMIUMITEMRENDERER:Class = PremiumItemRenderer;

    public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_PREMIUMWINDOW:Class = PremiumWindow;

    public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_DATA_PREMIUMITEMRENDERERVO:Class = PremiumItemRendererVo;

    public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_DATA_PREMIUMWINDOWRATESVO:Class = PremiumWindowRatesVO;

    public static const NET_WG_GUI_LOBBY_PREMIUMWINDOW_EVENTS_PREMIUMWINDOWEVENT:Class = PremiumWindowEvent;

    public static const NET_WG_GUI_LOBBY_PROFILE_LINKAGEUTILS:Class = LinkageUtils;

    public static const NET_WG_GUI_LOBBY_PROFILE_PROFILE:Class = Profile;

    public static const NET_WG_GUI_LOBBY_PROFILE_PROFILECONSTANTS:Class = ProfileConstants;

    public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEINVALIDATIONTYPES:Class = ProfileInvalidationTypes;

    public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEMENUINFOVO:Class = ProfileMenuInfoVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PROFILEOPENINFOEVENT:Class = ProfileOpenInfoEvent;

    public static const NET_WG_GUI_LOBBY_PROFILE_PROFILETABNAVIGATOR:Class = ProfileTabNavigator;

    public static const NET_WG_GUI_LOBBY_PROFILE_SECTIONINFO:Class = SectionInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_SECTIONVIEWINFO:Class = SectionViewInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_USERINFOFORM:Class = UserInfoForm;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_AWARDSTILELISTBLOCK:Class = AwardsTileListBlock;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_BATTLESTYPEDROPDOWN:Class = BattlesTypeDropdown;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CENTEREDLINEICONTEXT:Class = CenteredLineIconText;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_COLOREDDESHLINETEXTITEM:Class = ColoredDeshLineTextItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_GRADIENTLINEBUTTONBAR:Class = GradientLineButtonBar;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_HIDABLESCROLLBAR:Class = HidableScrollBar;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_ICOUNTER:Class = ICounter;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITBATTLES:Class = LditBattles;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITMARKSOFMASTERY:Class = LditMarksOfMastery;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LDITVALUED:Class = LditValued;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINEBUTTONBAR:Class = LineButtonBar;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_LINETEXTCOMPONENT:Class = LineTextComponent;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PERSONALSCORECOMPONENT:Class = PersonalScoreComponent;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEFOOTER:Class = ProfileFooter;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEGROUPBLOCK:Class = ProfileGroupBlock;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEMEDALSLIST:Class = ProfileMedalsList;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEPAGEFOOTER:Class = ProfilePageFooter;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_PROFILEWINDOWFOOTER:Class = ProfileWindowFooter;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLECONTENT:Class = ResizableContent;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_RESIZABLEINVALIDATIONTYPES:Class = ResizableInvalidationTypes;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_SIMPLELOADER:Class = SimpleLoader;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_TECHMASTERYICON:Class = TechMasteryIcon;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_TESTTRACK:Class = TestTrack;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_AXISCHART:Class = AxisChart;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_BARITEM:Class = BarItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_CHARTBASE:Class = ChartBase;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_CHARTITEM:Class = ChartItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_CHARTITEMBASE:Class = ChartItemBase;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_FRAMECHARTITEM:Class = FrameChartItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_ICHARTITEM:Class = IChartItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_AXIS_AXISBASE:Class = AxisBase;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_AXIS_ICHARTAXIS:Class = IChartAxis;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_LAYOUT_ICHARTLAYOUT:Class = IChartLayout;

    public static const NET_WG_GUI_LOBBY_PROFILE_COMPONENTS_CHART_LAYOUT_LAYOUTBASE:Class = LayoutBase;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_LAYOUTITEMINFO:Class = LayoutItemInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEBASEINFOVO:Class = ProfileBaseInfoVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEBATTLETYPEINITVO:Class = ProfileBattleTypeInitVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILECOMMONINFOVO:Class = ProfileCommonInfoVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEDOSSIERINFOVO:Class = ProfileDossierInfoVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEGROUPBLOCKVO:Class = ProfileGroupBlockVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_PROFILEUSERVO:Class = ProfileUserVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_DATA_SECTIONLAYOUTMANAGER:Class = SectionLayoutManager;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_PROFILEACHIEVEMENTSSECTION:Class = ProfileAchievementsSection;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_PROFILESECTION:Class = ProfileSection;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_PROFILETABINFO:Class = ProfiletabInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SECTIONSSHOWANIMATIONMANAGER:Class = SectionsShowAnimationManager;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_AWARDSBLOCK:Class = AwardsBlock;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_AWARDSMAINCONTAINER:Class = AwardsMainContainer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_PROFILEAWARDS:Class = ProfileAwards;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_STAGEAWARDSBLOCK:Class = StageAwardsBlock;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_ACHIEVEMENTFILTERVO:Class = AchievementFilterVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_AWARDSBLOCKDATAVO:Class = AwardsBlockDataVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_PROFILEAWARDSINITVO:Class = ProfileAwardsInitVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_AWARDS_DATA_RECEIVEDRAREVO:Class = ReceivedRareVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_CLANINFO:Class = ClanInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_ERRORINFO:Class = ErrorInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_FORMATIONHEADER:Class = FormationHeader;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_FORMATIONINFOABSTRACT:Class = FormationInfoAbstract;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_FORTINFO:Class = FortInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_LINKNAVIGATIONEVENT:Class = LinkNavigationEvent;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_NOCLAN:Class = NoClan;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_PREVIOUSTEAMRENDERER:Class = PreviousTeamRenderer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_PROFILEFORMATIONSPAGE:Class = ProfileFormationsPage;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_SHOWTEAMEVENT:Class = ShowTeamEvent;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_TEAMINFO:Class = TeamInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_FORMATIONHEADERVO:Class = FormationHeaderVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_FORMATIONSTATVO:Class = FormationStatVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_PREVIOUSTEAMSITEMVO:Class = PreviousTeamsItemVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_FORMATIONS_DATA_PROFILEFORMATIONSVO:Class = ProfileFormationsVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_LEVELBARCHARTITEM:Class = LevelBarChartItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_NATIONBARCHARTITEM:Class = NationBarChartItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICS:Class = ProfileStatistics;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICSBODYVO:Class = ProfileStatisticsBodyVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_PROFILESTATISTICSVO:Class = ProfileStatisticsVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTAXISPOINT:Class = StatisticBarChartAxisPoint;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTINITIALIZER:Class = StatisticBarChartInitializer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTITEM:Class = StatisticBarChartItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICBARCHARTLAYOUT:Class = StatisticBarChartLayout;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICCHARTINFO:Class = StatisticChartInfo;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSBARCHART:Class = StatisticsBarChart;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSBARCHARTAXIS:Class = StatisticsBarChartAxis;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSCHARTITEMANIMCLIENT:Class = StatisticsChartItemAnimClient;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_STATISTICSLAYOUTMANAGER:Class = StatisticsLayoutManager;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_TFCONTAINER:Class = TfContainer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_TYPEBARCHARTITEM:Class = TypeBarChartItem;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_CHARTSSTATISTICSGROUP:Class = ChartsStatisticsGroup;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_CHARTSSTATISTICSVIEW:Class = ChartsStatisticsView;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_PROFILESTATISTICSDETAILEDVO:Class = ProfileStatisticsDetailedVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_BODY_STATISTICSCHARTSTABDATAVO:Class = StatisticsChartsTabDataVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_HEADERBGIMAGE:Class = HeaderBGImage;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_HEADERCONTAINER:Class = HeaderContainer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_STATISTICS_HEADER_STATISTICSHEADERVO:Class = StatisticsHeaderVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_AWARDSLISTCOMPONENT:Class = AwardsListComponent;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_LINETEXTFIELDSLAYOUT:Class = LineTextFieldsLayout;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARY:Class = ProfileSummary;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYPAGE:Class = ProfileSummaryPage;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYVO:Class = ProfileSummaryVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_PROFILESUMMARYWINDOW:Class = ProfileSummaryWindow;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYCOMMONSCORESVO:Class = SummaryCommonScoresVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYINITVO:Class = SummaryInitVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYPAGEINITVO:Class = SummaryPageInitVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_SUMMARY_SUMMARYVIEWVO:Class = SummaryViewVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_ACHIEVEMENTSMALL:Class = AchievementSmall;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILESORTINGBUTTON:Class = ProfileSortingButton;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUE:Class = ProfileTechnique;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEEMPTYSCREEN:Class = ProfileTechniqueEmptyScreen;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEPAGE:Class = ProfileTechniquePage;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_PROFILETECHNIQUEWINDOW:Class = ProfileTechniqueWindow;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHAWARDSMAINCONTAINER:Class = TechAwardsMainContainer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHDETAILEDUNITGROUP:Class = TechDetailedUnitGroup;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHSTATISTICSINITVO:Class = TechStatisticsInitVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHSTATISTICSPAGEINITVO:Class = TechStatisticsPageInitVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNICSDASHLINETEXTITEMIRENDERER:Class = TechnicsDashLineTextItemIRenderer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUEACHIEVEMENTTAB:Class = TechniqueAchievementTab;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUEACHIEVEMENTSBLOCK:Class = TechniqueAchievementsBlock;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUELIST:Class = TechniqueList;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUELISTCOMPONENT:Class = TechniqueListComponent;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUERENDERER:Class = TechniqueRenderer;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUESTACKCOMPONENT:Class = TechniqueStackComponent;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_TECHNIQUESTATISTICTAB:Class = TechniqueStatisticTab;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_PROFILEVEHICLEDOSSIERVO:Class = ProfileVehicleDossierVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_SORTINGSETTINGVO:Class = SortingSettingVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_TECHNIQUELISTVEHICLEVO:Class = TechniqueListVehicleVO;

    public static const NET_WG_GUI_LOBBY_PROFILE_PAGES_TECHNIQUE_DATA_TECHNIQUESTATISTICVO:Class = TechniqueStatisticVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_CONDITIONBLOCK:Class = ConditionBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_CONDITIONELEMENT:Class = ConditionElement;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DESCRIPTIONBLOCK:Class = DescriptionBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_HEADERBLOCK:Class = HeaderBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_IQUESTSTAB:Class = IQuestsTab;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_ISUBTASKLISTLINKAGESELECTOR:Class = ISubtaskListLinkageSelector;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTAWARDSBLOCK:Class = QuestAwardsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTBATTLETASKRENDERER:Class = QuestBattleTaskRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTBLOCK:Class = QuestBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTCAROUSELAWARDSBLOCK:Class = QuestCarouselAwardsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTCONTENT:Class = QuestContent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTDETAILSSEPARATORBLOCK:Class = QuestDetailsSeparatorBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTDETAILSSPACINGBLOCK:Class = QuestDetailsSpacingBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTLISTSELECTIONNAVIGATOR:Class = QuestListSelectionNavigator;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTRENDERER:Class = QuestRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTWINDOWUTILS:Class = QuestWindowUtils;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSBASETAB:Class = QuestsBaseTab;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSBEGINNERTAB:Class = QuestsBeginnerTab;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSCURRENTTAB:Class = QuestsCurrentTab;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSFUTURETAB:Class = QuestsFutureTab;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSLIST:Class = QuestsList;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSTASKSNAVIGATOR:Class = QuestsTasksNavigator;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_QUESTSWINDOW:Class = QuestsWindow;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_REQUIREMENTBLOCK:Class = RequirementBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_SUBTASKCOMPONENT:Class = SubtaskComponent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_SUBTASKSLIST:Class = SubtasksList;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_VEHICLEBLOCK:Class = VehicleBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ABSTRACTRESIZABLECONTENT:Class = AbstractResizableContent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ALERTMESSAGE:Class = net.wg.gui.lobby.questsWindow.components.AlertMessage;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_ANIMRESIZABLECONTENT:Class = AnimResizableContent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_BASERESIZABLECONTENTHEADER:Class = BaseResizableContentHeader;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_COMMONCONDITIONSBLOCK:Class = CommonConditionsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CONDITIONSEPARATOR:Class = ConditionSeparator;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CONDITIONSGROUP:Class = ConditionsGroup;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_COUNTERTEXTELEMENT:Class = CounterTextElement;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CUSTOMIZATIONITEMRENDERER:Class = CustomizationItemRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_CUSTOMIZATIONSBLOCK:Class = CustomizationsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_EVENTSRESIZABLECONTENT:Class = EventsResizableContent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INNERRESIZABLECONTENT:Class = InnerResizableContent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_MOVABLEBLOCKSCONTAINER:Class = MovableBlocksContainer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_PROGRESSBLOCK:Class = ProgressBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTICONAWARDSBLOCK:Class = QuestIconAwardsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTICONELEMENT:Class = QuestIconElement;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSTATUSCOMPONENT:Class = QuestStatusComponent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTTEXTAWARDBLOCK:Class = QuestTextAwardBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSCOUNTER:Class = QuestsCounter;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_QUESTSDASHLINEITEM:Class = QuestsDashlineItem;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_RESIZABLECONTAINER:Class = ResizableContainer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_RESIZABLECONTENTHEADER:Class = ResizableContentHeader;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_SORTINGPANEL:Class = SortingPanel;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TEXTFIELDMESSAGECOMPONENT:Class = TextFieldMessageComponent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TEXTPROGRESSELEMENT:Class = TextProgressElement;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TREEHEADER:Class = TreeHeader;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TUTORIALHANGARDETAILSBLOCK:Class = TutorialHangarDetailsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TUTORIALHANGARMOTIVEDETAILSBLOCK:Class = TutorialHangarMotiveDetailsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TUTORIALHANGARQUESTDETAILSBASE:Class = TutorialHangarQuestDetailsBase;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TUTORIALMOTIVEQUESTDESCRIPTIONCONTAINER:Class = TutorialMotiveQuestDescriptionContainer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TUTORIALQUESTCONDITIONRENDERER:Class = TutorialQuestConditionRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_TUTORIALQUESTDESCRIPTIONCONTAINER:Class = TutorialQuestDescriptionContainer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLEBONUSTEXTELEMENT:Class = VehicleBonusTextElement;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLEITEMRENDERER:Class = VehicleItemRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_VEHICLESSORTINGBLOCK:Class = VehiclesSortingBlock;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_IBEGINNERQUESTDETAILS:Class = IBeginnerQuestDetails;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_ICOMPLEXVIEWSTACKITEM:Class = IComplexViewStackItem;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_ICONDITIONRENDERER:Class = IConditionRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_IQUESTSCURRENTTABDAAPI:Class = IQuestsCurrentTabDAAPI;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_IQUESTSWINDOW:Class = IQuestsWindow;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_IRESIZABLECONTENT:Class = net.wg.gui.lobby.questsWindow.components.interfaces.IResizableContent;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_COMPONENTS_INTERFACES_ITUTORIALHANGARQUESTDETAILS:Class = ITutorialHangarQuestDetails;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_BASERESIZABLECONTENTVO:Class = BaseResizableContentVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_COMPLEXTOOLTIPVO:Class = ComplexTooltipVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_CONDITIONELEMENTVO:Class = ConditionElementVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_CONDITIONSEPARATORVO:Class = ConditionSeparatorVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_COUNTERTEXTELEMENTVO:Class = CounterTextElementVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_DESCRIPTIONVO:Class = DescriptionVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_EVENTSRESIZABLECONTENTVO:Class = EventsResizableContentVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_HEADERDATAVO:Class = HeaderDataVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_INFODATAVO:Class = InfoDataVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_PADDINGSVO:Class = PaddingsVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_PERSONALINFOVO:Class = PersonalInfoVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_PROGRESSBLOCKVO:Class = ProgressBlockVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDASHLINEITEMVO:Class = QuestDashlineItemVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDATAVO:Class = QuestDataVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDETAILSSEPARATORVO:Class = QuestDetailsSeparatorVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDETAILSSPACINGVO:Class = QuestDetailsSpacingVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTDETAILSVO:Class = QuestDetailsVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTICONAWARDSBLOCKVO:Class = QuestIconAwardsBlockVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTICONELEMENTVO:Class = QuestIconElementVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTRENDERERVO:Class = QuestRendererVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTVEHICLERENDERERVO:Class = QuestVehicleRendererVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_QUESTSDATAVO:Class = QuestsDataVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_REQUIREMENTBLOCKVO:Class = RequirementBlockVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_SORTEDBTNVO:Class = SortedBtnVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_SUBTASKVO:Class = SubtaskVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TEXTBLOCKVO:Class = TextBlockVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TREECONTENTVO:Class = TreeContentVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TUTORIALHANGARQUESTDETAILSVO:Class = TutorialHangarQuestDetailsVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TUTORIALQUESTCONDITIONRENDERERVO:Class = TutorialQuestConditionRendererVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_TUTORIALQUESTDESCVO:Class = TutorialQuestDescVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLEBLOCKVO:Class = VehicleBlockVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLEBONUSTEXTELEMENTVO:Class = VehicleBonusTextElementVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_DATA_VEHICLESSORTINGBLOCKVO:Class = VehiclesSortingBlockVO;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_EVENTS_IQUESTRENDERER:Class = IQuestRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTSWINDOW_EVENTS_TUTORIALQUESTCONDITIONEVENT:Class = TutorialQuestConditionEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_AWARDCAROUSEL:Class = AwardCarousel;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_BASEQUESTSPROGRESS:Class = BaseQuestsProgress;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_ICONTITLEDESCSEASONAWARD:Class = IconTitleDescSeasonAward;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTSLOTRENDERER:Class = QuestSlotRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTTASKDESCRIPTION:Class = QuestTaskDescription;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTTASKLISTSELECTIONNAVIGATOR:Class = QuestTaskListSelectionNavigator;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTTILERENDERER:Class = QuestTileRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTSCONTENTTABS:Class = QuestsContentTabs;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTSPROGRESS:Class = QuestsProgress;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTSPROGRESSFALLOUT:Class = QuestsProgressFallout;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTSTILECHAINSVIEWFILTERS:Class = QuestsTileChainsViewFilters;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_QUESTSTILECHAINSVIEWHEADER:Class = QuestsTileChainsViewHeader;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RADIOBUTTONSCROLLBAR:Class = RadioButtonScrollBar;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SEASONAWARDSLIST:Class = SeasonAwardsList;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SEASONVIEWRENDERER:Class = SeasonViewRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SEASONSLISTVIEW:Class = SeasonsListView;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SLOTSGROUP:Class = SlotsGroup;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SLOTSLAYOUT:Class = SlotsLayout;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_SLOTSPANEL:Class = SlotsPanel;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_TASKAWARDSBLOCK:Class = TaskAwardsBlock;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_TEXTBLOCKWELCOMEVIEW:Class = TextBlockWelcomeView;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_VEHICLESEASONAWARD:Class = VehicleSeasonAward;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_IQUESTSLOTRENDERER:Class = IQuestSlotRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_IQUESTSPERSONALWELCOMEVIEW:Class = IQuestsPersonalWelcomeView;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_IQUESTSSEASONSVIEW:Class = IQuestsSeasonsView;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_IQUESTSTILECHAINSVIEW:Class = IQuestsTileChainsView;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_ITASKAWARDITEMRENDERER:Class = ITaskAwardItemRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_ITASKSPROGRESSCOMPONENT:Class = ITasksProgressComponent;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_INTERFACES_ITEXTBLOCKWELCOMEVIEW:Class = ITextBlockWelcomeView;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RENDERERS_AWARDCAROUSELITEMRENDERER:Class = AwardCarouselItemRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RENDERERS_ISEASONAWARDLISTRENDERER:Class = ISeasonAwardListRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RENDERERS_QUESTTASKLISTITEMRENDERER:Class = QuestTaskListItemRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RENDERERS_SEASONAWARDLISTRENDERER:Class = SeasonAwardListRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_COMPONENTS_RENDERERS_TASKAWARDITEMRENDERER:Class = TaskAwardItemRenderer;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_AWARDCAROUSELITEMRENDERERVO:Class = AwardCarouselItemRendererVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_CHAINPROGRESSITEMVO:Class = ChainProgressItemVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_CHAINPROGRESSVO:Class = ChainProgressVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSLOTVO:Class = QuestSlotVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSLOTSDATAVO:Class = QuestSlotsDataVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSSEASONSVIEWVO:Class = QuestsSeasonsViewVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONTILEVO:Class = SeasonTileVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONVO:Class = SeasonVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONSDATAVO:Class = SeasonsDataVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTCHAINVO:Class = QuestChainVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTTASKDETAILSVO:Class = QuestTaskDetailsVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTTASKLISTRENDERERVO:Class = QuestTaskListRendererVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTTASKVO:Class = QuestTaskVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTTILESTATISTICSVO:Class = QuestTileStatisticsVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTTILEVO:Class = QuestTileVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTSTILECHAINSVIEWFILTERSVO:Class = QuestsTileChainsViewFiltersVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTSTILECHAINSVIEWHEADERVO:Class = QuestsTileChainsViewHeaderVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_QUESTSTILECHAINS_QUESTSTILECHAINSVIEWVO:Class = QuestsTileChainsViewVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_ICONTITLEDESCSEASONAWARDVO:Class = IconTitleDescSeasonAwardVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_QUESTSPERSONALWELCOMEVIEWVO:Class = QuestsPersonalWelcomeViewVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_SEASONAWARDLISTRENDERERVO:Class = SeasonAwardListRendererVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_SEASONAWARDSVO:Class = SeasonAwardsVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_TEXTBLOCKWELCOMEVIEWVO:Class = TextBlockWelcomeViewVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_DATA_SEASONAWARDS_VEHICLESEASONAWARDVO:Class = VehicleSeasonAwardVO;

    public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_AWARDWINDOWEVENT:Class = AwardWindowEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_CHAINPROGRESSEVENT:Class = ChainProgressEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_PERSONALQUESTEVENT:Class = PersonalQuestEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_QUESTTASKDETAILSVIEWEVENT:Class = QuestTaskDetailsViewEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_QUESTSTILECHAINVIEWFILTERSEVENT:Class = QuestsTileChainViewFiltersEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_QUESTSTILECHAINVIEWHEADEREVENT:Class = QuestsTileChainViewHeaderEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_EVENTS_SEASONAWARDWINDOWEVENT:Class = SeasonAwardWindowEvent;

    public static const NET_WG_GUI_LOBBY_QUESTS_VIEWS_QUESTTASKDETAILSVIEW:Class = QuestTaskDetailsView;

    public static const NET_WG_GUI_LOBBY_QUESTS_VIEWS_QUESTSPERSONALWELCOMEVIEW:Class = QuestsPersonalWelcomeView;

    public static const NET_WG_GUI_LOBBY_QUESTS_VIEWS_QUESTSSEASONSVIEW:Class = QuestsSeasonsView;

    public static const NET_WG_GUI_LOBBY_QUESTS_VIEWS_QUESTSTILECHAINSVIEW:Class = QuestsTileChainsView;

    public static const NET_WG_GUI_LOBBY_QUESTS_WINDOWS_QUESTSSEASONAWARDSWINDOW:Class = QuestsSeasonAwardsWindow;

    public static const NET_WG_GUI_LOBBY_RECRUITWINDOW_QUESTRECRUITWINDOW:Class = QuestRecruitWindow;

    public static const NET_WG_GUI_LOBBY_RECRUITWINDOW_RECRUITWINDOW:Class = RecruitWindow;

    public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_AWARDRECEIVEDBLOCK:Class = AwardReceivedBlock;

    public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_PROGRESSSTEPRENDERER:Class = ProgressStepRenderer;

    public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_REFERRALMANAGEMENTEVENT:Class = ReferralManagementEvent;

    public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_REFERRALSTABLERENDERER:Class = ReferralsTableRenderer;

    public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_REFERRALSTABLERENDERERVO:Class = ReferralsTableRendererVO;

    public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_DATA_AWARDDATADATAVO:Class = AwardDataDataVO;

    public static const NET_WG_GUI_LOBBY_REFERRALSYSTEM_DATA_PROGRESSSTEPVO:Class = ProgressStepVO;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWBLOCKVO:Class = RetrainCrewBlockVO;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWBLOCKVOBASE:Class = RetrainCrewBlockVOBase;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWMAINBUTTONS:Class = RetrainCrewMainButtons;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWOPERATIONVO:Class = RetrainCrewOperationVO;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWROLEIR:Class = RetrainCrewRoleIR;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINCREWWINDOW:Class = RetrainCrewWindow;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINTANKMANVO:Class = RetrainTankmanVO;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_RETRAINVEHICLEBLOCKVO:Class = RetrainVehicleBlockVO;

    public static const NET_WG_GUI_LOBBY_RETRAINCREWWINDOW_TANKMANCREWRETRAININGSMALLBUTTON:Class = TankmanCrewRetrainingSmallButton;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_CONTROLQUESTIONCOMPONENT:Class = ControlQuestionComponent;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_MOVINGRESULT:Class = MovingResult;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_SALEITEMBLOCKRENDERER:Class = SaleItemBlockRenderer;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLDEVICESCOMPONENT:Class = SellDevicesComponent;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLDIALOGLISTITEMRENDERER:Class = SellDialogListItemRenderer;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLHEADERCOMPONENT:Class = SellHeaderComponent;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_SELLSLIDINGCOMPONENT:Class = SellSlidingComponent;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_SETTINGSBUTTON:Class = SettingsButton;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_SLIDINGSCROLLINGLIST:Class = SlidingScrollingList;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_TOTALRESULT:Class = TotalResult;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_USERINPUTCONTROL:Class = UserInputControl;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLDIALOGVO:Class = SellDialogVO;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLININVENTORYMODULEVO:Class = SellInInventoryModuleVo;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLININVENTORYSHELLVO:Class = SellInInventoryShellVo;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLONVEHICLEEQUIPMENTVO:Class = SellOnVehicleEquipmentVo;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLONVEHICLEOPTIONALDEVICEVO:Class = SellOnVehicleOptionalDeviceVo;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLONVEHICLESHELLVO:Class = SellOnVehicleShellVo;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLVEHICLEITEMBASEVO:Class = SellVehicleItemBaseVo;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VO_SELLVEHICLEVO:Class = SellVehicleVo;

    public static const NET_WG_GUI_LOBBY_SELLDIALOG_VEHICLESELLDIALOG:Class = VehicleSellDialog;

    public static const NET_WG_GUI_LOBBY_STORE_COMPLEXLISTITEMRENDERER:Class = ComplexListItemRenderer;

    public static const NET_WG_GUI_LOBBY_STORE_MODULERENDERERCREDITS:Class = ModuleRendererCredits;

    public static const NET_WG_GUI_LOBBY_STORE_STORE_STATUS_COLOR:Class = STORE_STATUS_COLOR;

    public static const NET_WG_GUI_LOBBY_STORE_STORECOMPONENT:Class = StoreComponent;

    public static const NET_WG_GUI_LOBBY_STORE_STOREEVENT:Class = StoreEvent;

    public static const NET_WG_GUI_LOBBY_STORE_STOREFORM:Class = StoreForm;

    public static const NET_WG_GUI_LOBBY_STORE_STOREHELPER:Class = StoreHelper;

    public static const NET_WG_GUI_LOBBY_STORE_STORELIST:Class = StoreList;

    public static const NET_WG_GUI_LOBBY_STORE_STORELISTITEMRENDERER:Class = StoreListItemRenderer;

    public static const NET_WG_GUI_LOBBY_STORE_STORETABLE:Class = StoreTable;

    public static const NET_WG_GUI_LOBBY_STORE_STORETABLEDATAPROVIDER:Class = StoreTableDataProvider;

    public static const NET_WG_GUI_LOBBY_STORE_STOREVIEW:Class = StoreView;

    public static const NET_WG_GUI_LOBBY_STORE_STOREVIEWSEVENT:Class = StoreViewsEvent;

    public static const NET_WG_GUI_LOBBY_STORE_TABLEHEADER:Class = TableHeader;

    public static const NET_WG_GUI_LOBBY_STORE_TABLEHEADERINFO:Class = TableHeaderInfo;

    public static const NET_WG_GUI_LOBBY_STORE_DATA_BUTTONBARVO:Class = ButtonBarVO;

    public static const NET_WG_GUI_LOBBY_STORE_DATA_FILTERSDATAVO:Class = FiltersDataVO;

    public static const NET_WG_GUI_LOBBY_STORE_DATA_STORETOOLTIPMAPVO:Class = StoreTooltipMapVO;

    public static const NET_WG_GUI_LOBBY_STORE_DATA_STOREVIEWINITVO:Class = StoreViewInitVO;

    public static const NET_WG_GUI_LOBBY_STORE_INTERFACES_ISTORETABLE:Class = IStoreTable;

    public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORY:Class = Inventory;

    public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORYMODULELISTITEMRENDERER:Class = InventoryModuleListItemRenderer;

    public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_INVENTORYVEHICLELISTITEMRDR:Class = InventoryVehicleListItemRdr;

    public static const NET_WG_GUI_LOBBY_STORE_INVENTORY_BASE_INVENTORYLISTITEMRENDERER:Class = InventoryListItemRenderer;

    public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOP:Class = Shop;

    public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPMODULELISTITEMRENDERER:Class = ShopModuleListItemRenderer;

    public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPRENT:Class = ShopRent;

    public static const NET_WG_GUI_LOBBY_STORE_SHOP_SHOPVEHICLELISTITEMRENDERER:Class = ShopVehicleListItemRenderer;

    public static const NET_WG_GUI_LOBBY_STORE_SHOP_BASE_ACTION_CREDITS_STATES:Class = ACTION_CREDITS_STATES;

    public static const NET_WG_GUI_LOBBY_STORE_SHOP_BASE_SHOPTABLEITEMRENDERER:Class = ShopTableItemRenderer;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_EQUIPMENTVIEW:Class = EquipmentView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_INVENTORYVEHICLEVIEW:Class = InventoryVehicleView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_MODULEVIEW:Class = ModuleView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_OPTIONALDEVICEVIEW:Class = OptionalDeviceView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_SHELLVIEW:Class = ShellView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_SHOPVEHICLEVIEW:Class = ShopVehicleView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_VEHICLEVIEW:Class = VehicleView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_BASESTOREMENUVIEW:Class = BaseStoreMenuView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_FITSSELECTABLESTOREMENUVIEW:Class = FitsSelectableStoreMenuView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_SIMPLESTOREMENUVIEW:Class = SimpleStoreMenuView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_VIEWUIELEMENTVO:Class = ViewUIElementVO;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_BASE_INTERFACES_ISTOREMENUVIEW:Class = IStoreMenuView;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_DROPDOWNITEMDATA:Class = DropDownItemData;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_EXTFITITEMSFILTERSVO:Class = ExtFitItemsFiltersVO;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_FILTERSVO:Class = FiltersVO;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_FITITEMSFILTERSVO:Class = FitItemsFiltersVO;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_SHOPVEHICLESFILTERSVO:Class = ShopVehiclesFiltersVO;

    public static const NET_WG_GUI_LOBBY_STORE_VIEWS_DATA_VEHICLESFILTERSVO:Class = VehiclesFiltersVO;

    public static const NET_WG_GUI_LOBBY_TANKMAN_CAROUSELTANKMANSKILLSMODEL:Class = CarouselTankmanSkillsModel;

    public static const NET_WG_GUI_LOBBY_TANKMAN_CREWTANKMANRETRAINING:Class = CrewTankmanRetraining;

    public static const NET_WG_GUI_LOBBY_TANKMAN_DROPSKILLSCOST:Class = DropSkillsCost;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASE:Class = PersonalCase;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBASE:Class = PersonalCaseBase;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKITEM:Class = PersonalCaseBlockItem;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKTITLE:Class = PersonalCaseBlockTitle;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEBLOCKSAREA:Class = PersonalCaseBlocksArea;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASECURRENTVEHICLE:Class = PersonalCaseCurrentVehicle;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEDOCS:Class = PersonalCaseDocs;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEDOCSMODEL:Class = PersonalCaseDocsModel;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEINPUTLIST:Class = PersonalCaseInputList;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASEMODEL:Class = PersonalCaseModel;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASERETRAININGMODEL:Class = PersonalCaseRetrainingModel;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLS:Class = PersonalCaseSkills;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLSITEMRENDERER:Class = PersonalCaseSkillsItemRenderer;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESKILLSMODEL:Class = PersonalCaseSkillsModel;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESPECIALIZATION:Class = PersonalCaseSpecialization;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASESTATS:Class = PersonalCaseStats;

    public static const NET_WG_GUI_LOBBY_TANKMAN_PERSONALCASETABNAME:Class = PersonalCaseTabName;

    public static const NET_WG_GUI_LOBBY_TANKMAN_RANKELEMENT:Class = RankElement;

    public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEITEM:Class = RoleChangeItem;

    public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEITEMS:Class = RoleChangeItems;

    public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEVEHICLESELECTION:Class = RoleChangeVehicleSelection;

    public static const NET_WG_GUI_LOBBY_TANKMAN_ROLECHANGEWINDOW:Class = RoleChangeWindow;

    public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLDROPMODEL:Class = SkillDropModel;

    public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLDROPWINDOW:Class = SkillDropWindow;

    public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLITEMVIEWMINI:Class = SkillItemViewMini;

    public static const NET_WG_GUI_LOBBY_TANKMAN_SKILLSITEMSRENDERERRANKICON:Class = SkillsItemsRendererRankIcon;

    public static const NET_WG_GUI_LOBBY_TANKMAN_TANKMANSKILLSINFOBLOCK:Class = TankmanSkillsInfoBlock;

    public static const NET_WG_GUI_LOBBY_TANKMAN_VEHICLETYPEBUTTON:Class = VehicleTypeButton;

    public static const NET_WG_GUI_LOBBY_TANKMAN_VO_ROLECHANGEITEMVO:Class = RoleChangeItemVO;

    public static const NET_WG_GUI_LOBBY_TANKMAN_VO_ROLECHANGEVO:Class = RoleChangeVO;

    public static const NET_WG_GUI_LOBBY_TANKMAN_VO_TANKMANSKILLSINFOBLOCKVO:Class = TankmanSkillsInfoBlockVO;

    public static const NET_WG_GUI_LOBBY_TANKMAN_VO_VEHICLESELECTIONITEMVO:Class = VehicleSelectionItemVO;

    public static const NET_WG_GUI_LOBBY_TANKMAN_VO_VEHICLESELECTIONVO:Class = VehicleSelectionVO;

    public static const NET_WG_GUI_LOBBY_TECHTREE_RESEARCHPAGE:Class = ResearchPage;

    public static const NET_WG_GUI_LOBBY_TECHTREE_TECHTREEEVENT:Class = TechTreeEvent;

    public static const NET_WG_GUI_LOBBY_TECHTREE_TECHTREEPAGE:Class = TechTreePage;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_ACTIONNAME:Class = ActionName;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_COLORINDEX:Class = ColorIndex;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_ICONTEXTRESOLVER:Class = IconTextResolver;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NAMEDLABELS:Class = NamedLabels;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NAVINDICATOR:Class = NavIndicator;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NODEENTITYTYPE:Class = NodeEntityType;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NODENAME:Class = NodeName;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_NODERENDERERSTATE:Class = NodeRendererState;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_OUTLITERAL:Class = OutLiteral;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_TTINVALIDATIONTYPE:Class = TTInvalidationType;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_TTSOUNDID:Class = TTSoundID;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONSTANTS_XPTYPESTRINGS:Class = XpTypeStrings;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_ACTIONBUTTON:Class = ActionButton;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_EXPERIENCEINFORMATION:Class = ExperienceInformation;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_EXPERIENCELABEL:Class = ExperienceLabel;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_LEVELDELIMITER:Class = LevelDelimiter;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_LEVELSCONTAINER:Class = LevelsContainer;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NAMEANDXPFIELD:Class = NameAndXpField;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONBUTTON:Class = NationButton;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NATIONSBUTTONBAR:Class = NationsButtonBar;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_NODECOMPONENT:Class = NodeComponent;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_PREMIUMDESCRIPTION:Class = PremiumDescription;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_PREMIUMLAYOUT:Class = PremiumLayout;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_RESEARCHTITLEBAR:Class = ResearchTitleBar;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_RETURNTOTTBUTTON:Class = ReturnToTTButton;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_TREENODESELECTOR:Class = TreeNodeSelector;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_TYPEANDLEVELFIELD:Class = TypeAndLevelField;

    public static const NET_WG_GUI_LOBBY_TECHTREE_CONTROLS_XPICON:Class = XPIcon;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_ABSTRACTDATAPROVIDER:Class = AbstractDataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_NATIONVODATAPROVIDER:Class = NationVODataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_NATIONXMLDATAPROVIDER:Class = NationXMLDataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_RESEARCHVODATAPROVIDER:Class = ResearchVODataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_RESEARCHXMLDATAPROVIDER:Class = ResearchXMLDataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_ANIMATIONPROPERTIES:Class = AnimationProperties;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_INVENTORYSTATEITEM:Class = InventoryStateItem;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_NODESTATECOLLECTION:Class = NodeStateCollection;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_NODESTATEITEM:Class = NodeStateItem;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_RESEARCHSTATEITEM:Class = ResearchStateItem;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_STATEPROPERTIES:Class = StateProperties;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_STATE_UNLOCKEDSTATEITEM:Class = UnlockedStateItem;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_EXTRAINFORMATION:Class = ExtraInformation;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NTDISPLAYINFO:Class = NTDisplayInfo;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NATIONDISPLAYSETTINGS:Class = NationDisplaySettings;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_NODEDATA:Class = NodeData;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_RESEARCHDISPLAYINFO:Class = ResearchDisplayInfo;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_SHOPPRICE:Class = ShopPrice;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_UNLOCKPROPS:Class = UnlockProps;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_VEHCOMPAREENTRYPOINTTREENODEVO:Class = VehCompareEntrypointTreeNodeVO;

    public static const NET_WG_GUI_LOBBY_TECHTREE_DATA_VO_VEHGLOBALSTATS:Class = VehGlobalStats;

    public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_DISTANCE:Class = Distance;

    public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_LINESGRAPHICS:Class = LinesGraphics;

    public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_MODULESGRAPHICS:Class = ModulesGraphics;

    public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_NTGRAPHICS:Class = NTGraphics;

    public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_NODEINDEXFILTER:Class = NodeIndexFilter;

    public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_RESEARCHGRAPHICS:Class = ResearchGraphics;

    public static const NET_WG_GUI_LOBBY_TECHTREE_HELPERS_TITLEAPPEARANCE:Class = TitleAppearance;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IHASRENDERERASOWNER:Class = IHasRendererAsOwner;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_INATIONTREEDATAPROVIDER:Class = INationTreeDataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_INODESCONTAINER:Class = INodesContainer;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_INODESDATAPROVIDER:Class = INodesDataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRENDERER:Class = IRenderer;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRESEARCHCONTAINER:Class = IResearchContainer;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRESEARCHDATAPROVIDER:Class = IResearchDataProvider;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IRESEARCHPAGE:Class = IResearchPage;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_ITECHTREEPAGE:Class = ITechTreePage;

    public static const NET_WG_GUI_LOBBY_TECHTREE_INTERFACES_IVALUEOBJECT:Class = IValueObject;

    public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_ADG_ITEMLEVELSBUILDER:Class = ADG_ItemLevelsBuilder;

    public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_HUNGARIANALGORITHM:Class = HungarianAlgorithm;

    public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_MATRIXPOSITION:Class = MatrixPosition;

    public static const NET_WG_GUI_LOBBY_TECHTREE_MATH_MATRIXUTILS:Class = MatrixUtils;

    public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_FAKENODE:Class = FakeNode;

    public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_NATIONTREENODE:Class = NationTreeNode;

    public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_RENDERER:Class = Renderer;

    public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_RESEARCHITEM:Class = ResearchItem;

    public static const NET_WG_GUI_LOBBY_TECHTREE_NODES_RESEARCHROOT:Class = ResearchRoot;

    public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_MODULESTREE:Class = ModulesTree;

    public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_NATIONTREE:Class = NationTree;

    public static const NET_WG_GUI_LOBBY_TECHTREE_SUB_RESEARCHITEMS:Class = ResearchItems;

    public static const NET_WG_GUI_LOBBY_TRAINING_ARENAVOIPSETTINGS:Class = ArenaVoipSettings;

    public static const NET_WG_GUI_LOBBY_TRAINING_DROPLIST:Class = DropList;

    public static const NET_WG_GUI_LOBBY_TRAINING_DROPTILELIST:Class = DropTileList;

    public static const NET_WG_GUI_LOBBY_TRAINING_OBSERVERBUTTONCOMPONENT:Class = ObserverButtonComponent;

    public static const NET_WG_GUI_LOBBY_TRAINING_PLAYERELEMENT:Class = PlayerElement;

    public static const NET_WG_GUI_LOBBY_TRAINING_TOOLTIPVIEWER:Class = TooltipViewer;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGCONSTANTS:Class = TrainingConstants;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGDRAGCONTROLLER:Class = TrainingDragController;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGDRAGDELEGATE:Class = TrainingDragDelegate;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGFORM:Class = TrainingForm;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGLISTITEMRENDERER:Class = TrainingListItemRenderer;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGPLAYERITEMRENDERER:Class = TrainingPlayerItemRenderer;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGROOM:Class = TrainingRoom;

    public static const NET_WG_GUI_LOBBY_TRAINING_TRAININGWINDOW:Class = TrainingWindow;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_BODYMC:Class = BodyMc;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_BUYINGVEHICLEVO:Class = BuyingVehicleVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_EXPANDBUTTON:Class = ExpandButton;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_FOOTERMC:Class = FooterMc;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_HEADERMC:Class = HeaderMc;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_VEHICLEBUYRENTITEMVO:Class = VehicleBuyRentItemVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_VEHICLEBUYWINDOW:Class = VehicleBuyWindow;

    public static const NET_WG_GUI_LOBBY_VEHICLEBUYWINDOW_VEHICLEBUYWINDOWANIMMANAGER:Class = VehicleBuyWindowAnimManager;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECARTITEMRENDERER:Class = VehicleCompareCartItemRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPARECARTPOPOVER:Class = VehicleCompareCartPopover;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLECOMPAREVIEW:Class = VehicleCompareView;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLEMODULESTREE:Class = VehicleModulesTree;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_VEHICLEMODULESWINDOW:Class = VehicleModulesWindow;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREADDVEHICLEPOPOVER:Class = VehicleCompareAddVehiclePopover;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREADDVEHICLERENDERER:Class = VehicleCompareAddVehicleRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREANIM:Class = VehicleCompareAnim;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREANIMRENDERER:Class = VehicleCompareAnimRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VEHICLECOMPAREVEHICLESELECTOR:Class = VehicleCompareVehicleSelector;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREBUBBLE:Class = VehCompareBubble;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARECREWDROPDOWNITEMRENDERER:Class = VehCompareCrewDropDownItemRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREGRIDLINE:Class = VehCompareGridLine;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREHEADER:Class = VehCompareHeader;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREHEADERBACKGROUND:Class = VehCompareHeaderBackground;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREMAINPANEL:Class = VehCompareMainPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREPARAMRENDERER:Class = VehCompareParamRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREPARAMSDELTA:Class = VehCompareParamsDelta;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREPARAMSVIEWPORT:Class = VehCompareParamsViewPort;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETABLECONTENT:Class = VehCompareTableContent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETABLEGRID:Class = VehCompareTableGrid;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETANKCAROUSEL:Class = VehCompareTankCarousel;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPARETOPPANEL:Class = VehCompareTopPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREVEHPARAMRENDERER:Class = VehCompareVehParamRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHCOMPAREVEHICLERENDERER:Class = VehCompareVehicleRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHPARAMSLISTDATAPROVIDER:Class = VehParamsListDataProvider;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_CONTROLS_VIEW_VEHPARAMSSCROLLER:Class = VehParamsScroller;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPARECREWLEVELVO:Class = VehCompareCrewLevelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREDATAPROVIDER:Class = VehCompareDataProvider;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREHEADERVO:Class = VehCompareHeaderVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREPARAMSDELTAVO:Class = VehCompareParamsDeltaVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPARESTATICDATAVO:Class = VehCompareStaticDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHCOMPAREVEHICLEVO:Class = VehCompareVehicleVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHPARAMSDATAVO:Class = VehParamsDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPAREADDVEHICLEPOPOVERVO:Class = VehicleCompareAddVehiclePopoverVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPAREANIMVO:Class = VehicleCompareAnimVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPARECARTITEMVO:Class = VehicleCompareCartItemVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPARECARTPOPOVERINITDATAVO:Class = VehicleCompareCartPopoverInitDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLECOMPAREVEHICLESELECTORITEMVO:Class = VehicleCompareVehicleSelectorItemVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_DATA_VEHICLEMODULESWINDOWINITDATAVO:Class = VehicleModulesWindowInitDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREEVENT:Class = VehCompareEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREPARAMSLISTEVENT:Class = VehCompareParamsListEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPARESCROLLEVENT:Class = VehCompareScrollEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREVEHPARAMRENDEREREVENT:Class = VehCompareVehParamRendererEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHCOMPAREVEHICLERENDEREREVENT:Class = VehCompareVehicleRendererEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHICLECOMPAREADDVEHICLERENDEREREVENT:Class = VehicleCompareAddVehicleRendererEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHICLECOMPARECARTEVENT:Class = VehicleCompareCartEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_EVENTS_VEHICLEMODULEITEMEVENT:Class = VehicleModuleItemEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_IMAINPANEL:Class = IMainPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_ITABLEGRIDLINE:Class = ITableGridLine;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_ITOPPANEL:Class = ITopPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_IVEHCOMPAREVIEWHEADER:Class = IVehCompareViewHeader;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_INTERFACES_IVEHPARAMRENDERER:Class = IVehParamRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULEITEMNODE:Class = ModuleItemNode;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULERENDERER:Class = ModuleRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULESROOTNODE:Class = ModulesRootNode;

    public static const NET_WG_GUI_LOBBY_VEHICLECOMPARE_NODES_MODULESTREEDATAPROVIDER:Class = ModulesTreeDataProvider;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_BOTTOMPANEL:Class = BottomPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBONUSPANEL:Class = CustomizationBonusPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBONUSRENDERER:Class = CustomizationBonusRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBUYWINDOW:Class = CustomizationBuyWindow;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONBUYINGPANEL:Class = CustomizationBuyingPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONCAROUSEL:Class = CustomizationCarousel;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONFILTERSPOPOVER:Class = CustomizationFiltersPopover;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONGROUPRENDERER:Class = CustomizationGroupRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONGROUPSSLOTPANEL:Class = CustomizationGroupsSlotPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONHEADER:Class = CustomizationHeader;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONHELPER:Class = CustomizationHelper;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONMAINVIEW:Class = CustomizationMainView;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONPURCHASESLISTITEMRENDERER:Class = CustomizationPurchasesListItemRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSLOTBUBBLE:Class = CustomizationSlotBubble;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSLOTRENDERER:Class = CustomizationSlotRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSLOTSPANEL:Class = CustomizationSlotsPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CUSTOMIZATIONSLOTSPANELVIEW:Class = CustomizationSlotsPanelView;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_ISLOTSPANELRENDERER:Class = ISlotsPanelRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_ANIMATEDBONUS:Class = AnimatedBonus;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CAROUSELITEMRENDERER:Class = CarouselItemRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CAROUSELITEMSLOT:Class = CarouselItemSlot;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_CHECKBOXICON:Class = net.wg.gui.lobby.vehicleCustomization.controls.CheckBoxIcon;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_DROPDOWNPRICEITEMRENDERER:Class = DropDownPriceItemRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_LABELBONUS:Class = LabelBonus;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_PURCHASETABLERENDERER:Class = PurchaseTableRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_RADIOBUTTONLISTSELECTIONNAVIGATOR:Class = RadioButtonListSelectionNavigator;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_CONTROLS_RADIORENDERER:Class = RadioRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_BOTTOMPANELVO:Class = BottomPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONBOTTOMPANELINITVO:Class = CustomizationBottomPanelInitVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONHEADERVO:Class = CustomizationHeaderVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONINITVO:Class = CustomizationInitVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPURCHASESPOPOVERINITVO:Class = CustomizationPurchasesPopoverInitVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPURCHASESPOPOVERVO:Class = CustomizationPurchasesPopoverVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONRADIORENDERERVO:Class = CustomizationRadioRendererVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_DDPRICERENDERERVO:Class = DDPriceRendererVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_FILTERSPOPOVERVO:Class = FiltersPopoverVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_FILTERSSTATEVO:Class = net.wg.gui.lobby.vehicleCustomization.data.FiltersStateVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CAROUSELDATAVO:Class = CarouselDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CAROUSELINITVO:Class = CarouselInitVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CAROUSELRENDERERVO:Class = CarouselRendererVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONCAROUSELFILTERVO:Class = CustomizationCarouselFilterVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONCAROUSELRENDERERVO:Class = CustomizationCarouselRendererVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONITEMVO:Class = net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationItemVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONSLOTUPDATEVO:Class = CustomizationSlotUpdateVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONSLOTVO:Class = CustomizationSlotVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONSLOTSGROUPVO:Class = CustomizationSlotsGroupVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_CUSTOMIZATIONPANEL_CUSTOMIZATIONSLOTSPANELVO:Class = CustomizationSlotsPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PANELS_ANIMATIONBONUSVO:Class = AnimationBonusVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PANELS_CUSTOMIZATIONBONUSPANELVO:Class = CustomizationBonusPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PANELS_CUSTOMIZATIONBONUSRENDERERVO:Class = CustomizationBonusRendererVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PANELS_CUSTOMIZATIONBUYINGPANELINITVO:Class = CustomizationBuyingPanelInitVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PANELS_CUSTOMIZATIONBUYINGPANELVO:Class = CustomizationBuyingPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PANELS_CUSTOMIZATIONTOTALBONUSPANELVO:Class = CustomizationTotalBonusPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_INITBUYWINDOWVO:Class = InitBuyWindowVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_PURCHASEVO:Class = PurchaseVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_PURCHASESPOPOVERRENDERERVO:Class = PurchasesPopoverRendererVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_DATA_PURCHASE_PURCHASESTOTALVO:Class = PurchasesTotalVO;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONEVENT:Class = CustomizationEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONITEMEVENT:Class = CustomizationItemEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLECUSTOMIZATION_EVENTS_CUSTOMIZATIONSLOTEVENT:Class = CustomizationSlotEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_BASEBLOCK:Class = BaseBlock;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_CREWBLOCK:Class = CrewBlock;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_IVEHICLEINFOBLOCK:Class = IVehicleInfoBlock;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_PROPBLOCK:Class = PropBlock;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFO:Class = VehicleInfo;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOBASE:Class = VehicleInfoBase;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOCREW:Class = VehicleInfoCrew;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOPROPS:Class = VehicleInfoProps;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_VEHICLEINFOVIEWCONTENT:Class = VehicleInfoViewContent;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHCOMPAREBUTTONDATAVO:Class = VehCompareButtonDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHICLEINFOCREWBLOCKVO:Class = VehicleInfoCrewBlockVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHICLEINFODATAVO:Class = VehicleInfoDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEINFO_DATA_VEHICLEINFOPROPBLOCKVO:Class = VehicleInfoPropBlockVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_VEHICLEPREVIEW:Class = VehiclePreview;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWBOTTOMPANEL:Class = VehPreviewBottomPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWBUYINGPANEL:Class = VehPreviewBuyingPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWCREWINFO:Class = VehPreviewCrewInfo;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWCREWLISTRENDERER:Class = VehPreviewCrewListRenderer;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWFACTSHEET:Class = VehPreviewFactSheet;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWHEADER:Class = VehPreviewHeader;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOPANEL:Class = VehPreviewInfoPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOPANELTAB:Class = VehPreviewInfoPanelTab;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOTABBUTTON:Class = VehPreviewInfoTabButton;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWINFOVIEWSTACK:Class = VehPreviewInfoViewStack;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_CONTROLS_VEHPREVIEWVEHICLEINFOPANEL:Class = VehPreviewVehicleInfoPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWBOTTOMPANELVO:Class = VehPreviewBottomPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWCREWINFOVO:Class = VehPreviewCrewInfoVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWCREWLISTRENDERERVO:Class = VehPreviewCrewListRendererVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWFACTSHEETVO:Class = VehPreviewFactSheetVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWHEADERVO:Class = VehPreviewHeaderVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWINFOPANELVO:Class = VehPreviewInfoPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWINFOTABDATAITEMVO:Class = VehPreviewInfoTabDataItemVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWPRICEDATAVO:Class = VehPreviewPriceDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWSTATICDATAVO:Class = VehPreviewStaticDataVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_DATA_VEHPREVIEWVEHICLEINFOPANELVO:Class = VehPreviewVehicleInfoPanelVO;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_EVENTS_VEHPREVIEWEVENT:Class = VehPreviewEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_EVENTS_VEHPREVIEWINFOPANELEVENT:Class = VehPreviewInfoPanelEvent;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWBOTTOMPANEL:Class = IVehPreviewBottomPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWBUYINGPANEL:Class = IVehPreviewBuyingPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWHEADER:Class = IVehPreviewHeader;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWINFOPANEL:Class = IVehPreviewInfoPanel;

    public static const NET_WG_GUI_LOBBY_VEHICLEPREVIEW_INTERFACES_IVEHPREVIEWINFOPANELTAB:Class = IVehPreviewInfoPanelTab;

    public static const NET_WG_GUI_LOBBY_WGNC_WGNCDIALOG:Class = WGNCDialog;

    public static const NET_WG_GUI_LOBBY_WGNC_WGNCDIALOGMODAL:Class = WGNCDialogModal;

    public static const NET_WG_GUI_LOBBY_WGNC_WGNCPOLLWINDOW:Class = WGNCPollWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_AWARDWINDOW:Class = AwardWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_BASEEXCHANGEWINDOW:Class = BaseExchangeWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_BASEEXCHANGEWINDOWRATEVO:Class = BaseExchangeWindowRateVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_BOOSTERSWINDOW:Class = BoostersWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_BROWSERWINDOW:Class = BrowserWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMEXCHANGEBLOCK:Class = ConfirmExchangeBlock;

    public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMEXCHANGEDIALOG:Class = ConfirmExchangeDialog;

    public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMITEMWINDOW:Class = ConfirmItemWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMITEMWINDOWBASEVO:Class = ConfirmItemWindowBaseVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_CONFIRMITEMWINDOWVO:Class = ConfirmItemWindowVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGECURRENCYWINDOW:Class = ExchangeCurrencyWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANINITVO:Class = ExchangeFreeToTankmanInitVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANXPWARNING:Class = ExchangeFreeToTankmanXpWarning;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEFREETOTANKMANXPWINDOW:Class = ExchangeFreeToTankmanXpWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEHEADER:Class = ExchangeHeader;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEHEADERVO:Class = ExchangeHeaderVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEUTILS:Class = ExchangeUtils;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEWINDOW:Class = ExchangeWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPFROMVEHICLEIR:Class = ExchangeXPFromVehicleIR;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPLIST:Class = ExchangeXPList;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPTANKMANSKILLSMODEL:Class = ExchangeXPTankmanSkillsModel;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPVEHICLEVO:Class = ExchangeXPVehicleVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWARNINGSCREEN:Class = ExchangeXPWarningScreen;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWINDOW:Class = ExchangeXPWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXCHANGEXPWINDOWVO:Class = ExchangeXPWindowVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_EXTENDEDICONTEXT:Class = ExtendedIconText;

    public static const NET_WG_GUI_LOBBY_WINDOW_IEXCHANGEHEADER:Class = IExchangeHeader;

    public static const NET_WG_GUI_LOBBY_WINDOW_MISSIONAWARDWINDOW:Class = MissionAwardWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_MODULEINFO:Class = ModuleInfo;

    public static const NET_WG_GUI_LOBBY_WINDOW_PROFILEWINDOW:Class = ProfileWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_PROFILEWINDOWINITVO:Class = ProfileWindowInitVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_PROMOPREMIUMIGRWINDOW:Class = PromoPremiumIgrWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_PUNISHMENTDIALOG:Class = PunishmentDialog;

    public static const NET_WG_GUI_LOBBY_WINDOW_PVESANDBOXQUEUEWINDOW:Class = PvESandboxQueueWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_REFMANAGEMENTWINDOWVO:Class = RefManagementWindowVO;

    public static const NET_WG_GUI_LOBBY_WINDOW_REFERRALMANAGEMENTWINDOW:Class = ReferralManagementWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_REFERRALREFERRALSINTROWINDOW:Class = ReferralReferralsIntroWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_REFERRALREFERRERINTROWINDOW:Class = ReferralReferrerIntroWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_REFERRALTEXTBLOCKCMP:Class = ReferralTextBlockCmp;

    public static const NET_WG_GUI_LOBBY_WINDOW_SWITCHPERIPHERYWINDOW:Class = SwitchPeripheryWindow;

    public static const NET_WG_GUI_LOBBY_WINDOW_VCOINEXCHANGEDATAVO:Class = VcoinExchangeDataVO;

    public static const NET_WG_GUI_LOGIN_EULA_EULADLG:Class = EULADlg;

    public static const NET_WG_GUI_LOGIN_EULA_EULAFULLDLG:Class = EULAFullDlg;

    public static const NET_WG_GUI_LOGIN_IFORMBASEVO:Class = IFormBaseVo;

    public static const NET_WG_GUI_LOGIN_ILOGINFORM:Class = ILoginForm;

    public static const NET_WG_GUI_LOGIN_ILOGINFORMVIEW:Class = ILoginFormView;

    public static const NET_WG_GUI_LOGIN_IRSSNEWSFEEDRENDERER:Class = IRssNewsFeedRenderer;

    public static const NET_WG_GUI_LOGIN_ISPARKSMANAGER:Class = ISparksManager;

    public static const NET_WG_GUI_LOGIN_IMPL_LOGINPAGE:Class = LoginPage;

    public static const NET_WG_GUI_LOGIN_IMPL_LOGINQUEUEWINDOW:Class = LoginQueueWindow;

    public static const NET_WG_GUI_LOGIN_IMPL_LOGINVIEWSTACK:Class = LoginViewStack;

    public static const NET_WG_GUI_LOGIN_IMPL_RUDIMENTARYSWFONLOGINCHECKINGHELPER:Class = RudimentarySwfOnLoginCheckingHelper;

    public static const NET_WG_GUI_LOGIN_IMPL_SPARK:Class = Spark;

    public static const NET_WG_GUI_LOGIN_IMPL_SPARKSMANAGER:Class = SparksManager;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_CAPSLOCKINDICATOR:Class = CapsLockIndicator;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_COPYRIGHT:Class = Copyright;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_COPYRIGHTEVENT:Class = CopyrightEvent;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_LOGINIGRWARNING:Class = LoginIgrWarning;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_LOGINLOGOS:Class = LoginLogos;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_RSSITEMEVENT:Class = RssItemEvent;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_RSSNEWSFEED:Class = RssNewsFeed;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_RSSNEWSFEEDRENDERER:Class = RssNewsFeedRenderer;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_SOCIALGROUP:Class = SocialGroup;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_SOCIALICONSLIST:Class = SocialIconsList;

    public static const NET_WG_GUI_LOGIN_IMPL_COMPONENTS_SOCIALITEMRENDERER:Class = SocialItemRenderer;

    public static const NET_WG_GUI_LOGIN_IMPL_EV_COPYRIGHTEVENT:Class = net.wg.gui.login.impl.ev.CopyrightEvent;

    public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINEVENT:Class = LoginEvent;

    public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINEVENTTEXTLINK:Class = LoginEventTextLink;

    public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINLOGOSEV:Class = LoginLogosEv;

    public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINSERVERDDEVENT:Class = LoginServerDDEvent;

    public static const NET_WG_GUI_LOGIN_IMPL_EV_LOGINVIEWSTACKEVENT:Class = LoginViewStackEvent;

    public static const NET_WG_GUI_LOGIN_IMPL_VIEWS_LOGINFORMVIEW:Class = LoginFormView;

    public static const NET_WG_GUI_LOGIN_IMPL_VIEWS_SIMPLEFORM:Class = SimpleForm;

    public static const NET_WG_GUI_LOGIN_IMPL_VIEWS_SOCIALFORM:Class = SocialForm;

    public static const NET_WG_GUI_LOGIN_IMPL_VO_FORMBASEVO:Class = FormBaseVo;

    public static const NET_WG_GUI_LOGIN_IMPL_VO_RSSITEMVO:Class = RssItemVo;

    public static const NET_WG_GUI_LOGIN_IMPL_VO_SIMPLEFORMVO:Class = SimpleFormVo;

    public static const NET_WG_GUI_LOGIN_IMPL_VO_SOCIALFORMVO:Class = SocialFormVo;

    public static const NET_WG_GUI_LOGIN_IMPL_VO_SOCIALICONVO:Class = SocialIconVo;

    public static const NET_WG_GUI_LOGIN_IMPL_VO_SUBMITDATAVO:Class = SubmitDataVo;

    public static const NET_WG_GUI_LOGIN_LEGAL_LEGALCONTENT:Class = LegalContent;

    public static const NET_WG_GUI_LOGIN_LEGAL_LEGALINFOWINDOW:Class = LegalInfoWindow;

    public static const NET_WG_GUI_MESSENGER_CHANNELCOMPONENT:Class = ChannelComponent;

    public static const NET_WG_GUI_MESSENGER_CONTACTSLISTPOPOVER:Class = ContactsListPopover;

    public static const NET_WG_GUI_MESSENGER_ICHANNELCOMPONENT:Class = IChannelComponent;

    public static const NET_WG_GUI_MESSENGER_SMILEYMAP:Class = SmileyMap;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_BASECONTACTSSCROLLINGLIST:Class = BaseContactsScrollingList;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CHANNELITEMRENDERER:Class = ChannelItemRenderer;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTATTRIBUTESGROUP:Class = ContactAttributesGroup;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTGROUPITEM:Class = ContactGroupItem;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTITEM:Class = ContactItem;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTITEMRENDERER:Class = ContactItemRenderer;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTLISTHEADERCHECKBOX:Class = ContactListHeaderCheckBox;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSCROLLINGLIST:Class = ContactScrollingList;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSBASEDROPLISTDELEGATE:Class = ContactsBaseDropListDelegate;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSBTNBAR:Class = ContactsBtnBar;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSDROPLISTDELEGATE:Class = ContactsDropListDelegate;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTBASECONTROLLER:Class = ContactsListBaseController;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTDRAGDROPDELEGATE:Class = ContactsListDragDropDelegate;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTDTAGCONTROLLER:Class = ContactsListDtagController;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTHIGHLIGHTAREA:Class = ContactsListHighlightArea;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTITEMRENDERER:Class = ContactsListItemRenderer;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSLISTSELECTIONNAVIGATOR:Class = ContactsListSelectionNavigator;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSTREECOMPONENT:Class = ContactsTreeComponent;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSTREEITEMRENDERER:Class = ContactsTreeItemRenderer;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_CONTACTSWINDOWVIEWBG:Class = ContactsWindowViewBG;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_DASHEDHIGHLIGHTAREA:Class = DashedHighlightArea;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_EMPTYHIGHLIGHTAREA:Class = EmptyHighlightArea;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_IMGDROPLISTDELEGATE:Class = ImgDropListDelegate;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_INFOMESSAGEVIEW:Class = InfoMessageView;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_MAINGROUPITEM:Class = MainGroupItem;

    public static const NET_WG_GUI_MESSENGER_CONTROLS_MEMBERITEMRENDERER:Class = MemberItemRenderer;

    public static const NET_WG_GUI_MESSENGER_DATA_CHANNELMEMBERVO:Class = ChannelMemberVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTEVENT:Class = ContactEvent;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTITEMVO:Class = ContactItemVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTLISTMAININFO:Class = ContactListMainInfo;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTUSERPROPVO:Class = ContactUserPropVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTVO:Class = ContactVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSCONSTANTS:Class = ContactsConstants;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSGROUPEVENT:Class = ContactsGroupEvent;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSLISTGROUPVO:Class = ContactsListGroupVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSLISTTREEITEMINFO:Class = ContactsListTreeItemInfo;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSSETTINGSDATAVO:Class = ContactsSettingsDataVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSSETTINGSVIEWINITDATAVO:Class = ContactsSettingsViewInitDataVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSSHARED:Class = ContactsShared;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSTREEDATAPROVIDER:Class = ContactsTreeDataProvider;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSVIEWINITDATAVO:Class = ContactsViewInitDataVO;

    public static const NET_WG_GUI_MESSENGER_DATA_CONTACTSWINDOWINITVO:Class = ContactsWindowInitVO;

    public static const NET_WG_GUI_MESSENGER_DATA_EXTCONTACTSVIEWINITVO:Class = ExtContactsViewInitVO;

    public static const NET_WG_GUI_MESSENGER_DATA_GROUPRULESVO:Class = GroupRulesVO;

    public static const NET_WG_GUI_MESSENGER_DATA_ICONTACTITEMRENDERER:Class = IContactItemRenderer;

    public static const NET_WG_GUI_MESSENGER_DATA_ITREEITEMINFO:Class = ITreeItemInfo;

    public static const NET_WG_GUI_MESSENGER_DATA_TREEDAAPIDATAPROVIDER:Class = TreeDAAPIDataProvider;

    public static const NET_WG_GUI_MESSENGER_DATA_TREEITEMINFO:Class = TreeItemInfo;

    public static const NET_WG_GUI_MESSENGER_EVNTS_CHANNELSFORMEVENT:Class = ChannelsFormEvent;

    public static const NET_WG_GUI_MESSENGER_EVNTS_CONTACTSFORMEVENT:Class = ContactsFormEvent;

    public static const NET_WG_GUI_MESSENGER_EVNTS_CONTACTSSCROLLINGLISTEVENT:Class = ContactsScrollingListEvent;

    public static const NET_WG_GUI_MESSENGER_EVNTS_CONTACTSTREEEVENT:Class = ContactsTreeEvent;

    public static const NET_WG_GUI_MESSENGER_FORMS_CHANNELSCREATEFORM:Class = ChannelsCreateForm;

    public static const NET_WG_GUI_MESSENGER_FORMS_CHANNELSSEARCHFORM:Class = ChannelsSearchForm;

    public static const NET_WG_GUI_MESSENGER_FORMS_CONTACTSLISTFORM:Class = ContactsListForm;

    public static const NET_WG_GUI_MESSENGER_FORMS_CONTACTSSEARCHFORM:Class = ContactsSearchForm;

    public static const NET_WG_GUI_MESSENGER_META_IBASECONTACTVIEWMETA:Class = IBaseContactViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_IBASEMANAGECONTACTVIEWMETA:Class = IBaseManageContactViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICHANNELCOMPONENTMETA:Class = IChannelComponentMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICHANNELWINDOWMETA:Class = IChannelWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICHANNELSMANAGEMENTWINDOWMETA:Class = IChannelsManagementWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICONNECTTOSECURECHANNELWINDOWMETA:Class = IConnectToSecureChannelWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICONTACTNOTEMANAGEVIEWMETA:Class = IContactNoteManageViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICONTACTSLISTPOPOVERMETA:Class = IContactsListPopoverMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICONTACTSSETTINGSVIEWMETA:Class = IContactsSettingsViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_ICONTACTSWINDOWMETA:Class = IContactsWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IFAQWINDOWMETA:Class = IFAQWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IGROUPDELETEVIEWMETA:Class = IGroupDeleteViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_ILOBBYCHANNELWINDOWMETA:Class = ILobbyChannelWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_ISEARCHCONTACTVIEWMETA:Class = ISearchContactViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_BASECONTACTVIEWMETA:Class = BaseContactViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_BASEMANAGECONTACTVIEWMETA:Class = BaseManageContactViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELCOMPONENTMETA:Class = ChannelComponentMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELWINDOWMETA:Class = ChannelWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CHANNELSMANAGEMENTWINDOWMETA:Class = ChannelsManagementWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CONNECTTOSECURECHANNELWINDOWMETA:Class = ConnectToSecureChannelWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTNOTEMANAGEVIEWMETA:Class = ContactNoteManageViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTSLISTPOPOVERMETA:Class = ContactsListPopoverMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTSSETTINGSVIEWMETA:Class = ContactsSettingsViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_CONTACTSWINDOWMETA:Class = ContactsWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_FAQWINDOWMETA:Class = FAQWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_GROUPDELETEVIEWMETA:Class = GroupDeleteViewMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_LOBBYCHANNELWINDOWMETA:Class = LobbyChannelWindowMeta;

    public static const NET_WG_GUI_MESSENGER_META_IMPL_SEARCHCONTACTVIEWMETA:Class = SearchContactViewMeta;

    public static const NET_WG_GUI_MESSENGER_VIEWS_BASECONTACTVIEW:Class = BaseContactView;

    public static const NET_WG_GUI_MESSENGER_VIEWS_BASEMANAGECONTACTVIEW:Class = BaseManageContactView;

    public static const NET_WG_GUI_MESSENGER_VIEWS_CONTACTNOTEMANAGEVIEW:Class = ContactNoteManageView;

    public static const NET_WG_GUI_MESSENGER_VIEWS_CONTACTSSETTINGSVIEW:Class = ContactsSettingsView;

    public static const NET_WG_GUI_MESSENGER_VIEWS_GROUPDELETEVIEW:Class = GroupDeleteView;

    public static const NET_WG_GUI_MESSENGER_VIEWS_SEARCHCONTACTVIEW:Class = SearchContactView;

    public static const NET_WG_GUI_MESSENGER_WINDOWS_CHANNELWINDOW:Class = ChannelWindow;

    public static const NET_WG_GUI_MESSENGER_WINDOWS_CHANNELSMANAGEMENTWINDOW:Class = ChannelsManagementWindow;

    public static const NET_WG_GUI_MESSENGER_WINDOWS_CONNECTTOSECURECHANNELWINDOW:Class = ConnectToSecureChannelWindow;

    public static const NET_WG_GUI_MESSENGER_WINDOWS_FAQWINDOW:Class = FAQWindow;

    public static const NET_WG_GUI_MESSENGER_WINDOWS_LAZYCHANNELWINDOW:Class = LazyChannelWindow;

    public static const NET_WG_GUI_MESSENGER_WINDOWS_LOBBYCHANNELWINDOW:Class = LobbyChannelWindow;

    public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONLISTVIEW:Class = NotificationListView;

    public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONPOPUPVIEWER:Class = NotificationPopUpViewer;

    public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONTIMECOMPONENT:Class = NotificationTimeComponent;

    public static const NET_WG_GUI_NOTIFICATION_NOTIFICATIONSLIST:Class = NotificationsList;

    public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGE:Class = ServiceMessage;

    public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGEITEMRENDERER:Class = ServiceMessageItemRenderer;

    public static const NET_WG_GUI_NOTIFICATION_SERVICEMESSAGEPOPUP:Class = ServiceMessagePopUp;

    public static const NET_WG_GUI_NOTIFICATION_SYSTEMMESSAGEDIALOG:Class = SystemMessageDialog;

    public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_BUTTONSTATE:Class = ButtonState;

    public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_BUTTONTYPE:Class = ButtonType;

    public static const NET_WG_GUI_NOTIFICATION_CONSTANTS_MESSAGEMETRICS:Class = MessageMetrics;

    public static const NET_WG_GUI_NOTIFICATION_EVENTS_NOTIFICATIONLAYOUTEVENT:Class = NotificationLayoutEvent;

    public static const NET_WG_GUI_NOTIFICATION_EVENTS_NOTIFICATIONLISTEVENT:Class = NotificationListEvent;

    public static const NET_WG_GUI_NOTIFICATION_EVENTS_SERVICEMESSAGEEVENT:Class = ServiceMessageEvent;

    public static const NET_WG_GUI_NOTIFICATION_VO_BUTTONVO:Class = ButtonVO;

    public static const NET_WG_GUI_NOTIFICATION_VO_MESSAGEINFOVO:Class = MessageInfoVO;

    public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONDIALOGINITINFOVO:Class = NotificationDialogInitInfoVO;

    public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONINFOVO:Class = NotificationInfoVO;

    public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONMESSAGESLISTVO:Class = NotificationMessagesListVO;

    public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONSETTINGSVO:Class = NotificationSettingsVO;

    public static const NET_WG_GUI_NOTIFICATION_VO_NOTIFICATIONVIEWINITVO:Class = NotificationViewInitVO;

    public static const NET_WG_GUI_NOTIFICATION_VO_POPUPNOTIFICATIONINFOVO:Class = PopUpNotificationInfoVO;

    public static const NET_WG_GUI_PREBATTLE_ABSTRACT_PREBATTLEWINDOWABSTRACT:Class = PrebattleWindowAbstract;

    public static const NET_WG_GUI_PREBATTLE_ABSTRACT_PREQUEUEWINDOW:Class = PrequeueWindow;

    public static const NET_WG_GUI_PREBATTLE_BASE_BASEPREBATTLELISTVIEW:Class = BasePrebattleListView;

    public static const NET_WG_GUI_PREBATTLE_BASE_BASEPREBATTLEROOMVIEW:Class = BasePrebattleRoomView;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BSFLAGRENDERER:Class = BSFlagRenderer;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BSFLAGRENDERERVO:Class = BSFlagRendererVO;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BSLISTRENDERERVO:Class = BSListRendererVO;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONLIST:Class = BattleSessionList;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONLISTRENDERER:Class = BattleSessionListRenderer;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_BATTLESESSIONWINDOW:Class = BattleSessionWindow;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_FLAGSLIST:Class = FlagsList;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_REQUIREMENTINFO:Class = RequirementInfo;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_TOPINFO:Class = TopInfo;

    public static const NET_WG_GUI_PREBATTLE_BATTLESESSION_TOPSTATS:Class = TopStats;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANIESLISTWINDOW:Class = CompaniesListWindow;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANIESSCROLLINGLIST:Class = CompaniesScrollingList;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYDROPITEMRENDERER:Class = CompanyDropItemRenderer;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYDROPLIST:Class = CompanyDropList;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYHELPER:Class = CompanyHelper;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYLISTITEMRENDERER:Class = CompanyListItemRenderer;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYLISTVIEW:Class = CompanyListView;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYMAINWINDOW:Class = CompanyMainWindow;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYROOMHEADER:Class = CompanyRoomHeader;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYROOMVIEW:Class = CompanyRoomView;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_COMPANYWINDOW:Class = CompanyWindow;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_GROUPPLAYERSDROPDOWNMENU:Class = GroupPlayersDropDownMenu;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_VO_COMPANYHEADERCLASSLIMITSVO:Class = CompanyHeaderClassLimitsVO;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_VO_COMPANYROOMHEADERBASEVO:Class = CompanyRoomHeaderBaseVO;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_VO_COMPANYROOMHEADERVO:Class = CompanyRoomHeaderVO;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_VO_COMPANYROOMINVALIDVEHICLESVO:Class = CompanyRoomInvalidVehiclesVO;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_EVENTS_COMPANYDROPDOWNEVENT:Class = CompanyDropDownEvent;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_EVENTS_COMPANYEVENT:Class = CompanyEvent;

    public static const NET_WG_GUI_PREBATTLE_COMPANY_INTERFACES_ICOMPANYROOMHEADER:Class = ICompanyRoomHeader;

    public static const NET_WG_GUI_PREBATTLE_CONSTANTS_PREBATTLESTATEFLAGS:Class = PrebattleStateFlags;

    public static const NET_WG_GUI_PREBATTLE_CONSTANTS_PREBATTLESTATESTRING:Class = PrebattleStateString;

    public static const NET_WG_GUI_PREBATTLE_CONTROLS_TEAMMEMBERRENDERER:Class = TeamMemberRenderer;

    public static const NET_WG_GUI_PREBATTLE_CONTROLS_TEAMMEMBERRENDERERBASE:Class = net.wg.gui.prebattle.controls.TeamMemberRendererBase;

    public static const NET_WG_GUI_PREBATTLE_DATA_PLAYERPRBINFOVO:Class = PlayerPrbInfoVO;

    public static const NET_WG_GUI_PREBATTLE_DATA_RECEIVEDINVITEVO:Class = ReceivedInviteVO;

    public static const NET_WG_GUI_PREBATTLE_INVITES_INVITESTACKCONTAINERBASE:Class = InviteStackContainerBase;

    public static const NET_WG_GUI_PREBATTLE_INVITES_PRBINVITESEARCHUSERSFORM:Class = PrbInviteSearchUsersForm;

    public static const NET_WG_GUI_PREBATTLE_INVITES_RECEIVEDINVITEWINDOW:Class = ReceivedInviteWindow;

    public static const NET_WG_GUI_PREBATTLE_INVITES_SENDINVITESEVENT:Class = SendInvitesEvent;

    public static const NET_WG_GUI_PREBATTLE_INVITES_USERROSTERITEMRENDERER:Class = UserRosterItemRenderer;

    public static const NET_WG_GUI_PREBATTLE_INVITES_USERROSTERVIEW:Class = UserRosterView;

    public static const NET_WG_GUI_PREBATTLE_META_IBATTLESESSIONLISTMETA:Class = IBattleSessionListMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IBATTLESESSIONWINDOWMETA:Class = IBattleSessionWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_ICOMPANIESWINDOWMETA:Class = ICompaniesWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_ICOMPANYMAINWINDOWMETA:Class = ICompanyMainWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_ICOMPANYWINDOWMETA:Class = ICompanyWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IPREBATTLEWINDOWMETA:Class = IPrebattleWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IPREQUEUEWINDOWMETA:Class = IPrequeueWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IRECEIVEDINVITEWINDOWMETA:Class = IReceivedInviteWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_BATTLESESSIONLISTMETA:Class = BattleSessionListMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_BATTLESESSIONWINDOWMETA:Class = BattleSessionWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_COMPANIESWINDOWMETA:Class = CompaniesWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_COMPANYMAINWINDOWMETA:Class = CompanyMainWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_COMPANYWINDOWMETA:Class = CompanyWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_PREBATTLEWINDOWMETA:Class = PrebattleWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_PREQUEUEWINDOWMETA:Class = PrequeueWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_META_IMPL_RECEIVEDINVITEWINDOWMETA:Class = ReceivedInviteWindowMeta;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADABSTRACTFACTORY:Class = SquadAbstractFactory;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADCHATSECTIONBASE:Class = SquadChatSectionBase;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADPROMOWINDOW:Class = SquadPromoWindow;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADTEAMSECTIONBASE:Class = SquadTeamSectionBase;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADVIEW:Class = SquadView;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SQUADWINDOW:Class = SquadWindow;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_EV_SQUADVIEWEVENT:Class = SquadViewEvent;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_FALLOUT_FALLOUTSLOTHELPER:Class = FalloutSlotHelper;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_FALLOUT_FALLOUTSLOTRENDERER:Class = FalloutSlotRenderer;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_FALLOUT_FALLOUTTEAMSECTION:Class = FalloutTeamSection;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_FALLOUT_VO_FALLOUTRALLYSLOTVO:Class = FalloutRallySlotVO;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_FALLOUT_VO_FALLOUTRALLYVO:Class = FalloutRallyVO;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_INTERFACES_ISQUADABSTRACTFACTORY:Class = ISquadAbstractFactory;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADCHATSECTION:Class = SimpleSquadChatSection;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADSLOTHELPER:Class = SimpleSquadSlotHelper;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADSLOTRENDERER:Class = SimpleSquadSlotRenderer;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SIMPLESQUADTEAMSECTION:Class = SimpleSquadTeamSection;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_SQUADVIEWHEADERVO:Class = SquadViewHeaderVO;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_VO_SIMPLESQUADRALLYSLOTVO:Class = SimpleSquadRallySlotVO;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_VO_SIMPLESQUADRALLYVO:Class = SimpleSquadRallyVO;

    public static const NET_WG_GUI_PREBATTLE_SQUADS_SIMPLE_VO_SIMPLESQUADTEAMSECTIONVO:Class = SimpleSquadTeamSectionVO;

    public static const NET_WG_GUI_RALLY_ABSTRACTRALLYVIEW:Class = AbstractRallyView;

    public static const NET_WG_GUI_RALLY_ABSTRACTRALLYWINDOW:Class = AbstractRallyWindow;

    public static const NET_WG_GUI_RALLY_BASERALLYMAINWINDOW:Class = BaseRallyMainWindow;

    public static const NET_WG_GUI_RALLY_BASERALLYVIEW:Class = BaseRallyView;

    public static const NET_WG_GUI_RALLY_RALLYMAINWINDOWWITHSEARCH:Class = RallyMainWindowWithSearch;

    public static const NET_WG_GUI_RALLY_CONSTANTS_PLAYERSTATUS:Class = PlayerStatus;

    public static const NET_WG_GUI_RALLY_CONTROLS_BASERALLYSLOTHELPER:Class = BaseRallySlotHelper;

    public static const NET_WG_GUI_RALLY_CONTROLS_CANDIDATESSCROLLINGLIST:Class = CandidatesScrollingList;

    public static const NET_WG_GUI_RALLY_CONTROLS_MANUALSEARCHSCROLLINGLIST:Class = ManualSearchScrollingList;

    public static const NET_WG_GUI_RALLY_CONTROLS_RALLYINVALIDATIONTYPE:Class = RallyInvalidationType;

    public static const NET_WG_GUI_RALLY_CONTROLS_RALLYLOCKABLESLOTRENDERER:Class = RallyLockableSlotRenderer;

    public static const NET_WG_GUI_RALLY_CONTROLS_RALLYSIMPLESLOTRENDERER:Class = RallySimpleSlotRenderer;

    public static const NET_WG_GUI_RALLY_CONTROLS_RALLYSLOTRENDERER:Class = RallySlotRenderer;

    public static const NET_WG_GUI_RALLY_CONTROLS_SLOTDROPINDICATOR:Class = SlotDropIndicator;

    public static const NET_WG_GUI_RALLY_CONTROLS_SLOTRENDERERHELPER:Class = SlotRendererHelper;

    public static const NET_WG_GUI_RALLY_CONTROLS_VOICERALLYSLOTRENDERER:Class = VoiceRallySlotRenderer;

    public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_IRALLYSIMPLESLOTRENDERER:Class = IRallySimpleSlotRenderer;

    public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_IRALLYSLOTWITHRATING:Class = IRallySlotWithRating;

    public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_ISLOTDROPINDICATOR:Class = ISlotDropIndicator;

    public static const NET_WG_GUI_RALLY_CONTROLS_INTERFACES_ISLOTRENDERERHELPER:Class = ISlotRendererHelper;

    public static const NET_WG_GUI_RALLY_DATA_MANUALSEARCHDATAPROVIDER:Class = ManualSearchDataProvider;

    public static const NET_WG_GUI_RALLY_DATA_TOOLTIPDATAVO:Class = net.wg.gui.rally.data.TooltipDataVO;

    public static const NET_WG_GUI_RALLY_EVENTS_RALLYVIEWSEVENT:Class = RallyViewsEvent;

    public static const NET_WG_GUI_RALLY_HELPERS_RALLYDRAGDROPDELEGATE:Class = RallyDragDropDelegate;

    public static const NET_WG_GUI_RALLY_HELPERS_RALLYDRAGDROPLISTDELEGATECONTROLLER:Class = RallyDragDropListDelegateController;

    public static const NET_WG_GUI_RALLY_INTERFACES_IBASECHATSECTION:Class = IBaseChatSection;

    public static const NET_WG_GUI_RALLY_INTERFACES_IBASETEAMSECTION:Class = IBaseTeamSection;

    public static const NET_WG_GUI_RALLY_INTERFACES_ICHATSECTIONWITHDESCRIPTION:Class = IChatSectionWithDescription;

    public static const NET_WG_GUI_RALLY_INTERFACES_IMANUALSEARCHRENDERER:Class = IManualSearchRenderer;

    public static const NET_WG_GUI_RALLY_INTERFACES_IMANUALSEARCHSCROLLINGLIST:Class = IManualSearchScrollingList;

    public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYLISTITEMVO:Class = IRallyListItemVO;

    public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYNOSORTIESCREEN:Class = IRallyNoSortieScreen;

    public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYSLOTVO:Class = IRallySlotVO;

    public static const NET_WG_GUI_RALLY_INTERFACES_IRALLYVO:Class = IRallyVO;

    public static const NET_WG_GUI_RALLY_INTERFACES_ITEAMSECTIONWITHDROPINDICATORS:Class = ITeamSectionWithDropIndicators;

    public static const NET_WG_GUI_RALLY_VIEWS_INTRO_BASERALLYINTROVIEW:Class = BaseRallyIntroView;

    public static const NET_WG_GUI_RALLY_VIEWS_LIST_ABTRACTRALLYDETAILSSECTION:Class = AbtractRallyDetailsSection;

    public static const NET_WG_GUI_RALLY_VIEWS_LIST_BASERALLYDETAILSSECTION:Class = BaseRallyDetailsSection;

    public static const NET_WG_GUI_RALLY_VIEWS_LIST_BASERALLYLISTVIEW:Class = BaseRallyListView;

    public static const NET_WG_GUI_RALLY_VIEWS_LIST_RALLYNOSORTIESCREEN:Class = RallyNoSortieScreen;

    public static const NET_WG_GUI_RALLY_VIEWS_LIST_SIMPLERALLYDETAILSSECTION:Class = SimpleRallyDetailsSection;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASECHATSECTION:Class = BaseChatSection;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASERALLYROOMVIEW:Class = BaseRallyRoomView;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASERALLYROOMVIEWWITHORDERSPANEL:Class = BaseRallyRoomViewWithOrdersPanel;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASERALLYROOMVIEWWITHWAITING:Class = BaseRallyRoomViewWithWaiting;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASETEAMSECTION:Class = BaseTeamSection;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_BASEWAITLISTSECTION:Class = BaseWaitListSection;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_CHATSECTIONWITHDESCRIPTION:Class = ChatSectionWithDescription;

    public static const NET_WG_GUI_RALLY_VIEWS_ROOM_TEAMSECTIONWITHDROPINDICATORS:Class = TeamSectionWithDropIndicators;

    public static const NET_WG_GUI_RALLY_VO_ACTIONBUTTONVO:Class = ActionButtonVO;

    public static const NET_WG_GUI_RALLY_VO_INTROVEHICLEVO:Class = IntroVehicleVO;

    public static const NET_WG_GUI_RALLY_VO_RALLYCANDIDATEVO:Class = RallyCandidateVO;

    public static const NET_WG_GUI_RALLY_VO_RALLYSHORTVO:Class = RallyShortVO;

    public static const NET_WG_GUI_RALLY_VO_RALLYSLOTVO:Class = RallySlotVO;

    public static const NET_WG_GUI_RALLY_VO_RALLYVO:Class = RallyVO;

    public static const NET_WG_GUI_RALLY_VO_SETTINGROSTERVO:Class = SettingRosterVO;

    public static const NET_WG_GUI_RALLY_VO_VEHICLEALERTVO:Class = VehicleAlertVO;

    public static const NET_WG_GUI_TUTORIAL_CONSTANTS_HINTITEMTYPE:Class = HintItemType;

    public static const NET_WG_GUI_TUTORIAL_CONSTANTS_PLAYERXPLEVEL:Class = PlayerXPLevel;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_BATTLEBONUSITEM:Class = BattleBonusItem;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_BATTLEPROGRESS:Class = BattleProgress;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_CHAPTERPROGRESSITEMRENDERER:Class = ChapterProgressItemRenderer;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_FINALSTATISTICPROGRESS:Class = FinalStatisticProgress;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTBASEITEMRENDERER:Class = HintBaseItemRenderer;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTLIST:Class = HintList;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTTEXTITEMRENDERER:Class = HintTextItemRenderer;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_HINTVIDEOITEMRENDERER:Class = HintVideoItemRenderer;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_PROGRESSITEM:Class = ProgressItem;

    public static const NET_WG_GUI_TUTORIAL_CONTROLS_PROGRESSSEPARATOR:Class = ProgressSeparator;

    public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALBATTLENORESULTSMETA:Class = ITutorialBattleNoResultsMeta;

    public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALBATTLESTATISTICMETA:Class = ITutorialBattleStatisticMeta;

    public static const NET_WG_GUI_TUTORIAL_META_ITUTORIALCONFIRMREFUSEDIALOGMETA:Class = ITutorialConfirmRefuseDialogMeta;

    public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALBATTLENORESULTSMETA:Class = TutorialBattleNoResultsMeta;

    public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALBATTLESTATISTICMETA:Class = TutorialBattleStatisticMeta;

    public static const NET_WG_GUI_TUTORIAL_META_IMPL_TUTORIALCONFIRMREFUSEDIALOGMETA:Class = TutorialConfirmRefuseDialogMeta;

    public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALBATTLENORESULTSWINDOW:Class = TutorialBattleNoResultsWindow;

    public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALBATTLESTATISTICWINDOW:Class = TutorialBattleStatisticWindow;

    public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALCONFIRMREFUSEDIALOG:Class = TutorialConfirmRefuseDialog;

    public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALGREETINGDIALOG:Class = TutorialGreetingDialog;

    public static const NET_WG_GUI_TUTORIAL_WINDOWS_TUTORIALQUEUEDIALOG:Class = TutorialQueueDialog;

    public static const NET_WG_GUI_UTILS_IMAGESUBSTITUTION:Class = ImageSubstitution;

    public static const NET_WG_GUI_UTILS_VO_PRICEVO:Class = PriceVO;

    public static const NET_WG_GUI_UTILS_VO_UNITSLOTPROPERTIES:Class = UnitSlotProperties;

    public static const NET_WG_INFRASTRUCTURE_BASE_ABSTRACTCONFIRMITEMDIALOG:Class = AbstractConfirmItemDialog;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IABSTRACTRALLYVIEWMETA:Class = IAbstractRallyViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IABSTRACTRALLYWINDOWMETA:Class = IAbstractRallyWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IACADEMYVIEWMETA:Class = IAcademyViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IACCOUNTPOPOVERMETA:Class = IAccountPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IAMMUNITIONPANELMETA:Class = IAmmunitionPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IAWARDWINDOWMETA:Class = IAwardWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBARRACKSMETA:Class = IBarracksMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEEXCHANGEWINDOWMETA:Class = IBaseExchangeWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEPREBATTLELISTVIEWMETA:Class = IBasePrebattleListViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASEPREBATTLEROOMVIEWMETA:Class = IBasePrebattleRoomViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYINTROVIEWMETA:Class = IBaseRallyIntroViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYLISTVIEWMETA:Class = IBaseRallyListViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYMAINWINDOWMETA:Class = IBaseRallyMainWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYROOMVIEWMETA:Class = IBaseRallyRoomViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBASERALLYVIEWMETA:Class = IBaseRallyViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLEQUEUEMETA:Class = IBattleQueueMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLERESULTSMETA:Class = IBattleResultsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBATTLETYPESELECTPOPOVERMETA:Class = IBattleTypeSelectPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBOOSTERSWINDOWMETA:Class = IBoostersWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERMETA:Class = IBrowserMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBROWSERWINDOWMETA:Class = IBrowserWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IBUTTONWITHCOUNTERMETA:Class = IButtonWithCounterMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICALENDARMETA:Class = ICalendarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHANNELCAROUSELMETA:Class = IChannelCarouselMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHECKBOXDIALOGMETA:Class = ICheckBoxDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHRISTMASCHESTSVIEWMETA:Class = IChristmasChestsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICHRISTMASMAINVIEWMETA:Class = IChristmasMainViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESVIEWMETA:Class = IClanInvitesViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESVIEWWITHTABLEMETA:Class = IClanInvitesViewWithTableMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESWINDOWABSTRACTTABVIEWMETA:Class = IClanInvitesWindowAbstractTabViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANINVITESWINDOWMETA:Class = IClanInvitesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPERSONALINVITESVIEWMETA:Class = IClanPersonalInvitesViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPERSONALINVITESWINDOWMETA:Class = IClanPersonalInvitesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEBASEVIEWMETA:Class = IClanProfileBaseViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEFORTIFICATIONINFOVIEWMETA:Class = IClanProfileFortificationInfoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEFORTIFICATIONPROMOVIEWMETA:Class = IClanProfileFortificationPromoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEFORTIFICATIONVIEWMETA:Class = IClanProfileFortificationViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEGLOBALMAPINFOVIEWMETA:Class = IClanProfileGlobalMapInfoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEGLOBALMAPPROMOVIEWMETA:Class = IClanProfileGlobalMapPromoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEMAINWINDOWMETA:Class = IClanProfileMainWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILEPERSONNELVIEWMETA:Class = IClanProfilePersonnelViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILESUMMARYVIEWMETA:Class = IClanProfileSummaryViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANPROFILETABLESTATISTICSVIEWMETA:Class = IClanProfileTableStatisticsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANREQUESTSVIEWMETA:Class = IClanRequestsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANSEARCHINFOMETA:Class = IClanSearchInfoMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICLANSEARCHWINDOWMETA:Class = IClanSearchWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICOMPANYLISTMETA:Class = ICompanyListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICOMPANYROOMMETA:Class = ICompanyRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONFIRMDIALOGMETA:Class = IConfirmDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONFIRMEXCHANGEDIALOGMETA:Class = IConfirmExchangeDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONFIRMITEMWINDOWMETA:Class = IConfirmItemWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICONTACTSTREECOMPONENTMETA:Class = IContactsTreeComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICREWMETA:Class = ICrewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICREWOPERATIONSPOPOVERMETA:Class = ICrewOperationsPopOverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONBUYWINDOWMETA:Class = ICustomizationBuyWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONCONFIGURATIONWINDOWMETA:Class = ICustomizationConfigurationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONFILTERSPOPOVERMETA:Class = ICustomizationFiltersPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICUSTOMIZATIONMAINVIEWMETA:Class = ICustomizationMainViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTINTROMETA:Class = ICyberSportIntroMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTMAINWINDOWMETA:Class = ICyberSportMainWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTRESPAWNFORMMETA:Class = ICyberSportRespawnFormMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTRESPAWNVIEWMETA:Class = ICyberSportRespawnViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTUNITMETA:Class = ICyberSportUnitMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ICYBERSPORTUNITSLISTMETA:Class = ICyberSportUnitsListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IDEMONSTRATORWINDOWMETA:Class = IDemonstratorWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IEULAMETA:Class = IEULAMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IELITEWINDOWMETA:Class = IEliteWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEFREETOTANKMANXPWINDOWMETA:Class = IExchangeFreeToTankmanXpWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEWINDOWMETA:Class = IExchangeWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IEXCHANGEXPWINDOWMETA:Class = IExchangeXpWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFALLOUTBATTLESELECTORWINDOWMETA:Class = IFalloutBattleSelectorWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFALLOUTTANKCAROUSELMETA:Class = IFalloutTankCarouselMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFITTINGSELECTPOPOVERMETA:Class = IFittingSelectPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTBATTLEDIRECTIONPOPOVERMETA:Class = IFortBattleDirectionPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTBATTLERESULTSWINDOWMETA:Class = IFortBattleResultsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTBATTLEROOMWINDOWMETA:Class = IFortBattleRoomWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTBUILDINGCARDPOPOVERMETA:Class = IFortBuildingCardPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTBUILDINGCOMPONENTMETA:Class = IFortBuildingComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTBUILDINGPROCESSWINDOWMETA:Class = IFortBuildingProcessWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCALENDARWINDOWMETA:Class = IFortCalendarWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCHOICEDIVISIONWINDOWMETA:Class = IFortChoiceDivisionWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCLANBATTLELISTMETA:Class = IFortClanBattleListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCLANBATTLEROOMMETA:Class = IFortClanBattleRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCLANLISTWINDOWMETA:Class = IFortClanListWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCLANSTATISTICSWINDOWMETA:Class = IFortClanStatisticsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCOMBATRESERVESINTROMETA:Class = IFortCombatReservesIntroMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCREATEDIRECTIONWINDOWMETA:Class = IFortCreateDirectionWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTCREATIONCONGRATULATIONSWINDOWMETA:Class = IFortCreationCongratulationsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTDATEPICKERPOPOVERMETA:Class = IFortDatePickerPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTDECLARATIONOFWARWINDOWMETA:Class = IFortDeclarationOfWarWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTDEMOUNTBUILDINGWINDOWMETA:Class = IFortDemountBuildingWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTDISABLEDEFENCEPERIODWINDOWMETA:Class = IFortDisableDefencePeriodWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTDISCONNECTVIEWMETA:Class = IFortDisconnectViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTFIXEDPLAYERSWINDOWMETA:Class = IFortFixedPlayersWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTINTELFILTERMETA:Class = IFortIntelFilterMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTINTELLIGENCECLANDESCRIPTIONMETA:Class = IFortIntelligenceClanDescriptionMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTINTELLIGENCECLANFILTERPOPOVERMETA:Class = IFortIntelligenceClanFilterPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTINTELLIGENCENOTAVAILABLEWINDOWMETA:Class = IFortIntelligenceNotAvailableWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTINTELLIGENCEWINDOWMETA:Class = IFortIntelligenceWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTINTROMETA:Class = IFortIntroMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTLISTMETA:Class = IFortListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTMAINVIEWMETA:Class = IFortMainViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTMODERNIZATIONWINDOWMETA:Class = IFortModernizationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTNOTCOMMANDERFIRSTENTERWINDOWMETA:Class = IFortNotCommanderFirstEnterWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTORDERCONFIRMATIONWINDOWMETA:Class = IFortOrderConfirmationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTORDERINFOWINDOWMETA:Class = IFortOrderInfoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTORDERPOPOVERMETA:Class = IFortOrderPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTORDERSELECTPOPOVERMETA:Class = IFortOrderSelectPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTPERIODDEFENCEWINDOWMETA:Class = IFortPeriodDefenceWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTROOMMETA:Class = IFortRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTROSTERINTROWINDOWMETA:Class = IFortRosterIntroWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTSETTINGSDAYOFFPOPOVERMETA:Class = IFortSettingsDayoffPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTSETTINGSDEFENCEHOURPOPOVERMETA:Class = IFortSettingsDefenceHourPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTSETTINGSPERIPHERYPOPOVERMETA:Class = IFortSettingsPeripheryPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTSETTINGSVACATIONPOPOVERMETA:Class = IFortSettingsVacationPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTSETTINGSWINDOWMETA:Class = IFortSettingsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTTRANSPORTCONFIRMATIONWINDOWMETA:Class = IFortTransportConfirmationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTWELCOMEINFOVIEWMETA:Class = IFortWelcomeInfoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTWELCOMEVIEWMETA:Class = IFortWelcomeViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFORTIFICATIONSVIEWMETA:Class = IFortificationsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IFREEXPINFOWINDOWMETA:Class = IFreeXPInfoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IGETPREMIUMPOPOVERMETA:Class = IGetPremiumPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IGOLDFISHWINDOWMETA:Class = IGoldFishWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IHANGARHEADERMETA:Class = IHangarHeaderMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IHANGARMETA:Class = IHangarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IICONDIALOGMETA:Class = IIconDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IICONPRICEDIALOGMETA:Class = IIconPriceDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IINPUTCHECKERMETA:Class = IInputCheckerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IINTROPAGEMETA:Class = IIntroPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IINVENTORYMETA:Class = IInventoryMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ILEGALINFOWINDOWMETA:Class = ILegalInfoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYHEADERMETA:Class = ILobbyHeaderMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYMENUMETA:Class = ILobbyMenuMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOBBYPAGEMETA:Class = ILobbyPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOGINPAGEMETA:Class = ILoginPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ILOGINQUEUEWINDOWMETA:Class = ILoginQueueWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMESSENGERBARMETA:Class = IMessengerBarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMINICLIENTCOMPONENTMETA:Class = IMiniClientComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMISSIONAWARDWINDOWMETA:Class = IMissionAwardWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMODULEINFOMETA:Class = IModuleInfoMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMODULESPANELMETA:Class = IModulesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONLISTBUTTONMETA:Class = INotificationListButtonMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONPOPUPVIEWERMETA:Class = INotificationPopUpViewerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_INOTIFICATIONSLISTMETA:Class = INotificationsListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPERSONALCASEMETA:Class = IPersonalCaseMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPREMIUMWINDOWMETA:Class = IPremiumWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEACHIEVEMENTSECTIONMETA:Class = IProfileAchievementSectionMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEAWARDSMETA:Class = IProfileAwardsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEFORMATIONSPAGEMETA:Class = IProfileFormationsPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEMETA:Class = IProfileMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESECTIONMETA:Class = IProfileSectionMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESTATISTICSMETA:Class = IProfileStatisticsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESUMMARYMETA:Class = IProfileSummaryMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILESUMMARYWINDOWMETA:Class = IProfileSummaryWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETABNAVIGATORMETA:Class = IProfileTabNavigatorMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETECHNIQUEMETA:Class = IProfileTechniqueMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILETECHNIQUEPAGEMETA:Class = IProfileTechniquePageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROFILEWINDOWMETA:Class = IProfileWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPROMOPREMIUMIGRWINDOWMETA:Class = IPromoPremiumIgrWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPUNISHMENTDIALOGMETA:Class = IPunishmentDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IPVESANDBOXQUEUEWINDOWMETA:Class = IPvESandboxQueueWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTRECRUITWINDOWMETA:Class = IQuestRecruitWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSCONTENTTABSMETA:Class = IQuestsContentTabsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSCONTROLMETA:Class = IQuestsControlMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSCURRENTTABMETA:Class = IQuestsCurrentTabMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSPERSONALWELCOMEVIEWMETA:Class = IQuestsPersonalWelcomeViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSSEASONAWARDSWINDOWMETA:Class = IQuestsSeasonAwardsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSSEASONSVIEWMETA:Class = IQuestsSeasonsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSTABMETA:Class = IQuestsTabMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSTILECHAINSVIEWMETA:Class = IQuestsTileChainsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IQUESTSWINDOWMETA:Class = IQuestsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRALLYMAINWINDOWWITHSEARCHMETA:Class = IRallyMainWindowWithSearchMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRECRUITPARAMETERSMETA:Class = IRecruitParametersMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRECRUITWINDOWMETA:Class = IRecruitWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IREFERRALMANAGEMENTWINDOWMETA:Class = IReferralManagementWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IREFERRALREFERRALSINTROWINDOWMETA:Class = IReferralReferralsIntroWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IREFERRALREFERRERINTROWINDOWMETA:Class = IReferralReferrerIntroWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHMETA:Class = IResearchMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHPANELMETA:Class = IResearchPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRESEARCHVIEWMETA:Class = IResearchViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRETRAINCREWWINDOWMETA:Class = IRetrainCrewWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IROLECHANGEMETA:Class = IRoleChangeMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IROSTERSLOTSETTINGSWINDOWMETA:Class = IRosterSlotSettingsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IRSSNEWSFEEDMETA:Class = IRssNewsFeedMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISENDINVITESWINDOWMETA:Class = ISendInvitesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISHOPMETA:Class = IShopMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISIMPLEWINDOWMETA:Class = ISimpleWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISKILLDROPMETA:Class = ISkillDropMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISLOTSPANELMETA:Class = ISlotsPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISQUADPROMOWINDOWMETA:Class = ISquadPromoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISQUADVIEWMETA:Class = ISquadViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISQUADWINDOWMETA:Class = ISquadWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATICFORMATIONINVITESANDREQUESTSMETA:Class = IStaticFormationInvitesAndRequestsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATICFORMATIONLADDERVIEWMETA:Class = IStaticFormationLadderViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATICFORMATIONPROFILEWINDOWMETA:Class = IStaticFormationProfileWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATICFORMATIONSTAFFVIEWMETA:Class = IStaticFormationStaffViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATICFORMATIONSTATSVIEWMETA:Class = IStaticFormationStatsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATICFORMATIONSUMMARYVIEWMETA:Class = IStaticFormationSummaryViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTATICFORMATIONUNITMETA:Class = IStaticFormationUnitMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORECOMPONENTMETA:Class = IStoreComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTORETABLEMETA:Class = IStoreTableMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISTOREVIEWMETA:Class = IStoreViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISWITCHMODEPANELMETA:Class = ISwitchModePanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISWITCHPERIPHERYWINDOWMETA:Class = ISwitchPeripheryWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ISYSTEMMESSAGEDIALOGMETA:Class = ISystemMessageDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITANKCAROUSELFILTERPOPOVERMETA:Class = ITankCarouselFilterPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITANKCAROUSELMETA:Class = ITankCarouselMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITANKMANOPERATIONDIALOGMETA:Class = ITankmanOperationDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITECHTREEMETA:Class = ITechTreeMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITECHNICALMAINTENANCEMETA:Class = ITechnicalMaintenanceMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITMENXPPANELMETA:Class = ITmenXpPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGFORMMETA:Class = ITrainingFormMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGROOMMETA:Class = ITrainingRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITRAININGWINDOWMETA:Class = ITrainingWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_ITUTORIALHANGARQUESTDETAILSMETA:Class = ITutorialHangarQuestDetailsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEBUYWINDOWMETA:Class = IVehicleBuyWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPAREADDVEHICLEPOPOVERMETA:Class = IVehicleCompareAddVehiclePopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPARECARTPOPOVERMETA:Class = IVehicleCompareCartPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLECOMPAREVIEWMETA:Class = IVehicleCompareViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEINFOMETA:Class = IVehicleInfoMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEMODULESWINDOWMETA:Class = IVehicleModulesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPARAMETERSMETA:Class = IVehicleParametersMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLEPREVIEWMETA:Class = IVehiclePreviewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELECTORPOPUPMETA:Class = IVehicleSelectorPopupMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IVEHICLESELLDIALOGMETA:Class = IVehicleSellDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IWGNCDIALOGMETA:Class = IWGNCDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IWGNCPOLLWINDOWMETA:Class = IWGNCPollWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ABSTRACTRALLYVIEWMETA:Class = AbstractRallyViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ABSTRACTRALLYWINDOWMETA:Class = AbstractRallyWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ACADEMYVIEWMETA:Class = AcademyViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ACCOUNTPOPOVERMETA:Class = AccountPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AMMUNITIONPANELMETA:Class = AmmunitionPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_AWARDWINDOWMETA:Class = AwardWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BARRACKSMETA:Class = BarracksMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEEXCHANGEWINDOWMETA:Class = BaseExchangeWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEPREBATTLELISTVIEWMETA:Class = BasePrebattleListViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASEPREBATTLEROOMVIEWMETA:Class = BasePrebattleRoomViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYINTROVIEWMETA:Class = BaseRallyIntroViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYLISTVIEWMETA:Class = BaseRallyListViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYMAINWINDOWMETA:Class = BaseRallyMainWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYROOMVIEWMETA:Class = BaseRallyRoomViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BASERALLYVIEWMETA:Class = BaseRallyViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLEQUEUEMETA:Class = BattleQueueMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLERESULTSMETA:Class = BattleResultsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BATTLETYPESELECTPOPOVERMETA:Class = BattleTypeSelectPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BOOSTERSWINDOWMETA:Class = BoostersWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERMETA:Class = BrowserMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BROWSERWINDOWMETA:Class = BrowserWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_BUTTONWITHCOUNTERMETA:Class = ButtonWithCounterMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CALENDARMETA:Class = CalendarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CHANNELCAROUSELMETA:Class = ChannelCarouselMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CHECKBOXDIALOGMETA:Class = CheckBoxDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CHRISTMASCHESTSVIEWMETA:Class = ChristmasChestsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CHRISTMASMAINVIEWMETA:Class = ChristmasMainViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESVIEWMETA:Class = ClanInvitesViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESVIEWWITHTABLEMETA:Class = ClanInvitesViewWithTableMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESWINDOWABSTRACTTABVIEWMETA:Class = ClanInvitesWindowAbstractTabViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANINVITESWINDOWMETA:Class = ClanInvitesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPERSONALINVITESVIEWMETA:Class = ClanPersonalInvitesViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPERSONALINVITESWINDOWMETA:Class = ClanPersonalInvitesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEBASEVIEWMETA:Class = ClanProfileBaseViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEFORTIFICATIONINFOVIEWMETA:Class = ClanProfileFortificationInfoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEFORTIFICATIONPROMOVIEWMETA:Class = ClanProfileFortificationPromoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEFORTIFICATIONVIEWMETA:Class = ClanProfileFortificationViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEGLOBALMAPINFOVIEWMETA:Class = ClanProfileGlobalMapInfoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEGLOBALMAPPROMOVIEWMETA:Class = ClanProfileGlobalMapPromoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEMAINWINDOWMETA:Class = ClanProfileMainWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILEPERSONNELVIEWMETA:Class = ClanProfilePersonnelViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILESUMMARYVIEWMETA:Class = ClanProfileSummaryViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANPROFILETABLESTATISTICSVIEWMETA:Class = ClanProfileTableStatisticsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANREQUESTSVIEWMETA:Class = ClanRequestsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANSEARCHINFOMETA:Class = ClanSearchInfoMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CLANSEARCHWINDOWMETA:Class = ClanSearchWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_COMPANYLISTMETA:Class = CompanyListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_COMPANYROOMMETA:Class = CompanyRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONFIRMDIALOGMETA:Class = ConfirmDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONFIRMEXCHANGEDIALOGMETA:Class = ConfirmExchangeDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONFIRMITEMWINDOWMETA:Class = ConfirmItemWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CONTACTSTREECOMPONENTMETA:Class = ContactsTreeComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CREWMETA:Class = CrewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CREWOPERATIONSPOPOVERMETA:Class = CrewOperationsPopOverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONBUYWINDOWMETA:Class = CustomizationBuyWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONCONFIGURATIONWINDOWMETA:Class = CustomizationConfigurationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONFILTERSPOPOVERMETA:Class = CustomizationFiltersPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CUSTOMIZATIONMAINVIEWMETA:Class = CustomizationMainViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTINTROMETA:Class = CyberSportIntroMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTMAINWINDOWMETA:Class = CyberSportMainWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTRESPAWNFORMMETA:Class = CyberSportRespawnFormMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTRESPAWNVIEWMETA:Class = CyberSportRespawnViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTUNITMETA:Class = CyberSportUnitMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_CYBERSPORTUNITSLISTMETA:Class = CyberSportUnitsListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_DEMONSTRATORWINDOWMETA:Class = DemonstratorWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EULAMETA:Class = EULAMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ELITEWINDOWMETA:Class = EliteWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEFREETOTANKMANXPWINDOWMETA:Class = ExchangeFreeToTankmanXpWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEWINDOWMETA:Class = ExchangeWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_EXCHANGEXPWINDOWMETA:Class = ExchangeXpWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FALLOUTBATTLESELECTORWINDOWMETA:Class = FalloutBattleSelectorWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FALLOUTTANKCAROUSELMETA:Class = FalloutTankCarouselMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FITTINGSELECTPOPOVERMETA:Class = FittingSelectPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTBATTLEDIRECTIONPOPOVERMETA:Class = FortBattleDirectionPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTBATTLERESULTSWINDOWMETA:Class = FortBattleResultsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTBATTLEROOMWINDOWMETA:Class = FortBattleRoomWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTBUILDINGCARDPOPOVERMETA:Class = FortBuildingCardPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTBUILDINGCOMPONENTMETA:Class = FortBuildingComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTBUILDINGPROCESSWINDOWMETA:Class = FortBuildingProcessWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCALENDARWINDOWMETA:Class = FortCalendarWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCHOICEDIVISIONWINDOWMETA:Class = FortChoiceDivisionWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCLANBATTLELISTMETA:Class = FortClanBattleListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCLANBATTLEROOMMETA:Class = FortClanBattleRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCLANLISTWINDOWMETA:Class = FortClanListWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCLANSTATISTICSWINDOWMETA:Class = FortClanStatisticsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCOMBATRESERVESINTROMETA:Class = FortCombatReservesIntroMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCREATEDIRECTIONWINDOWMETA:Class = FortCreateDirectionWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTCREATIONCONGRATULATIONSWINDOWMETA:Class = FortCreationCongratulationsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTDATEPICKERPOPOVERMETA:Class = FortDatePickerPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTDECLARATIONOFWARWINDOWMETA:Class = FortDeclarationOfWarWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTDEMOUNTBUILDINGWINDOWMETA:Class = FortDemountBuildingWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTDISABLEDEFENCEPERIODWINDOWMETA:Class = FortDisableDefencePeriodWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTDISCONNECTVIEWMETA:Class = FortDisconnectViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTFIXEDPLAYERSWINDOWMETA:Class = FortFixedPlayersWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTINTELFILTERMETA:Class = FortIntelFilterMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTINTELLIGENCECLANDESCRIPTIONMETA:Class = FortIntelligenceClanDescriptionMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTINTELLIGENCECLANFILTERPOPOVERMETA:Class = FortIntelligenceClanFilterPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTINTELLIGENCENOTAVAILABLEWINDOWMETA:Class = FortIntelligenceNotAvailableWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTINTELLIGENCEWINDOWMETA:Class = FortIntelligenceWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTINTROMETA:Class = FortIntroMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTLISTMETA:Class = FortListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTMAINVIEWMETA:Class = FortMainViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTMODERNIZATIONWINDOWMETA:Class = FortModernizationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTNOTCOMMANDERFIRSTENTERWINDOWMETA:Class = FortNotCommanderFirstEnterWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTORDERCONFIRMATIONWINDOWMETA:Class = FortOrderConfirmationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTORDERINFOWINDOWMETA:Class = FortOrderInfoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTORDERPOPOVERMETA:Class = FortOrderPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTORDERSELECTPOPOVERMETA:Class = FortOrderSelectPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTPERIODDEFENCEWINDOWMETA:Class = FortPeriodDefenceWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTROOMMETA:Class = FortRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTROSTERINTROWINDOWMETA:Class = FortRosterIntroWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTSETTINGSDAYOFFPOPOVERMETA:Class = FortSettingsDayoffPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTSETTINGSDEFENCEHOURPOPOVERMETA:Class = FortSettingsDefenceHourPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTSETTINGSPERIPHERYPOPOVERMETA:Class = FortSettingsPeripheryPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTSETTINGSVACATIONPOPOVERMETA:Class = FortSettingsVacationPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTSETTINGSWINDOWMETA:Class = FortSettingsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTTRANSPORTCONFIRMATIONWINDOWMETA:Class = FortTransportConfirmationWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTWELCOMEINFOVIEWMETA:Class = FortWelcomeInfoViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTWELCOMEVIEWMETA:Class = FortWelcomeViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FORTIFICATIONSVIEWMETA:Class = FortificationsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_FREEXPINFOWINDOWMETA:Class = FreeXPInfoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_GETPREMIUMPOPOVERMETA:Class = GetPremiumPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_GOLDFISHWINDOWMETA:Class = GoldFishWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_HANGARHEADERMETA:Class = HangarHeaderMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_HANGARMETA:Class = HangarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ICONDIALOGMETA:Class = IconDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ICONPRICEDIALOGMETA:Class = IconPriceDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INPUTCHECKERMETA:Class = InputCheckerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INTROPAGEMETA:Class = IntroPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_INVENTORYMETA:Class = InventoryMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LEGALINFOWINDOWMETA:Class = LegalInfoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYHEADERMETA:Class = LobbyHeaderMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYMENUMETA:Class = LobbyMenuMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOBBYPAGEMETA:Class = LobbyPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOGINPAGEMETA:Class = LoginPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_LOGINQUEUEWINDOWMETA:Class = LoginQueueWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MESSENGERBARMETA:Class = MessengerBarMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MINICLIENTCOMPONENTMETA:Class = MiniClientComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MISSIONAWARDWINDOWMETA:Class = MissionAwardWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MODULEINFOMETA:Class = ModuleInfoMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_MODULESPANELMETA:Class = ModulesPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONLISTBUTTONMETA:Class = NotificationListButtonMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONPOPUPVIEWERMETA:Class = NotificationPopUpViewerMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_NOTIFICATIONSLISTMETA:Class = NotificationsListMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PERSONALCASEMETA:Class = PersonalCaseMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PREMIUMWINDOWMETA:Class = PremiumWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEACHIEVEMENTSECTIONMETA:Class = ProfileAchievementSectionMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEAWARDSMETA:Class = ProfileAwardsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEFORMATIONSPAGEMETA:Class = ProfileFormationsPageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEMETA:Class = ProfileMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESECTIONMETA:Class = ProfileSectionMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESTATISTICSMETA:Class = ProfileStatisticsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESUMMARYMETA:Class = ProfileSummaryMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILESUMMARYWINDOWMETA:Class = ProfileSummaryWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETABNAVIGATORMETA:Class = ProfileTabNavigatorMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETECHNIQUEMETA:Class = ProfileTechniqueMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILETECHNIQUEPAGEMETA:Class = ProfileTechniquePageMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROFILEWINDOWMETA:Class = ProfileWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PROMOPREMIUMIGRWINDOWMETA:Class = PromoPremiumIgrWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PUNISHMENTDIALOGMETA:Class = PunishmentDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_PVESANDBOXQUEUEWINDOWMETA:Class = PvESandboxQueueWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTRECRUITWINDOWMETA:Class = QuestRecruitWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSCONTENTTABSMETA:Class = QuestsContentTabsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSCONTROLMETA:Class = QuestsControlMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSCURRENTTABMETA:Class = QuestsCurrentTabMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSPERSONALWELCOMEVIEWMETA:Class = QuestsPersonalWelcomeViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSSEASONAWARDSWINDOWMETA:Class = QuestsSeasonAwardsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSSEASONSVIEWMETA:Class = QuestsSeasonsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSTABMETA:Class = QuestsTabMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSTILECHAINSVIEWMETA:Class = QuestsTileChainsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_QUESTSWINDOWMETA:Class = QuestsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RALLYMAINWINDOWWITHSEARCHMETA:Class = RallyMainWindowWithSearchMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RECRUITPARAMETERSMETA:Class = RecruitParametersMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RECRUITWINDOWMETA:Class = RecruitWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_REFERRALMANAGEMENTWINDOWMETA:Class = ReferralManagementWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_REFERRALREFERRALSINTROWINDOWMETA:Class = ReferralReferralsIntroWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_REFERRALREFERRERINTROWINDOWMETA:Class = ReferralReferrerIntroWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHMETA:Class = ResearchMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHPANELMETA:Class = ResearchPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RESEARCHVIEWMETA:Class = ResearchViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RETRAINCREWWINDOWMETA:Class = RetrainCrewWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ROLECHANGEMETA:Class = RoleChangeMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_ROSTERSLOTSETTINGSWINDOWMETA:Class = RosterSlotSettingsWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_RSSNEWSFEEDMETA:Class = RssNewsFeedMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SENDINVITESWINDOWMETA:Class = SendInvitesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SHOPMETA:Class = ShopMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SIMPLEWINDOWMETA:Class = SimpleWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SKILLDROPMETA:Class = SkillDropMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SLOTSPANELMETA:Class = SlotsPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SQUADPROMOWINDOWMETA:Class = SquadPromoWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SQUADVIEWMETA:Class = SquadViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SQUADWINDOWMETA:Class = SquadWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATICFORMATIONINVITESANDREQUESTSMETA:Class = StaticFormationInvitesAndRequestsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATICFORMATIONLADDERVIEWMETA:Class = StaticFormationLadderViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATICFORMATIONPROFILEWINDOWMETA:Class = StaticFormationProfileWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATICFORMATIONSTAFFVIEWMETA:Class = StaticFormationStaffViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATICFORMATIONSTATSVIEWMETA:Class = StaticFormationStatsViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATICFORMATIONSUMMARYVIEWMETA:Class = StaticFormationSummaryViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STATICFORMATIONUNITMETA:Class = StaticFormationUnitMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORECOMPONENTMETA:Class = StoreComponentMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STORETABLEMETA:Class = StoreTableMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_STOREVIEWMETA:Class = StoreViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SWITCHMODEPANELMETA:Class = SwitchModePanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SWITCHPERIPHERYWINDOWMETA:Class = SwitchPeripheryWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_SYSTEMMESSAGEDIALOGMETA:Class = SystemMessageDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TANKCAROUSELFILTERPOPOVERMETA:Class = TankCarouselFilterPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TANKCAROUSELMETA:Class = TankCarouselMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TANKMANOPERATIONDIALOGMETA:Class = TankmanOperationDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TECHTREEMETA:Class = TechTreeMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TECHNICALMAINTENANCEMETA:Class = TechnicalMaintenanceMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TMENXPPANELMETA:Class = TmenXpPanelMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGFORMMETA:Class = TrainingFormMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGROOMMETA:Class = TrainingRoomMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TRAININGWINDOWMETA:Class = TrainingWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_TUTORIALHANGARQUESTDETAILSMETA:Class = TutorialHangarQuestDetailsMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEBUYWINDOWMETA:Class = VehicleBuyWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPAREADDVEHICLEPOPOVERMETA:Class = VehicleCompareAddVehiclePopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPARECARTPOPOVERMETA:Class = VehicleCompareCartPopoverMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLECOMPAREVIEWMETA:Class = VehicleCompareViewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEINFOMETA:Class = VehicleInfoMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEMODULESWINDOWMETA:Class = VehicleModulesWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPARAMETERSMETA:Class = VehicleParametersMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLEPREVIEWMETA:Class = VehiclePreviewMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELECTORPOPUPMETA:Class = VehicleSelectorPopupMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_VEHICLESELLDIALOGMETA:Class = VehicleSellDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WGNCDIALOGMETA:Class = WGNCDialogMeta;

    public static const NET_WG_INFRASTRUCTURE_BASE_META_IMPL_WGNCPOLLWINDOWMETA:Class = WGNCPollWindowMeta;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_DRAGEVENT:Class = DragEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_DROPEVENT:Class = DropEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_FOCUSCHAINCHANGEEVENT:Class = FocusChainChangeEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_FOCUSEDVIEWEVENT:Class = FocusedViewEvent;

    public static const NET_WG_INFRASTRUCTURE_EVENTS_GAMEEVENT:Class = GameEvent;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_DRAGDELEGATE:Class = DragDelegate;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_DRAGDELEGATECONTROLLER:Class = DragDelegateController;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_DROPLISTDELEGATE:Class = DropListDelegate;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_DROPLISTDELEGATECTRLR:Class = DropListDelegateCtrlr;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_LOADEREX:Class = LoaderEx;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_INTERFACES_IDRAGDELEGATE:Class = IDragDelegate;

    public static const NET_WG_INFRASTRUCTURE_HELPERS_INTERFACES_IDROPLISTDELEGATE:Class = IDropListDelegate;

    public static const NET_WG_INFRASTRUCTURE_INTERFACES_ISORTABLE:Class = ISortable;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALBUILDER:Class = TutorialBuilder;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALCUSTOMHINTBUILDER:Class = TutorialCustomHintBuilder;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALHINTBUILDER:Class = TutorialHintBuilder;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALOVERLAYBUILDER:Class = TutorialOverlayBuilder;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALRESEARCHOVERLAYBLDR:Class = TutorialResearchOverlayBldr;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_BUILDERS_TUTORIALTECHTREEOVERLAYBLDR:Class = TutorialTechTreeOverlayBldr;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALHELPBTNCONTROLLER:Class = TutorialHelpBtnController;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALRESEARCHHELPBTNCTRLLR:Class = TutorialResearchHelpBtnCtrllr;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALTECHTREEHELPBTNCTRLLR:Class = TutorialTechTreeHelpBtnCtrllr;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALVIEWHELPBTNCTRLLR:Class = TutorialViewHelpBtnCtrllr;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_TUTORIALWINDOWHELPBTNCTRLLR:Class = TutorialWindowHelpBtnCtrllr;

    public static const NET_WG_INFRASTRUCTURE_TUTORIAL_HELPBTNCONTROLLERS_INTERFACES_ITUTORIALHELPBTNCONTROLLER:Class = ITutorialHelpBtnController;

    public function ClassManagerMeta() {
        super();
    }
}
}
