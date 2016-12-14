package net.wg.gui.lobby.christmas.event {
import flash.events.Event;

public class ChristmasSlotsEvent extends Event {

    public static const ITEM_REMOVED:String = "decorationItemRemoved";

    public static const ITEM_MOVED:String = "decorationItemMoved";

    private var _itemId:int;

    private var _targetSlotId:int;

    private var _sourceSlotId:int;

    public function ChristmasSlotsEvent(param1:String, param2:int, param3:int = -1, param4:int = -1, param5:Boolean = false, param6:Boolean = false) {
        super(param1, param5, param6);
        this._itemId = param3;
        this._targetSlotId = param2;
        this._sourceSlotId = param4;
    }

    override public function clone():Event {
        return new ChristmasSlotsEvent(type, this._itemId, this._targetSlotId, this._sourceSlotId, bubbles, cancelable);
    }

    override public function toString():String {
        return formatToString("ChristmasSlotsEvent", "type", "itemId", "targetSlotId", "sourceSlotId", "bubbles", "cancelable");
    }

    public function get itemId():int {
        return this._itemId;
    }

    public function get targetSlotId():int {
        return this._targetSlotId;
    }

    public function get sourceSlotId():int {
        return this._sourceSlotId;
    }
}
}
