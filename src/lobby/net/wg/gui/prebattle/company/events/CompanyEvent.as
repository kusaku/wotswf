package net.wg.gui.prebattle.company.events {
import flash.events.Event;

public class CompanyEvent extends Event {

    public static const SELECTED_ITEM:String = "selectedItem";

    public static const DROP_LIST_CLICK:String = "listClick";

    public var prbID:int;

    public var isSelected:Boolean;

    public function CompanyEvent(param1:String, param2:Boolean = true, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
