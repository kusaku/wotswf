package net.wg.gui.cyberSport.controls.events {
import flash.events.Event;

public class CSRallyInfoEvent extends Event {

    public static const SHOW_PROFILE:String = "showProfile";

    private var _rallyId:Number;

    public function CSRallyInfoEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._rallyId = param2;
    }

    public function get rallyId():Number {
        return this._rallyId;
    }
}
}
