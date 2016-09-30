package net.wg.gui.lobby.settings.counter.data {
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.controls.Button;

public class TabCounterVO implements IDisposable {

    private var _btn:Button = null;

    public var counterValue:int = 0;

    public function TabCounterVO(param1:Button) {
        super();
        this._btn = param1;
    }

    public function dispose():void {
        this._btn = null;
    }

    public function get btn():Button {
        return this._btn;
    }
}
}
