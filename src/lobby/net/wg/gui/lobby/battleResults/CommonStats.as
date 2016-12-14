package net.wg.gui.lobby.battleResults {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.data.constants.ArenaBonusTypes;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.CounterEx;
import net.wg.gui.components.controls.ResizableScrollPane;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.events.FinalStatisticEvent;
import net.wg.gui.lobby.battleResults.components.AlertMessage;
import net.wg.gui.lobby.battleResults.components.BattleResultsMedalsList;
import net.wg.gui.lobby.battleResults.components.DetailsBlock;
import net.wg.gui.lobby.battleResults.components.EfficiencyHeader;
import net.wg.gui.lobby.battleResults.components.TankStatsView;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
import net.wg.gui.lobby.battleResults.data.IconEfficiencyTooltipData;
import net.wg.gui.lobby.battleResults.data.OvertimeVO;
import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
import net.wg.gui.lobby.battleResults.event.ClanEmblemRequestEvent;
import net.wg.gui.lobby.battleResults.managers.impl.StatsUtilsManager;
import net.wg.gui.lobby.battleResults.progressReport.ProgressReportLinkageSelector;
import net.wg.gui.lobby.questsWindow.ISubtaskListLinkageSelector;
import net.wg.gui.lobby.questsWindow.SubtasksList;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IFormattedInt;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.utils.ILocale;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.gfx.TextFieldEx;

public class CommonStats extends UIComponentEx implements IViewStackContent, IEmblemLoadedDelegate {

    private static const COUNTERS_SCALE:Number = 0.9;

    private static const COUNTER_LEFT_OFFSET:int = -17;

    private static const CREDITS_COUNTER_TOP_OFFSET:int = -10;

    private static const XP_COUNTER_TOP_OFFSET:int = -14;

    private static const CREDITS_ICON_TOP_OFFSET:int = -15;

    private static const XP_ICON_TOP_OFFSET:int = -16;

    private static const RES_ICON_LEFT_OFFSET:int = 8;

    private static const ARENA_NAME_Y_WITH_ICON:int = 229;

    private static const RESULT_DEFAULT_Y:int = 23;

    private static const RESULT_MULTIPLE_FINISH_REASON_Y:int = -5;

    private static const ARENA_ENEMY_CLAN_EMBLEM:String = "arenaEnemyClanEmblem";

    private static const TEAM_ENEMY_EMBLEM_COMMON:String = "teamEnemyEmblemCommon";

    private static const SORTIE_STATE:String = "sortie";

    private static const LABEL_PLAYER_NAME:String = "playerName";

    public var resultLbl:TextField;

    public var finishReasonLbl:TextField;

    public var arenaNameLbl:TextField;

    public var noEfficiencyLbl:TextField;

    public var efficiencyTitle:TextField;

    public var tankSlot:TankStatsView;

    public var efficiencyList:ScrollingListEx;

    public var detailsMc:DetailsBlock;

    public var imageSwitcher_mc:MovieClip;

    public var medalsListLeft:BattleResultsMedalsList;

    public var medalsListRight:BattleResultsMedalsList;

    public var xpIcon:DisplayObject;

    public var creditsIcon:DisplayObject;

    public var resIcon:DisplayObject;

    public var creditsCounter:CounterEx;

    public var xpCounter:CounterEx;

    public var resCounter:CounterEx;

    public var scrollPane:ResizableScrollPane;

    public var subtasksScrollBar:ScrollBar;

    public var upperShadow:DisplayObjectContainer;

    public var lowerShadow:DisplayObjectContainer;

    public var noProgressTF:TextField;

    public var noIncomeAlert:AlertMessage;

    public var progressInfoBG:DisplayObject;

    public var overtimeFinishReasonTitle:TextField;

    public var mainFinishReasonTitle:TextField;

    public var overtimeFinishReason:TextField;

    public var mainFinishReason:TextField;

    public var overtimeBg:DisplayObject;

    public var efficiencyHeader:EfficiencyHeader;

    private var _progressReport:SubtasksList;

    private var _creditsCounterNumber:Number;

    private var _xpCounterNumber:Number;

    private var _resCounterNumber:Number;

    private var _unlocksAndQuests:Array;

    private var _linkageSelector:ISubtaskListLinkageSelector;

    private var _data:BattleResultsVO;

    public function CommonStats() {
        this._linkageSelector = new ProgressReportLinkageSelector();
        super();
    }

    private static function onEfficiencyIconRollOutHandler(param1:FinalStatisticEvent):void {
        App.toolTipMgr.hide();
    }

    override protected function onDispose():void {
        this.tryCleanMedalListDataProviders();
        this.detailsMc.detailedReportBtn.removeEventListener(ButtonEvent.CLICK, this.onDetailsClickHandler);
        this.efficiencyList.removeEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER, this.onEfficiencyIconRollOverHandler);
        this.efficiencyList.removeEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OUT, onEfficiencyIconRollOutHandler);
        this.tankSlot.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        this.noIncomeAlert.dispose();
        this.tankSlot.dispose();
        this.efficiencyList.dispose();
        this.detailsMc.dispose();
        this.medalsListLeft.dispose();
        this.medalsListRight.dispose();
        this.creditsCounter.dispose();
        this.xpCounter.dispose();
        this.resCounter.dispose();
        this.subtasksScrollBar.dispose();
        this._unlocksAndQuests.splice(0, this._unlocksAndQuests.length);
        this.noIncomeAlert = null;
        this.progressInfoBG = null;
        this.resultLbl = null;
        this.finishReasonLbl = null;
        this.arenaNameLbl = null;
        this.noEfficiencyLbl = null;
        this.efficiencyTitle = null;
        this.tankSlot = null;
        this.efficiencyList = null;
        this.detailsMc = null;
        this.imageSwitcher_mc = null;
        this.medalsListLeft = null;
        this.medalsListRight = null;
        this.xpIcon = null;
        this.creditsIcon = null;
        this.resIcon = null;
        this.creditsCounter = null;
        this.xpCounter = null;
        this.resCounter = null;
        this.efficiencyHeader.dispose();
        this.efficiencyHeader = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        this.subtasksScrollBar = null;
        this._progressReport = null;
        this.upperShadow = null;
        this.lowerShadow = null;
        this.noProgressTF = null;
        this.overtimeFinishReasonTitle = null;
        this.mainFinishReasonTitle = null;
        this.overtimeFinishReason = null;
        this.mainFinishReason = null;
        this.overtimeBg = null;
        this._unlocksAndQuests = null;
        this._linkageSelector.dispose();
        this._linkageSelector = null;
        this._data = null;
        super.onDispose();
    }

    override protected function configUI():void {
        super.configUI();
        this.width = this.width ^ 0;
        this.height = this.height ^ 0;
        this.upperShadow.mouseEnabled = false;
        this.upperShadow.mouseChildren = false;
        this.lowerShadow.mouseEnabled = false;
        this.lowerShadow.mouseChildren = false;
        this.efficiencyList.visible = false;
    }

    override protected function draw():void {
        super.draw();
        if (this._data != null && (isInvalid(InvalidationType.DATA) || isInvalid(InvalidationType.SIZE))) {
            this.tankSlot.validateNow();
            this.efficiencyList.validateNow();
            this.detailsMc.validateNow();
            this.medalsListLeft.validateNow();
            this.medalsListRight.validateNow();
            this.creditsCounter.validateNow();
            this.xpCounter.validateNow();
            this.resCounter.validateNow();
            this.visible = true;
        }
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function onEmblemLoaded(param1:String, param2:String, param3:String):void {
        var _loc4_:String = null;
        var _loc5_:String = null;
        if (param1 == TEAM_ENEMY_EMBLEM_COMMON || param1 == ARENA_ENEMY_CLAN_EMBLEM) {
            this.arenaNameLbl.y = ARENA_NAME_Y_WITH_ICON;
            _loc4_ = param2 != null ? param2 + Values.SPACE_STR : Values.EMPTY_STR;
            _loc5_ = param3 != null ? Values.SPACE_STR + param3 : Values.EMPTY_STR;
            this.arenaNameLbl.htmlText = this.arenaNameLbl.htmlText + (_loc4_ + this._data.common.clans.enemies.clanAbbrev + _loc5_);
        }
    }

    public function update(param1:Object):void {
        var _loc2_:PersonalDataVO = null;
        var _loc3_:CommonStatsVO = null;
        var _loc4_:Array = null;
        var _loc5_:Array = null;
        var _loc6_:Boolean = false;
        if (this._data == null) {
            this._data = BattleResultsVO(param1);
            _loc2_ = this._data.personal;
            _loc3_ = this._data.common;
            _loc4_ = this._data.quests;
            _loc5_ = this._data.unlocks;
            this._unlocksAndQuests = StatsUtilsManager.getInstance().mergeArrays(_loc5_, _loc4_);
            this.initCounters(_loc2_.creditsStr, _loc2_.xpStr);
            if (_loc3_.falloutMode == Values.EMPTY_STR) {
                this.efficiencyTitle.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_TITLE;
            }
            else {
                this.efficiencyTitle.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCYWITHOUTOREDERS_TITLE;
            }
            this.initResultText(_loc3_);
            this.imageSwitcher_mc.gotoAndStop(_loc3_.resultShortStr);
            this.arenaNameLbl.htmlText = _loc3_.arenaStr;
            this.tankSlot.setData(this._data);
            this.tankSlot.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
            this.resCounter.visible = false;
            this.resIcon.visible = false;
            if (_loc3_.bonusType == ArenaBonusTypes.FORT_BATTLE) {
                this.showClan(_loc3_);
            }
            else if (_loc3_.bonusType == ArenaBonusTypes.SORTIE) {
                this.showClan(_loc3_);
                this.initSortieArena(_loc2_);
            }
            this.tryCleanMedalListDataProviders();
            this.medalsListLeft.dataProvider = new DataProvider(_loc2_.achievementsLeft);
            this.medalsListRight.dataProvider = new DataProvider(_loc2_.achievementsRight);
            this.initEfficiencyList(_loc2_);
            this.initEfficiencyHeader(_loc2_);
            _loc6_ = _loc2_.showNoIncomeAlert;
            this.setNoIncomeVisible(_loc6_);
            if (!_loc6_) {
                this.detailsMc.data = _loc2_;
                this.detailsMc.detailedReportBtn.addEventListener(ButtonEvent.CLICK, this.onDetailsClickHandler);
                this.initProgressReport(_loc5_.length);
                this.subtasksScrollBar.visible = true;
            }
            else {
                this.noIncomeAlert.setData(_loc2_.noIncomeAlert);
                this.layoutNoIncomeAlert();
            }
        }
        if (this._data.common.playerVehicles.length > 1) {
            this.tankSlot.setVehicleIdxInGarageDropdown(this._data.selectedIdxInGarageDropdown);
        }
        invalidateSize();
        this.medalsListLeft.invalidateData();
        this.medalsListRight.invalidateData();
    }

    private function initEfficiencyHeader(param1:PersonalDataVO):void {
        if (param1) {
            this.efficiencyHeader.setData(param1.efficiencyHeader);
            this.efficiencyHeader.visible = true;
        }
        else {
            this.efficiencyHeader.visible = false;
        }
    }

    private function initResultText(param1:CommonStatsVO):void {
        var _loc2_:OvertimeVO = param1.overtime;
        this.resultLbl.text = param1.resultStr;
        this.resultLbl.y = !!_loc2_.enabled ? Number(RESULT_MULTIPLE_FINISH_REASON_Y) : Number(RESULT_DEFAULT_Y);
        this.overtimeBg.visible = _loc2_.enabled;
        this.mainFinishReasonTitle.visible = _loc2_.enabled;
        this.mainFinishReason.visible = _loc2_.enabled;
        this.overtimeFinishReasonTitle.visible = _loc2_.enabled;
        this.overtimeFinishReason.visible = _loc2_.enabled;
        this.finishReasonLbl.visible = !_loc2_.enabled;
        if (_loc2_.enabled) {
            this.mainFinishReasonTitle.text = _loc2_.mainTitle;
            this.mainFinishReason.text = param1.finishReasonStr;
            this.overtimeFinishReasonTitle.text = _loc2_.overtimeTitle;
            this.overtimeFinishReason.text = _loc2_.overtimeFinishReason;
        }
        else {
            this.finishReasonLbl.text = param1.finishReasonStr;
        }
    }

    private function tryCleanMedalListDataProviders():void {
        if (this.medalsListLeft.dataProvider != null) {
            this.medalsListLeft.dataProvider.cleanUp();
            this.medalsListLeft.dataProvider = null;
        }
        if (this.medalsListRight.dataProvider != null) {
            this.medalsListRight.dataProvider.cleanUp();
            this.medalsListRight.dataProvider = null;
        }
    }

    private function layoutNoIncomeAlert():void {
        var _loc1_:Number = this.detailsMc.x;
        var _loc2_:Number = this.detailsMc.y;
        var _loc3_:Number = this.detailsMc.width;
        var _loc4_:Number = height - this.detailsMc.y;
        this.noIncomeAlert.x = _loc1_ + (_loc3_ - this.noIncomeAlert.width >> 1) | 0;
        this.noIncomeAlert.y = _loc2_ + (_loc4_ - this.noIncomeAlert.height >> 1) | 0;
    }

    private function setNoIncomeVisible(param1:Boolean):void {
        this.noIncomeAlert.visible = param1;
        if (this._progressReport != null) {
            this._progressReport.visible = !param1;
        }
        this.detailsMc.visible = !param1;
        this.lowerShadow.visible = !param1;
        this.upperShadow.visible = !param1;
        this.subtasksScrollBar.visible = !param1;
        this.noProgressTF.visible = !param1;
        this.subtasksScrollBar.visible = !param1;
        this.progressInfoBG.visible = !param1;
    }

    private function showClan(param1:Object):void {
        dispatchEvent(new ClanEmblemRequestEvent(ARENA_ENEMY_CLAN_EMBLEM, param1.clans.enemies.clanDBID, this));
    }

    private function initSortieArena(param1:PersonalDataVO):void {
        var _loc3_:IFormattedInt = null;
        var _loc2_:ILocale = App.utils.locale;
        this.detailsMc.gotoAndStop(SORTIE_STATE);
        if (!param1.isLegionnaire) {
            this.resCounter.visible = true;
            this.resIcon.visible = true;
            _loc3_ = _loc2_.parseFormattedInteger(param1.fortResourceTotal);
            this.resCounter.init(_loc3_.value, _loc2_.cutCharsBeforeNumber(param1.fortResourceTotal), _loc3_.delimiter, this._resCounterNumber != _loc3_.value);
            this._resCounterNumber = _loc3_.value;
            this.resCounter.x = (this.imageSwitcher_mc.width + this.resCounter.metricsWidth >> 1) + COUNTER_LEFT_OFFSET ^ 0;
            this.alignSortieControls();
        }
    }

    private function alignSortieControls():void {
        this.resIcon.x = this.resCounter.x + RES_ICON_LEFT_OFFSET;
        this.resCounter.scaleX = this.resCounter.scaleY = COUNTERS_SCALE;
        this.creditsCounter.y = this.creditsCounter.y + CREDITS_COUNTER_TOP_OFFSET;
        this.creditsCounter.scaleX = this.creditsCounter.scaleY = COUNTERS_SCALE;
        this.creditsIcon.y = this.creditsIcon.y + CREDITS_ICON_TOP_OFFSET;
        this.xpCounter.y = this.xpCounter.y + XP_COUNTER_TOP_OFFSET;
        this.xpCounter.scaleX = this.xpCounter.scaleY = COUNTERS_SCALE;
        this.xpIcon.y = this.xpIcon.y + XP_ICON_TOP_OFFSET;
    }

    private function initEfficiencyList(param1:PersonalDataVO):void {
        this.efficiencyList.addEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER, this.onEfficiencyIconRollOverHandler);
        this.efficiencyList.addEventListener(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OUT, onEfficiencyIconRollOutHandler);
        if (param1.details && param1.details.length > 0) {
            this.noEfficiencyLbl.visible = false;
            this.efficiencyList.labelField = LABEL_PLAYER_NAME;
            this.tryCleanEfficiencyListDataProvider();
            this.efficiencyList.dataProvider = new DataProvider(param1.details[0]);
            App.utils.scheduler.scheduleOnNextFrame(this.showEfficiencyList);
        }
        else {
            this.efficiencyList.visible = false;
            this.noEfficiencyLbl.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_NONE;
            this.noEfficiencyLbl.visible = true;
        }
    }

    private function showEfficiencyList():void {
        this.efficiencyList.visible = true;
    }

    private function initProgressReport(param1:int):void {
        this._progressReport = SubtasksList(this.scrollPane.target);
        this._progressReport.linkage = Linkages.BR_SUBTASK_COMPONENT_UI;
        if (this._unlocksAndQuests && this._unlocksAndQuests.length > 0) {
            this._linkageSelector.setUnlocksCount(param1);
            this._progressReport.setLinkageSelector(this._linkageSelector);
            this._progressReport.setData(this._unlocksAndQuests);
            this.noProgressTF.visible = false;
        }
        else {
            this.lowerShadow.visible = false;
            this.upperShadow.visible = false;
            this._progressReport.visible = false;
            this.subtasksScrollBar.visible = false;
            this.noProgressTF.visible = true;
            this.noProgressTF.text = BATTLE_RESULTS.COMMON_NOPROGRESS;
            TextFieldEx.setVerticalAlign(this.noProgressTF, TextFieldEx.VALIGN_CENTER);
        }
    }

    private function initCounters(param1:String, param2:String):void {
        var _loc3_:ILocale = App.utils.locale;
        var _loc4_:IFormattedInt = _loc3_.parseFormattedInteger(param1);
        this.creditsCounter.init(_loc4_.value, param1, _loc4_.delimiter, this._creditsCounterNumber != _loc4_.value);
        this._creditsCounterNumber = _loc4_.value;
        this.creditsIcon.x = this.creditsCounter.x = (this.imageSwitcher_mc.width + this.creditsCounter.metricsWidth >> 1) + COUNTER_LEFT_OFFSET ^ 0;
        var _loc5_:IFormattedInt = _loc3_.parseFormattedInteger(param2);
        this.xpCounter.init(_loc5_.value, _loc3_.cutCharsBeforeNumber(param2), _loc5_.delimiter, this._xpCounterNumber != _loc5_.value);
        this._xpCounterNumber = _loc5_.value;
        this.xpIcon.x = this.xpCounter.x = (this.imageSwitcher_mc.width + this.xpCounter.metricsWidth >> 1) + COUNTER_LEFT_OFFSET ^ 0;
    }

    private function tryCleanEfficiencyListDataProvider():void {
        if (this.efficiencyList.dataProvider != null) {
            this.efficiencyList.dataProvider.cleanUp();
        }
    }

    private function onDetailsClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new BattleResultsViewEvent(BattleResultsViewEvent.SHOW_DETAILS));
    }

    private function onDropDownIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:int = param1.index;
        var _loc3_:Array = this._data.personal.details[_loc2_];
        this.tryCleanEfficiencyListDataProvider();
        this.efficiencyList.dataProvider = new DataProvider(_loc3_);
        this.detailsMc.currentSelectedVehIdx = _loc2_;
    }

    private function onEfficiencyIconRollOverHandler(param1:FinalStatisticEvent):void {
        var _loc3_:* = false;
        var _loc4_:IconEfficiencyTooltipData = null;
        var _loc2_:Object = param1.data;
        if (_loc2_.hoveredKind) {
            _loc3_ = this._data.common.playerVehicles.length > 1;
            _loc4_ = new IconEfficiencyTooltipData();
            _loc4_.type = _loc2_.hoveredKind;
            _loc4_.disabled = _loc2_.isDisabled;
            _loc4_.isGarage = _loc3_;
            switch (_loc2_.hoveredKind) {
                case BATTLE_EFFICIENCY_TYPES.DAMAGE:
                    _loc4_.setBaseValues(_loc2_.damageDealtVals, _loc2_.damageDealtNames, _loc2_.damageTotalItems);
                    break;
                case BATTLE_EFFICIENCY_TYPES.ARMOR:
                    _loc4_.setBaseValues(_loc2_.armorVals, _loc2_.armorNames, _loc2_.armorTotalItems);
                    break;
                case BATTLE_EFFICIENCY_TYPES.CAPTURE:
                    _loc4_.setBaseValues(_loc2_.captureVals, _loc2_.captureNames, _loc2_.captureTotalItems);
                    break;
                case BATTLE_EFFICIENCY_TYPES.DEFENCE:
                    _loc4_.setBaseValues(_loc2_.defenceVals, _loc2_.defenceNames, _loc2_.defenceTotalItems);
                    break;
                case BATTLE_EFFICIENCY_TYPES.ASSIST:
                    _loc4_.totalAssistedDamage = _loc2_.damageAssisted;
                    _loc4_.setBaseValues(_loc2_.damageAssistedVals, _loc2_.damageAssistedNames, _loc2_.assistTotalItems);
                    break;
                case BATTLE_EFFICIENCY_TYPES.CRITS:
                    _loc4_.setCritValues(_loc2_.criticalDevices, _loc2_.destroyedTankmen, _loc2_.destroyedDevices, _loc2_.critsCount);
                    break;
                case BATTLE_EFFICIENCY_TYPES.DESTRUCTION:
                case BATTLE_EFFICIENCY_TYPES.TEAM_DESTRUCTION:
                    _loc4_.killReason = _loc2_.deathReason;
                    _loc4_.arenaType = this._data.common.arenaType;
            }
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EFFICIENCY_PARAM, null, _loc4_);
        }
    }
}
}
