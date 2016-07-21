package net.wg.gui.settings {
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.settings.config.SettingsConfigHelper;
import net.wg.gui.settings.evnts.SettingsSubVewEvent;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.infrastructure.base.UIComponentEx;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.clik.events.SliderEvent;

public class SettingsArcadeForm extends UIComponentEx {

    public var netSlider:Slider = null;

    public var netLabel:LabelControl = null;

    public var netValue:LabelControl = null;

    public var netTypeDropDown:DropdownMenu = null;

    public var centralTagSlider:Slider = null;

    public var centralTagLabel:LabelControl = null;

    public var centralTagValue:LabelControl = null;

    public var centralTagTypeDropDown:DropdownMenu = null;

    public var reloaderSlider:Slider = null;

    public var reloaderLabel:LabelControl = null;

    public var reloaderValue:LabelControl = null;

    public var conditionSlider:Slider = null;

    public var conditionLabel:LabelControl = null;

    public var conditionValue:LabelControl = null;

    public var mixingSlider:Slider = null;

    public var mixingLabel:LabelControl = null;

    public var mixingValue:LabelControl = null;

    public var mixingTypeDropDown:DropdownMenu = null;

    public var gunTagSlider:Slider = null;

    public var gunTagLabel:LabelControl = null;

    public var gunTagValue:LabelControl = null;

    public var gunTagTypeDropDown:DropdownMenu = null;

    public var cassetteSlider:Slider = null;

    public var cassetteLabel:LabelControl = null;

    public var cassetteValue:LabelControl = null;

    public var reloaderTimerSlider:Slider = null;

    public var reloaderTimerLabel:LabelControl = null;

    public var reloaderTimerValue:LabelControl = null;

    private var _data:Object = null;

    private var _id:String = null;

    public function SettingsArcadeForm() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function draw():void {
        super.draw();
    }

    override protected function onDispose():void {
        var _loc1_:String = null;
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:SettingsControlProp = null;
        var _loc5_:Slider = null;
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
                        case SettingsConfigHelper.TYPE_SLIDER:
                            _loc5_ = this[_loc1_ + _loc4_.type];
                            _loc5_.removeEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            break;
                        case SettingsConfigHelper.TYPE_DROPDOWN:
                            _loc6_ = this[_loc1_ + _loc4_.type];
                            _loc6_.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownChange);
                    }
                }
                _loc3_++;
            }
            this._data = null;
        }
        super.onDispose();
    }

    public function setData(param1:String, param2:Object):void {
        var _loc3_:Vector.<String> = null;
        var _loc4_:Vector.<Object> = null;
        var _loc5_:int = 0;
        var _loc6_:String = null;
        var _loc7_:SettingsControlProp = null;
        var _loc8_:int = 0;
        var _loc9_:Slider = null;
        var _loc10_:DropdownMenu = null;
        var _loc11_:LabelControl = null;
        var _loc12_:LabelControl = null;
        this.id = param1;
        if (param2 != null) {
            this._data = param2;
            _loc3_ = param2.keys;
            _loc4_ = param2.values;
            _loc5_ = _loc3_.length;
            _loc6_ = param2.EMPTY_STR;
            _loc7_ = null;
            _loc8_ = 0;
            while (_loc8_ < _loc5_) {
                _loc6_ = _loc3_[_loc8_];
                _loc7_ = _loc4_[_loc8_] as SettingsControlProp;
                if (this[_loc6_ + _loc7_.type]) {
                    switch (_loc7_.type) {
                        case SettingsConfigHelper.TYPE_SLIDER:
                            _loc9_ = this[_loc6_ + _loc7_.type];
                            _loc9_.value = _loc7_.current;
                            _loc9_.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                            _loc9_.enabled = _loc7_.current != null;
                            if (_loc7_.hasValue && this[_loc6_ + SettingsConfigHelper.TYPE_VALUE]) {
                                _loc11_ = this[_loc6_ + SettingsConfigHelper.TYPE_VALUE];
                                _loc11_.text = !!_loc7_.current ? _loc7_.current : "";
                            }
                            if (_loc7_.hasLabel && this[_loc6_ + SettingsConfigHelper.TYPE_LABEL]) {
                                _loc12_ = this[_loc6_ + SettingsConfigHelper.TYPE_LABEL];
                                _loc12_.text = SETTINGS.aim(_loc6_);
                            }
                            break;
                        case SettingsConfigHelper.TYPE_DROPDOWN:
                            _loc10_ = this[_loc6_ + _loc7_.type];
                            _loc10_.dataProvider = new DataProvider(_loc7_.options);
                            _loc10_.menuRowCount = _loc7_.options is Array ? Number(_loc7_.options.length) : Number(0);
                            _loc10_.selectedIndex = _loc7_.current;
                            _loc10_.enabled = _loc7_.current != null;
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

    protected function disableAllControls():void {
        this.netSlider.enabled = false;
        this.netTypeDropDown.enabled = false;
        this.centralTagSlider.enabled = false;
        this.centralTagTypeDropDown.enabled = false;
        this.reloaderSlider.enabled = false;
        this.conditionSlider.enabled = false;
        this.mixingSlider.enabled = false;
        this.mixingTypeDropDown.enabled = false;
        this.gunTagSlider.enabled = false;
        this.gunTagTypeDropDown.enabled = false;
        this.cassetteSlider.enabled = false;
        this.reloaderTimerSlider.enabled = false;
    }

    public function get id():String {
        return this._id;
    }

    public function set id(param1:String):void {
        this._id = param1;
    }

    private function onDropDownChange(param1:ListEvent):void {
        var _loc2_:DropdownMenu = DropdownMenu(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_DROPDOWN);
        dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, _loc3_, _loc2_.selectedIndex));
    }

    private function onSliderValueChanged(param1:SliderEvent):void {
        var _loc5_:LabelControl = null;
        var _loc2_:Slider = Slider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_SLIDER);
        var _loc4_:SettingsControlProp = SettingsControlProp(this._data[_loc3_]);
        if (_loc4_.hasValue && this[_loc3_ + SettingsConfigHelper.TYPE_VALUE]) {
            _loc5_ = this[_loc3_ + SettingsConfigHelper.TYPE_VALUE];
            _loc5_.text = _loc2_.value.toString();
        }
        dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE, this._id, _loc3_, _loc2_.value));
    }
}
}
