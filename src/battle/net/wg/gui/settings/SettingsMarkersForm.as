package net.wg.gui.settings {
import flash.events.Event;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.settings.config.SettingsConfigHelper;
import net.wg.gui.settings.evnts.SettingsSubVewEvent;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.gui.settings.vo.base.SettingsDataVo;

import scaleform.clik.core.UIComponent;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;

public class SettingsMarkersForm extends UIComponent {

    private var _id:String = null;

    private var _data:SettingsDataVo = null;

    public var markerHeader:TextField = null;

    public var markerHP:TextField = null;

    public var markerHeaderAlt:TextField = null;

    public var markerHPAlt:TextField = null;

    public var markerBaseIconCheckbox:CheckBox = null;

    public var markerBaseLevelCheckbox:CheckBox = null;

    public var markerBaseVehicleNameCheckbox:CheckBox = null;

    public var markerBasePlayerNameCheckbox:CheckBox = null;

    public var markerBaseHpIndicatorCheckbox:CheckBox = null;

    public var markerBaseHpDropDown:DropdownMenu = null;

    public var markerBaseDamageCheckbox:CheckBox = null;

    public var markerAltIconCheckbox:CheckBox = null;

    public var markerAltLevelCheckbox:CheckBox = null;

    public var markerAltVehicleNameCheckbox:CheckBox = null;

    public var markerAltPlayerNameCheckbox:CheckBox = null;

    public var markerAltHpIndicatorCheckbox:CheckBox = null;

    public var markerAltHpDropDown:DropdownMenu = null;

    public var markerAltDamageCheckbox:CheckBox = null;

    public function SettingsMarkersForm() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function draw():void {
        super.draw();
    }

    public function setData(param1:String, param2:SettingsDataVo):void {
        var _loc3_:Vector.<String> = null;
        var _loc4_:Vector.<Object> = null;
        var _loc5_:int = 0;
        var _loc6_:String = null;
        var _loc7_:SettingsControlProp = null;
        var _loc8_:int = 0;
        var _loc9_:CheckBox = null;
        var _loc10_:DropdownMenu = null;
        this._id = param1;
        if (param2 != null) {
            this._data = param2;
            _loc3_ = param2.keys;
            _loc4_ = param2.values;
            _loc5_ = _loc3_.length;
            _loc6_ = Values.EMPTY_STR;
            _loc7_ = null;
            _loc8_ = 0;
            while (_loc8_ < _loc5_) {
                _loc6_ = _loc3_[_loc8_];
                _loc7_ = _loc4_[_loc8_] as SettingsControlProp;
                if (this[_loc6_ + _loc7_.type]) {
                    switch (_loc7_.type) {
                        case SettingsConfigHelper.TYPE_CHECKBOX:
                            _loc9_ = this[_loc6_ + _loc7_.type];
                            _loc9_.selected = _loc7_.current;
                            _loc9_.addEventListener(Event.SELECT, this.onCheckBoxSelected);
                            break;
                        case SettingsConfigHelper.TYPE_DROPDOWN:
                            _loc10_ = this[_loc6_ + _loc7_.type];
                            _loc10_.menuRowCount = _loc7_.options.length;
                            _loc10_.dataProvider = new DataProvider(_loc7_.options);
                            _loc10_.selectedIndex = _loc7_.current;
                            _loc10_.enabled = _loc7_.current == null ? false : true;
                            _loc10_.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownChange);
                    }
                }
                _loc8_++;
            }
        }
        else {
            this.disableAllControls();
        }
    }

    private function onDropDownChange(param1:ListEvent):void {
        var _loc2_:DropdownMenu = DropdownMenu(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_DROPDOWN);
        var _loc4_:String = this.getAltPrefix(_loc3_);
        dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, _loc3_, _loc2_.selectedIndex, _loc4_));
    }

    private function onCheckBoxSelected(param1:Event):void {
        var _loc2_:CheckBox = CheckBox(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_CHECKBOX);
        var _loc4_:String = this.getAltPrefix(_loc3_);
        dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, _loc3_, _loc2_.selected, _loc4_));
    }

    private function getAltPrefix(param1:String):String {
        return param1.indexOf("Alt", 0) >= 0 ? "Alt" : "";
    }

    private function disableAllControls():void {
        this.markerBaseIconCheckbox.enabled = false;
        this.markerBaseLevelCheckbox.enabled = false;
        this.markerBaseVehicleNameCheckbox.enabled = false;
        this.markerBasePlayerNameCheckbox.enabled = false;
        this.markerBaseHpIndicatorCheckbox.enabled = false;
        this.markerBaseHpDropDown.enabled = false;
        this.markerBaseDamageCheckbox.enabled = false;
        this.markerAltIconCheckbox.enabled = false;
        this.markerAltLevelCheckbox.enabled = false;
        this.markerAltVehicleNameCheckbox.enabled = false;
        this.markerAltPlayerNameCheckbox.enabled = false;
        this.markerAltHpIndicatorCheckbox.enabled = false;
        this.markerAltHpDropDown.enabled = false;
        this.markerAltDamageCheckbox.enabled = false;
    }

    override protected function onDispose():void {
        var _loc1_:String = null;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:SettingsControlProp = null;
        var _loc5_:CheckBox = null;
        var _loc6_:DropdownMenu = null;
        if (this._data != null) {
            _loc1_ = Values.EMPTY_STR;
            _loc2_ = this._data.keys.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc1_ = this._data.keys[_loc3_];
                _loc4_ = SettingsControlProp(this._data.values[_loc3_]);
                if (this[_loc1_ + _loc4_.type]) {
                    switch (_loc4_.type) {
                        case SettingsConfigHelper.TYPE_CHECKBOX:
                            _loc5_ = this[_loc1_ + _loc4_.type];
                            if (_loc5_.hasEventListener(Event.SELECT)) {
                                _loc5_.removeEventListener(Event.SELECT, this.onCheckBoxSelected);
                            }
                            break;
                        case SettingsConfigHelper.TYPE_DROPDOWN:
                            _loc6_ = this[_loc1_ + _loc4_.type];
                            if (_loc6_.hasEventListener(ListEvent.INDEX_CHANGE)) {
                                _loc6_.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownChange);
                            }
                    }
                }
                _loc3_++;
            }
            this._data = null;
        }
        super.onDispose();
    }
}
}
