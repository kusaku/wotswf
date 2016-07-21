package net.wg.gui.lobby.hangar.crew {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CrewItemLabel extends Sprite implements IDisposable {

    public var textField:TextField = null;

    public function CrewItemLabel() {
        super();
    }

    public function set label(param1:String):void {
        this.textField.htmlText = param1;
    }

    public function get label():String {
        return this.textField.htmlText;
    }

    public function dispose():void {
        this.textField = null;
    }
}
}
