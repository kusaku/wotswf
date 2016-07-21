package net.wg.gui.components.controls {
import flash.display.MovieClip;

import net.wg.gui.interfaces.IButtonIconTextTransparent;

public class ButtonIconTextTransparent extends SoundButtonEx implements IButtonIconTextTransparent {

    public static const ICON_NO_ICON:String = "noIcon";

    public static const ICON_CROSS:String = "cross";

    public static const ICON_LOCK:String = "lock";

    public static const ICON_UP:String = "up";

    public static const ICON_DOWN:String = "down";

    public var iconContainer:MovieClip;

    private var _icon:String = "noIcon";

    public function ButtonIconTextTransparent() {
        super();
    }

    public function get icon():String {
        return this._icon;
    }

    public function set icon(param1:String):void {
        this._icon = param1;
        if (this._icon) {
            this.iconContainer.gotoAndStop(this._icon);
            this.iconContainer.visible = true;
        }
        else {
            this.iconContainer.visible = false;
        }
    }
}
}
