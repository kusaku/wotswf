package net.wg.gui.battle.views.stats.constants {
import net.wg.data.constants.InvitationStatus;

public class DynamicSquadState {

    public static var NONE:int = -1;

    public static var INVITE_DISABLED:int = 0;

    public static var IN_SQUAD:int = 1;

    public static var INVITE_AVAILABLE:int = 2;

    public static var INVITE_SENT:int = 3;

    public static var INVITE_RECEIVED:int = 4;

    public static var INVITE_RECEIVED_FROM_SQUAD:int = 5;

    public function DynamicSquadState() {
        super();
    }

    public static function getState(param1:uint, param2:Boolean, param3:Boolean, param4:Boolean):int {
        if (param2) {
            return !!param3 ? int(DynamicSquadState.IN_SQUAD) : int(DynamicSquadState.NONE);
        }
        if (InvitationStatus.isSent(param1) && !InvitationStatus.isSentInactive(param1)) {
            return DynamicSquadState.INVITE_SENT;
        }
        if (InvitationStatus.isReceived(param1) && !InvitationStatus.isReceivedInactive(param1) && !param4) {
            return !!param3 ? int(DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD) : int(DynamicSquadState.INVITE_RECEIVED);
        }
        if (param4 || InvitationStatus.isForbiddenByReceiver(param1) || InvitationStatus.isForbiddenBySender(param1)) {
            return !!param3 ? int(DynamicSquadState.IN_SQUAD) : int(DynamicSquadState.INVITE_DISABLED);
        }
        return !!param3 ? int(DynamicSquadState.IN_SQUAD) : int(DynamicSquadState.INVITE_AVAILABLE);
    }
}
}
