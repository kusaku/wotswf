package net.wg.gui.lobby.fortifications.cmp.build.impl {
import flash.display.MovieClip;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class IndicatorLabels extends MovieClip implements IDisposable {

    public var hpValue:TextField;

    public var defResValue:TextField;

    public function IndicatorLabels() {
        super();
    }

    public function dispose():void {
        this.hpValue = null;
        this.defResValue = null;
    }
}
}
