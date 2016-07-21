package net.wg.gui.components.advanced {
import net.wg.data.constants.SoundTypes;
import net.wg.gui.components.controls.SoundButtonEx;

public class TabButton extends SoundButtonEx {

    public function TabButton() {
        super();
        soundType = SoundTypes.TAB;
    }

    override public function toString():String {
        return "[WG TabButton " + name + "]";
    }
}
}
