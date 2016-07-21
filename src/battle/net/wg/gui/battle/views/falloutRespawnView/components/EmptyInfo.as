package net.wg.gui.battle.views.falloutRespawnView.components {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class EmptyInfo extends Sprite implements IDisposable {

    public var infoTF:TextField = null;

    public function EmptyInfo() {
        super();
    }

    public function dispose():void {
        this.infoTF = null;
    }
}
}
