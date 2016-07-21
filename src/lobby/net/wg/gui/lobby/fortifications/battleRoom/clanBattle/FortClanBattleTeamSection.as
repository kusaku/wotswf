package net.wg.gui.lobby.fortifications.battleRoom.clanBattle {
import net.wg.gui.lobby.fortifications.battleRoom.SortieTeamSection;
import net.wg.gui.rally.interfaces.IRallySlotVO;
import net.wg.gui.rally.vo.RallySlotVO;

public class FortClanBattleTeamSection extends SortieTeamSection {

    public function FortClanBattleTeamSection() {
        super();
    }

    override protected function getSlotVO(param1:Object):IRallySlotVO {
        return new RallySlotVO(param1);
    }

    override protected function updateTeamHeader():void {
        lblTeamHeader.x = Math.round((this.width - lblTeamHeader.width) / 2);
    }

    public function updateTeamHeaderText(param1:String):void {
        lblTeamHeader.htmlText = param1;
    }
}
}
