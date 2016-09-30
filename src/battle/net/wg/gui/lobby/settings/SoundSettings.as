package net.wg.gui.lobby.settings {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

import net.wg.data.constants.Errors;
import net.wg.data.constants.Values;
import net.wg.gui.components.advanced.ButtonBarEx;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.lobby.settings.components.KeyInput;
import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.events.AlternativeVoiceEvent;
import net.wg.gui.lobby.settings.events.SettingViewEvent;
import net.wg.gui.lobby.settings.interfaces.IViewWithCounteredBar;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
import net.wg.infrastructure.managers.ITooltipMgr;

import scaleform.clik.controls.ButtonBar;
import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.clik.events.IndexEvent;
import scaleform.clik.events.ListEvent;
import scaleform.clik.events.SliderEvent;

public class SoundSettings extends SoundSettingsBase implements IViewWithCounteredBar {

    private static const VOICE_TEST_DURATION:Number = 10;

    private static const VOICE_TEST_UPDATE_RATE:Number = 0.1;

    private static const TIME_MS_IN_SECOND:Number = 1000;

    private static const LOCALIZATION_PREFIX:String = Values.EMPTY_STR;

    private static const COMMON_TAB_INDEX:int = 0;

    private static const VIVOX_TAB_INDEX:int = 1;

    private static const SPECIAL_TAB_INDEX:int = 2;

    private static const ENABLE_ALPHA:Number = 1;

    private static const DISABLE_ALPHA:Number = 0.5;

    private static const BULB_VOICES:String = "bulbVoices";

    private var _isVoiceTestStarted:Boolean = false;

    private var _vivoxTestTimeLeft:Number = 0;

    private var _toolTipMgr:ITooltipMgr;

    private var _existsBulbVoices:Array = null;

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
        bulbVoicesButton.addEventListener(ButtonEvent.CLICK, this.onTestBulbVoicesButtonClickHandler);
        bulbVoicesButton.addEventListener(MouseEvent.MOUSE_OVER, this.onTestBulbVoicesButtonMouseOverHandler);
        bulbVoicesButton.addEventListener(MouseEvent.MOUSE_OUT, this.onTestBulbVoicesButtonMouseOutHandler);
        enableVoIPCheckbox.enabled = App.voiceChatMgr.getYY();
        tabs.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        super.configUI();
    }

    override protected function setData(param1:SettingsDataVo):void {
        var _loc3_:Boolean = false;
        var _loc9_:String = null;
        var _loc11_:String = null;
        var _loc12_:String = null;
        var _loc13_:DisplayObject = null;
        var _loc15_:* = false;
        var _loc16_:KeyInput = null;
        this.controlsUnsubscribe();
        super.setData(param1);
        var _loc2_:SettingsControlProp = SettingsControlProp(param1.getByKey(SettingsConfigHelper.VOICE_CHAT_SUPPORTED));
        _loc3_ = _loc2_.current;
        var _loc4_:Array = [{"label": SETTINGS.SOUNDS_TABCOMMON}];
        var _loc5_:Boolean = App.voiceChatMgr.getYY();
        if (_loc3_ || _loc5_) {
            _loc4_.push({"label": SETTINGS.SOUNDS_TABVIVOX});
            enableVoIPCheckbox.visible = true;
            this.showHideVoiceSettings(_loc3_);
        }
        tabs.dataProvider = new DataProvider(_loc4_);
        tabs.visible = _loc4_.length > 1;
        var _loc6_:Vector.<String> = param1.keys;
        var _loc7_:Vector.<Object> = param1.values;
        var _loc8_:int = _loc6_.length;
        var _loc10_:SettingsControlProp = null;
        var _loc14_:int = 0;
        while (_loc14_ < _loc8_) {
            _loc9_ = _loc6_[_loc14_];
            _loc10_ = SettingsControlProp(_loc7_[_loc14_]);
            _loc11_ = _loc10_.type;
            _loc12_ = _loc9_ + _loc11_;
            _loc13_ = this[_loc12_] as DisplayObject;
            if (_loc13_) {
                _loc15_ = _loc10_.current != null;
                if (SettingsConfigHelper.TYPE_CHECKBOX == _loc11_) {
                    this.prepareCheckbox(CheckBox(_loc13_), _loc9_, _loc15_, _loc10_);
                }
                else if (SettingsConfigHelper.TYPE_SLIDER == _loc11_) {
                    this.prepareSlider(Slider(_loc13_), _loc9_, _loc15_, _loc10_);
                }
                else if (SettingsConfigHelper.TYPE_DROPDOWN == _loc11_) {
                    if (_loc9_ == BULB_VOICES) {
                        this._existsBulbVoices = _loc10_.extraData as Array;
                        App.utils.asserter.assertNotNull(this._existsBulbVoices, "_existsBulbVoices" + Errors.CANT_NULL);
                    }
                    this.prepareDropdown(DropdownMenu(_loc13_), _loc15_, _loc10_);
                }
                else if (SettingsConfigHelper.TYPE_KEYINPUT == _loc11_) {
                    _loc16_ = KeyInput(_loc13_);
                    _loc16_.key = Number(_loc10_.current);
                    _loc16_.validateNow();
                }
                else if (SettingsConfigHelper.TYPE_BUTTON_BAR == _loc11_) {
                    this.prepareButtonBar(ButtonBarEx(_loc13_), _loc15_, _loc10_);
                }
                trySetLabel(_loc9_, LOCALIZATION_PREFIX);
            }
            else if (!_loc10_.readOnly) {
                App.utils.asserter.assert(false, _loc12_ + Errors.WASNT_FOUND);
            }
            _loc14_++;
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
        bulbVoicesButton.removeEventListener(ButtonEvent.CLICK, this.onTestBulbVoicesButtonClickHandler);
        bulbVoicesButton.removeEventListener(MouseEvent.MOUSE_OVER, this.onTestBulbVoicesButtonMouseOverHandler);
        bulbVoicesButton.removeEventListener(MouseEvent.MOUSE_OUT, this.onTestBulbVoicesButtonMouseOutHandler);
        PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OVER, this.onPTTKeyInputDisableOverHandler);
        PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_OUT, this.onPTTKeyInputDisableOutHandler);
        PTTKeyInput.removeEventListener(KeyInputEvents.DISABLE_PRESS, this.onPTTKeyInputDisablePressHandler);
        this.controlsUnsubscribe();
        this._toolTipMgr = null;
        this._existsBulbVoices.splice(0, this._existsBulbVoices.length);
        this._existsBulbVoices = null;
        tabs.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabsIndexChangeHandler);
        super.onDispose();
    }

    public function breakSoundCheck():void {
        if (this._isVoiceTestStarted) {
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST, viewId, Values.EMPTY_STR, false));
        }
    }

    public function onViewChanged():void {
        this.breakSoundCheck();
    }

    public function setCaptureDevices(param1:Number, param2:Array):void {
        captureDeviceDropDown.dataProvider = new DataProvider(param2);
        captureDeviceDropDown.selectedIndex = param1;
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(captureDeviceDropDown.name, SettingsConfigHelper.TYPE_DROPDOWN);
        var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
        if (param2.length != _loc4_.options.length) {
            _loc4_.current = -1;
        }
        _loc4_.options = param2;
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, param1));
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
        if (data && data.keys) {
            _loc3_ = data.keys.length;
            _loc5_ = 0;
            while (_loc5_ < _loc3_) {
                _loc1_ = data.keys[_loc5_];
                _loc4_ = SettingsControlProp(data.values[_loc5_]).type;
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
                    else if (_loc4_ == SettingsConfigHelper.TYPE_BUTTON_BAR) {
                        _loc2_.removeEventListener(IndexEvent.INDEX_CHANGE, this.onButtonBarIndexChangeHandler);
                    }
                }
                _loc5_++;
            }
        }
    }

    private function prepareButtonBar(param1:ButtonBarEx, param2:Boolean, param3:SettingsControlProp):void {
        param1.dataProvider = new DataProvider(param3.options);
        param1.selectedIndex = int(param3.current);
        param1.addEventListener(IndexEvent.INDEX_CHANGE, this.onButtonBarIndexChangeHandler);
        param1.enabled = param2;
    }

    private function prepareDropdown(param1:DropdownMenu, param2:Boolean, param3:SettingsControlProp):void {
        param1.dataProvider = new DataProvider(param3.options);
        param1.selectedIndex = int(param3.current);
        param1.addEventListener(ListEvent.INDEX_CHANGE, this.onDropdownIndexChangeHandler);
        param1.enabled = param2;
    }

    private function prepareSlider(param1:Slider, param2:String, param3:Boolean, param4:SettingsControlProp):void {
        param1.value = Number(param4.current);
        param1.addEventListener(SliderEvent.VALUE_CHANGE, this.onSliderValueChangeHandler);
        var _loc5_:LabelControl = this[param2 + SettingsConfigHelper.TYPE_VALUE] as LabelControl;
        if (_loc5_ && param4.hasValue) {
            _loc5_.text = param4.current.toString();
        }
        param1.enabled = param3;
    }

    private function prepareCheckbox(param1:CheckBox, param2:String, param3:Boolean, param4:SettingsControlProp):void {
        var _loc5_:Boolean = false;
        param1.selected = param4.current;
        param1.addEventListener(Event.SELECT, this.onCheckboxSelectHandler);
        if (param2 == SettingsConfigHelper.ENABLE_VO_IP) {
            param1.enabled = param3 && SettingsControlProp(data[SettingsConfigHelper.VOICE_CHAT_SUPPORTED]).current;
        }
        else if (param2 == SettingsConfigHelper.MASTER_VOLUME_TOGGLE) {
            param1.infoIcoType = !!param1.selected ? Values.EMPTY_STR : InfoIcon.TYPE_WARNING;
            param1.toolTip = !!param1.selected ? Values.EMPTY_STR : TOOLTIPS.MASTERVOLUMETOGGLEOFF;
        }
        else if (param2 == SettingsConfigHelper.SOUND_QUALITY) {
            param1.visible = SettingsControlProp(data[SettingsConfigHelper.SOUND_QUALITY_VISIBLE]).current;
            _loc5_ = param1.selected && param1.visible;
            param1.infoIcoType = !!_loc5_ ? InfoIcon.TYPE_WARNING : Values.EMPTY_STR;
            param1.toolTip = !!_loc5_ ? TOOLTIPS.SOUNDQUALITY : Values.EMPTY_STR;
            if (param1.visible) {
                param1.enabled = param3 && SettingsControlProp(data[SettingsConfigHelper.MASTER_VOLUME_TOGGLE]).current;
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
            dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST, viewId, Values.EMPTY_STR, false));
        }
    }

    private function forceFinishVivoxTest():void {
        App.utils.scheduler.cancelTask(this.voiceTimerTest);
        this._vivoxTestTimeLeft = 0;
        voiceAnimationText.text = Values.EMPTY_STR;
        btnVivoxTest.enabled = btnCaptureDevicesUpdate.enabled = !this._isVoiceTestStarted;
        voiceAnimation.speak(this._isVoiceTestStarted);
    }

    private function updateMasterVolumeEnabled():void {
        var _loc1_:Boolean = masterVolumeToggleCheckbox.selected;
        masterVolumeToggleCheckbox.infoIcoType = !!_loc1_ ? Values.EMPTY_STR : InfoIcon.TYPE_WARNING;
        masterVolumeToggleCheckbox.toolTip = !!_loc1_ ? Values.EMPTY_STR : TOOLTIPS.MASTERVOLUMETOGGLEOFF;
        masterVolumeLabel.enabled = _loc1_;
        masterVolumeSlider.enabled = _loc1_;
        masterVolumeValue.enabled = _loc1_;
        guiVolumeLabel.enabled = _loc1_;
        guiVolumeSlider.enabled = _loc1_;
        guiVolumeValue.enabled = _loc1_;
        vehiclesVolumeLabel.enabled = _loc1_;
        vehiclesVolumeSlider.enabled = _loc1_;
        vehiclesVolumeValue.enabled = _loc1_;
        voiceNotificationVolumeLabel.enabled = _loc1_;
        voiceNotificationVolumeSlider.enabled = _loc1_;
        voiceNotificationVolumeValue.enabled = _loc1_;
        effectsVolumeLabel.enabled = _loc1_;
        effectsVolumeSlider.enabled = _loc1_;
        effectsVolumeValue.enabled = _loc1_;
        ambientVolumeLabel.enabled = _loc1_;
        ambientVolumeSlider.enabled = _loc1_;
        ambientVolumeValue.enabled = _loc1_;
        musicVolumeLabel.enabled = _loc1_;
        musicVolumeSlider.enabled = _loc1_;
        musicVolumeValue.enabled = _loc1_;
        musicHangarLabel.enabled = _loc1_;
        musicHangarSlider.enabled = _loc1_;
        musicHangarValue.enabled = _loc1_;
        soundDeviceLabel.enabled = _loc1_;
        if (soundDeviceButtonBar != null) {
            soundDeviceButtonBar.enabled = _loc1_;
        }
        bassBoostCheckbox.enabled = _loc1_;
        nightModeCheckbox.enabled = _loc1_;
        alternativeVoicesButtonBar.enabled = _loc1_;
        testAlternativeVoicesButton.enabled = _loc1_;
        commonForm.bulbIcon.alpha = !!_loc1_ ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
        bulbVoicesLabel.enabled = _loc1_;
        bulbVoicesDropDown.enabled = _loc1_;
        bulbVoicesButton.enabled = _loc1_ && this._existsBulbVoices[bulbVoicesDropDown.selectedIndex];
        commonForm.bulbIcon.enabled = _loc1_;
        soundQualityCheckbox.enabled = _loc1_;
    }

    private function updateVoiceChatEnabled():void {
        this.breakSoundCheck();
        var _loc1_:Boolean = enableVoIPCheckbox.selected && SettingsControlProp(data[SettingsConfigHelper.VOICE_CHAT_SUPPORTED]).current;
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
        voiceConnectFieldSet.visible = param1;
        PTTLabel.visible = param1;
        PTTKeyInput.visible = param1;
        captureDeviceLabel.visible = param1;
        captureDeviceDropDown.visible = param1;
        btnCaptureDevicesUpdate.visible = param1;
        btnVivoxTest.visible = param1;
        voiceAnimation.visible = param1;
        voiceAnimationText.text = !!param1 ? voiceAnimationText.text : Values.EMPTY_STR;
        masterVivoxVolumeLabel.visible = param1;
        masterVivoxVolumeSlider.visible = param1;
        masterVivoxVolumeValue.visible = param1;
        micVivoxVolumeLabel.visible = param1;
        micVivoxVolumeSlider.visible = param1;
        micVivoxVolumeValue.visible = param1;
        masterFadeVivoxVolumeLabel.visible = param1;
        masterFadeVivoxVolumeSlider.visible = param1;
        masterFadeVivoxVolumeValue.visible = param1;
    }

    private function hideTooltip():void {
        this._toolTipMgr.hide();
    }

    private function onBtnVivoxTestClickHandler(param1:ButtonEvent):void {
        if (this._isVoiceTestStarted) {
            return;
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_VIVOX_TEST, viewId, Values.EMPTY_STR, true));
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
        this.hideTooltip();
    }

    private function onTestAlternativeVoicesButtonMouseOverHandler(param1:MouseEvent):void {
        this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES);
    }

    private function onTestAlternativeVoicesButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new AlternativeVoiceEvent(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES));
    }

    private function onTestBulbVoicesButtonMouseOutHandler(param1:MouseEvent):void {
        this.hideTooltip();
    }

    private function onTestBulbVoicesButtonMouseOverHandler(param1:MouseEvent):void {
        this._toolTipMgr.showComplex(TOOLTIPS.SETTINGS_DIALOG_SOUND_ALTERNATIVEVOICES);
    }

    private function onTestBulbVoicesButtonClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new AlternativeVoiceEvent(AlternativeVoiceEvent.ON_TEST_BULB_VOICES, bulbVoicesDropDown.selectedIndex));
    }

    private function onBtnCaptureDevicesUpdateClickHandler(param1:ButtonEvent):void {
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE, viewId));
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
            _loc2_.toolTip = _loc2_.selected && _loc2_.visible ? TOOLTIPS.SOUNDQUALITY : Values.EMPTY_STR;
            _loc2_.infoIcoType = _loc2_.selected && _loc2_.visible ? InfoIcon.TYPE_WARNING : Values.EMPTY_STR;
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc2_.selected));
    }

    private function onSliderValueChangeHandler(param1:SliderEvent):void {
        var _loc2_:Slider = Slider(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_SLIDER);
        var _loc4_:SettingsControlProp = SettingsControlProp(data[_loc3_]);
        var _loc5_:LabelControl = this[_loc3_ + SettingsConfigHelper.TYPE_VALUE] as LabelControl;
        if (_loc5_ && _loc4_.hasValue) {
            _loc5_.text = _loc2_.value.toString();
        }
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc2_.value));
    }

    private function onDropdownIndexChangeHandler(param1:ListEvent):void {
        var _loc2_:DropdownMenu = DropdownMenu(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_DROPDOWN);
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc2_.selectedIndex));
        if (_loc3_ == BULB_VOICES) {
            bulbVoicesButton.enabled = this._existsBulbVoices[bulbVoicesDropDown.selectedIndex];
        }
    }

    private function onButtonBarIndexChangeHandler(param1:IndexEvent):void {
        var _loc2_:ButtonBarEx = ButtonBarEx(param1.target);
        var _loc3_:String = SettingsConfigHelper.instance.getControlId(_loc2_.name, SettingsConfigHelper.TYPE_BUTTON_BAR);
        dispatchEvent(new SettingViewEvent(SettingViewEvent.ON_CONTROL_CHANGED, viewId, _loc3_, _loc2_.selectedIndex));
    }

    private function onTabsIndexChangeHandler(param1:IndexEvent):void {
        commonForm.visible = false;
        vivoxForm.visible = false;
        specialForm.visible = false;
        switch (param1.index) {
            case COMMON_TAB_INDEX:
                commonForm.visible = true;
                break;
            case VIVOX_TAB_INDEX:
                vivoxForm.visible = true;
                break;
            case SPECIAL_TAB_INDEX:
                specialForm.visible = true;
        }
    }

    public function getCounteredBar():ButtonBar {
        return !!tabs.visible ? tabs : null;
    }
}
}
