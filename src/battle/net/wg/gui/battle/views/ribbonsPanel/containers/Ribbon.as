package net.wg.gui.battle.views.ribbonsPanel.containers {
import flash.display.Sprite;

import net.wg.gui.battle.views.ribbonsPanel.RibbonTitleAnimation;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class Ribbon extends Sprite implements IDisposable {

    public var ribbonsIcons:Icons = null;

    public var ribbonTitleAnimation:RibbonTitleAnimation = null;

    public function Ribbon() {
        super();
    }

    public function dispose():void {
        this.ribbonsIcons.dispose();
        this.ribbonsIcons = null;
        this.ribbonTitleAnimation.dispose();
        this.ribbonTitleAnimation = null;
    }
}
}
