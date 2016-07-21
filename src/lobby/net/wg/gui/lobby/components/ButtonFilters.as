package net.wg.gui.lobby.components {
import flash.events.Event;

import net.wg.data.constants.Errors;
import net.wg.gui.components.common.containers.Group;
import net.wg.gui.components.controls.BlackButton;
import net.wg.gui.lobby.components.data.ButtonFiltersItemVO;
import net.wg.gui.lobby.components.data.ButtonFiltersVO;
import net.wg.gui.lobby.components.events.FiltersEvent;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.controls.Button;

public class ButtonFilters extends Group {

    private static const BUTTON_WIDTH:int = 40;

    private var _buttonFiltersGroup:ButtonFiltersGroup;

    private var _filtersValue:int = 0;

    private var _buttonLinkage:String;

    public function ButtonFilters() {
        super();
        this._buttonFiltersGroup = new ButtonFiltersGroup();
        this._buttonFiltersGroup.addEventListener(Event.CHANGE, this.onFiltersGroupChangeHandler);
    }

    override protected function onDispose():void {
        this._buttonFiltersGroup.removeEventListener(Event.CHANGE, this.onFiltersGroupChangeHandler);
        this._buttonFiltersGroup.dispose();
        this._buttonFiltersGroup = null;
        super.onDispose();
    }

    public function resetFilters(param1:int):void {
        var _loc2_:Button = null;
        var _loc3_:ButtonFiltersItemVO = null;
        var _loc4_:int = this._buttonFiltersGroup.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc2_ = this._buttonFiltersGroup.getButtonAt(_loc5_);
            _loc3_ = ButtonFiltersItemVO(_loc2_.data);
            _loc2_.selected = (_loc3_.filterValue & param1) > 0;
            _loc5_++;
        }
    }

    public function setData(param1:ButtonFiltersVO):void {
        var _loc3_:Button = null;
        var _loc4_:ButtonFiltersItemVO = null;
        this.removeAllButtons();
        this._buttonFiltersGroup.minSelectedCount = param1.minSelectedItems;
        var _loc2_:Vector.<ButtonFiltersItemVO> = param1.items;
        if (_loc2_.length > 0) {
            App.utils.asserter.assert(StringUtils.isNotEmpty(this._buttonLinkage), "buttonLinkage" + Errors.CANT_EMPTY);
        }
        for each(_loc4_ in _loc2_) {
            _loc3_ = App.utils.classFactory.getComponent(this._buttonLinkage, Button);
            _loc3_.toggle = true;
            this.applyDataToButton(_loc3_, _loc4_);
            addChild(_loc3_);
            this._buttonFiltersGroup.addButton(_loc3_);
        }
    }

    protected function applyDataToButton(param1:Button, param2:ButtonFiltersItemVO):void {
        var _loc3_:BlackButton = BlackButton(param1);
        _loc3_.toggleEnable = true;
        _loc3_.iconSource = param2.icon;
        _loc3_.tooltip = param2.tooltip;
        _loc3_.mouseEnabledOnDisabled = true;
        _loc3_.width = BUTTON_WIDTH;
        param1.data = param2;
        param1.selected = param2.selected;
    }

    protected function onSelectionChange():void {
        var _loc2_:ButtonFiltersItemVO = null;
        var _loc3_:Button = null;
        var _loc1_:Vector.<Button> = this._buttonFiltersGroup.getSelectedButtons();
        this._filtersValue = 0;
        for each(_loc3_ in _loc1_) {
            _loc2_ = ButtonFiltersItemVO(_loc3_.data);
            this._filtersValue = this._filtersValue | _loc2_.filterValue;
        }
        _loc1_.splice(0, _loc1_.length);
        dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED, this._filtersValue));
    }

    private function removeAllButtons():void {
        removeAllChildren(true);
        this._buttonFiltersGroup.removeAllButtons();
    }

    public function get filtersValue():int {
        return this._filtersValue;
    }

    public function get buttonLinkage():String {
        return this._buttonLinkage;
    }

    public function set buttonLinkage(param1:String):void {
        this._buttonLinkage = param1;
    }

    private function onFiltersGroupChangeHandler(param1:Event):void {
        this.onSelectionChange();
    }
}
}
