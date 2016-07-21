package net.wg.gui.battle.random.views.stats.components.playersPanel.events {
import flash.events.Event;

public class PlayersPanelListEvent extends Event {

    public static const ITEM_SELECTED:String = "itemSelected";

    public var vehicleID:Number;

    public function PlayersPanelListEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = false) {
        this.vehicleID = param2;
        super(param1, param3, param4);
    }

    override public function clone():Event {
        return new PlayersPanelListEvent(type, this.vehicleID, bubbles, cancelable);
    }
}
}
