package net.wg.gui.settings.vo.config {
import net.wg.gui.settings.vo.base.SettingsDataVo;
import net.wg.gui.settings.vo.config.aim.AimSettingsDataVo;
import net.wg.gui.settings.vo.config.marker.MarkerSettingsDataVo;

public class SettingConfigDataVo extends SettingsDataVo {

    public var GameSettings:GameSettingsDataVo = null;

    public var GraphicSettings:GraphicSettingsDataVo = null;

    public var SoundSettings:SoundSettingsDataVo = null;

    public var ControlsSettings:ControlsSettingsDataVo = null;

    public var AimSettings:AimSettingsDataVo = null;

    public var MarkerSettings:MarkerSettingsDataVo = null;

    public var OtherSettings:OtherSettingsDataVo = null;

    public function SettingConfigDataVo() {
        super({
            "GameSettings": new GameSettingsDataVo(),
            "GraphicSettings": new GraphicSettingsDataVo(),
            "SoundSettings": new SoundSettingsDataVo(),
            "ControlsSettings": new ControlsSettingsDataVo(),
            "AimSettings": new AimSettingsDataVo(),
            "MarkerSettings": new MarkerSettingsDataVo(),
            "OtherSettings": new OtherSettingsDataVo()
        });
    }
}
}
