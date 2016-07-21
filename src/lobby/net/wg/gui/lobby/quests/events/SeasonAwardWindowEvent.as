package net.wg.gui.lobby.quests.events {
import flash.events.Event;

public class SeasonAwardWindowEvent extends Event {

    public static const SHOW_VEHICLE_INFO:String = "showVehicleInfo";

    private var _id:Number;

    public function SeasonAwardWindowEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._id = param2;
    }

    public function get id():Number {
        return this._id;
    }
}
}
