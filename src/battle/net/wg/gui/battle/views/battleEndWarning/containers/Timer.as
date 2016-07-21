package net.wg.gui.battle.views.battleEndWarning.containers {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class Timer extends Sprite implements IDisposable {

    public var infoText:TextField = null;

    public var timeText:TextField = null;

    public function Timer() {
        super();
    }

    public function dispose():void {
        this.infoText = null;
        this.timeText = null;
    }
}
}
