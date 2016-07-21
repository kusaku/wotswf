package net.wg.gui.lobby.fortifications.events {
import flash.events.Event;

public class FortBattleResultsEvent extends Event {

    public static const MORE_BTN_CLICK:String = "moreBtnClick";

    public var rendererID:int = -1;

    public function FortBattleResultsEvent(param1:String, param2:int = -1) {
        super(param1, true, true);
        this.rendererID = param2;
    }
}
}
