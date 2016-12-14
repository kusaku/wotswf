package net.wg.gui.lobby.quests.windows {
import flash.display.InteractiveObject;
import flash.events.Event;

import net.wg.data.constants.Values;
import net.wg.data.constants.generated.QUESTS_ALIASES;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.quests.components.QuestsContentTabs;
import net.wg.gui.lobby.quests.components.SeasonAwardsList;
import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardsVO;
import net.wg.gui.lobby.quests.events.SeasonAwardWindowEvent;
import net.wg.infrastructure.base.meta.IQuestsSeasonAwardsWindowMeta;
import net.wg.infrastructure.base.meta.impl.QuestsSeasonAwardsWindowMeta;
import net.wg.infrastructure.events.FocusChainChangeEvent;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;

public class QuestsSeasonAwardsWindow extends QuestsSeasonAwardsWindowMeta implements IQuestsSeasonAwardsWindowMeta {

    private static const SEPARATOR_WIDTH:int = 758;

    private static const DISABLE_TABS_OFFSET:int = -12;

    private static const INVALID_SCROLL_BUTTONS:String = "invalidScrollButtons";

    public var awardsList:SeasonAwardsList;

    public var tabs:QuestsContentTabs;

    public var decScrollPosBtn:SoundButtonEx;

    public var incScrollPosBtn:SoundButtonEx;

    private var _tabItems:Vector.<InteractiveObject>;

    private var _lastOffset:int = 0;

    public function QuestsSeasonAwardsWindow() {
        this._tabItems = new Vector.<InteractiveObject>(0);
        super();
    }

    override protected function initialize():void {
        this.tabs.tabsSeparator.width = SEPARATOR_WIDTH;
        super.initialize();
    }

    override protected function configUI():void {
        super.configUI();
        this.decScrollPosBtn.addEventListener(ButtonEvent.PRESS, this.onDecScrollPosBtnPressHandler);
        this.incScrollPosBtn.addEventListener(ButtonEvent.PRESS, this.onIncScrollPosBtnPressHandler);
        this.awardsList.addEventListener(Event.SCROLL, this.onAwardsListScrollHandler);
        this.awardsList.addEventListener(SeasonAwardWindowEvent.SHOW_VEHICLE_INFO, this.onAwardsListShowVehicleInfoHandler);
        addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onFocusChainChangeHandler);
        this.updateTabIndexes();
    }

    override protected function setData(param1:SeasonAwardsVO):void {
        window.title = param1.windowTitle;
        this.tabs.visible = param1.visibleTabs;
        if (this._lastOffset != 0) {
            this.offsetViewItems(-this._lastOffset);
            this._lastOffset = 0;
        }
        if (!param1.visibleTabs) {
            this.offsetViewItems(DISABLE_TABS_OFFSET);
            this._lastOffset = DISABLE_TABS_OFFSET;
        }
        this.awardsList.scrollPosition = 0;
        this.awardsList.selectedIndex = Values.DEFAULT_INT;
        if (this.awardsList.canCleanDataProvider && this.awardsList.dataProvider != null) {
            this.awardsList.dataProvider.cleanUp();
        }
        this.awardsList.dataProvider = new DataProvider(param1.awards);
        this.awardsList.validateNow();
        invalidate(INVALID_SCROLL_BUTTONS);
    }

    override protected function onDispose():void {
        removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE, this.onFocusChainChangeHandler);
        this.decScrollPosBtn.removeEventListener(ButtonEvent.PRESS, this.onDecScrollPosBtnPressHandler);
        this.incScrollPosBtn.removeEventListener(ButtonEvent.PRESS, this.onIncScrollPosBtnPressHandler);
        this.decScrollPosBtn.dispose();
        this.decScrollPosBtn = null;
        this.incScrollPosBtn.dispose();
        this.incScrollPosBtn = null;
        this.tabs = null;
        this.awardsList.removeEventListener(Event.SCROLL, this.onAwardsListScrollHandler);
        this.awardsList.removeEventListener(SeasonAwardWindowEvent.SHOW_VEHICLE_INFO, this.onAwardsListShowVehicleInfoHandler);
        this.awardsList.dispose();
        this.awardsList = null;
        this.clearTabItems();
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        registerFlashComponentS(this.tabs, QUESTS_ALIASES.QUESTS_CONTENT_TABS_PY_ALIAS);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(INVALID_SCROLL_BUTTONS)) {
            this.updateScrollButtons();
        }
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new <InteractiveObject>[window.getCloseBtn(), this.tabs.tabBar, this.decScrollPosBtn, this.incScrollPosBtn];
        _loc1_ = _loc1_.concat(this.awardsList.getFocusChain());
        return _loc1_;
    }

    private function offsetViewItems(param1:int):void {
        this.awardsList.y = this.awardsList.y + param1;
        this.decScrollPosBtn.y = this.decScrollPosBtn.y + param1;
        this.incScrollPosBtn.y = this.incScrollPosBtn.y + param1;
    }

    private function updateTabIndexes():void {
        this.clearTabIndexes();
        this.clearTabItems();
        this._tabItems = this.getFocusChain();
        App.utils.commons.initTabIndex(this._tabItems);
    }

    private function clearTabIndexes():void {
        var _loc3_:InteractiveObject = null;
        var _loc1_:int = this._tabItems.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this._tabItems[_loc2_];
            _loc3_.tabIndex = -1;
            _loc2_++;
        }
    }

    private function clearTabItems():void {
        if (this._tabItems != null) {
            this._tabItems.splice(0, this._tabItems.length);
            this._tabItems = null;
        }
    }

    private function updateScrollButtons():void {
        var _loc1_:int = this.awardsList.columnCount;
        var _loc2_:int = this.awardsList.dataProvider.length;
        var _loc3_:int = this.awardsList.scrollPosition;
        this.decScrollPosBtn.visible = this.incScrollPosBtn.visible = _loc2_ > _loc1_;
        if (this.decScrollPosBtn.visible) {
            this.decScrollPosBtn.enabled = _loc3_ > 0;
        }
        if (this.incScrollPosBtn.visible) {
            this.incScrollPosBtn.enabled = _loc3_ + _loc1_ < _loc2_;
        }
    }

    private function onFocusChainChangeHandler(param1:FocusChainChangeEvent):void {
        this.updateTabIndexes();
    }

    private function onAwardsListShowVehicleInfoHandler(param1:SeasonAwardWindowEvent):void {
        showVehicleInfoS(param1.id);
    }

    private function onDecScrollPosBtnPressHandler(param1:ButtonEvent):void {
        this.awardsList.scrollPosition--;
    }

    private function onIncScrollPosBtnPressHandler(param1:ButtonEvent):void {
        this.awardsList.scrollPosition++;
    }

    private function onAwardsListScrollHandler(param1:Event):void {
        invalidate(INVALID_SCROLL_BUTTONS);
    }
}
}
