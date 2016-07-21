package net.wg.gui.lobby.profile.pages.technique {
import fl.transitions.easing.Strong;

import flash.display.MovieClip;
import flash.events.Event;

import net.wg.data.constants.SortingInfo;
import net.wg.gui.components.advanced.SortableHeaderButtonBar;
import net.wg.gui.components.advanced.SortingButton;
import net.wg.gui.components.controls.NormalSortingBtnVO;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.controls.SortableScrollingList;
import net.wg.gui.events.SortingEvent;
import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
import net.wg.gui.utils.ExcludeTweenManager;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.ScrollIndicator;
import scaleform.clik.data.DataProvider;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.motion.Tween;

public class TechniqueListComponent extends UIComponentEx {

    public static const DATA_CHANGED:String = "dataChanged";

    private static const DEFAULT_SELECTED_BUTTON_INDEX:int = 4;

    private static const LIST_DATA_INVALIDATED:String = "ldInv";

    private static const ANIM_SPEED:uint = 1000;

    private static const MASTERY_TAB_ENABLING_CHANGED:String = "mTabEnablingChanged";

    public var lowerShadow:MovieClip = null;

    public var upperShadow:MovieClip = null;

    public var sortableButtonBar:SortableHeaderButtonBar = null;

    public var techniqueList:TechniqueList = null;

    public var bg:MovieClip = null;

    public var scrollBar:ScrollBar = null;

    private var _isMarkOfMasteryBtnEnabled:Boolean = true;

    private var _tweenManager:ExcludeTweenManager;

    private var _vehicles:Array = null;

    private var _waitForSorting:Boolean = false;

    private var _selectedVehicleId:int = -1;

    public function TechniqueListComponent() {
        this._tweenManager = new ExcludeTweenManager();
        super();
        this.techniqueList.addEventListener(TechniqueList.SELECTED_INDEX_CHANGE, this.onTechniqueListSelectedIndexChangeHandler);
        this.techniqueList.addEventListener(SortableScrollingList.DATA_INVALIDATED, this.onTechniqueListDataInvalidatedHandler);
        this.techniqueList.addEventListener(TechniqueList.DATA_PROVIDER_CHANGED, this.onTechniqueListDataProviderChangedHandler);
    }

    override public function setSize(param1:Number, param2:Number):void {
        super.setSize(param1, param2);
        var _loc3_:Number = this.techniqueList.rowHeight;
        var _loc4_:int = int(_height / _loc3_);
        _loc4_ = _loc4_ != -1 ? int(_loc4_) : 0;
        this.techniqueList.rowCount = _loc4_;
        var _loc5_:uint = _loc3_ * _loc4_;
        this.techniqueList.setSize(this.techniqueList.width, _loc5_);
        this.techniqueList.invalidateSize();
        this.techniqueList.validateNow();
        this.bg.height = _loc5_ - this.bg.y;
        this.scrollBar.setActualSize(this.scrollBar.width, _loc5_ - this.scrollBar.y);
        this.scrollBar.validateNow();
        this.lowerShadow.y = _loc5_ - this.lowerShadow.height;
    }

    override protected function draw():void {
        var _loc1_:uint = 0;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:ScrollIndicator = null;
        var _loc5_:Number = NaN;
        var _loc6_:int = 0;
        var _loc7_:NormalSortingBtnVO = null;
        var _loc8_:int = 0;
        if (this._vehicles == null) {
            return;
        }
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            this.techniqueList.dataProvider = new DataProvider(this._vehicles);
        }
        if (isInvalid(LIST_DATA_INVALIDATED)) {
            _loc1_ = this.techniqueList.dataProvider.length;
            _loc2_ = this.techniqueList.renderersCount;
            if (_loc1_ <= _loc2_) {
                this._tweenManager.registerAndLaunch(ANIM_SPEED, this.upperShadow, {"alpha": 0}, this.getAnimTweenSet());
                this._tweenManager.registerAndLaunch(ANIM_SPEED, this.lowerShadow, {"alpha": 0}, this.getAnimTweenSet());
            }
            else {
                _loc3_ = _loc1_ - _loc2_;
                _loc4_ = ScrollIndicator(this.techniqueList.scrollBar);
                _loc5_ = !!_loc4_ ? Number(_loc4_.position) : Number(0);
                if (_loc5_ == 0) {
                    this._tweenManager.registerAndLaunch(ANIM_SPEED, this.upperShadow, {"alpha": 0}, this.getAnimTweenSet());
                    this._tweenManager.registerAndLaunch(ANIM_SPEED, this.lowerShadow, {"alpha": 1}, this.getAnimTweenSet());
                }
                else if (_loc5_ == _loc3_) {
                    this._tweenManager.registerAndLaunch(ANIM_SPEED, this.upperShadow, {"alpha": 1}, this.getAnimTweenSet());
                    this._tweenManager.registerAndLaunch(ANIM_SPEED, this.lowerShadow, {"alpha": 0}, this.getAnimTweenSet());
                }
                else {
                    this._tweenManager.registerAndLaunch(ANIM_SPEED, this.upperShadow, {"alpha": 1}, this.getAnimTweenSet());
                    this._tweenManager.registerAndLaunch(ANIM_SPEED, this.lowerShadow, {"alpha": 1}, this.getAnimTweenSet());
                }
            }
            if (this._waitForSorting) {
                this._waitForSorting = false;
                this.applySelectedVehicle();
            }
        }
        if (isInvalid(MASTERY_TAB_ENABLING_CHANGED)) {
            _loc6_ = !!this.sortableButtonBar.dataProvider ? int(this.sortableButtonBar.dataProvider.length) : 0;
            _loc8_ = _loc6_ - 1;
            while (_loc8_ >= 0) {
                _loc7_ = this.sortableButtonBar.dataProvider[_loc8_];
                if (_loc7_ && _loc7_.id == TechniqueList.MARK_OF_MASTERY) {
                    this.sortableButtonBar.enableButtonAt(this._isMarkOfMasteryBtnEnabled, _loc8_);
                    if (_loc8_ == this.sortableButtonBar.selectedIndex && !this._isMarkOfMasteryBtnEnabled) {
                        this.applyDefaultSorting();
                    }
                    break;
                }
                _loc8_--;
            }
        }
    }

    override protected function onDispose():void {
        this._tweenManager.dispose();
        this._tweenManager = null;
        if (this._vehicles) {
            this._vehicles.splice(0, this._vehicles.length);
            this._vehicles = null;
        }
        this.sortableButtonBar.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED, this.onSortableButtonBarSortDirectionChangedHandler);
        if (this.techniqueList) {
            this.techniqueList.removeEventListener(TechniqueList.SELECTED_INDEX_CHANGE, this.onTechniqueListSelectedIndexChangeHandler);
            this.techniqueList.removeEventListener(SortableScrollingList.DATA_INVALIDATED, this.onTechniqueListDataInvalidatedHandler);
            this.techniqueList.removeEventListener(TechniqueList.DATA_PROVIDER_CHANGED, this.onTechniqueListDataProviderChangedHandler);
            this.techniqueList.dispose();
            this.techniqueList = null;
        }
        if (this.sortableButtonBar) {
            this.sortableButtonBar.dispose();
            this.sortableButtonBar = null;
        }
        this.scrollBar.dispose();
        this.scrollBar = null;
        this.lowerShadow = null;
        this.upperShadow = null;
        this.bg = null;
        super.onDispose();
    }

    public function enableMarkOfMasteryBtn(param1:Boolean):void {
        if (this._isMarkOfMasteryBtnEnabled != param1) {
            this._isMarkOfMasteryBtnEnabled = param1;
            invalidate(MASTERY_TAB_ENABLING_CHANGED);
        }
    }

    private function applyDefaultSorting():void {
        this.sortableButtonBar.selectedIndex = DEFAULT_SELECTED_BUTTON_INDEX;
        this.techniqueList.sortByField(TechniqueList.BATTLES_COUNT, false);
    }

    private function getAnimTweenSet():Object {
        return {
            "ease": Strong.easeOut,
            "onComplete": this.onTweenComplete
        };
    }

    private function onTweenComplete(param1:Tween):void {
        if (this._tweenManager) {
            this._tweenManager.unregister(param1);
        }
    }

    public function set headerDataProvider(param1:IDataProvider):void {
        this.sortableButtonBar.dataProvider = param1;
        this.lowerShadow.mouseEnabled = this.upperShadow.mouseEnabled = false;
        this.sortableButtonBar.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED, this.onSortableButtonBarSortDirectionChangedHandler, false, 0, true);
        this.techniqueList.columnsData = this.sortableButtonBar.dataProvider;
        this.techniqueList.smartScrollBar = true;
    }

    public function set vehicles(param1:Array):void {
        this._vehicles = param1;
        invalidateData();
        if (this._vehicles) {
            this.applyDefaultSorting();
        }
    }

    public function getSelectedItem():TechniqueListVehicleVO {
        return TechniqueListVehicleVO(this.techniqueList.selectedItem);
    }

    private function onTechniqueListDataInvalidatedHandler(param1:Event):void {
        invalidate(LIST_DATA_INVALIDATED);
    }

    private function onTechniqueListSelectedIndexChangeHandler(param1:Event):void {
        this.storeVehicleSelectedId();
        dispatchEvent(new Event(DATA_CHANGED));
    }

    private function onTechniqueListDataProviderChangedHandler(param1:Event):void {
        this.applySelectedVehicle();
        dispatchEvent(new Event(DATA_CHANGED));
    }

    private function onSortableButtonBarSortDirectionChangedHandler(param1:Event):void {
        var _loc2_:SortingButton = SortingButton(param1.target);
        var _loc3_:int = this.sortableButtonBar.dataProvider.indexOf(_loc2_.data);
        if (_loc3_ != -1 && _loc2_.sortDirection != SortingInfo.WITHOUT_SORT) {
            this.techniqueList.sortByField(_loc2_.id, _loc2_.sortDirection == SortingInfo.ASCENDING_SORT);
            this._waitForSorting = true;
        }
    }

    private function applySelectedVehicle():void {
        var _loc1_:int = 0;
        if (this.techniqueList.dataProvider && this.techniqueList.dataProvider.length) {
            _loc1_ = this.techniqueList.getVehicleIndexByID(this._selectedVehicleId);
            if (this._selectedVehicleId < 0 || _loc1_ == -1) {
                this._selectedVehicleId = TechniqueListVehicleVO(this.techniqueList.dataProvider[0]).id;
                _loc1_ = 0;
            }
            this.techniqueList.selectVehicleByIndex(_loc1_);
        }
    }

    public function selectVehicleById(param1:int):void {
        this._selectedVehicleId = param1;
        this.applySelectedVehicle();
    }

    public function storeVehicleSelectedId():void {
        var _loc1_:TechniqueListVehicleVO = this.getSelectedItem();
        if (_loc1_) {
            this._selectedVehicleId = _loc1_.id;
        }
    }
}
}
