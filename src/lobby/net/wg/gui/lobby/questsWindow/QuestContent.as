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

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.motion.Tween;

public class QuestContent extends UIComponentEx implements IFocusContainer {

    private static const INVALIDATE_QUEST_INFO:String = "invQuestInfo";

    private static const INVALIDATE_SORTING_FUNC:String = "invSortFunc";

    private static const AVAILABLE_HEIGHT:int = 583;

    private static const WAITING_SIZE:int = 400;

    private static const SCROLLBAR_MARGIN:int = 10;

    private static const AWARDS_PADDING:int = 1;

    private static const AWARDS_CAROUSEL_PADDING:int = 2;

    private static const WAITING_TOP_PADDING:int = 10;

    private static const HIDE_ANIMATION_TIME:int = 600;

    public var sortingPanel:SortingPanel;

    public var alertMsg:AlertMessage;

    public var scrollBar:ScrollBar;

    public var questsList:QuestsList;

    public var notSelected:TextFieldMessageComponent;

    public var noQuestsMC:MovieClip;

    public var listHidingBG:MovieClip;

    public var blackListBackground:MovieClip;

    public var questBG:MovieClip;

    public var questInfo:QuestBlock = null;

    public var scrollPane:ResizableScrollPane;

    public var header:HeaderBlock;

    public var awards:QuestAwardsBlock;

    public var carouselAwardsBlock:QuestCarouselAwardsBlock = null;

    public var separator:MovieClip = null;

    private var _waiting:Waiting = null;

    private var _componentForFocus:InteractiveObject;

    private var _questData:QuestDataVO = null;

    private var _daapi:IQuestsCurrentTabDAAPI;

    private var _sortingFunction:Function = null;

    private var _showWaiting:Boolean = false;

    private var _awardsResized:Boolean = false;

    private var _questInfoResized:Boolean = false;

    private var _headerResized:Boolean = false;

    private var _tweens:Vector.<Tween>;

    private var _currentQuestID:String = "";

    public function QuestContent() {
        this._tweens = new Vector.<Tween>();
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.questInfo = QuestBlock(this.scrollPane.target);
        this.notSelected.text = QUESTS.QUESTS_TABS_NOSELECTED_TEXT;
        this.questsList.smartScrollBar = true;
        this.sortingPanel.validateNow();
        this.scrollPane.scrollBarMargin = SCROLLBAR_MARGIN;
        this.listHidingBG.mouseChildren = false;
        this.listHidingBG.mouseEnabled = false;
        this.noQuestsMC.visible = false;
        this.scrollPane.visible = true;
        this.alertMsg.visible = false;
        this.awards.visible = false;
        this.carouselAwardsBlock.visible = false;
        this.header.visible = false;
        this.separator.visible = false;
        this.addListeners();
    }

