package net.wg.gui.lobby.store.shop {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class ShopRent extends Sprite implements IDisposable {

    public var textField:TextField = null;

    public function ShopRent() {
        super();
    }

    public function dispose():void {
        this.textField = null;
    }

    public function updateText(param1:String):void {
        this.textField.text = param1;
    }
}
}
