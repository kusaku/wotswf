package net.wg.gui.cyberSport.staticFormation.events {
import flash.events.Event;

public class FormationStaffEvent extends Event {

    public static const REMOVE_MEMBER:String = "removerMember";

    public static const PROMOTE_MEMBER:String = "promoteMember";

    public static const DEMOTE_MEMBER:String = "demoteMember";

    private var _memberId:Number;

    private var _userName:String;

    public function FormationStaffEvent(param1:String, param2:Number, param3:String, param4:Boolean = false, param5:Boolean = false) {
        super(param1, param4, param5);
        this._memberId = param2;
        this._userName = param3;
    }

    public function get memberId():Number {
        return this._memberId;
    }

    public function get userName():String {
        return this._userName;
    }
}
}
