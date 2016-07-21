package net.wg.gui.components.advanced.events {
import flash.events.Event;

public class CalendarEvent extends Event {

    public static const DAY_SELECTED:String = "dateSelected";

    public static const MONTH_CHANGED:String = "monthChanged";

    public var displayDate:Date = null;

    public var selectedDate:Date = null;

    public function CalendarEvent(param1:String, param2:Date, param3:Date, param4:Boolean = false, param5:Boolean = false) {
        this.displayDate = param2;
        this.selectedDate = param3;
        super(param1, param4, param5);
    }
}
}
