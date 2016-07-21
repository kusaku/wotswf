package net.wg.gui.lobby.hangar.crew {
import net.wg.gui.components.controls.UILoaderAlt;

import scaleform.clik.core.UIComponent;

public class TankmenIcons extends UIComponent {

    public var imageLoader:UILoaderAlt;

    public function TankmenIcons() {
        super();
    }

    override protected function onDispose():void {
        this.imageLoader.dispose();
        this.imageLoader = null;
        super.onDispose();
    }
}
}
