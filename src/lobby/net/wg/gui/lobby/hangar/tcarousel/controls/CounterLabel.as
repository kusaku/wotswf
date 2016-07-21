package net.wg.gui.lobby.hangar.tcarousel.controls {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CounterLabel extends Sprite implements IDisposable {

    public var countTF:TextField = null;

    public function CounterLabel() {
        super();
    }

    public function dispose():void {
        this.countTF = null;
    }

    public function get label():String {
        return this.countTF.htmlText;
    }

    public function set label(param1:String):void {
        this.countTF.htmlText = param1;
    }
}
}
