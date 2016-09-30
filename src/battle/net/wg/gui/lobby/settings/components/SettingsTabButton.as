package net.wg.gui.lobby.settings.components {
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.components.controls.UILoaderAlt;

public class SettingsTabButton extends SoundButtonEx {

    private static const ENABLE_ALPHA:Number = 1;

    private static const DISABLE_TEXT_ALPHA:Number = 0.3;

    private static const DISABLE_ICON_ALPHA:Number = 0.5;

    private static const DISABLE_MC_ALPHA:Number = 0.7;

    public var icon:UILoaderAlt = null;

    public function SettingsTabButton() {
        super();
        preventAutosizing = true;
        constraintsDisabled = true;
        disableMc.alpha = DISABLE_MC_ALPHA;
    }

    override protected function onDispose():void {
        this.icon.dispose();
        this.icon = null;
        super.onDispose();
    }

    override protected function updateDisable():void {
        super.updateDisable();
        this.icon.alpha = !!enabled ? Number(ENABLE_ALPHA) : Number(DISABLE_ICON_ALPHA);
        textField.alpha = !!enabled ? Number(ENABLE_ALPHA) : Number(DISABLE_TEXT_ALPHA);
    }

    public function iconSource(param1:String):void {
        this.icon.source = param1;
    }
}
}
