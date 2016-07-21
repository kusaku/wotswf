package net.wg.gui.settings {
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.FieldSet;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.settings.config.SettingsConfigHelper;
import net.wg.gui.settings.evnts.SettingViewEvent;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.gui.settings.vo.base.SettingsDataVo;

import scaleform.clik.events.SliderEvent;

public class OtherSettings extends SettingsBaseView {

    public var fieldSetVibro:FieldSet = null;

    public var vibroDeviceConnectionStateField:TextField = null;

    public var vibroGainLabel:TextField = null;

    public var vibroGainSlider:Slider = null;

    public var vibroGainValue:LabelControl = null;

    public var vibroEngineLabel:TextField = null;

    public var vibroEngineSlider:Slider = null;

    public var vibroEngineValue:LabelControl = null;

    public var vibroAccelerationLabel:TextField = null;

    public var vibroAccelerationSlider:Slider = null;

    public var vibroAccelerationValue:LabelControl = null;

    public var vibroShotsLabel:TextField = null;

    public var vibroShotsSlider:Slider = null;

    public var vibroShotsValue:LabelControl = null;

    public var vibroHitsLabel:TextField = null;

    public var vibroHitsSlider:Slider = null;

    public var vibroHitsValue:LabelControl = null;

    public var vibroCollisionsLabel:TextField = null;

    public var vibroCollisionsSlider:Slider = null;

    public var vibroCollisionsValue:LabelControl = null;

    public var vibroDamageLabel:TextField = null;

    public var vibroDamageSlider:Slider = null;

    public var vibroDamageValue:LabelControl = null;

    public var vibroGUILabel:TextField = null;

    public var vibroGUISlider:Slider = null;

    public var vibroGUIValue:LabelControl = null;

    public function OtherSettings() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.vibroDeviceConnectionStateField.text = SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
        this.vibroGainLabel.text = SETTINGS.VIBRO_LABELS_GAIN;
        this.vibroEngineLabel.text = SETTINGS.VIBRO_LABELS_ENGINE;
        this.vibroAccelerationLabel.text = SETTINGS.VIBRO_LABELS_ACCELERATION;
        this.vibroShotsLabel.text = SETTINGS.VIBRO_LABELS_SHOTS;
        this.vibroHitsLabel.text = SETTINGS.VIBRO_LABELS_HITS;
        this.vibroCollisionsLabel.text = SETTINGS.VIBRO_LABELS_COLLISIONS;
        this.vibroDamageLabel.text = SETTINGS.VIBRO_LABELS_DAMAGE;
        this.vibroGUILabel.text = SETTINGS.VIBRO_LABELS_GUI;
        this.fieldSetVibro.label = SETTINGS.VIBRO_FIELDSET_HEADER;
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc6_:String = null;
        var _loc7_:SettingsControlProp = null;
        var _loc9_:* = false;
        var _loc10_:Slider = null;
        var _loc11_:LabelControl = null;
        var _loc12_:Boolean = false;
        super.setData(param1);
        var _loc2_:Boolean = SettingsControlProp(_data[SettingsConfigHelper.VIBRO_IS_CONNECTED]).current;
        if (!_loc2_) {
            return;
        }
        this.vibroDeviceConnectionStateField.text = !!_loc2_ ? SETTINGS.VIBRO_DEVICE_STATE_CONNECTED : SETTINGS.VIBRO_DEVICE_STATE_NOTCONNECTED;
        var _loc3_:Vector.<String> = param1.keys;
        var _loc4_:Vector.<Object> = param1.values;
        var _loc5_:int = _loc3_.length;
        _loc6_ = Values.EMPTY_STR;
        _loc7_ = null;
        var _loc8_:int = 0;
        while (_loc8_ < _loc5_) {
            _loc6_ = _loc3_[_loc8_];
            _loc7_ = _loc4_[_loc8_] as SettingsControlProp;
            if (this[_loc6_ + _loc7_.type]) {
                _loc9_ = !(_loc7_.current == null || _loc7_.readOnly);
                switch (_loc7_.type) {
                    case SettingsConfigHelper.TYPE_SLIDER:
                        _loc10_ = Slider(this[_loc6_ + _loc7_.type]);
                        _loc10_.value = _loc7_.current;
                        _loc10_.enabled = _loc9_;
                        _loc10_.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChanged);
                        if (_loc7_.hasValue && this[_loc6_ + SettingsConfigHelper.TYPE_VALUE]) {
                            _loc11_ = this[_loc6_ + SettingsConfigHelper.TYPE_VALUE];
                            _loc11_.text = _loc7_.current;
                        }
                }
            }
            if (this[_loc6_ + _loc7_.type] && _loc7_.isDependOn) {
                _loc12_ = SettingsControlProp(_data[_loc7_.isDependOn]).current;
                this.showHideControl(_loc6_, _loc7_, _loc12_);
            }
            _loc8_++;
        }
    }

    private function onSliderValueChanged(param1:SliderEvent):void {
        var _loc5_:LabelControl = null;
        var _loc2_:Slider = Slider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_SLIDER);
        var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
        if (_loc4_.hasValue && this[_loc3_ + SettingsConfigHelper.TYPE_VALUE]) {
            _loc5_ = LabelControl(this[_loc3_ + SettingsConfigHelper.TYPE_VALUE]);
            _loc5_.text = _loc2_.value.toString();
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc3_, _loc2_.value));
    }

    private function showHideControl(param1:String, param2:SettingsControlProp, param3:Boolean):void {
        if (this[param1 + param2.type]) {
            this[param1 + param2.type].visible = param3;
        }
        if (param2.hasLabel && this[param1 + SettingsConfigHelper.TYPE_LABEL]) {
            this[param1 + SettingsConfigHelper.TYPE_LABEL].visible = param3;
        }
        if (param2.hasValue && this[param1 + SettingsConfigHelper.TYPE_VALUE]) {
            this[param1 + SettingsConfigHelper.TYPE_VALUE].visible = param3;
        }
    }

    override protected function onDispose():void {
        this.fieldSetVibro.dispose();
        this.fieldSetVibro = null;
        super.onDispose();
    }
}
}
