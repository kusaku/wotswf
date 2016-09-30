package net.wg.gui.battle.components.damageIndicator {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ItemWithRotation extends Sprite implements IDisposable {

    public var textField:TextField = null;

    public function ItemWithRotation() {
        super();
    }

    public function dispose():void {
        this.textField = null;
    }
}
}
