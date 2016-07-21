package net.wg.gui.lobby.quests.views {
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.ScrollingListEx;
import net.wg.gui.lobby.quests.components.QuestTaskListSelectionNavigator;
import net.wg.gui.lobby.quests.components.QuestsTileChainsViewFilters;
import net.wg.gui.lobby.quests.components.QuestsTileChainsViewHeader;
import net.wg.gui.lobby.quests.components.interfaces.IQuestsTileChainsView;
import net.wg.gui.lobby.quests.data.ChainProgressVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestChainVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskDetailsVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskListRendererVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileVO;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewVO;
import net.wg.gui.lobby.quests.events.QuestTaskDetailsViewEvent;
import net.wg.gui.lobby.quests.events.QuestsTileChainViewFiltersEvent;
import net.wg.gui.lobby.quests.events.QuestsTileChainViewHeaderEvent;
import net.wg.infrastructure.base.meta.impl.QuestsTileChainsViewMeta;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;
import net.wg.infrastructure.interfaces.IViewStackContent;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;

public class QuestsTileChainsView extends QuestsTileChainsViewMeta implements IQuestsTileChainsView {

    public var header:QuestsTileChainsViewHeader = null;

    public var taskFilters:QuestsTileChainsViewFilters = null;

    public var tasksScrollingList:ScrollingListEx = null;

    public var tasksScrollBar:ScrollBar = null;

    public var itemTitleTf:TextField = null;

    public var taskDetailsViewStack:ViewStack = null;

    public var filtersHeaderDelimiter:Sprite = null;

    public var filtersListDelimiter:Sprite = null;

    public var detailsDelimiter:Sprite = null;

    public var noTasksLabel:TextField = null;

    public var taskListTf:TextField = null;

    public var delimiterHitArea:MovieClip = null;

    public var infoBlock:MovieClip = null;

    private var _tasksListDataItems:Array;

    private var _isUpdateTileDataScheduled:Boolean = false;

    public function QuestsTileChainsView() {
        super();
        this.taskFilters.addEventListener(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED, this.onTaskFiltersFiltersChangedHandler);
        this.tasksScrollingList.addEventListener(ListEvent.INDEX_CHANGE, this.onTasksScrollingListIndexChangeHandler);
        this.tasksScrollingList.setSelectionNavigator(new QuestTaskListSelectionNavigator());
        this.header.addEventListener(QuestsTileChainViewHeaderEvent.BACK_BUTTON_PRESS, this.onHeaderBackButtonPressHandler);
        addEventListener(QuestTaskDetailsViewEvent.SELECT_TASK, this.onSelectTaskHandler);
        addEventListener(QuestTaskDetailsViewEvent.CANCEL_TASK, this.onCancelTaskHandler);
    }

    override protected function configUI():void {
        super.configUI();
        this.taskListTf.text = QUESTS.TILECHAINSVIEW_TASKLIST_TEXT;
        this.filtersHeaderDelimiter.hitArea = this.delimiterHitArea;
        this.filtersListDelimiter.hitArea = this.delimiterHitArea;
        this.detailsDelimiter.hitArea = this.delimiterHitArea;
    }

    override protected function setHeaderData(param1:QuestsTileChainsViewVO):void {
        this.header.setData(param1.header);
        this.taskFilters.setData(param1.filters);
        this.noTasksLabel.htmlText = param1.noTasksText;
    }

    override protected function updateTileData(param1:QuestTileVO):void {
        var _loc4_:Vector.<QuestChainVO> = null;
        var _loc5_:QuestChainVO = null;
        var _loc6_:Vector.<QuestTaskVO> = null;
        var _loc7_:QuestTaskVO = null;
        var _loc2_:Array = [];
        var _loc3_:Boolean = param1.hasTasks();
        if (_loc3_) {
            _loc4_ = param1.chains;
            for each(_loc5_ in _loc4_) {
                if (_loc5_.tasks.length > 0) {
                    _loc2_.push(new QuestTaskListRendererVO(QuestTaskListRendererVO.CHAIN, _loc5_));
                    _loc6_ = _loc5_.tasks;
                    for each(_loc7_ in _loc6_) {
                        _loc2_.push(new QuestTaskListRendererVO(QuestTaskListRendererVO.TASK, _loc7_, _loc7_.tooltip));
                    }
                }
            }
        }
        else {
            this.taskDetailsViewStack.visible = false;
        }
        if (this.tasksScrollingList.canCleanDataProvider) {
            this.tasksScrollingList.dataProvider.cleanUp();
        }
        this.tasksScrollingList.dataProvider = new DataProvider(_loc2_);
        this.clearTaskList();
        this._tasksListDataItems = _loc2_;
        this.noTasksLabel.visible = !_loc3_;
    }

    override protected function updateChainProgress(param1:ChainProgressVO):void {
        this.header.tasksProgress.update(param1);
    }

    override protected function updateTaskDetails(param1:QuestTaskDetailsVO):void {
        var _loc2_:* = param1 != null;
        this.infoBlock.visible = !_loc2_;
        if (_loc2_) {
            this.taskDetailsViewStack.visible = true;
            if (this.taskDetailsViewStack.currentLinkage != Linkages.QUEST_TASK_DETAILS_VIEW) {
                this.taskDetailsViewStack.show(Linkages.QUEST_TASK_DETAILS_VIEW);
                dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
            }
            IViewStackContent(this.taskDetailsViewStack.currentView).update(param1);
        }
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.requestTileData);
        removeEventListener(QuestTaskDetailsViewEvent.SELECT_TASK, this.onSelectTaskHandler);
        removeEventListener(QuestTaskDetailsViewEvent.CANCEL_TASK, this.onCancelTaskHandler);
        this.header.removeEventListener(QuestsTileChainViewHeaderEvent.BACK_BUTTON_PRESS, this.onHeaderBackButtonPressHandler);
        this.header.dispose();
        this.header = null;
        this.tasksScrollingList.removeEventListener(ListEvent.INDEX_CHANGE, this.onTasksScrollingListIndexChangeHandler);
        this.tasksScrollingList.dispose();
        this.tasksScrollingList = null;
        this.taskFilters.removeEventListener(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED, this.onTaskFiltersFiltersChangedHandler);
        this.taskFilters.dispose();
        this.taskFilters = null;
        this.tasksScrollBar.dispose();
        this.tasksScrollBar = null;
        this.taskDetailsViewStack.dispose();
        this.taskDetailsViewStack = null;
        this.filtersHeaderDelimiter.hitArea = null;
        this.filtersListDelimiter.hitArea = null;
        this.detailsDelimiter.hitArea = null;
        this.itemTitleTf = null;
        this.filtersHeaderDelimiter = null;
        this.filtersListDelimiter = null;
        this.detailsDelimiter = null;
        this.noTasksLabel = null;
        this.delimiterHitArea = null;
        this.taskListTf = null;
        this.infoBlock = null;
        this.clearTaskList();
        super.onDispose();
    }

    public function as_setSelectedTask(param1:Number):void {
        var _loc2_:QuestTaskListRendererVO = null;
        var _loc3_:IDataProvider = this.tasksScrollingList.dataProvider;
        var _loc4_:uint = _loc3_.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc2_ = QuestTaskListRendererVO(_loc3_.requestItemAt(_loc5_));
            if (_loc2_.type == QuestTaskListRendererVO.TASK) {
                if (param1 == -1 || _loc2_.taskData.id == param1) {
                    if (this.tasksScrollingList.selectedIndex == _loc5_) {
                        this.showDetails(_loc2_);
                    }
                    this.tasksScrollingList.selectedIndex = _loc5_;
                    return;
                }
            }
            _loc5_++;
        }
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return this;
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new <InteractiveObject>[InteractiveObject(this.header.backBtn)];
        _loc1_ = _loc1_.concat(this.taskFilters.getFocusChain());
        _loc1_.push(this.tasksScrollingList);
        if (this.taskDetailsViewStack.currentView is IFocusChainContainer) {
            _loc1_ = _loc1_.concat(IFocusChainContainer(this.taskDetailsViewStack.currentView).getFocusChain());
        }
        return _loc1_;
    }

    public function update(param1:Object):void {
    }

    private function clearTaskList():void {
        var _loc1_:IDisposable = null;
        if (this._tasksListDataItems != null) {
            for each(_loc1_ in this._tasksListDataItems) {
                _loc1_.dispose();
            }
            this._tasksListDataItems.splice(0, this._tasksListDataItems.length);
            this._tasksListDataItems = null;
        }
    }

    private function scheduleUpdateTileData():void {
        if (!this._isUpdateTileDataScheduled) {
            App.utils.scheduler.scheduleOnNextFrame(this.requestTileData);
            this._isUpdateTileDataScheduled = true;
        }
    }

    private function requestTileData():void {
        this._isUpdateTileDataScheduled = false;
        var _loc1_:int = this.taskFilters.selectedVehicleType;
        var _loc2_:int = this.taskFilters.selectedTaskType;
        App.utils.asserter.assertNotNull(_loc2_, "Selected taskType can not be null!");
        getTileDataS(_loc1_, _loc2_);
    }

    private function showDetails(param1:Object):void {
        var _loc2_:QuestTaskListRendererVO = QuestTaskListRendererVO(param1);
        if (_loc2_ && _loc2_.type == QuestTaskListRendererVO.TASK) {
            getTaskDetailsS(_loc2_.taskData.id);
        }
    }

    private function onTaskFiltersFiltersChangedHandler(param1:QuestsTileChainViewFiltersEvent):void {
        this.scheduleUpdateTileData();
    }

    private function onTasksScrollingListIndexChangeHandler(param1:ListEvent):void {
        if (param1.index == -1) {
            this.infoBlock.visible = true;
            this.taskDetailsViewStack.visible = false;
        }
        else {
            this.showDetails(param1.itemData);
        }
    }

    private function onHeaderBackButtonPressHandler(param1:QuestsTileChainViewHeaderEvent):void {
        gotoBackS();
    }

    private function onSelectTaskHandler(param1:QuestTaskDetailsViewEvent):void {
        selectTaskS(param1.taskID);
    }

    private function onCancelTaskHandler(param1:QuestTaskDetailsViewEvent):void {
        refuseTaskS(param1.taskID);
    }
}
}
