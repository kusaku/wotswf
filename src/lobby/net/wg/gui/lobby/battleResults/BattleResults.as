package net.wg.gui.lobby.battleResults {
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.data.constants.ArenaBonusTypes;
import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.cyberSport.controls.CSAnimation;
import net.wg.gui.cyberSport.controls.data.CSAnimationVO;
import net.wg.gui.events.CSAnimationEvent;
import net.wg.gui.events.FinalStatisticEvent;
import net.wg.gui.events.QuestEvent;
import net.wg.gui.events.ViewStackEvent;
import net.wg.gui.lobby.battleResults.cs.CsTeamEmblemEvent;
import net.wg.gui.lobby.battleResults.cs.CsTeamEvent;
import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
import net.wg.gui.lobby.battleResults.data.TabInfoVO;
import net.wg.gui.lobby.battleResults.event.BattleResultsViewEvent;
import net.wg.gui.lobby.battleResults.event.ClanEmblemRequestEvent;
import net.wg.gui.lobby.battleResults.event.TeamTableSortEvent;
import net.wg.gui.lobby.battleResults.progressReport.UnlockLinkEvent;
import net.wg.infrastructure.base.meta.IBattleResultsMeta;
import net.wg.infrastructure.base.meta.impl.BattleResultsMeta;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;

public class BattleResults extends BattleResultsMeta implements IBattleResultsMeta {

    private static const CS_ANIMATION_LINKAGES:Vector.<String> = new <String>[CYBER_SPORT_ALIASES.CS_ANIMATION_LEAGUE_DIVISION_UP, CYBER_SPORT_ALIASES.CS_ANIMATION_LEAGUE_DIVISION_UP_ALT, CYBER_SPORT_ALIASES.CS_ANIMATION_LEAGUE_DIVISION_DOWN, CYBER_SPORT_ALIASES.CS_ANIMATION_LEAGUE_UP];

    public var tabs_mc:ButtonBarEx = null;

    public var view_mc:ViewStack = null;

    public var line:Sprite = null;

    public var noResult:TextField = null;

    public var resultsShareBtn:SoundButtonEx = null;

    public var wndBgForm:Sprite = null;

    private var _emblemLoadingDelegates:Dictionary;

    private var _csAnimationLoader:Loader = null;

    private var _csAnimation:CSAnimation = null;

    private var _animationData:CSAnimationVO = null;

    private var _data:BattleResultsVO = null;

    public function BattleResults() {
        this._emblemLoadingDelegates = new Dictionary();
        super();
        this.wndBgForm.visible = false;
        showWindowBgForm = false;
        this.visible = false;
        isCentered = true;
        this.noResult.visible = false;
        addEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onFocusRequestHandler, false, 0, true);
        addEventListener(ClanEmblemRequestEvent.TYPE, this.onClanEmblemLoadEventHandler);
    }

    override protected function setAnimation(param1:CSAnimationVO):void {
        assert(CS_ANIMATION_LINKAGES.indexOf(param1.animationType) != -1, param1.animationType + " is bad animation linkage.");
        var _loc2_:URLRequest = new URLRequest(CYBER_SPORT_ALIASES.CS_ANIMATION_UI);
        this._csAnimationLoader = new Loader();
        var _loc3_:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
        this._csAnimationLoader.load(_loc2_, _loc3_);
        this._csAnimationLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onCSAnimationLoadedHandler);
        this._animationData = param1;
    }

    override protected function configUI():void {
        super.configUI();
        this.noResult.text = BATTLE_RESULTS.NODATA;
        this.tabs_mc.addEventListener(FocusEvent.FOCUS_IN, this.onTabFocusInHandler);
        this.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChangedHandler);
        addEventListener(UnlockLinkEvent.TYPE, this.onUnlockLinkBtnHandler);
        addEventListener(TeamTableSortEvent.TYPE, this.onTeamTableSortEventHandler);
        addEventListener(BattleResultsViewEvent.SHOW_DETAILS, this.onShowDetailsHandler, false, 0, true);
        addEventListener(QuestEvent.SELECT_QUEST, this.onShowEventsWindowHandler, false, 0, true);
        this.tabs_mc.visible = false;
        this.line.visible = false;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        showWaitingMessage("");
        this.visible = true;
        window.getBackground().tabChildren = false;
        window.getBackground().tabEnabled = false;
        this.resultsShareBtn.visible = false;
    }

    override protected function onDispose():void {
        removeEventListener(TeamTableSortEvent.TYPE, this.onTeamTableSortEventHandler);
        removeEventListener(UnlockLinkEvent.TYPE, this.onUnlockLinkBtnHandler);
        removeEventListener(FocusRequestEvent.REQUEST_FOCUS, this.onFocusRequestHandler);
        removeEventListener(ClanEmblemRequestEvent.TYPE, this.onClanEmblemLoadEventHandler);
        this.resultsShareBtn.removeEventListener(ButtonEvent.CLICK, this.onResultsShareBtnClickHandler);
        this.resultsShareBtn.dispose();
        this.resultsShareBtn = null;
        this.wndBgForm = null;
        removeEventListener(BattleResultsViewEvent.SHOW_DETAILS, this.onShowDetailsHandler);
        removeEventListener(QuestEvent.SELECT_QUEST, this.onShowEventsWindowHandler);
        App.utils.data.cleanupDynamicObject(this._emblemLoadingDelegates);
        this._emblemLoadingDelegates = null;
        if (this._csAnimation != null) {
            this._csAnimation.removeEventListener(CSAnimationEvent.APPLY_BTN_CLICK, this.onCSAnimationApplyBtnClickHandler);
            this._csAnimation.removeEventListener(CSAnimationEvent.ANIMATIONS_LOADED, this.onAllCSAnimationsLoadedHandler);
            this._csAnimation.removeEventListener(CSAnimationEvent.ANIMATIONS_LOAD_ERROR, this.onAllCSAnimationsLoadedHandler);
            this.removeChild(this._csAnimation);
            this._csAnimation.dispose();
            this._csAnimation = null;
        }
        this.tabs_mc.removeEventListener(FocusEvent.FOCUS_IN, this.onTabFocusInHandler);
        this.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        this.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChangedHandler);
        this.tabs_mc.dispose();
        this.tabs_mc = null;
        this.view_mc.removeEventListener(CsTeamEvent.TO_TEAM_CARD_CLICK, this.onTeamCardClickHandler);
        this.view_mc.removeEventListener(CsTeamEmblemEvent.TEAM_EMBLEM_REQUEST, this.onTeamEmblemRequestHandler);
        this.view_mc.dispose();
        if (this._csAnimationLoader != null) {
            this._csAnimationLoader.unload();
            this._csAnimationLoader = null;
        }
        this._animationData = null;
        this.view_mc = null;
        this.noResult = null;
        this._data = null;
        this.line = null;
        super.onDispose();
    }

    override protected function draw():void {
        if (isInvalid(InvalidationType.DATA)) {
            if (this._data) {
                this.tabs_mc.visible = true;
                this.line.visible = true;
                window.title = this._data.textData.windowTitle;
                this.resultsShareBtn.label = this._data.textData.shareButtonLabel;
                this.resultsShareBtn.tooltip = this._data.textData.shareButtonTooltip;
            }
            this.noResult.visible = this._data == null;
        }
        super.draw();
    }

    override protected function setData(param1:BattleResultsVO):void {
        this._data = param1;
        this.tabs_mc.dataProvider = param1.tabInfo;
        this.tabs_mc.selectedIndex = 0;
        this.tabs_mc.validateNow();
        setFocus(this.tabs_mc);
        this.resultsShareBtn.visible = this._data.common.battleResultsSharingIsAvailable;
        if (this.resultsShareBtn.visible) {
            this.resultsShareBtn.addEventListener(ButtonEvent.CLICK, this.onResultsShareBtnClickHandler);
        }
        else {
            this.resultsShareBtn.removeEventListener(ButtonEvent.CLICK, this.onResultsShareBtnClickHandler);
        }
        if (this._data.common.bonusType == ArenaBonusTypes.RATED_CYBERSPORT) {
            this.view_mc.addEventListener(CsTeamEvent.TO_TEAM_CARD_CLICK, this.onTeamCardClickHandler);
            this.view_mc.addEventListener(CsTeamEmblemEvent.TEAM_EMBLEM_REQUEST, this.onTeamEmblemRequestHandler);
        }
        invalidateData();
        showWaiting = false;
        IViewStackContent(this.view_mc.currentView).update(param1);
    }

    public function as_setClanEmblem(param1:String, param2:String):void {
        this.onEmblemLoaded(param1, param2, null);
    }

    public function as_setTeamInfo(param1:String, param2:String, param3:String):void {
        this.onEmblemLoaded(param1, param2, param3);
    }

    private function onEmblemLoaded(param1:String, param2:String, param3:String):void {
        var _loc4_:IEmblemLoadedDelegate = null;
        if (this._emblemLoadingDelegates[param1] != null) {
            _loc4_ = IEmblemLoadedDelegate(this._emblemLoadingDelegates[param1]);
            _loc4_.onEmblemLoaded(param1, param2, param3);
            delete this._emblemLoadingDelegates[param1];
        }
    }

    private function closeAnimation():void {
        this._csAnimation.removeEventListener(CSAnimationEvent.APPLY_BTN_CLICK, this.onCSAnimationApplyBtnClickHandler);
        this._csAnimation.removeEventListener(CSAnimationEvent.ANIMATIONS_LOADED, this.onAllCSAnimationsLoadedHandler);
        this._csAnimation.removeEventListener(CSAnimationEvent.ANIMATIONS_LOAD_ERROR, this.onAllCSAnimationsLoadedHandler);
        this.removeChild(this._csAnimation);
        this._csAnimation.dispose();
        this._csAnimation = null;
        this._csAnimationLoader.unloadAndStop();
    }

    private function onUnlockLinkBtnHandler(param1:UnlockLinkEvent):void {
        showUnlockWindowS(param1.itemId, param1.unlockType);
    }

    private function onTeamTableSortEventHandler(param1:TeamTableSortEvent):void {
        saveSortingS(param1.columnId, param1.sortDirection, param1.bonusType);
    }

    private function onResultsShareBtnClickHandler(param1:ButtonEvent):void {
        onResultsSharingBtnPressS();
    }

    private function onClanEmblemLoadEventHandler(param1:ClanEmblemRequestEvent):void {
        param1.stopPropagation();
        this._emblemLoadingDelegates[param1.uid] = param1.delegate;
        getClanEmblemS(param1.uid, param1.clanId);
    }

    private function onTeamEmblemRequestHandler(param1:CsTeamEmblemEvent):void {
        param1.stopPropagation();
        this._emblemLoadingDelegates[param1.requestID] = param1.delegate;
        getTeamEmblemS(param1.requestID, param1.teamDBID, false);
    }

    private function onTeamCardClickHandler(param1:CsTeamEvent):void {
        param1.stopPropagation();
        onTeamCardClickS(param1.teamDBID);
    }

    private function onCSAnimationLoadedHandler(param1:Event):void {
        this._csAnimationLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onCSAnimationLoadedHandler);
        this._csAnimation = App.utils.classFactory.getComponent(this._animationData.animationType, CSAnimation);
        this.addChild(this._csAnimation);
        this._csAnimation.addEventListener(CSAnimationEvent.APPLY_BTN_CLICK, this.onCSAnimationApplyBtnClickHandler);
        this._csAnimation.addEventListener(CSAnimationEvent.ANIMATIONS_LOADED, this.onAllCSAnimationsLoadedHandler);
        this._csAnimation.addEventListener(CSAnimationEvent.ANIMATIONS_LOAD_ERROR, this.onAllCSAnimationsErrorHandler);
        this._csAnimation.setData(this._animationData);
        this._csAnimation.x = this.view_mc.x;
        this._csAnimation.y = this.view_mc.y;
        setChildIndex(this._csAnimation, getChildIndex(this.tabs_mc));
    }

    private function onCSAnimationApplyBtnClickHandler(param1:CSAnimationEvent):void {
        this.closeAnimation();
    }

    private function onAllCSAnimationsLoadedHandler(param1:CSAnimationEvent):void {
        startCSAnimationSoundS();
        this._csAnimation.removeEventListener(CSAnimationEvent.ANIMATIONS_LOADED, this.onAllCSAnimationsLoadedHandler);
    }

    private function onAllCSAnimationsErrorHandler(param1:CSAnimationEvent):void {
        this.closeAnimation();
    }

    private function onFocusRequestHandler(param1:FocusRequestEvent):void {
        setFocus(param1.focusContainer.getComponentForFocus());
    }

    private function onTabFocusInHandler(param1:FocusEvent):void {
        this.view_mc.dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.HIDE_STATS_VIEW));
    }

    private function onTabIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:Boolean = TabInfoVO(param1.data).showWndBg;
        this.wndBgForm.visible = _loc2_;
    }

    private function onViewChangedHandler(param1:ViewStackEvent):void {
        param1.view.update(this._data);
    }

    private function onShowDetailsHandler(param1:Event):void {
        this.tabs_mc.selectedIndex = 2;
    }

    private function onShowEventsWindowHandler(param1:QuestEvent):void {
        showEventsWindowS(param1.questID, param1.eventType);
    }
}
}
