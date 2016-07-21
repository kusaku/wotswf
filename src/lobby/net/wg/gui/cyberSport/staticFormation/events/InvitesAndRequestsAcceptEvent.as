package net.wg.gui.cyberSport.staticFormation.events {
import flash.events.Event;

public class InvitesAndRequestsAcceptEvent extends Event {

    public static const TYPE:String = "InvitesAndRequestsEvent";

    public var playerId:int = -1;

    public var isAccepted:Boolean = false;

    public function InvitesAndRequestsAcceptEvent(param1:int, param2:Boolean) {
        this.playerId = param1;
        this.isAccepted = param2;
        super(TYPE, true);
    }
}
}
