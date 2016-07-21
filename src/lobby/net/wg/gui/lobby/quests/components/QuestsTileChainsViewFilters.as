package net.wg.gui.lobby.quests.components {
import flash.display.InteractiveObject;
import flash.text.TextField;

import net.wg.gui.components.controls.DropDownImageText;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewFiltersVO;
import net.wg.gui.lobby.quests.events.QuestsTileChainViewFiltersEvent;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.events.FocusChainChangeEvent;
import net.wg.infrastructure.interfaces.IFocusChainContainer;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;

public class QuestsTileChainsViewFilters extends UIComponentEx implements IFocusChainContainer {

    private static const LEFT_MARGIN:int = 19;

    private static const LABEL_FILTERS_GAP:int = 9;

    private static const FILTERS_GAP:int = 5;

    private static const DATA_PROP_NAME:String = "data";

    public var filtersLabelTf:TextField = null;

    public var vehicleTypeFilter:DropDownImageText = null;

    public var taskTypeFilter:DropdownMenu = null;

    private var _blockFiltersChangedEvent:Boolean = false;

    public function QuestsTileChainsViewFilters() {
        super();
        this.vehicleTypeFilter.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        this.taskTypeFilter.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
    }

    override protected function onDispose():void {
        this.vehicleTypeFilter.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        this.taskTypeFilter.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownIndexChangeHandler);
        this.vehicleTypeFilter.dispose();
        this.taskTypeFilter.dispose();
        this.vehicleTypeFilter = null;
        this.taskTypeFilter = null;
        this.filtersLabelTf = null;
        super.onDispose();
    }

    public function getFocusChain():Vector.<InteractiveObject> {
        var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>(0);
        if (this.vehicleTypeFilter.visible) {
            _loc1_.push(this.vehicleTypeFilter);
        }
        _loc1_.push(this.taskTypeFilter);
        return _loc1_;
    }

    public function setData(param1:QuestsTileChainsViewFiltersVO):void {
        var _loc2_:Boolean = false;
        this._blockFiltersChangedEvent = true;
        this.filtersLabelTf.htmlText = param1.filtersLabel;
        _loc2_ = param1.showVehicleTypeFilterData;
        this.vehicleTypeFilter.visible = param1.showVehicleTypeFilterData;
        if (_loc2_) {
            this.tryCleanUpDP(this.vehicleTypeFilter.dataProvider);
            this.vehicleTypeFilter.dataProvider = new DataProvider(param1.vehicleTypeFilterData);
            this.selectDropdownMenuItem(this.vehicleTypeFilter, param1.defVehicleType);
        }
        this.tryCleanUpDP(this.taskTypeFilter.dataProvider);
        this.taskTypeFilter.dataProvider = new DataProvider(param1.taskTypeFilterData);
        this.selectDropdownMenuItem(this.taskTypeFilter, param1.defTaskType);
        this.layoutComponents();
        this._blockFiltersChangedEvent = false;
        dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
    }

    private function selectDropdownMenuItem(param1:DropdownMenu, param2:int):void {
        var _loc6_:Object = null;
        var _loc3_:IDataProvider = param1.dataProvider;
        var _loc4_:int = _loc3_.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = _loc3_.requestItemAt(_loc5_);
            if (_loc6_[DATA_PROP_NAME] == param2) {
                param1.selectedIndex = _loc5_;
                return;
            }
            _loc5_++;
        }
    }

    private function layoutComponents():void {
        var _loc1_:int = LEFT_MARGIN;
        this.filtersLabelTf.x = _loc1_;
        _loc1_ = _loc1_ + (this.filtersLabelTf.textWidth + LABEL_FILTERS_GAP >> 0);
        if (this.vehicleTypeFilter.visible) {
            this.vehicleTypeFilter.x = _loc1_;
            _loc1_ = _loc1_ + (this.vehicleTypeFilter.width + FILTERS_GAP >> 0);
        }
        this.taskTypeFilter.x = _loc1_;
    }

    private function getSelectedDropDownItem(param1:DropdownMenu):int {
        var _loc2_:Object = null;
        if (param1.selectedIndex >= 0) {
            _loc2_ = param1.dataProvider.requestItemAt(param1.selectedIndex);
        }
        return _loc2_ != null ? int(_loc2_[DATA_PROP_NAME]) : -1;
    }

    private function tryCleanUpDP(param1:IDataProvider):void {
        if (param1 != null) {
            param1.cleanUp();
        }
    }

    public function get selectedVehicleType():int {
        return this.getSelectedDropDownItem(this.vehicleTypeFilter);
    }

    public function get selectedTaskType():int {
        return this.getSelectedDropDownItem(this.taskTypeFilter);
    }

    private function onDropDownIndexChangeHandler(param1:ListEvent):void {
        if (!this._blockFiltersChangedEvent) {
            dispatchEvent(new QuestsTileChainViewFiltersEvent(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED));
        }
    }
}
}
