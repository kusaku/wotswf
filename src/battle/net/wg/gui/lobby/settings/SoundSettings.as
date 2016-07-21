package net.wg.gui.lobby.settings {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.lobby.settings.components.KeyInput;
import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent;
import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.events.SliderEvent;

public class SoundSettings extends SoundSettingsBase {

    private static const VOICE_TEST_DURATION:Number = 10;

    private static const VOICE_TEST_UPDATE_RATE:Number = 0.1;

    private static const TIME_MS_IN_SECOND:Number = 1000;

    private static const LOCALIZATION_PREFIX:String = "";

    private var _isVoiceTestStarted:Boolean = false;

    private var _vivoxTestTimeLeft:Number = 0;

    private var _toolTipMgr:ITooltipMgr;

    public function SoundSettings() {
        super();
        this._toolTipMgr = App.toolTipMgr;
    }

    override public function toString():String {
        return "[WG SoundSettings " + name + "]";
    }

    override protected function configUI():void {
        btnVivoxTest.addEventListener(ButtonEvent.CLICK, this.onBtnVivoxTestClickHandler);
        btnCaptureDevicesUpdate.addEventListener(ButtonEvent.CLICK, this.onBtnCaptureDevicesUpdateClickHandler);
        PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_OVER, this.onPTTKeyInputDisableOverHandler);
        PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_OUT, this.onPTTKeyInputDisableOutHandler);
        PTTKeyInput.addEventListener(KeyInputEvents.DISABLE_PRESS, this.onPTTKeyInputDisablePressHandler);
        testAlternativeVoicesButton.addEventListener(ButtonEvent.CLICK, this.onTestAlternativeVoicesButtonClickHandler);
        testAlternativeVoicesButton.addEventListener(MouseEvent.MOUSE_OVER, this.onTestAlternativeVoicesButtonMouseOverHandler);
        testAlternativeVoicesButton.addEventListener(MouseEvent.MOUSE_OUT, this.onTestAlternativeVoicesButtonMouseOutHandler);
        super.configUI();
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc6_:String = null;
        var _loc8_:String = null;
        var _loc9_:String = null;
        var _loc10_:DisplayObject = null;
        var _loc12_:* = false;
        this.controlsUnsubscribe();
        super.setData(param1);
        var _loc2_:Boolean = SettingsControlProp(param1.getByKey(SettingsConfigHelper.VOICE_CHAT_SUPORTED)).current;
        this.showHideVoiceSettings(_loc2_);
        var _loc3_:Vector.<String> = param1.keys;
        var _loc4_:Vector.<Object> = param1.values;
        var _loc5_:int = _loc3_.length;
        var _loc7_:SettingsControlProp = null;
        var _loc11_:int = 0;
        while (_loc11_ < _loc5_) {
            _loc6_ = _loc3_[_loc11_];
            _loc7_ = SettingsControlProp(_loc4_[_loc11_]);
            _loc8_ = _loc7_.type;
            _loc9_ = _loc6_ + _loc8_;
            _loc10_ = this[_loc9_] as DisplayObject;
            if (_loc10_) {
                _loc12_ = _loc7_.current != null;
                if (SettingsConfigHelper.TYPE_CHECKBOX == _loc8_) {
                    this.prepareCheckbox(CheckBox(_loc10_), _loc6_, _loc12_, _loc7_);
                }
                else if (SettingsConfigHelper.TYPE_SLIDER == _loc8_) {
                    this.prepareSlider(Slider(_loc10_), _loc6_, _loc12_, _loc7_);
                }
                else if (SettingsConfigHelper.TYPE_DROPDOWN == _loc8_) {
                    this.prepareDropdown(DropdownMenu(_loc10_), _loc6_, _loc12_, _loc7_);
                }
                else if (SettingsConfigHelper.TYPE_KEYINPUT == _loc8_) {
                    this.prepareKeyInput(KeyInput(_loc10_), _loc7_);
                }
                trySetLabel(_loc6_, LOCALIZATION_PREFIX);
            }
            else if (!_loc7_.readOnly) {
                App.utils.asserter.assert(false, _loc9_ + Errors.WASNT_FOUND);
            }
            _loc11_++;
        }
        this.updateMasterVolumeEnabled();
        this.updateVoiceChatEnabled();
    }

    override protected function onDispose():void {
        this.breakSoundCheck();
        this.forceFinishVivoxTest();
        btnCaptureDevicesUpdate.removeEventListener(ButtonEvent.CLICK, this.onBtnCaptureDevicesUpdateClickHandler);
        btnVivoxTest.removeEventListener(ButtonEvent.CLICK, this.onBtnVivoxTestClickHandler);
        testAlternativeVoicesButton.removeEventListener(ButtonEvent.CLICK, this.onTestAlternativeVoicesButtonClickHandler);
        testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OVER, this.onTestAlternativeVoicesButtonMouseOverHandler);
        testAlternativeVoicesButton.removeEventListener(MouseEvent.MOUSE_OUT, this.onTestAlternativeVoicesButtonMouseOutHandler);
        PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OVER, this.onPTTKeyInputDisableOverHandler);
        PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OUT, this.onPTTKeyInputDisableOutHandler);
        PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_PRESS, this.onPTTKeyInputDisablePressHandler);
        this.controlsUnsubscribe();
        this._toolTipMgr = null;
        super.onDispose();
    }

    public function breakSoundCheck():void {
        if (this._isVoiceTestStarted) {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST, _viewId, "", false));
        }
    }

    public function onViewChanged():void {
        this.breakSoundCheck();
    }

    public function setCaptureDevices(param1:Number, param2:Array):void {
        captureDeviceDropDown.dataProvider = new DataProvider(param2);
        captureDeviceDropDown.selectedIndex = param1;
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(captureDeviceDropDown.name, SettingsConfigHelper.TYPE_DROPDOWN);
        var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
        if (param2.length != _loc4_.options.length) {
            _loc4_.current = -1;
        }
        _loc4_.options = param2;
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc3_, param1));
        this.updateVoiceChatEnabled();
    }

    public function setVoiceTestState(param1:Boolean):void {
        if (this._isVoiceTestStarted == param1) {
            return;
        }
        this._isVoiceTestStarted = param1;
        voiceAnimation.speak(this._isVoiceTestStarted);
        btnVivoxTest.enabled = btnCaptureDevicesUpdate.enabled = !this._isVoiceTestStarted;
        if (this._isVoiceTestStarted) {
            this._vivoxTestTimeLeft = VOICE_TEST_DURATION;
            App.utils.scheduler.scheduleRepeatableTask(this.voiceTimerTest, VOICE_TEST_UPDATE_RATE * TIME_MS_IN_SECOND, VOICE_TEST_DURATION / VOICE_TEST_UPDATE_RATE + 1);
        }
        else {
            this.forceFinishVivoxTest();
        }
    }

    public function updatePTTControl(param1:Number):void {
        PTTKeyInput.key = param1;
    }

    private function controlsUnsubscribe():void {
        var _loc1_:String = null;
        var _loc2_:IEventDispatcher = null;
        var _loc3_:int = 0;
        var _loc4_:String = null;
        var _loc5_:int = 0;
        if (_data) {
            _loc3_ = _data.keys.length;
            _loc5_ = 0;
            while (_loc5_ < _loc3_) {
                _loc1_ = _data.keys[_loc5_];
                _loc4_ = SettingsControlProp(_data.values[_loc5_]).type;
                _loc2_ = this[_loc1_ + _loc4_] as IEventDispatcher;
                if (_loc2_) {
                    if (_loc4_ == SettingsConfigHelper.TYPE_CHECKBOX) {
                        _loc2_.removeEventListener(Event.SELECT, this.onCheckboxSelectHandler);
                    }
                    else if (_loc4_ == SettingsConfigHelper.TYPE_SLIDER) {
                        _loc2_.removeEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangeHandler);
                    }
                    else if (_loc4_ == SettingsConfigHelper.TYPE_DROPDOWN) {
                        _loc2_.removeEventListener(ListEvent.INDEX_CHANGE, this.onDropdownIndexChangeHandler);
                    }
                }
                _loc5_++;
            }
        }
    }

    private function prepareKeyInput(param1:KeyInput, param2:SettingsControlProp):void {
        param1.key = param2.current;
        param1.validateNow();
    }

    private function prepareDropdown(param1:DropdownMenu, param2:String, param3:Boolean, param4:SettingsControlProp):void {
        param1.dataProvider = new DataProvider(param4.options);
        param1.selectedIndex = param4.current;
        param1.addEventListener(ListEvent.INDEX_CHANGE, this.onDropdownIndexChangeHandler);
        param1.enabled = param3;
        if (param2 == SettingsConfigHelper.ALTERNATIVE_VOICES) {
            this.showHideAlternativeVoices(param3 && param4.options.length > 1);
        }
    }

    private function prepareSlider(param1:Slider, param2:String, param3:Boolean, param4:SettingsControlProp):void {
        param1.value = param4.current;
        param1.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangeHandler);
        var _loc5_:LabelControl = this[param2 + SettingsConfigHelper.TYPE_VALUE] as LabelControl;
        if (_loc5_ && param4.hasValue) {
            _loc5_.text = param4.current;
        }
        param1.enabled = param3;
    }

    private function prepareCheckbox(param1:CheckBox, param2:String, param3:Boolean, param4:SettingsControlProp):void {
        var _loc5_:Boolean = false;
        param1.selected = param4.current;
        param1.addEventListener(Event.SELECT, this.onCheckboxSelectHandler);
        if (param2 == SettingsConfigHelper.ENABLE_VO_IP) {
            param1.enabled = param3 && SettingsControlProp(_data[SettingsConfigHelper.VOICE_CHAT_SUPORTED]).current;
        }
        else if (param2 == SettingsConfigHelper.MASTER_VOLUME_TOGGLE) {
            param1.infoIcoType = !!param1.selected ? "" : InfoIcon.TYPE_WARNING;
            param1.toolTip = !!param1.selected ? "" : TOOLTIPS.MASTERVOLUMETOGGLEOFF;
        }
        else if (param2 == SettingsConfigHelper.SOUND_QUALITY) {
            param1.visible = SettingsControlProp(_data[SettingsConfigHelper.SOUND_QUALITY_VISIBLE]).current;
            _loc5_ = param1.selected && param1.visible;
            param1.infoIcoType = !!_loc5_ ? InfoIcon.TYPE_WARNING : "";
            param1.toolTip = !!_loc5_ ? TOOLTIPS.SOUNDQUALITY : "";
            if (param1.visible) {
                param1.enabled = param3 && SettingsControlProp(_data[SettingsConfigHelper.MASTER_VOLUME_TOGGLE]).current;
            }
        }
        else {
            param1.enabled = param3;
        }
    }

    private function voiceTimerTest():void {
        this._vivoxTestTimeLeft = this._vivoxTestTimeLeft - VOICE_TEST_UPDATE_RATE;
        if (this._vivoxTestTimeLeft > 0) {
            voiceAnimationText.text = this._vivoxTestTimeLeft.toFixed(1);
        }
        else {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST, _viewId, "", false));
        }
    }

    private function forceFinishVivoxTest():void {
        App.utils.scheduler.cancelTask(this.voiceTimerTest);
        this._vivoxTestTimeLeft = 0;
        voiceAnimationText.text = "";
        btnVivoxTest.enabled = btnCaptureDevicesUpdate.enabled = !this._isVoiceTestStarted;
        voiceAnimation.speak(this._isVoiceTestStarted);
    }

    private function updateMasterVolumeEnabled():void {
        var _loc1_:Boolean = masterVolumeToggleCheckbox.selected;
        masterVolumeToggleCheckbox.infoIcoType = !!_loc1_ ? "" : InfoIcon.TYPE_WARNING;
        masterVolumeToggleCheckbox.toolTip = !!_loc1_ ? "" : TOOLTIPS.MASTERVOLUMETOGGLEOFF;
        soundQualityCheckbox.enabled = _loc1_;
        masterVolumeSlider.enabled = _loc1_;
        masterVolumeValue.enabled = _loc1_;
        musicVolumeSlider.enabled = _loc1_;
        musicVolumeValue.enabled = _loc1_;
        guiVolumeSlider.enabled = _loc1_;
        guiVolumeValue.enabled = _loc1_;
        vehiclesVolumeSlider.enabled = _loc1_;
        vehiclesVolumeValue.enabled = _loc1_;
        effectsVolumeSlider.enabled = _loc1_;
        effectsVolumeValue.enabled = _loc1_;
        ambientVolumeSlider.enabled = _loc1_;
        ambientVolumeValue.enabled = _loc1_;
        alternativeVoicesDropDown.enabled = _loc1_;
        testAlternativeVoicesButton.enabled = _loc1_;
        dynamicRangeDropDown.enabled = _loc1_;
        bassBoostCheckbox.enabled = _loc1_;
        if (soundDeviceDropDown != null) {
            soundDeviceDropDown.enabled = _loc1_;
        }
    }

    private function updateVoiceChatEnabled():void {
        this.breakSoundCheck();
        var _loc1_:Boolean = enableVoIPCheckbox.selected && SettingsControlProp(_data[SettingsConfigHelper.VOICE_CHAT_SUPORTED]).current;
        btnCaptureDevicesUpdate.enabled = _loc1_;
        masterVivoxVolumeSlider.enabled = _loc1_;
        masterFadeVivoxVolumeSlider.enabled = _loc1_;
        var _loc2_:Boolean = _loc1_ && captureDeviceDropDown.dataProvider.length > 0;
        captureDeviceDropDown.enabled = _loc2_;
        micVivoxVolumeSlider.enabled = _loc2_;
        btnVivoxTest.enabled = _loc2_;
        micVivoxVolumeValue.enabled = _loc1_;
        masterFadeVivoxVolumeValue.enabled = _loc1_;
        masterVivoxVolumeValue.enabled = _loc1_;
    }

    private function showHideVoiceSettings(param1:Boolean):void {
        var _loc2_:Boolean = App.voiceChatMgr.getYY();
        voiceConnectFieldSet.enabled = param1;
        enableVoIPCheckbox.enabled = param1 || _loc2_;
        PTTKeyInput.enabled = param1;
        captureDeviceDropDown.enabled = param1;
        btnCaptureDevicesUpdate.enabled = param1;
        btnVivoxTest.enabled = param1;
        voiceAnimation.enabled = param1;
        voiceAnimationText.text = !!param1 ? voiceAnimationText.text : "";
        masterVivoxVolumeSlider.enabled = param1;
        masterVivoxVolumeValue.enabled = param1;
        micVivoxVolumeSlider.enabled = param1;
        micVivoxVolumeValue.enabled = param1;
        masterFadeVivoxVolumeSlider.enabled = param1;
        masterFadeVivoxVolumeValue.enabled = param1;
    }

    private function showHideAlternativeVoices(param1:Boolean):void {
        alternativeVoicesFieldSet.visible = param1;
        alternativeVoicesLabel.visible = param1;
        alternativeVoicesDropDown.visible = param1;
        testAlternativeVoicesButton.visible = param1;
    }

    private function onBtnVivoxTestClickHandler(param1:ButtonEvent):void {
        if (this._isVoiceTestStarted) {
            return;
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST, _viewId, "", true));
    }

    private function onPTTKeyInputDisablePressHandler(param1:KeyInputEvents):void {
        this._toolTipMgr.hide();
    }

    private function onPTTKeyInputDisableOutHandler(param1:KeyInputEvents):void {
        this._toolTipMgr.hide();
    }

    private function onPTTKeyInputDisableOverHandler(param1:KeyInputEvents):void {
        this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_PTTKEY, null);
    }

    private function onTestAlternativeVoicesButtonMouseOutHandler(param1:MouseEvent):void {
        this._toolTipMgr.hide();
    }

    private function onTestAlternativeVoicesButtonMouseOverHandler(param1:MouseEvent):void {
        this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES);
    }

    private function onTestAlternativeVoicesButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new AlternativeVoiceEvent(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES));
    }

    private function onBtnCaptureDevicesUpdateClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE, _viewId));
    }

    private function onCheckboxSelectHandler(param1:Event):void {
        var _loc2_:CheckBox = CheckBox(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_CHECKBOX);
        if (_loc3_ == SettingsConfigHelper.ENABLE_VO_IP) {
            this.updateVoiceChatEnabled();
        }
        else if (_loc3_ == SettingsConfigHelper.MASTER_VOLUME_TOGGLE) {
            this.updateMasterVolumeEnabled();
        }
        else if (_loc3_ == SettingsConfigHelper.SOUND_QUALITY) {
            _loc2_.toolTip = _loc2_.selected && _loc2_.visible ? TOOLTIPS.SOUNDQUALITY : "";
            _loc2_.infoIcoType = _loc2_.selected && _loc2_.visible ? InfoIcon.TYPE_WARNING : "";
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc3_, _loc2_.selected));
    }

    private function onSliderValueChangeHandler(param1:SliderEvent):void {
        var _loc2_:Slider = Slider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_SLIDER);
        var _loc4_:SettingsControlProp = SettingsControlProp(_data[_loc3_]);
        var _loc5_:LabelControl = this[_loc3_ + SettingsConfigHelper.TYPE_VALUE] as LabelControl;
        if (_loc5_ && _loc4_.hasValue) {
            _loc5_.text = _loc2_.value.toString();
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc3_, _loc2_.value));
    }

    private function onDropdownIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:DropdownMenu = DropdownMenu(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_DROPDOWN);
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, _viewId, _loc3_, _loc2_.selectedIndex));
    }
}
}