    override protected function onDispose():void {
        var _loc1_:Tween = null;
        this.removeListeners();
        App.utils.scheduler.cancelTask(invalidate);
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
        this.carouselAwardsBlock.dispose();
        this.carouselAwardsBlock = null;
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
        this.blackListBackground = null;
        this.separator = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALIDATE_SORTING_FUNC) && this._sortingFunction != null) {
            this.questInfo.conditionsView.blocksContainer.sortingFunction = this._sortingFunction;
            this.questInfo.requirementsView.blocksContainer.sortingFunction = this._sortingFunction;
        }
        if (isInvalid(WindowViewInvalidationType.WAITING_INVALID)) {
            this.invalidateWaiting();
        }
        if (isInvalid(INVALIDATE_QUEST_INFO)) {
            if (this._questData) {
                this.notSelected.visible = false;
                this.scrollPane.scrollPosition = 0;
                this.questInfo.setData(this._questData);
                this.header.setData(this._questData.header);
                this.awards.setData(this._questData.award);
                this.carouselAwardsBlock.setDataProvider(this._questData.awardsDataProvider);
            }
        }
    }

    public function getComponentForFocus():InteractiveObject {
        return this._componentForFocus;
    }

    public function hideSortPanel(param1:Boolean):void {
        this.sortingPanel.visible = !param1;
    }

    public function setNoData():void {
        this.showQuestInfo(false);
        this.notSelected.visible = false;
        this.blackListBackground.visible = false;
        this.questBG.visible = false;
        this.questsList.visible = false;
        this.scrollBar.visible = false;
        this.noQuestsMC.visible = true;
    }

    public function setNoDataLabel(param1:String):void {
        this.noQuestsMC.noResult.text = param1;
    }

    public function setNotSelected():void {
        this.showQuestInfo(false);
        this.notSelected.visible = true;
    }

    public function setQuestsListData(param1:Array, param2:String):void {
        if (this.questsList.dataProvider != null) {
            this.questsList.dataProvider.cleanUp();
        }
        this.questsList.itemRenderer = App.utils.classFactory.getClass(param2);
        this.questsList.dataProvider = new DataProvider(param1);
        var _loc3_:Boolean = Boolean(param1.length > 0);
        this.questsList.visible = _loc3_;
        this.blackListBackground.visible = _loc3_;
        this.questBG.visible = true;
        this.scrollBar.visible = true;
        this.noQuestsMC.visible = false;
    }

    public function setSelectedQuest(param1:String):void {
        this._currentQuestID = param1;
        var _loc2_:IDataProvider = this.questsList.dataProvider;
        var _loc3_:Number = _loc2_.length;
        var _loc4_:QuestRendererVO = null;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc4_ = _loc2_[_loc5_];
            if (_loc4_.isTitle == false && _loc4_.questID == param1) {
                this.questsList.selectedIndex = _loc5_;
                return;
            }
            _loc5_++;
        }
        this.questsList.selectedIndex = -1;
    }

    public function sortElementsUnVisible():void {
        this.sortingPanel.doneCB.x = this.sortingPanel.sortTF.x;
        this.sortingPanel.sortingDD.visible = false;
        this.sortingPanel.sortTF.visible = false;
    }

    public function updateQuestInfo(param1:Object):void {
        this.tryClearQuestData();
        this._questData = param1 != null ? new QuestDataVO(param1) : null;
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
        addEventListener(QuestEvent.SELECT_QUEST, this.onSelectQuestHandler);
    }

    private function removeListeners():void {
        this.header.contentTabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onHeaderContentTabsIndexChangeHandler);
        this.awards.removeEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.header.removeEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.questInfo.removeEventListener(Event.RESIZE, this.onControlResizeHandler);
        this.questsList.removeEventListener(ListEventEx.ITEM_CLICK, this.onQuestListItemClickHandler);
        this.questsList.removeEventListener(ListEvent.INDEX_CHANGE, this.onQuestListIndexChangeHandler);
        this.sortingPanel.doneCB.removeEventListener(Event.SELECT, this.onDoneCheckBoxSelectHandler);
        this.sortingPanel.sortingDD.removeEventListener(ListEvent.INDEX_CHANGE, this.onSortingDDIndexChangeHandler);
        removeEventListener(QuestEvent.SELECT_QUEST, this.onSelectQuestHandler);
    }

    private function invalidateWaiting():void {
        if (this._waiting == null) {
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
        else if (this._showWaiting) {
            this._waiting.show();
            this.showQuestInfo(false);
            this.notSelected.visible = false;
        }
        else {
            this._waiting.hide();
            this.playFadeAnimation(1, HIDE_ANIMATION_TIME, null);
        }
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
        }), new Tween(param2, this.carouselAwardsBlock, {"alpha": param1}, {
            "paused": false,
            "ease": Strong.easeInOut,
            "onComplete": param3
        })]);
        for each(_loc5_ in this._tweens) {
            _loc5_.fastTransform = false;
        }
    }

    private function showQuestInfo(param1:Boolean):void {
        this.scrollPane.visible = param1;
        this.header.visible = param1;
        if (this._questData != null) {
            this.awards.visible = this._questData.award != null && this._questData.award.length > 0 && param1;
            this.carouselAwardsBlock.visible = this._questData.awardsDataProvider.length > 0 && param1;
            this.separator.visible = this.awards.visible || this.carouselAwardsBlock.visible;
        }
    }

    private function assertDaapiNotNull():void {
        App.utils.asserter.assertNotNull(this._daapi, "daapi module" + Errors.CANT_NULL);
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
        this._componentForFocus = InteractiveObject(param1.target);
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS, this));
    }

    private function onQuestListItemClickHandler(param1:ListEvent):void {
        this.assertDaapiNotNull();
        var _loc2_:QuestRendererVO = QuestRendererVO(param1.itemData);
        if (_loc2_ != null) {
            if (_loc2_.isTitle) {
                this._daapi.collapseS(_loc2_.groupID);
            }
            else if (_loc2_.questID != this._currentQuestID) {
                this._currentQuestID = _loc2_.questID;
                this._daapi.getQuestInfoS(_loc2_.questID);
            }
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

    private function onControlResizeHandler(param1:Event):void {
        var _loc2_:Number = NaN;
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
                this.awards.y = AVAILABLE_HEIGHT - this.awards.height - AWARDS_PADDING | 0;
                this.scrollPane.y = this.header.height | 0;
                if (!this.noQuestsMC.visible) {
                    this.showQuestInfo(true);
                }
                this.showWaiting = false;
                _loc2_ = 0;
                if (this.awards.visible) {
                    _loc2_ = this.awards.height + AWARDS_PADDING;
                }
                if (this.carouselAwardsBlock.visible) {
                    _loc2_ = this.carouselAwardsBlock.height + AWARDS_CAROUSEL_PADDING;
                }
                this.scrollPane.height = AVAILABLE_HEIGHT - this.header.height - _loc2_ | 0;
                this.scrollPane.validateNow();
            }
        }
    }

    private function onHeaderContentTabsIndexChangeHandler(param1:IndexEvent):void {
        this.questInfo.changeView(this.header.contentTabs.selectedItem.data);
    }

    private function onSelectQuestHandler(param1:QuestEvent):void {
        this.assertDaapiNotNull();
        if (param1.questID != this._currentQuestID) {
            this.setSelectedQuest(param1.questID);
            this._daapi.getQuestInfoS(param1.questID);
        }
    }
}
}
