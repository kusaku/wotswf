package net.wg.gui.lobby.fortifications.data.battleRoom {
import net.wg.data.daapi.base.DAAPIDataClass;

public class IntroViewVO extends DAAPIDataClass {

    public var enableBtn:Boolean = false;

    public var fortBattleTitle:String = "";

    public var fortBattleDescr:String = "";

    public var additionalText:String = "";

    public var fortBattleBtnTitle:String = "";

    public var fortBattleBtnTooltip:String = "";

    public var listRoomBtnBtnTooltip:String = "";

    public function IntroViewVO(param1:Object) {
        super(param1);
    }
}
}
