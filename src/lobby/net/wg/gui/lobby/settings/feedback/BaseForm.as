package net.wg.gui.lobby.settings.feedback {
import flash.display.InteractiveObject;
import flash.events.Event;

import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.lobby.settings.components.RadioButtonBar;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.events.SettingsSubVewEvent;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IDisplayObject;
import net.wg.infrastructure.interfaces.IViewStackContent;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.IndexEvent;

public class BaseForm extends UIComponentEx implements IViewStackContent {

    private var _initialized:Boolean = false;

    private var _checkBoxes:Vector.<CheckBox>;

    private var _buttonBars:Vector.<RadioButtonBar>;

    private var _data:SettingsDataVo;

    public function BaseForm() {
        this._checkBoxes = new Vector.<CheckBox>();
        this._buttonBars = new Vector.<RadioButtonBar>();
        super();
    }

    override protected function onBeforeDispose():void {
        var _loc1_:CheckBox = null;
        var _loc2_:RadioButtonBar = null;
        for each(_loc1_ in this._checkBoxes) {
            _loc1_.removeEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
        }
        for each(_loc2_ in this._buttonBars) {
            _loc2_.removeEventListener(IndexEvent.INDEX_CHANGE, this.onButtonBarIndexChangeHandler);
        }
        super.onBeforeDispose();
    }

    override protected function onDispose():void {
        this._checkBoxes.splice(0, this._checkBoxes.length);
        this._checkBoxes = null;
        this._buttonBars.splice(0, this._buttonBars.length);
        this._buttonBars = null;
        this._data = null;
        super.onDispose();
    }

    public function canShowAutomatically():Boolean {
        return true;
    }

    public function getComponentForFocus():InteractiveObject {
        return null;
    }

    public function setData(param1:Object):void {
        var _loc5_:String = null;
        var _loc6_:SettingsControlProp = null;
        var _loc7_:IDisplayObject = null;
        var _loc8_:CheckBox = null;
        var _loc9_:RadioButtonBar = null;
        var _loc10_:* = false;
        if (this._initialized) {
            return;
        }
        var _loc2_:SettingsDataVo = SettingsDataVo(param1);
        this._data = _loc2_;
        var _loc3_:int = 0;
        var _loc4_:int = _loc2_.keys.length;
        _loc3_ = 0;
        while (_loc3_ < _loc4_) {
            _loc5_ = _loc2_.keys[_loc3_];
            _loc6_ = SettingsControlProp(_loc2_[_loc5_]);
            _loc7_ = this[_loc5_ + _loc6_.type];
            if (_loc6_ && _loc7_) {
                _loc10_ = !(_loc6_.current == null || _loc6_.readOnly);
                switch (_loc6_.type) {
                    case SettingsConfigHelper.TYPE_CHECKBOX:
                        _loc8_ = CheckBox(_loc7_);
                        this.setupCheckBox(_loc8_, _loc6_.changedVal, _loc10_);
                        break;
                    case SettingsConfigHelper.TYPE_BUTTON_BAR:
                        _loc9_ = RadioButtonBar(_loc7_);
                        this.setupButtonBar(_loc9_, _loc6_.options, int(_loc6_.current), _loc10_);
                }
            }
            _loc3_++;
        }
        this._initialized = true;
    }

    public function update(param1:Object):void {
    }

    public function updateContent(param1:Object):void {
        var _loc2_:IDisplayObject = null;
        var _loc3_:SettingsControlProp = null;
        var _loc4_:* = null;
        if (!param1 || !this._initialized) {
            return;
        }
        for (_loc4_ in param1) {
            _loc3_ = this._data[_loc4_];
            _loc2_ = this[_loc4_ + _loc3_.type];
            if (_loc2_) {
                switch (_loc3_.type) {
                    case SettingsConfigHelper.TYPE_BUTTON_BAR:
                        if (RadioButtonBar(_loc2_).selectedIndex != param1[_loc4_]) {
                            RadioButtonBar(_loc2_).selectedIndex = param1[_loc4_];
                        }
                        continue;
                    case SettingsConfigHelper.TYPE_CHECKBOX:
                        if (CheckBox(_loc2_).selected != param1[_loc4_]) {
                            CheckBox(_loc2_).selected = param1[_loc4_];
                        }
                        continue;
                    default:
                        continue;
                }
            }
            else {
                continue;
            }
        }
    }

    protected function setupCheckBox(param1:CheckBox, param2:Boolean, param3:Boolean):void {
        param1.selected = param2;
        param1.enabled = param3;
        param1.addEventListener(Event.SELECT, this.onCheckBoxSelectHandler);
        this._checkBoxes.push(param1);
    }

    protected function dispatchSettingSubVewEvent(param1:String, param2:Object):void {
        dispatchEvent(new SettingsSubVewEvent(SettingsSubVewEvent.ON_CONTROL_CHANGE, this.formId, param1, param2));
    }

    protected function setupButtonBar(param1:RadioButtonBar, param2:Array, param3:int, param4:Boolean):void {
        param1.dataProvider = new DataProvider(param2);
        param1.selectedIndex = param3;
        param1.addEventListener(IndexEvent.INDEX_CHANGE, this.onButtonBarIndexChangeHandler);
        this._buttonBars.push(param1);
    }

    protected function onCheckBoxSelected(param1:CheckBox):void {
        var _loc2_:String = SettingsConfigHelper.instance.getControlId(param1.name, SettingsConfigHelper.TYPE_CHECKBOX);
        this.dispatchSettingSubVewEvent(_loc2_, param1.selected);
    }

    protected function onButtonBarIndexChange(param1:RadioButtonBar):void {
        var _loc2_:String = SettingsConfigHelper.instance.getControlId(param1.name, SettingsConfigHelper.TYPE_BUTTON_BAR);
        this.dispatchSettingSubVewEvent(_loc2_, param1.selectedIndex);
    }

    public function get formId():String {
        App.utils.asserter.assert(false, "formId must be overridden");
        return "";
    }

    private function onCheckBoxSelectHandler(param1:Event):void {
        var _loc2_:CheckBox = CheckBox(param1.target);
        this.onCheckBoxSelected(_loc2_);
    }

    private function onButtonBarIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:RadioButtonBar = RadioButtonBar(param1.target);
        this.onButtonBarIndexChange(_loc2_);
    }
}
}