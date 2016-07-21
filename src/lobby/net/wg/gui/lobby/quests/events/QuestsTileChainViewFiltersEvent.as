package net.wg.gui.lobby.quests.events {
import flash.events.Event;

public class QuestsTileChainViewFiltersEvent extends Event {

    public static const FILTERS_CHANGED:String = "filtersChanged";

    public function QuestsTileChainViewFiltersEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
