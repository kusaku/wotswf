package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasDecorationsListEvent extends Event {

    public static const INSTALL_ITEM:String = "installChristmasItem";

    public static const HIDE_NEW_ITEM:String = "hideNewItem";

    private var _id:int;

    private var _slotId:int;

    public function ChristmasDecorationsListEvent(param1:String, param2:int, param3:int = -1, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this._id = param2;
        this._slotId = param3;
    }

    override public function clone():Event {
        return new ChristmasDecorationsListEvent(type, this._id, this._slotId, bubbles, cancelable);
    }

    override public function toString():String {
        return formatToString("ChristmasDecorationsListEvent", "type", "id", "slotId", "bubbles", "cancelable");
    }

    public function get id():int {
        return this._id;
    }

    public function get slotId():int {
        return this._slotId;
    }
}
}
