package net.wg.gui.cyberSport.staticFormation.events {
import flash.events.Event;

public class StaticFormationStatsEvent extends Event {

    public static const CHANGE_FILTER:String = "StaticFormationStatsChangeFilterEvent";

    public var filterIndex:int = -1;

    public function StaticFormationStatsEvent(param1:int) {
        this.filterIndex = param1;
        super(CHANGE_FILTER);
    }
}
}
