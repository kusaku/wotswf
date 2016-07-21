package net.wg.gui.battle.views.radialMenu.components {
import flash.display.Sprite;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class SectorHoveredWrapper extends Sprite implements IDisposable {

    public var content:Content = null;

    public function SectorHoveredWrapper() {
        super();
    }

    public function dispose():void {
        this.content.dispose();
        this.content = null;
    }
}
}
