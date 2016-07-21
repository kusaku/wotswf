package net.wg.gui.cyberSport.staticFormation.events {
import flash.events.Event;

public class FormationAppointmentEvent extends Event {

    public static const PROMOTE_BUTTON_PRESS:String = "promoteButtonPress";

    public static const DEMOTE_BUTTON_PRESS:String = "demoteButtonPress";

    public function FormationAppointmentEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
