package net.wg.gui.components.advanced {
import flash.display.MovieClip;

import scaleform.clik.core.UIComponent;

public class UnClickableShadowBG extends UIComponent {

    public var shadow:MovieClip;

    public var hit:MovieClip;

    public function UnClickableShadowBG() {
        super();
        this.shadow.buttonMode = true;
        this.shadow.hitArea = this.hit;
        this.shadow.tabEnabled = false;
    }
}
}
