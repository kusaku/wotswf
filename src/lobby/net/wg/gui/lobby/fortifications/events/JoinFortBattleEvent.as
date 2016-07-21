package net.wg.gui.lobby.fortifications.events {
import flash.events.Event;

public class JoinFortBattleEvent extends Event {

    public static const JOIN_FORT_BATTLE:String = "joinFortBattle";

    public var fortBattleID:int = -1;

    public function JoinFortBattleEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) {
        this.fortBattleID = param2;
        super(param1, param3, param4);
    }

    override public function clone():Event {
        return new JoinFortBattleEvent(type, this.fortBattleID);
    }
}
}
