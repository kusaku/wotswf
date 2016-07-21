package net.wg.gui.lobby.fortifications.events {
import flash.display.DisplayObject;
import flash.events.Event;

public class FortSettingsEvent extends Event {

    public static const CLICK_BLOCK_BUTTON:String = "clickBlockButton";

    public static const ACTIVATE_DEFENCE_PERIOD:String = "activateDefencePeriod";

    public static const DISABLE_DEFENCE_PERIOD:String = "disableDefencePeriod";

    public static const CANCEL_DISABLE_DEFENCE_PERIOD:String = "cancelDisableDefencePeriod";

    private var _blockButtonPoints:DisplayObject = null;

    public function FortSettingsEvent(param1:String) {
        super(param1, true, true);
    }

    public function get blockButtonPoints():DisplayObject {
        return this._blockButtonPoints;
    }

    public function set blockButtonPoints(param1:DisplayObject):void {
        this._blockButtonPoints = param1;
    }
}
}
