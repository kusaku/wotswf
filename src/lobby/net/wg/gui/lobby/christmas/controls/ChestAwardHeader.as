package net.wg.gui.lobby.christmas.controls {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ChestAwardHeader extends Sprite implements IDisposable {

    public var headerTF:TextField = null;

    public function ChestAwardHeader() {
        super();
    }

    public function dispose():void {
        this.headerTF = null;
    }
}
}
