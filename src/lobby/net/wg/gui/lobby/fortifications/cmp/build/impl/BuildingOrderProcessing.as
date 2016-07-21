package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class BuildingOrderProcessing extends MovieClip implements IDisposable {

    public var timeOver:TextField;

    public function BuildingOrderProcessing() {
        super();
    }

    public function dispose():void {
        this.timeOver = null;
        graphics.clear();
    }

    public function setTime(param1:String):void {
        this.timeOver.text = param1;
    }
}
}
