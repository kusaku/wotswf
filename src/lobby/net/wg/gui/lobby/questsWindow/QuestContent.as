package net.wg.gui.lobby.questsWindow {
import fl.transitions.easing.Strong;

import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.events.Event;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.gui.components.common.waiting.Waiting;
import net.wg.gui.components.controls.ResizableScrollPane;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.events.ListEventEx;
import net.wg.gui.events.QuestEvent;
import net.wg.gui.lobby.questsWindow.components.AlertMessage;
import net.wg.gui.lobby.questsWindow.components.SortingPanel;
import net.wg.gui.lobby.questsWindow.components.TextFieldMessageComponent;
import net.wg.gui.lobby.questsWindow.components.interfaces.IQuestsCurrentTabDAAPI;
import net.wg.gui.lobby.questsWindow.data.QuestDataVO;
import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.constants.WindowViewInvalidationType;
import net.wg.infrastructure.events.FocusRequestEvent;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.motion.Tween;

public class QuestContent extends UIComponentEx implements IFocusContainer {

    private static const INVALIDATE_QUEST_INFO:String = "invQuestInfo";

    private static const INVALIDATE_QUEST_ID:String = "invQuestID";

    private static const INVALIDATE_SORTING_FUNC:String = "invSortFunc";

    private static const INVALIDATE_NO_DATA_LABEL:String = "invNoDataLabel";

    private static const AVAILABLE_HEIGHT:int = 583;

    private static const WAITING_SIZE:int = 400;

    private static const SCROLLBAR_MARGIN:int = 10;

    private static const AWARDS_PADDING:int = 1;

    private static const WAITING_TOP_PADDING:int = 10;

    private static const SHOW_ANIMATION_TIME:int = 150;

    private static const HIDE_ANIMATION_TIME:int = 600;

    public var sortingPanel:SortingPanel;

    public var alertMsg:AlertMessage;

    public var scrollBar:ScrollBar;

    public var questsList:QuestsList;

    public var notSelected:TextFieldMessageComponent;

    public var noQuestsMC:MovieClip;

    public var listHidingBG:MovieClip;

    public var questBG:MovieClip;

    public var questInfo:QuestBlock = null;

    public var scrollPane:ResizableScrollPane;

    public var header:HeaderBlock;

    public var awards:QuestAwardsBlock;

    private var _currentQuest:String = "";

    private var _questForUpdate:String = "";

    private var _lastUpdatedQuest:String = "";

    private var _totalTasks:Number = 0;

    private var _waiting:Waiting = null;

    private var _componentForFocus:InteractiveObject;

    private var _questData:QuestDataVO = null;

    private var _allTasks:Vector.<String> = null;

    private var _daapi:IQuestsCurrentTabDAAPI;

    private var _sortingFunction:Function = null;

    private var _hideSortPanel:Boolean = false;

    private var _noDataLabel:String = "";

    private var _showWaiting:Boolean = false;

    private var _awardsResized:Boolean = false;

    private var _questInfoResized:Boolean = false;

    private var _headerResized:Boolean = false;

    private var _isInRoaming:Boolean = false;

    private var _questInFade:Boolean = false;

    private var _tweens:Vector.<Tween>;

    public function QuestContent() {
        this._tweens = new Vector.<Tween>();
        super();
        this._allTasks = new Vector.<String>();
        this.noQuestsMC.visible = false;
    }

    override protected function configUI():void {
        super.configUI();
        this.questInfo = QuestBlock(this.scrollPane.target);
        this.notSelected.text = QUESTS.QUESTS_TABS_NOSELECTED_TEXT;
        this.listHidingBG.mouseEnabled = false;
        this.listHidingBG.mouseChildren = false;
        this.scrollPane.visible = false;
        this.awards.visible = false;
        this.header.visible = false;
        this.alertMsg.visible = false;
        this._isInRoaming = App.globalVarsMgr.isInRoamingS();
        this.questsList.smartScrollBar = true;
        this.sortingPanel.validateNow();
        this.scrollPane.scrollBarMargin = SCROLLBAR_MARGIN;
        this.addListeners();
    }

    override protected function onDispose():void {
        var _loc1_:Tween = null;
        this.removeListeners();
        App.utils.scheduler.cancelTask(invalidate);
        if (this._allTasks) {
            this._allTasks.splice(0, this._allTasks.length);
            this._allTasks = null;
        }
        this.tryClearQuestData();
        if (this._waiting) {
            this._waiting.dispose();
            removeChild(this._waiting);
            this._waiting = null;
        }
        for each(_loc1_ in this._tweens) {
            _loc1_.onComplete = null;
            _loc1_.onChange = null;
            _loc1_.paused = true;
            _loc1_.dispose();
            _loc1_ = null;
        }
        this._tweens.splice(0, this._tweens.length);
        this._tweens = null;
        this.header.dispose();
        this.header = null;
        this.awards.dispose();
        this.awards = null;
        this.sortingPanel.dispose();
        this.sortingPanel = null;
        this.alertMsg.dispose();
        this.alertMsg = null;
        this.scrollBar.dispose();
        this.scrollBar = null;
        this.questsList.dispose();
        this.questsList = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        this.questInfo = null;
        this.notSelected.dispose();
        this.notSelected = null;
        this.noQuestsMC = null;
        this.listHidingBG = null;
        this.questBG = null;
        this._sortingFunction = null;
        this._componentForFocus = null;
        this._daapi = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.invalidateCommonData();
        }
        if (isInvalid(INVALIDATE_SORTING_FUNC) && this._sortingFunction != null) {
            this.questInfo.conditionsView.blocksContainer.sortingFunction = this._sortingFunction;
            this.questInfo.requirementsView.blocksContainer.sortingFunction = this._sortingFunction;
        }
        if (isInvalid(INVALIDATE_NO_DATA_LABEL)) {
            this.noQuestsMC.noResult.text = this._noDataLabel;
        }
        if (isInvalid(WindowViewInvalidationType.WAITING_INVALID)) {
            this.invalidateWaiting();
        }
        if (isInvalid(INVALIDATE_QUEST_ID)) {
            if (this._questInFade) {
                if (this._lastUpdatedQuest == this._questForUpdate) {
                    this.getQuestData();
                }
                else {
                    this._lastUpdatedQuest = this._questForUpdate;
                    App.utils.scheduler.scheduleOnNextFrame(invalidate, INVALIDATE_QUEST_ID);
                }
            }
        }
        if (isInvalid(INVALIDATE_QUEST_INFO)) {
            if (this._questData) {
                this.scrollPane.scrollPosition = 0;
                this.questInfo.setData(this._questData);
                this.header.setData(this._questData.header);
                this.awards.setData(this._questData.award);
            }
        }
    }

    public function getComponentForFocus():InteractiveObject {
        return this._componentForFocus;
    }

    public function hideSortPanel(param1:Boolean):void {
        this._hideSortPanel = param1;
    }

    public function setNoDataLabel(param1:String):void {
        this._noDataLabel = param1;
        invalidate(INVALIDATE_NO_DATA_LABEL);
    }

    public function setQuestsData(param1:Array, param2:Number):void {
        var _loc3_:QuestRendererVO = null;
        if (this.questsList.dataProvider != null) {
            this.questsList.dataProvider.cleanUp();
        }
        this.questsList.dataProvider = new DataProvider(param1);
        this._totalTasks = param2;
        this._allTasks.splice(0, this._allTasks.length);
        for each(_loc3_ in param1) {
            this._allTasks.push(_loc3_.questID);
        }
        invalidateData();
    }

    public function setSelectedQuest(param1:String):void {
        this.sortingPanel.doneCB.selected = false;
        this._currentQuest = param1;
        invalidateData();
    }

    public function sortElementsUnVisible():void {
        this.sortingPanel.doneCB.x = this.sortingPanel.sortTF.x;
        this.sortingPanel.sortingDD.visible = false;
        this.sortingPanel.sortTF.visible = false;
    }

    public function updateQuestInfo(param1:Object):void {
        var _loc7_:QuestRenderer = null;
        var _loc2_:Object = param1;
        this.tryClearQuestData();
        this._questData = !!_loc2_ ? new QuestDataVO(_loc2_) : null;
        this._lastUpdatedQuest = this._questForUpdate;
        var _loc3_:IDataProvider = this.questsList.dataProvider;
        var _loc4_:Number = _loc3_.length;
        var _loc5_:QuestRendererVO = null;
        var _loc6_:int = 0;
        while (_loc6_ < _loc4_) {
            _loc5_ = _loc3_[_loc6_];
            if (_loc5_.questID == this._questForUpdate) {
                _loc5_.isNew = false;
                if (this.questsList.selectedIndex == _loc6_) {
                    _loc7_ = QuestRenderer(this.questsList.getRendererAt(_loc6_, this.questsList.scrollPosition));
                    if (_loc7_ != null) {
                        _loc7_.hideNew();
                    }
                    break;
                }
            }
            _loc6_++;
        }
        invalidate(INVALIDATE_QUEST_INFO);
    }

    private function tryClearQuestData():void {
        if (this._questData) {
            this._questData.dispose();
            this._questData = null;
        }
    }

    private function addListeners():void {
        this.header.contentTabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onHeaderContentTabsIndexChangeHandler);
        this.header.addEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.awards.addEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.questInfo.addEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.questsList.addEventListener(ListEventEx.ITEM_CLICK, this.onQuestListItemClickHandler);
        this.questsList.addEventListener(ListEvent.INDEX_CHANGE, this.onQuestListIndexChangeHandler);
        this.sortingPanel.doneCB.addEventListener(Event.SELECT, this.onDoneCheckBoxSelectHandler);
        this.sortingPanel.sortingDD.addEventListener(ListEvent.INDEX_CHANGE, this.onSortingDDIndexChangeHandler);
        this.questInfo.addEventListener(QuestEvent.SELECT_QUEST, this.onSelectQuestHandler);
        this.awards.addEventListener(QuestEvent.SELECT_QUEST, this.onSelectQuestHandler);
    }

    private function removeListeners():void {
        this.header.contentTabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onHeaderContentTabsIndexChangeHandler);
        this.awards.removeEventListener(QuestEvent.SELECT_QUEST, this.onSelectQuestHandler);
        this.awards.removeEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.header.removeEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.questInfo.removeEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.questsList.removeEventListener(ListEventEx.ITEM_CLICK, this.onQuestListItemClickHandler);
        this.questsList.removeEventListener(ListEvent.INDEX_CHANGE, this.onQuestListIndexChangeHandler);
        this.sortingPanel.doneCB.removeEventListener(Event.SELECT, this.onDoneCheckBoxSelectHandler);
        this.sortingPanel.sortingDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onSortingDDIndexChangeHandler);
        this.questInfo.removeEventListener(QuestEvent.SELECT_QUEST, this.onSelectQuestHandler);
    }

    private function invalidateWaiting():void {
        if (!this._waiting) {
            this._waiting = new Waiting();
            addChild(this._waiting);
            this._waiting.x = this.notSelected.x + (this.notSelected.width - WAITING_SIZE >> 1);
            this._waiting.y = (AVAILABLE_HEIGHT - WAITING_SIZE >> 1) - WAITING_TOP_PADDING;
            this._waiting.setSize(WAITING_SIZE, WAITING_SIZE);
            this._waiting.setMessage(Values.EMPTY_STR);
            this._waiting.show();
            this._waiting.hide();
            this._waiting.validateNow();
            this._waiting.backgroundAlpha = 0;
        }
        if (this._waiting) {
            if (this._showWaiting) {
                this._waiting.show();
                this.playFadeAnimation(0, SHOW_ANIMATION_TIME, this.tweenFadeOutCallback);
            }
            else {
                this._waiting.hide();
                this.playFadeAnimation(1, HIDE_ANIMATION_TIME, null);
            }
        }
    }

    private function invalidateCommonData():void {
        this.questInfo.setAvailableQuests(this._allTasks);
        var _loc1_:* = this._totalTasks > 0;
        this.sortingPanel.visible = !this._hideSortPanel && _loc1_ && !this._isInRoaming;
        this.questsList.visible = _loc1_;
        this.scrollBar.visible = !!_loc1_ ? Boolean(this.scrollBar.visible) : false;
        this.listHidingBG.visible = _loc1_;
        this.questBG.visible = _loc1_;
        this.notSelected.visible = _loc1_;
        this.noQuestsMC.visible = !_loc1_;
        this.alertMsg.visible = _loc1_ && this._isInRoaming;
        if (_loc1_) {
            this.checkSelectedQuest();
        }
        else {
            this.scrollPane.visible = false;
            this.header.visible = false;
            this.awards.visible = false;
        }
    }

    private function updateQuest(param1:String):void {
        this.showWaiting = true;
        this._questForUpdate = param1;
        invalidate(INVALIDATE_QUEST_ID);
    }

    private function playFadeAnimation(param1:Number, param2:Number, param3:Function):void {
        var _loc4_:Tween = null;
        var _loc5_:Tween = null;
        for each(_loc4_ in this._tweens) {
            _loc4_.onComplete = null;
            _loc4_.paused = true;
            _loc4_ = null;
        }
        this._tweens = Vector.<Tween>([new Tween(param2, this.header, {"alpha": param1}, {
            "paused": false,
            "ease": Strong.easeInOut,
            "onComplete": null
        }), new Tween(param2, this.awards, {"alpha": param1}, {
            "paused": false,
            "ease": Strong.easeInOut,
            "onComplete": null
        }), new Tween(param2, this.notSelected, {"alpha": param1}, {
            "paused": false,
            "ease": Strong.easeInOut,
            "onComplete": null
        }), new Tween(param2, this.scrollPane, {"alpha": param1}, {
            "paused": false,
            "ease": Strong.easeInOut,
            "onComplete": param3
        })]);
        for each(_loc5_ in this._tweens) {
            _loc5_.fastTransform = false;
        }
    }

    private function tweenFadeOutCallback():void {
        this._questInFade = true;
        invalidate(INVALIDATE_QUEST_ID);
    }

    private function showQuestInfo(param1:Boolean):void {
        this.scrollPane.visible = param1;
        this.header.visible = param1;
    }

    private function checkSelectedQuest():void {
        var _loc5_:int = 0;
        var _loc1_:IDataProvider = this.questsList.dataProvider;
        var _loc2_:Number = _loc1_.length;
        var _loc3_:QuestRendererVO = null;
        var _loc4_:Boolean = false;
        if (StringUtils.isNotEmpty(this._currentQuest)) {
            _loc5_ = 0;
            while (_loc5_ < _loc2_) {
                _loc3_ = _loc1_[_loc5_];
                if (_loc3_.questID == this._currentQuest) {
                    if (this.questsList.selectedIndex == _loc5_) {
                        this.questsList.scrollToIndex(_loc5_);
                    }
                    else {
                        this.questsList.selectedIndex = _loc5_;
                    }
                    this.updateQuest(this._currentQuest);
                    _loc4_ = true;
                    this.showQuestInfo(false);
                    this.notSelected.visible = false;
                    break;
                }
                _loc5_++;
            }
        }
        if (!_loc4_) {
            this.questsList.selectedIndex = -1;
        }
    }

    private function setNotSelected():void {
        this.showQuestInfo(false);
        this.notSelected.visible = true;
        this.awards.visible = false;
        this._currentQuest = Values.EMPTY_STR;
    }

    private function assertDaapiNotNull():void {
        App.utils.asserter.assertNotNull(this._daapi, "daapi module" + Errors.CANT_NULL);
    }

    private function getQuestData():void {
        this.assertDaapiNotNull();
        this._daapi.getQuestInfoS(this._questForUpdate);
    }

    public function set daapi(param1:IQuestsCurrentTabDAAPI):void {
        this._daapi = param1;
    }

    public function set showWaiting(param1:Boolean):void {
        if (this._showWaiting != param1) {
            this._showWaiting = param1;
            invalidate(WindowViewInvalidationType.WAITING_INVALID);
        }
    }

    public function get sortingFunction():Function {
        return this._sortingFunction;
    }

    public function set sortingFunction(param1:Function):void {
        this._sortingFunction = param1;
        invalidate(INVALIDATE_SORTING_FUNC);
    }

    private function onQuestListIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:QuestRendererVO = null;
        if (param1.index >= 0) {
            _loc2_ = QuestRendererVO(param1.itemData);
            this._currentQuest = _loc2_.questID;
            this.updateQuest(this._currentQuest);
        }
        else {
            this.setNotSelected();
        }
        this._componentForFocus = InteractiveObject(param1.target);
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    private function onQuestListItemClickHandler(param1:ListEvent):void {
        if (param1.index == this.questsList.selectedIndex) {
            this.questsList.selectedIndex = -1;
        }
    }

    private function onDoneCheckBoxSelectHandler(param1:Event):void {
        this.assertDaapiNotNull();
        this._daapi.sortS(this.sortingPanel.sortingDD.selectedIndex, this.sortingPanel.doneCB.selected);
    }

    private function onSortingDDIndexChangeHandler(param1:ListEvent):void {
        this.questsList.questsType = param1.index;
        this.assertDaapiNotNull();
        this._daapi.sortS(param1.index, this.sortingPanel.doneCB.selected);
    }

    private function onSelectQuestHandler(param1:QuestEvent):void {
        var _loc2_:IDataProvider = this.questsList.dataProvider;
        var _loc3_:int = _loc2_.length;
        var _loc4_:QuestRendererVO = null;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = _loc2_[_loc5_];
            if (_loc4_.questID == param1.questID) {
                if (this.questsList.selectedIndex == _loc5_) {
                    this.questsList.scrollToIndex(_loc5_);
                }
                else {
                    this.questsList.selectedIndex = _loc5_;
                }
                break;
            }
            _loc5_++;
        }
    }

    private function onControlResizeHandler(param1:Event):void {
        if (this._questData) {
            if (param1.target == this.awards) {
                this._awardsResized = true;
            }
            if (param1.target == this.header) {
                this._headerResized = true;
            }
            if (param1.target == this.questInfo) {
                this._questInfoResized = true;
            }
            if (this._awardsResized && this._headerResized && this._questInfoResized) {
                this._awardsResized = this._headerResized = this._questInfoResized = false;
                this.awards.visible = Boolean(this._questData.award && this._questData.award.length);
                this.awards.y = AVAILABLE_HEIGHT - this.awards.height - AWARDS_PADDING | 0;
                this.scrollPane.y = this.header.height | 0;
                this.scrollPane.height = AVAILABLE_HEIGHT - this.header.height - this.awards.height - AWARDS_PADDING | 0;
                this.scrollPane.validateNow();
                if (this._lastUpdatedQuest != this._questForUpdate) {
                    invalidate(INVALIDATE_QUEST_ID);
                }
                else {
                    if (this.questsList.selectedIndex > -1) {
                        this.showQuestInfo(true);
                        this.notSelected.visible = false;
                    }
                    else {
                        this.setNotSelected();
                    }
                    this._questInFade = false;
                    this.showWaiting = false;
                }
            }
        }
    }

    private function onHeaderContentTabsIndexChangeHandler(param1:IndexEvent):void {
        this.questInfo.changeView(this.header.contentTabs.selectedItem.data);
    }
}
}
