package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasCustomizationTabEvent extends Event {

    public static const CHANGE_TAB:String = "changeTab";

    private var _id:String = null;

    public function ChristmasCustomizationTabEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._id = param2;
    }

    override public function clone():Event {
        return new ChristmasCustomizationTabEvent(type, this._id, bubbles, cancelable);
    }

    override public function toString():String {
        return formatToString("ChristmasCustomizationTabEvent", "type", "id", "bubbles", "cancelable");
    }

    public function get id():String {
        return this._id;
    }
}
}
