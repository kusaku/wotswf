package net.wg.gui.lobby.profile.pages.technique {
import flash.events.Event;
import flash.utils.getQualifiedClassName;

import net.wg.gui.components.controls.SortableScrollingList;
import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.interfaces.IDataProvider;
import scaleform.clik.interfaces.IListItemRenderer;

public class TechniqueList extends SortableScrollingList {

    public static const NATION_INDEX:String = "nationIndex";

    public static const TYPE_INDEX:String = "typeIndex";

    public static const SHORT_USER_NAME:String = "shortUserName";

    public static const BATTLES_COUNT:String = "battlesCount";

    public static const WINS_EFFICIENCY:String = "winsEfficiency";

    public static const AVG_EXPERIENCE:String = "avgExperience";

    public static const MARK_OF_MASTERY:String = "markOfMastery";

    public static const LEVEL:String = "level";

    public static const SELECTED_INDEX_CHANGE:String = "selectedIndexChange";

    public static const DATA_PROVIDER_CHANGED:String = "dataProviderChanged";

    private static const NO_SELECTION_VALUE:int = -1;

    private var _isValidationChecked:Boolean = false;

    private var _isSortingTheLastActivity:Boolean = false;

    private var _isDataProviderReceived:Boolean = false;

    public function TechniqueList() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        addEventListener(ListEvent.INDEX_CHANGE, this.onIndexChangeHandler);
    }

    override protected function applySorting(param1:Array):void {
        super.applySorting(param1);
        if (this._isSortingTheLastActivity) {
            this._isSortingTheLastActivity = false;
        }
    }

    override protected function draw():void {
        super.draw();
        this._isSortingTheLastActivity = false;
        if (isInvalid(InvalidationType.DATA) && this._isDataProviderReceived) {
            this._isDataProviderReceived = false;
            dispatchEvent(new Event(DATA_PROVIDER_CHANGED));
        }
    }

    override protected function invalidateSorting(param1:Object):void {
        this._isSortingTheLastActivity = true;
        super.invalidateSorting(param1);
    }

    override protected function drawLayout():void {
        var _loc8_:IListItemRenderer = null;
        var _loc1_:uint = _renderers.length;
        var _loc2_:Number = rowHeight;
        var _loc3_:Number = availableWidth - padding.horizontal;
        var _loc4_:Number = margin + padding.left;
        var _loc5_:Number = margin + padding.top;
        var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
        var _loc7_:uint = 0;
        while (_loc7_ < _loc1_) {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = Math.round(_loc4_);
            _loc8_.y = Math.round(_loc5_ + _loc7_ * _loc2_);
            _loc8_.width = _loc3_;
            if (!_loc6_) {
                _loc8_.validateNow();
            }
            _loc7_++;
        }
        drawScrollBar();
    }

    override protected function onDispose():void {
        this.removeEventListener(ListEvent.INDEX_CHANGE, this.onIndexChangeHandler);
        super.onDispose();
    }

    public function getVehicleIndexByID(param1:int):int {
        var _loc2_:TechniqueListVehicleVO = null;
        var _loc4_:int = 0;
        var _loc3_:uint = dataProvider.length;
        if (param1 != -1) {
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                _loc2_ = dataProvider[_loc4_];
                if (param1 == _loc2_.id) {
                    return _loc4_;
                }
                _loc4_++;
            }
        }
        return NO_SELECTION_VALUE;
    }

    override public function set dataProvider(param1:IDataProvider):void {
        var _loc2_:Vector.<String> = null;
        var _loc3_:Object = null;
        var _loc4_:String = null;
        this._isSortingTheLastActivity = false;
        this._isDataProviderReceived = true;
        super.dataProvider = param1;
        if (!this._isValidationChecked) {
            if (param1 && param1.length > 0) {
                this._isValidationChecked = true;
                _loc2_ = new Vector.<String>();
                _loc2_.push(NATION_INDEX);
                _loc2_.push(TYPE_INDEX);
                _loc2_.push(SHORT_USER_NAME);
                _loc2_.push(BATTLES_COUNT);
                _loc2_.push(WINS_EFFICIENCY);
                _loc2_.push(AVG_EXPERIENCE);
                _loc2_.push(MARK_OF_MASTERY);
                _loc2_.push(LEVEL);
                _loc3_ = param1[0];
                for each(_loc4_ in _loc2_) {
                    App.utils.asserter.assert(_loc3_.hasOwnProperty(_loc4_), "There is no property \'" + _loc4_ + "\' in the " + getQualifiedClassName(_loc3_) + " to apply sort operation! " + getQualifiedClassName(this));
                }
            }
        }
    }

    public function get selectedItem():Object {
        if (dataProvider && dataProvider.length > 0) {
            return dataProvider[selectedIndex];
        }
        return null;
    }

    override protected function handleItemClick(param1:ButtonEvent):void {
        super.handleItemClick(param1);
        this._isSortingTheLastActivity = false;
    }

    private function onIndexChangeHandler(param1:ListEvent):void {
        if (!this._isSortingTheLastActivity) {
            dispatchEvent(new Event(SELECTED_INDEX_CHANGE));
        }
    }

    public function selectVehicleByIndex(param1:int):void {
        _newSelectedIndex = param1;
        updateSelectedIndex();
    }
}
}
