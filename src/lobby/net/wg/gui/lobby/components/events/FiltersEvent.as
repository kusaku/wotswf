package net.wg.gui.lobby.components.events {
import flash.events.Event;

public class FiltersEvent extends Event {

    public static const FILTERS_CHANGED:String = "changeFilters";

    public static const RESET_FILTERS:String = "resetFilters";

    private var _filtersValue:int;

    public function FiltersEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._filtersValue = param2;
    }

    override public function clone():Event {
        return new FiltersEvent(type, this._filtersValue, bubbles, cancelable);
    }

    public function get filtersValue():int {
        return this._filtersValue;
    }
}
}
