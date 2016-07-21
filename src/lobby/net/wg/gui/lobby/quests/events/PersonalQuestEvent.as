package net.wg.gui.lobby.quests.events {
import flash.events.Event;

public class PersonalQuestEvent extends Event {

    public static const TILE_CLICK:String = "tileClick";

    public static const SLOT_CLICK:String = "slotClick";

    private var _id:int = -1;

    public function PersonalQuestEvent(param1:String, param2:int) {
        super(param1, true, true);
        this._id = param2;
    }

    public function get id():int {
        return this._id;
    }
}
}
