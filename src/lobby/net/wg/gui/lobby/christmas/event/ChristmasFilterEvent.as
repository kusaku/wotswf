package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasFilterEvent extends Event {

    public static const CHANGE:String = "christmasFilterChange";

    private var _index:int = -1;

    public function ChristmasFilterEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._index = param2;
    }

    override public function clone():Event {
        return new ChristmasFilterEvent(type, this._index, bubbles, cancelable);
    }

    public function get index():int {
        return this._index;
    }
}
}
