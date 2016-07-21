package net.wg.gui.lobby.fortifications.events {
import flash.events.Event;

public class FortIntelClanDescriptionEvent extends Event {

    public static const SHOW_CLAN_INFOTIP:String = "showClanInfotip";

    public static const HIDE_CLAN_INFOTIP:String = "hideClanInfotip";

    public static const CHECKBOX_CLICK:String = "checkBoxClick";

    public static const OPEN_CALENDAR:String = "openCalendar";

    public static const CLICK_LINK_BTN:String = "clickLinkBtn";

    public static const OPEN_CLAN_LIST:String = "openClanList";

    public static const OPEN_CLAN_STATISTICS:String = "openClanStatistics";

    public static const OPEN_CLAN_CARD:String = "openClanCard";

    public static const ATTACK_DIRECTION:String = "attackDirection";

    public static const HOVER_DIRECTION:String = "hoverDirection";

    public static const FOCUS_UP:String = "focusUp";

    public static const FOCUS_DOWN:String = "focusDown";

    private var _data = null;

    public function FortIntelClanDescriptionEvent(param1:String, param2:* = null) {
        super(param1, true, true);
        this._data = param2;
    }

    public function get data():* {
        return this._data;
    }
}
}
