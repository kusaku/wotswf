package net.wg.gui.fortBase.events {
import flash.events.Event;

public class FortInitEvent extends Event {

    public static const LANDSCAPE_LOADING_COMPLETE:String = "landscapeLoadingComplete";

    public static const COMMANDER_HELP_VIEW_BTN_CLICK:String = "commanderHelpViewBtnClick";

    public function FortInitEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
        super(param1, param2, param3);
    }
}
}
