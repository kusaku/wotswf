package net.wg.gui.prebattle.squads.interfaces {
import net.wg.gui.rally.interfaces.IBaseChatSection;
import net.wg.gui.rally.interfaces.IBaseTeamSection;

public interface ISquadAbstractFactory {

    function getTeamSection():IBaseTeamSection;

    function getChatSection():IBaseChatSection;
}
}
