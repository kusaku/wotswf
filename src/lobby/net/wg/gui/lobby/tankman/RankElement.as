package net.wg.gui.lobby.tankman {
import net.wg.gui.components.controls.UILoaderAlt;

import scaleform.clik.core.UIComponent;

public class RankElement extends UIComponent {

    public var icoLoader:UILoaderAlt;

    public function RankElement() {
        super();
    }

    override protected function onDispose():void {
        this.icoLoader.dispose();
        this.icoLoader = null;
        super.onDispose();
    }

    public function setSource(param1:String):void {
        this.icoLoader.source = param1;
    }
}
}
