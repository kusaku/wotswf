package net.wg.gui.settings {
import flash.events.Event;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.BorderShadowScrollPane;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.settings.config.SettingsConfigHelper;
import net.wg.gui.settings.evnts.SettingViewEvent;
import net.wg.gui.settings.vo.IncreasedZoomVO;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.gui.settings.vo.base.SettingsDataVo;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ListEvent;
import scaleform.clik.events.SliderEvent;

public class GameSettings extends SettingsBaseView {

    private static const PANE_WIDTH:Number = 800;

    private static const PANE_HEIGHT:Number = 523;

    private static const SHADOW_HEIGHT:int = 20;

    private static const INCREASED_ZOOM_LBL:String = "increasedZoom";

    public var scrollPane:BorderShadowScrollPane;

    public var content:GameSettingsContent;

    public function GameSettings() {
        super();
    }

    override public function toString():String {
        return "[WG GameSettings " + name + "]";
    }

    override public function updateDependentData():void {
        this.updatePostMortem();
    }

    override protected function configUI():void {
        super.configUI();
        this.scrollPane.topShadow.height = this.scrollPane.bottomShadow.height = SHADOW_HEIGHT;
        this.scrollPane.setSize(PANE_WIDTH, PANE_HEIGHT);
        this.content = this.scrollPane.target as GameSettingsContent;
        App.utils.asserter.assertNotNull(this.content, "content" + Errors.CANT_NULL);
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc5_:String = null;
        var _loc6_:SettingsControlProp = null;
        var _loc8_:* = false;
        var _loc9_:CheckBox = null;
        var _loc10_:IncreasedZoomVO = null;
        var _loc2_:Vector.<String> = param1.keys;
        var _loc3_:Vector.<Object> = param1.values;
        var _loc4_:int = _loc2_.length;
        _loc5_ = Values.EMPTY_STR;
        _loc6_ = null;
        var _loc7_:int = 0;
        while (_loc7_ < _loc4_) {
            _loc5_ = _loc2_[_loc7_];
            _loc6_ = _loc3_[_loc7_] as SettingsControlProp;
            App.utils.asserter.assertNotNull(_loc6_, "controlProp" + Errors.CANT_NULL);
            if (this.content[_loc5_ + _loc6_.type]) {
                _loc8_ = !(_loc6_.current == null || _loc6_.readOnly);
                switch (_loc6_.type) {
                    case SettingsConfigHelper.TYPE_CHECKBOX:
                        _loc9_ = CheckBox(this.content[_loc5_ + _loc6_.type]);
                        this.setupCheckBox(_loc9_, _loc6_.current, _loc8_);
                        if (_loc5_ == SettingsConfigHelper.RECEIVE_CLAN_INVITES_NOTIFICATIONS) {
                            _loc9_.visible = _loc6_.current != null;
                        }
                        else if (_loc5_ == INCREASED_ZOOM_LBL) {
                            _loc10_ = new IncreasedZoomVO(_loc6_.extraData);
                            _loc9_.toolTip = _loc10_.tooltip;
                            _loc9_.label = _loc10_.checkBoxLabel;
                            _loc10_.dispose();
                        }
                        break;
                    case SettingsConfigHelper.TYPE_DROPDOWN:
                        this.setupDropDown(this.content[_loc5_ + _loc6_.type], _loc6_, _loc8_);
                        break;
                    case SettingsConfigHelper.TYPE_SLIDER:
                        this.setupSlider(Slider(this.content[_loc5_ + _loc6_.type]), _loc6_.current, _loc8_);
                        if (_loc6_.hasValue && this.content[_loc5_ + SettingsConfigHelper.TYPE_VALUE]) {
                            this.setupLabel(this.content[_loc5_ + SettingsConfigHelper.TYPE_VALUE], _loc6_.current);
                        }
                }
            }
            else if (!_loc6_.readOnly) {
                DebugUtils.LOG_WARNING("ERROR in" + this + " control " + (_loc5_ + _loc6_.type) + " can not find");
            }
            _loc7_++;
        }
    }

    override protected function onDispose():void {
        var _loc1_:String = null;
        var _loc2_:Vector.<String> = null;
        var _loc3_:Vector.<Object> = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:SettingsControlProp = null;
        var _loc7_:CheckBox = null;
        var _loc8_:Slider = null;
        var _loc9_:DropdownMenu = null;
        if (_data != null) {
            _loc1_ = Values.EMPTY_STR;
            _loc2_ = _data.keys;
            _loc3_ = _data.values;
            _loc4_ = _loc2_.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc1_ = _loc2_[_loc5_];
                if (this.content[_loc1_ + _loc3_[_loc5_].type] != null) {
                    _loc6_ = _loc3_[_loc5_] as SettingsControlProp;
                    App.utils.asserter.assertNotNull(_loc6_, "controlProp" + Errors.CANT_NULL);
                    switch (_loc6_.type) {
                        case SettingsConfigHelper.TYPE_CHECKBOX:
                            _loc7_ = this.content[_loc1_ + _loc6_.type];
                            _loc7_.removeEventListener(Event.SELECT, this.onCheckBoxSelectedHandler);
                            break;
                        case SettingsConfigHelper.TYPE_SLIDER:
                            _loc8_ = this.content[_loc1_ + _loc6_.type];
                            _loc8_.removeEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangedHandler);
                            break;
                        case SettingsConfigHelper.TYPE_DROPDOWN:
                            _loc9_ = this.content[_loc1_ + _loc6_.type];
                            _loc9_.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropDownChangeHandler);
                    }
                }
                _loc5_++;
            }
        }
        _data = null;
        this.content = null;
        this.scrollPane.dispose();
        this.scrollPane = null;
        super.onDispose();
    }

    private function setupLabel(param1:LabelControl, param2:String):void {
        param1.text = param2;
    }

    private function setupSlider(param1:Slider, param2:Number, param3:Boolean):void {
        param1.value = param2;
        param1.enabled = param3;
        param1.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangedHandler);
    }

    private function setupDropDown(param1:DropdownMenu, param2:SettingsControlProp, param3:Boolean):void {
        if (param1.dataProvider != null) {
            param1.dataProvider.cleanUp();
        }
        param1.dataProvider = new DataProvider(param2.options);
        param1.menuRowCount = param2.options is Array ? Number(param2.options.length) : Number(0);
        param1.selectedIndex = param2.current;
        param1.addEventListener(ListEvent.INDEX_CHANGE, this.onDropDownChangeHandler);
        param1.enabled = param3;
    }

    private function setupCheckBox(param1:CheckBox, param2:Boolean, param3:Boolean):void {
        param1.selected = param2;
        param1.enabled = param3;
        param1.addEventListener(Event.SELECT, this.onCheckBoxSelectedHandler);
    }

    private function updatePostMortem():void {
        var _loc1_:SettingsControlProp = SettingsControlProp(SettingsConfigHelper.instance.settingsData[SettingsConfigHelper.GRAPHIC_SETTINGS][SettingsConfigHelper.POST_PROCESSING_QUALITY]);
        this.content.enablePostMortemEffectCheckbox.enabled = _loc1_.changedVal != _loc1_.options.length - 1;
    }

    private function onSliderValueChangedHandler(param1:SliderEvent):void {
        var _loc2_:Slider = Slider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_SLIDER);
        var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
        if (_loc4_.hasValue && this.content[_loc3_ + SettingsConfigHelper.TYPE_VALUE] != null) {
            this.setupLabel(LabelControl(this.content[_loc3_ + SettingsConfigHelper.TYPE_VALUE]), _loc2_.value.toString());
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc3_, _loc2_.value));
    }

    private function onCheckBoxSelectedHandler(param1:Event):void {
        var _loc2_:String = SettingsConfigHelper.instance.getControlId(CheckBox(param1.target).name, SettingsConfigHelper.TYPE_CHECKBOX);
        var _loc3_:Boolean = CheckBox(param1.target).selected;
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc2_, _loc3_));
    }

    private function onDropDownChangeHandler(param1:ListEvent):void {
        var _loc2_:DropdownMenu = DropdownMenu(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_DROPDOWN);
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc3_, _loc2_.selectedIndex));
    }
}
}
