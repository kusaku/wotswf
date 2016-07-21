package net.wg.gui.lobby.settings {
import flash.text.TextField;

import net.wg.gui.components.advanced.FieldSet;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.settings.components.KeyInput;
import net.wg.gui.lobby.settings.components.SoundVoiceWaves;

public class SoundSettingsBase extends SettingsBaseView {

    public var volumeFieldSet:FieldSet = null;

    public var masterVolumeToggleCheckbox:CheckBox = null;

    public var soundQualityCheckbox:CheckBox = null;

    public var masterVolumeLabel:LabelControl = null;

    public var masterVolumeSlider:Slider = null;

    public var masterVolumeValue:LabelControl = null;

    public var musicVolumeLabel:LabelControl = null;

    public var musicVolumeSlider:Slider = null;

    public var musicVolumeValue:LabelControl = null;

    public var vehiclesVolumeLabel:LabelControl = null;

    public var vehiclesVolumeSlider:Slider = null;

    public var vehiclesVolumeValue:LabelControl = null;

    public var effectsVolumeLabel:LabelControl = null;

    public var effectsVolumeSlider:Slider = null;

    public var effectsVolumeValue:LabelControl = null;

    public var guiVolumeLabel:LabelControl = null;

    public var guiVolumeSlider:Slider = null;

    public var guiVolumeValue:LabelControl = null;

    public var ambientVolumeLabel:LabelControl = null;

    public var ambientVolumeSlider:Slider = null;

    public var ambientVolumeValue:LabelControl = null;

    public var alternativeVoicesFieldSet:FieldSet = null;

    public var alternativeVoicesLabel:LabelControl = null;

    public var alternativeVoicesDropDown:DropdownMenu = null;

    public var testAlternativeVoicesButton:IButtonIconLoader = null;

    public var presetsFieldSet:FieldSet = null;

    public var dynamicRangeLabel:LabelControl = null;

    public var dynamicRangeDropDown:DropdownMenu = null;

    public var dynamicRangeInfoIcon:InfoIcon = null;

    public var soundDeviceLabel:LabelControl = null;

    public var soundDeviceDropDown:DropdownMenu = null;

    public var soundDeviceInfoIcon:InfoIcon = null;

    public var bassBoostCheckbox:CheckBox = null;

    public var voiceConnectFieldSet:FieldSet = null;

    public var enableVoIPCheckbox:CheckBox = null;

    public var PTTLabel:LabelControl = null;

    public var PTTKeyInput:KeyInput = null;

    public var captureDeviceLabel:LabelControl = null;

    public var captureDeviceDropDown:DropdownMenu = null;

    public var btnCaptureDevicesUpdate:SoundButtonEx = null;

    public var vivoxTestlabel:LabelControl = null;

    public var btnVivoxTest:SoundButtonEx = null;

    public var voiceAnimationText:TextField = null;

    public var masterVivoxVolumeLabel:LabelControl = null;

    public var masterVivoxVolumeSlider:Slider = null;

    public var masterVivoxVolumeValue:LabelControl = null;

    public var micVivoxVolumeLabel:LabelControl = null;

    public var micVivoxVolumeSlider:Slider = null;

    public var micVivoxVolumeValue:LabelControl = null;

    public var masterFadeVivoxVolumeLabel:LabelControl = null;

    public var masterFadeVivoxVolumeSlider:Slider = null;

    public var masterFadeVivoxVolumeValue:LabelControl = null;

    public var voiceAnimation:SoundVoiceWaves = null;

    public function SoundSettingsBase() {
        super();
    }

    override protected function configUI():void {
        this.volumeFieldSet.label = SETTINGS.SOUND_FIELDSET_HEADER;
        this.masterVolumeToggleCheckbox.label = SETTINGS.SOUNDS_MASTERVOLUMETOGGLE;
        this.soundQualityCheckbox.label = SETTINGS.SOUNDS_SOUNDQUALITY;
        this.soundQualityCheckbox.toolTip = TOOLTIPS.SOUNDQUALITY;
        this.masterVolumeLabel.text = SETTINGS.SOUNDS_MASTERVOLUME;
        this.musicVolumeLabel.text = SETTINGS.SOUNDS_ARENA;
        this.vehiclesVolumeLabel.text = SETTINGS.SOUNDS_VEHICLES;
        this.effectsVolumeLabel.text = SETTINGS.SOUNDS_EFFECTS;
        this.guiVolumeLabel.text = SETTINGS.SOUNDS_GUI;
        this.ambientVolumeLabel.text = SETTINGS.SOUNDS_AMBIENT;
        this.testAlternativeVoicesButton.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_SOUND;
        this.testAlternativeVoicesButton.iconOffsetLeft = 2;
        this.testAlternativeVoicesButton.iconOffsetTop = -1;
        this.voiceConnectFieldSet.label = SETTINGS.VOICE_CHAT_FIELDSET_HEADER;
        this.enableVoIPCheckbox.label = SETTINGS.VOICE_CHAT_VOICECHATENABLE;
        this.PTTLabel.text = SETTINGS.VOICE_CHAT_PTT;
        this.captureDeviceLabel.text = SETTINGS.VOICE_CHAT_MICROPHONE;
        this.btnCaptureDevicesUpdate.label = SETTINGS.SOUND_VIVOX_BUTTONS_CAPTURE_DEVICES_REFRESH;
        this.vivoxTestlabel.text = SETTINGS.SOUND_VIVOX_VIVOX_TEST;
        this.btnVivoxTest.label = SETTINGS.SOUND_VIVOX_BUTTONS_TEST_START;
        this.voiceAnimationText.text = "";
        this.masterVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_MASTER_VOLUME;
        this.micVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_MIC_SENSITIVITY;
        this.masterFadeVivoxVolumeLabel.text = SETTINGS.SOUND_VIVOX_FADE_VOLUME;
        this.alternativeVoicesFieldSet.label = SETTINGS.ALTERNATIVEVOICES_FIELDSET_HEADER;
        this.alternativeVoicesLabel.text = SETTINGS.ALTERNATIVEVOICES_LABELS_VOICEBATTLE;
        this.presetsFieldSet.label = SETTINGS.SOUND_PRESETS_TITLE;
        this.dynamicRangeLabel.text = SETTINGS.SOUND_DYNAMICRANGE_LABEL;
        this.dynamicRangeInfoIcon.tooltip = TOOLTIPS.SOUND_DYNAMICRANGE_HELP;
        this.soundDeviceLabel.text = SETTINGS.SOUND_SOUNDDEVICE_LABEL;
        this.soundDeviceInfoIcon.tooltip = TOOLTIPS.SOUND_SOUNDDEVICE_HELP;
        this.bassBoostCheckbox.label = SETTINGS.SOUND_BASSBOOST_LABEL;
        super.configUI();
    }

    override protected function onDispose():void {
        this.volumeFieldSet.dispose();
        this.volumeFieldSet = null;
        this.masterVolumeToggleCheckbox.dispose();
        this.masterVolumeToggleCheckbox = null;
        this.soundQualityCheckbox.dispose();
        this.soundQualityCheckbox = null;
        this.masterVolumeLabel.dispose();
        this.masterVolumeLabel = null;
        this.masterVolumeSlider.dispose();
        this.masterVolumeSlider = null;
        this.masterVolumeValue.dispose();
        this.masterVolumeValue = null;
        this.musicVolumeLabel.dispose();
        this.musicVolumeLabel = null;
        this.musicVolumeSlider.dispose();
        this.musicVolumeSlider = null;
        this.musicVolumeValue.dispose();
        this.musicVolumeValue = null;
        this.vehiclesVolumeLabel.dispose();
        this.vehiclesVolumeLabel = null;
        this.vehiclesVolumeSlider.dispose();
        this.vehiclesVolumeSlider = null;
        this.vehiclesVolumeValue.dispose();
        this.vehiclesVolumeValue = null;
        this.effectsVolumeLabel.dispose();
        this.effectsVolumeLabel = null;
        this.effectsVolumeSlider.dispose();
        this.effectsVolumeSlider = null;
        this.effectsVolumeValue.dispose();
        this.effectsVolumeValue = null;
        this.guiVolumeLabel.dispose();
        this.guiVolumeLabel = null;
        this.guiVolumeSlider.dispose();
        this.guiVolumeSlider = null;
        this.guiVolumeValue.dispose();
        this.guiVolumeValue = null;
        this.ambientVolumeLabel.dispose();
        this.ambientVolumeLabel = null;
        this.ambientVolumeSlider.dispose();
        this.ambientVolumeSlider = null;
        this.ambientVolumeValue.dispose();
        this.ambientVolumeValue = null;
        this.alternativeVoicesFieldSet.dispose();
        this.alternativeVoicesFieldSet = null;
        this.alternativeVoicesLabel.dispose();
        this.alternativeVoicesLabel = null;
        this.alternativeVoicesDropDown.dispose();
        this.alternativeVoicesDropDown = null;
        this.testAlternativeVoicesButton.dispose();
        this.testAlternativeVoicesButton = null;
        this.presetsFieldSet.dispose();
        this.presetsFieldSet = null;
        this.dynamicRangeLabel.dispose();
        this.dynamicRangeLabel = null;
        this.dynamicRangeDropDown.dispose();
        this.dynamicRangeDropDown = null;
        this.dynamicRangeInfoIcon.dispose();
        this.dynamicRangeInfoIcon = null;
        this.soundDeviceLabel.dispose();
        this.soundDeviceLabel = null;
        this.soundDeviceDropDown.dispose();
        this.soundDeviceDropDown = null;
        this.soundDeviceInfoIcon.dispose();
        this.soundDeviceInfoIcon = null;
        this.bassBoostCheckbox.dispose();
        this.bassBoostCheckbox = null;
        this.voiceConnectFieldSet.dispose();
        this.voiceConnectFieldSet = null;
        this.enableVoIPCheckbox.dispose();
        this.enableVoIPCheckbox = null;
        this.PTTLabel.dispose();
        this.PTTLabel = null;
        this.PTTKeyInput.dispose();
        this.PTTKeyInput = null;
        this.captureDeviceLabel.dispose();
        this.captureDeviceLabel = null;
        this.captureDeviceDropDown.dispose();
        this.captureDeviceDropDown = null;
        this.btnCaptureDevicesUpdate.dispose();
        this.btnCaptureDevicesUpdate = null;
        this.vivoxTestlabel.dispose();
        this.vivoxTestlabel = null;
        this.btnVivoxTest.dispose();
        this.btnVivoxTest = null;
        this.voiceAnimationText = null;
        this.masterVivoxVolumeLabel.dispose();
        this.masterVivoxVolumeLabel = null;
        this.masterVivoxVolumeSlider.dispose();
        this.masterVivoxVolumeSlider = null;
        this.masterVivoxVolumeValue.dispose();
        this.masterVivoxVolumeValue = null;
        this.micVivoxVolumeLabel.dispose();
        this.micVivoxVolumeLabel = null;
        this.micVivoxVolumeSlider.dispose();
        this.micVivoxVolumeSlider = null;
        this.micVivoxVolumeValue.dispose();
        this.micVivoxVolumeValue = null;
        this.masterFadeVivoxVolumeLabel.dispose();
        this.masterFadeVivoxVolumeLabel = null;
        this.masterFadeVivoxVolumeSlider.dispose();
        this.masterFadeVivoxVolumeSlider = null;
        this.masterFadeVivoxVolumeValue.dispose();
        this.masterFadeVivoxVolumeValue = null;
        this.voiceAnimation.dispose();
        this.voiceAnimation = null;
        super.onDispose();
    }
}
}
