package net.wg.gui.lobby.questsWindow.components {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class TextFieldMessageComponent extends Sprite implements IDisposable {

    public var textField:TextField;

    public function TextFieldMessageComponent() {
        super();
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        this.textField = null;
    }

    public function get text():String {
        return this.textField.text;
    }

    public function set text(param1:String):void {
        this.textField.text = param1;
    }

    public function get htmlText():String {
        return this.textField.htmlText;
    }

    public function set htmlText(param1:String):void {
        this.textField.htmlText = param1;
    }
}
}
