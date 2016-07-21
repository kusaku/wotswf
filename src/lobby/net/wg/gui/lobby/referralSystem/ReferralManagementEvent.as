package net.wg.gui.lobby.referralSystem {
import flash.events.Event;

public class ReferralManagementEvent extends Event {

    public static const CREATE_SQUAD_BTN_CLICK:String = "createSquadBtnClick";

    public var referralID:Number = -1;

    public function ReferralManagementEvent(param1:String, param2:Number = -1) {
        super(param1, true, true);
        this.referralID = param2;
    }
}
}
