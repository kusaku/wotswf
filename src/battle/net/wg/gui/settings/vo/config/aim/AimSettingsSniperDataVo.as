package net.wg.gui.settings.vo.config.aim {
import net.wg.gui.settings.config.ControlsFactory;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.gui.settings.vo.base.SettingsDataVo;

public class AimSettingsSniperDataVo extends SettingsDataVo {

    public var netType:SettingsControlProp = null;

    public var net:SettingsControlProp = null;

    public var centralTagType:SettingsControlProp = null;

    public var centralTag:SettingsControlProp = null;

    public var reloader:SettingsControlProp = null;

    public var condition:SettingsControlProp = null;

    public var mixingType:SettingsControlProp = null;

    public var mixing:SettingsControlProp = null;

    public var cassette:SettingsControlProp = null;

    public var gunTagType:SettingsControlProp = null;

    public var gunTag:SettingsControlProp = null;

    public var reloaderTimer:SettingsControlProp = null;

    public var zoomIndicator:SettingsControlProp = null;

    public function AimSettingsSniperDataVo() {
        super({
            "netType": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "net": createSliderWithLabelAndValue().build(),
            "centralTagType": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "centralTag": createSliderWithLabelAndValue().build(),
            "reloader": createSliderWithLabelAndValue().build(),
            "condition": createSliderWithLabelAndValue().build(),
            "mixingType": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "mixing": createSliderWithLabelAndValue().build(),
            "cassette": createSliderWithLabelAndValue().build(),
            "gunTagType": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "gunTag": createSliderWithLabelAndValue().build(),
            "reloaderTimer": createSliderWithLabelAndValue().build(),
            "zoomIndicator": createSliderWithLabelAndValue().build()
        });
    }
}
}
