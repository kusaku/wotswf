package net.wg.gui.lobby.vehicleCustomization.events {
import flash.events.Event;

public class CustomizationSlotEvent extends Event {

    public static const SELECT_SLOT:String = "selectSlotEvent";

    public static const REMOVE_SLOT:String = "removeSlotEvent";

    public static const REVERT_SLOT:String = "revertSlotEvent";

    private var _slotId:int = -1;

    private var _groupId:int = -1;

    private var _selectId:int = -1;

    public function CustomizationSlotEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = true, param6:Boolean = false) {
        super(param1, param5, param6);
        this._slotId = param2;
        this._groupId = param3;
        this._selectId = param4;
    }

    public function get slotId():int {
        return this._slotId;
    }

    public function get groupId():int {
        return this._groupId;
    }

    public function get selectId():int {
        return this._selectId;
    }
}
}
