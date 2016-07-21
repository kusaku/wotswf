package net.wg.gui.lobby.hangar.tcarousel.controls {
import flash.display.MovieClip;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CounterTFContainer extends MovieClip implements IDisposable {

    public var textFieldMc:CounterLabel;

    public function CounterTFContainer() {
        super();
    }

    public function dispose():void {
        this.textFieldMc.dispose();
        this.textFieldMc = null;
    }

    public function setText(param1:String):void {
        this.textFieldMc.label = param1;
    }
}
}
