package net.wg.gui.lobby.battleResults.event {
import flash.events.Event;

public class BattleResultsViewEvent extends Event {

    public static const SHOW_DETAILS:String = "ShowDetails";

    public function BattleResultsViewEvent(param1:String) {
        super(param1, true, true);
    }
}
}
