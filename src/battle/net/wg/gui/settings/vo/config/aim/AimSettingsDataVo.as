package net.wg.gui.settings.vo.config.aim {
import net.wg.gui.settings.vo.base.SettingsDataVo;

public class AimSettingsDataVo extends SettingsDataVo {

    public var arcade:AimSettingsArcadeDataVo = null;

    public var sniper:AimSettingsSniperDataVo = null;

    public function AimSettingsDataVo() {
        super({
            "arcade": new AimSettingsArcadeDataVo(),
            "sniper": new AimSettingsSniperDataVo()
        });
    }
}
}
