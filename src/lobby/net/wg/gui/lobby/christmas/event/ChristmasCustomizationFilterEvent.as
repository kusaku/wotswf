package net.wg.gui.lobby.christmas.event {
public class ChristmasCustomizationFilterEvent extends ChristmasFilterEvent {

    public static const RANK_CHANGE:String = "christmasFilterRankChange";

    public static const TYPE_CHANGE:String = "christmasFilterTypeChange";

    public function ChristmasCustomizationFilterEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param2, param3, param4);
    }
}
}
