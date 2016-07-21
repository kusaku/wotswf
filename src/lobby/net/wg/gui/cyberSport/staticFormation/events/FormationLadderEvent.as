package net.wg.gui.cyberSport.staticFormation.events {
import flash.events.Event;

public class FormationLadderEvent extends Event {

    public static const SHOW_FORMATION_PROFILE:String = "showFormationProfile";

    private var _formationId:Number = NaN;

    public function FormationLadderEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this._formationId = param2;
    }

    public function get formationId():Number {
        return this._formationId;
    }
}
}
