package net.wg.gui.settings.vo.config {
import net.wg.gui.settings.config.ControlsFactory;
import net.wg.gui.settings.config.SettingsConfigHelper;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.gui.settings.vo.base.SettingsDataVo;

public class OtherSettingsDataVo extends SettingsDataVo {

    public var vibroIsConnected:SettingsControlProp = null;

    public var vibroGain:SettingsControlProp = null;

    public var vibroEngine:SettingsControlProp = null;

    public var vibroAcceleration:SettingsControlProp = null;

    public var vibroShots:SettingsControlProp = null;

    public var vibroHits:SettingsControlProp = null;

    public var vibroCollisions:SettingsControlProp = null;

    public var vibroDamage:SettingsControlProp = null;

    public var vibroGUI:SettingsControlProp = null;

    public function OtherSettingsDataVo() {
        super({
            "vibroIsConnected": createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build(),
            "vibroGain": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
            "vibroEngine": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
            "vibroAcceleration": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
            "vibroShots": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
            "vibroHits": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
            "vibroCollisions": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
            "vibroDamage": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build(),
            "vibroGUI": createSliderWithLabelAndValue().isDependOn(SettingsConfigHelper.VIBRO_IS_CONNECTED).build()
        });
    }
}
}
