package net.wg.gui.lobby.quests.events {
import flash.events.Event;

public class QuestsTileChainViewHeaderEvent extends Event {

    public static const BACK_BUTTON_PRESS:String = "backButtonPressed";

    public function QuestsTileChainViewHeaderEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
