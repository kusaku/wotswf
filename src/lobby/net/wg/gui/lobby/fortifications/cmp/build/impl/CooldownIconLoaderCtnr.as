package net.wg.gui.lobby.fortifications.cmp.build.impl {
import net.wg.gui.components.controls.UILoaderAlt;
import net.wg.infrastructure.base.UIComponentEx;

public class CooldownIconLoaderCtnr extends UIComponentEx {

    public var loader:UILoaderAlt = null;

    public function CooldownIconLoaderCtnr() {
        super();
    }

    override protected function onDispose():void {
        this.loader.dispose();
        this.loader = null;
        super.onDispose();
    }
}
}
