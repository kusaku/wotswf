package net.wg.gui.prebattle.company.events {
import flash.display.MovieClip;
import flash.events.Event;

public class CompanyDropDownEvent extends Event {

    public static const SHOW_DROP_DOWN:String = "showCrewDropDown";

    private var _dropDownref:MovieClip = null;

    public function CompanyDropDownEvent(param1:String, param2:MovieClip) {
        super(param1, true, true);
        this._dropDownref = param2;
    }

    public function get dropDownref():MovieClip {
        return this._dropDownref;
    }
}
}
