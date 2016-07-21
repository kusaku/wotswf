package net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortClanBattleRoomVO extends DAAPIDataClass {

    public var mapID:int = -1;

    public var headerDescr:String = "";

    public var mineClanName:String = "";

    public var enemyClanName:String = "";

    public var isOrdersBgVisible:Boolean = false;

    public var ordersDisabledTooltip:String = "";

    public var ordersDisabledMessage:String = "";

    public function FortClanBattleRoomVO(param1:Object) {
        super(param1);
    }
}
}
