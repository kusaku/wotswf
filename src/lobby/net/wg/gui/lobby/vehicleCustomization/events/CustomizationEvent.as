package net.wg.gui.lobby.vehicleCustomization.events {
import flash.events.Event;

public class CustomizationEvent extends Event {

    public static const FILTER_DURATION_TYPE:String = "filterDurationType";

    public static const FILTER_PURCHASED:String = "filterPurchased";

    public static const CLOSE_VIEW:String = "closeView";

    public static const SHOW_BUY_WINDOW:String = "showBuyWindow";

    public static const BACK_TO_GROUP_SELECTOR:String = "groupSelector";

    private var _index:int = -1;

    private var _select:Boolean = false;

    public function CustomizationEvent(param1:String, param2:Boolean = false, param3:int = -1) {
        super(param1, true, true);
        this._index = param3;
        this._select = param2;
    }

    public function get index():int {
        return this._index;
    }

    public function get select():Boolean {
        return this._select;
    }
}
}
