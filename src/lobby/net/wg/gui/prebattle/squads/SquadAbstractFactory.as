package net.wg.gui.prebattle.squads {
import net.wg.data.constants.generated.SQUADTYPES;
import net.wg.gui.prebattle.squads.interfaces.ISquadAbstractFactory;
import net.wg.gui.rally.interfaces.IBaseChatSection;
import net.wg.gui.rally.interfaces.IBaseTeamSection;

public class SquadAbstractFactory implements ISquadAbstractFactory {

    private var _squadType:String = "";

    public function SquadAbstractFactory(param1:String) {
        super();
        this._squadType = param1;
    }

    public function getChatSection():IBaseChatSection {
        var _loc1_:String = this._squadType == SQUADTYPES.SQUAD_TYPE_SIMPLE ? SQUADTYPES.SIMPLE_SQUAD_CHAT_SECTION : SQUADTYPES.FALLOUT_SQUAD_CHAT_SECTION;
        return App.utils.classFactory.getComponent(_loc1_, IBaseChatSection);
    }

    public function getTeamSection():IBaseTeamSection {
        var _loc1_:String = this._squadType == SQUADTYPES.SQUAD_TYPE_SIMPLE ? SQUADTYPES.SIMPLE_SQUAD_TEAM_SECTION : SQUADTYPES.FALLOUT_SQUAD_TEAM_SECTION;
        return App.utils.classFactory.getComponent(_loc1_, IBaseTeamSection);
    }
}
}
