package net.wg.gui.lobby.hangar.tcarousel.event {
import flash.events.Event;

public class TankItemEvent extends Event {

    public static const SELECT_ITEM:String = "selectItemEvent";

    public static const SELECT_BUY_SLOT:String = "selectBuySlot";

    public static const SELECT_BUY_TANK:String = "selectBuyTank";

    private var _itemId:int = 0;

    public function TankItemEvent(param1:String, param2:uint, param3:Boolean = true, param4:Boolean = false) {
        super(param1, param3, param4);
        this._itemId = param2;
    }

    override public function clone():Event {
        return new TankItemEvent(type, this._itemId, bubbles, cancelable);
    }

    public function get itemId():uint {
        return this._itemId;
    }
}
}
