package net.wg.gui.lobby.settings.counter {
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import net.wg.gui.components.advanced.ViewStack;
import net.wg.gui.lobby.settings.counter.data.TabCounterVO;
import net.wg.gui.lobby.settings.counter.events.CounterEvent;
import net.wg.gui.lobby.settings.interfaces.IViewWithCounteredBar;
import net.wg.gui.lobby.settings.vo.TabsDataVo;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.utils.ICounterManager;

import scaleform.clik.controls.Button;
import scaleform.clik.controls.ButtonBar;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.interfaces.IDataProvider;

public class SettingsCounterDelegate extends EventDispatcher implements IDisposable {

    private var _mainTabs:ButtonBar = null;

    private var _tabsDataProvider:IDataProvider = null;

    private var _mainViewStack:ViewStack = null;

    private var _countersData:Array = null;

    private var _counterManager:ICounterManager = null;

    private var _tabsMap:Dictionary = null;

    private var _currentMainTabLinkage:String = "";

    private var _subTabsWithCounters:Vector.<String> = null;

    public function SettingsCounterDelegate() {
        super();
        this._countersData = [];
        this._tabsMap = new Dictionary();
        this._counterManager = App.utils.counterManager;
        this._subTabsWithCounters = new Vector.<String>();
    }

    public function setSettingsItems(param1:Array, param2:ButtonBar, param3:ViewStack):void {
        this._tabsDataProvider = param2.dataProvider;
        this._mainViewStack = param3;
        this._mainTabs = param2;
        this._countersData = param1;
        this.updateMainTabLinkage();
        if (this.checkLinkageInCountersData(this._currentMainTabLinkage)) {
            this.applyAsVisitedTarget(this._currentMainTabLinkage);
        }
        this.createMainCountersData();
        param3.addEventListener(IndexEvent.INDEX_CHANGE, this.onViewIndexChangeHandler);
        param2.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        this.checkMainButtonBarData();
    }

    private function createMainCountersData():void {
        var _loc2_:TabsDataVo = null;
        var _loc3_:String = null;
        var _loc1_:int = this._tabsDataProvider.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc1_) {
            _loc2_ = this._tabsDataProvider[_loc4_];
            _loc3_ = _loc2_.linkage;
            this.recalculateMainTabButtonCounterValue(_loc3_, _loc4_);
            _loc4_++;
        }
    }

    private function createCounterDataForSubTabs(param1:ButtonBar):void {
        var _loc2_:String = null;
        param1.validateNow();
        var _loc3_:int = param1.dataProvider.length;
        var _loc4_:int = param1.selectedIndex;
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            _loc2_ = this._currentMainTabLinkage + _loc5_.toString();
            if (_loc5_ == _loc4_) {
                this.applyAsVisitedTarget(_loc2_);
            }
            else if (this.checkLinkageInCountersData(_loc2_)) {
                this.createCounter(_loc2_, 1, param1.getButtonAt(_loc5_));
            }
            _loc5_++;
        }
    }

    private function createCounter(param1:String, param2:int, param3:Button):void {
        var _loc4_:TabCounterVO = null;
        _loc4_ = new TabCounterVO(param3);
        _loc4_.counterValue = param2;
        this._tabsMap[param1] = _loc4_;
        this._counterManager.setCounter(param3, param2.toString());
    }

    private function checkLinkageInCountersData(param1:String):Boolean {
        var _loc2_:int = this._countersData.indexOf(param1);
        return _loc2_ >= 0;
    }

    private function onTabIndexChangeHandler(param1:IndexEvent):void {
        this.checkMainButtonBarData();
    }

    private function checkMainButtonBarData():void {
        var _loc2_:ButtonBar = null;
        this.updateMainTabLinkage();
        if (this.checkLinkageInCountersData(this._currentMainTabLinkage)) {
            this.applyAsVisitedTarget(this._currentMainTabLinkage);
            this.removeCounter(this._currentMainTabLinkage);
        }
        var _loc1_:IViewWithCounteredBar = this._mainViewStack.currentView as IViewWithCounteredBar;
        if (_loc1_ != null && this._subTabsWithCounters.indexOf(this._currentMainTabLinkage) < 0) {
            _loc2_ = _loc1_.getCounteredBar();
            if (_loc2_ != null) {
                this._subTabsWithCounters.push(this._currentMainTabLinkage);
                this.createCounterDataForSubTabs(_loc1_.getCounteredBar());
                this.recalculateMainTabButtonCounterValue(this._currentMainTabLinkage, this._mainTabs.selectedIndex);
            }
        }
    }

    private function recalculateMainTabButtonCounterValue(param1:String, param2:int):void {
        var _loc4_:String = null;
        var _loc3_:int = 0;
        this._mainTabs.validateNow();
        for each(_loc4_ in this._countersData) {
            if (_loc4_.indexOf(param1) >= 0) {
                _loc3_++;
            }
        }
        if (_loc3_ > 0) {
            this.createCounter(param1, _loc3_, this._mainTabs.getButtonAt(param2));
        }
        else {
            this.removeCounter(this._currentMainTabLinkage);
        }
    }

    private function onViewIndexChangeHandler(param1:IndexEvent):void {
        var _loc5_:int = 0;
        var _loc6_:String = null;
        var _loc7_:Boolean = false;
        this.updateMainTabLinkage();
        var _loc2_:ButtonBar = ButtonBar(param1.target);
        var _loc3_:IViewWithCounteredBar = this._mainViewStack.currentView as IViewWithCounteredBar;
        var _loc4_:Boolean = _loc3_ != null && _loc2_ != null;
        if (_loc4_ && _loc2_ == _loc3_.getCounteredBar() && _loc2_.visible) {
            _loc5_ = param1.index;
            _loc6_ = this._currentMainTabLinkage + _loc5_.toString();
            _loc7_ = this.checkLinkageInCountersData(_loc6_);
            if (_loc7_) {
                this.applyAsVisitedTarget(_loc6_);
            }
            if (_loc7_) {
                this.removeCounter(_loc6_);
                this.recalculateMainTabButtonCounterValue(this._currentMainTabLinkage, this._mainTabs.selectedIndex);
            }
        }
    }

    private function removeCounter(param1:String):void {
        var _loc2_:TabCounterVO = this._tabsMap[param1];
        if (_loc2_ != null) {
            this._counterManager.removeCounter(_loc2_.btn);
            _loc2_.dispose();
            delete this._tabsMap[param1];
        }
    }

    private function applyAsVisitedTarget(param1:String):void {
        var _loc2_:int = this._countersData.indexOf(param1);
        if (_loc2_ >= 0) {
            this._countersData.splice(_loc2_, 1);
            dispatchEvent(new CounterEvent(CounterEvent.COUNTER_VISITED, param1));
        }
    }

    private function updateMainTabLinkage():void {
        var _loc1_:TabsDataVo = this._tabsDataProvider[this._mainTabs.selectedIndex];
        this._currentMainTabLinkage = _loc1_.linkage;
    }

    public final function dispose():void {
        var _loc1_:TabCounterVO = null;
        for each(_loc1_ in this._tabsMap) {
            _loc1_.dispose();
            this._counterManager.removeCounter(_loc1_.btn);
        }
        this._subTabsWithCounters.splice(0, this._subTabsWithCounters.length);
        this._subTabsWithCounters = null;
        this._tabsMap = null;
        this._tabsDataProvider = null;
        this._countersData = null;
        this._mainViewStack.removeEventListener(IndexEvent.INDEX_CHANGE, this.onViewIndexChangeHandler);
        this._mainTabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChangeHandler);
        this._counterManager = null;
        this._mainTabs = null;
        this._mainViewStack = null;
    }
}
}
