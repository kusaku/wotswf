package net.wg.gui.lobby.profile.pages.statistics.header {
import flash.display.MovieClip;

import scaleform.clik.core.UIComponent;

public class HeaderBGImage extends UIComponent {

    public var separator:MovieClip;

    public function HeaderBGImage() {
        super();
    }

    override protected function onDispose():void {
        this.separator = null;
        super.onDispose();
    }
}
}
