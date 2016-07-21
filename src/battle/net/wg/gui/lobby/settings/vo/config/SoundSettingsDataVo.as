package net.wg.gui.lobby.settings.vo.config {
import net.wg.gui.lobby.settings.config.ControlsFactory;
import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;

public class SoundSettingsDataVo extends SettingsDataVo {

    public var PTT:SettingsControlProp = null;

    public var masterVolume:SettingsControlProp = null;

    public var musicVolume:SettingsControlProp = null;

    public var vehiclesVolume:SettingsControlProp = null;

    public var effectsVolume:SettingsControlProp = null;

    public var guiVolume:SettingsControlProp = null;

    public var ambientVolume:SettingsControlProp = null;

    public var alternativeVoices:SettingsControlProp = null;

    public var dynamicRange:SettingsControlProp = null;

    public var soundDevice:SettingsControlProp = null;

    public var enableVoIP:SettingsControlProp = null;

    public var captureDevice:SettingsControlProp = null;

    public var masterVivoxVolume:SettingsControlProp = null;

    public var micVivoxVolume:SettingsControlProp = null;

    public var masterFadeVivoxVolume:SettingsControlProp = null;

    public var voiceChatSupported:SettingsControlProp = null;

    public var bassBoost:SettingsControlProp = null;

    public var masterVolumeToggle:SettingsControlProp = null;

    public var soundQuality:SettingsControlProp = null;

    public var soundQualityVisible:SettingsControlProp = null;

    public function SoundSettingsDataVo() {
        super({
            "PTT": createControl(ControlsFactory.TYPE_KEYINPUT).isDependOn(SettingsConfigHelper.PUSH_TO_TALK).readOnly(true).build(),
            "masterVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "musicVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "vehiclesVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "effectsVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "guiVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "ambientVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "alternativeVoices": createControl(ControlsFactory.TYPE_DROPDOWN).isDataAsSelectedIndex(true).build(),
            "dynamicRange": createControl(ControlsFactory.TYPE_DROPDOWN).isDataAsSelectedIndex(true).build(),
            "soundDevice": createControl(ControlsFactory.TYPE_DROPDOWN).isDataAsSelectedIndex(true).build(),
            "enableVoIP": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "captureDevice": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "masterVivoxVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "micVivoxVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "masterFadeVivoxVolume": createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "voiceChatSupported": createControl(ControlsFactory.TYPE_SLIDER).readOnly(true).build(),
            "masterVolumeToggle": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "soundQuality": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "soundQualityVisible": createControl(ControlsFactory.TYPE_VALUE).readOnly(true).build(),
            "bassBoost": createControl(ControlsFactory.TYPE_CHECKBOX).build()
        });
    }

    override protected function onDispose():void {
        this.PTT = null;
        this.masterVolume = null;
        this.musicVolume = null;
        this.vehiclesVolume = null;
        this.effectsVolume = null;
        this.guiVolume = null;
        this.ambientVolume = null;
        this.alternativeVoices = null;
        this.dynamicRange = null;
        this.soundDevice = null;
        this.enableVoIP = null;
        this.captureDevice = null;
        this.masterVivoxVolume = null;
        this.micVivoxVolume = null;
        this.masterFadeVivoxVolume = null;
        this.voiceChatSupported = null;
        this.masterVolumeToggle = null;
        this.soundQuality = null;
        this.soundQualityVisible = null;
        this.bassBoost = null;
        super.onDispose();
    }
}
}
