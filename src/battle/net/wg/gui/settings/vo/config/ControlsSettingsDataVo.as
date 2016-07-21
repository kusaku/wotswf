package net.wg.gui.settings.vo.config {
import net.wg.gui.settings.config.ControlsFactory;
import net.wg.gui.settings.vo.SettingsControlProp;
import net.wg.gui.settings.vo.base.SettingsDataVo;

public class ControlsSettingsDataVo extends SettingsDataVo {

    public var keyboardImportantBinds:Vector.<String>;

    public var keysLayoutOrder:Vector.<String> = null;

    public var keyboard:SettingsDataVo = null;

    public var mouseHorzInvert:SettingsControlProp = null;

    public var mouseArcadeSens:SettingsControlProp = null;

    public var mouseVertInvert:SettingsControlProp = null;

    public var mouseSniperSens:SettingsControlProp = null;

    public var mouseStrategicSens:SettingsControlProp = null;

    public var backDraftInvert:SettingsControlProp = null;

    public function ControlsSettingsDataVo() {
        super({
            "keysLayoutOrder": new Vector.<String>(),
            "keyboard": new SettingsDataVo({}),
            "mouseHorzInvert": createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build(),
            "mouseArcadeSens": createControl(ControlsFactory.TYPE_SLIDER).readOnly(true).build(),
            "mouseVertInvert": createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build(),
            "mouseSniperSens": createControl(ControlsFactory.TYPE_SLIDER).readOnly(true).build(),
            "mouseStrategicSens": createControl(ControlsFactory.TYPE_SLIDER).readOnly(true).build(),
            "backDraftInvert": createControl(ControlsFactory.TYPE_CHECKBOX).build()
        });
    }
}
}
