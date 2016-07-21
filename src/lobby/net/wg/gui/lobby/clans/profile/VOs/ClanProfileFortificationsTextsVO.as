package net.wg.gui.lobby.clans.profile.VOs {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ClanProfileFortificationsTextsVO extends DAAPIDataClass {

    public var totalBuildingsCount:String = "";

    public var totalDirectionsCount:String = "";

    public var defenceHour:String = "";

    public var server:String = "";

    public var vacation:String = "";

    public var dayOff:String = "";

    public function ClanProfileFortificationsTextsVO(param1:Object) {
        super(param1);
    }
}
}
