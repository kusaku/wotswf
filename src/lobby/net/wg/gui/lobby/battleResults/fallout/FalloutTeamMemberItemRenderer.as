package net.wg.gui.lobby.battleResults.fallout {
import flash.text.TextField;

import net.wg.gui.components.icons.SquadIcon;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;

public class FalloutTeamMemberItemRenderer extends FalloutTeamMemberItemRendererBase {

    public var squadIcon:SquadIcon = null;

    public var modePointsLbl:TextField = null;

    public function FalloutTeamMemberItemRenderer() {
        super();
    }

    override protected function onDispose():void {
        this.squadIcon.dispose();
        this.squadIcon = null;
        this.modePointsLbl = null;
        super.onDispose();
    }

    override protected function showData(param1:TeamMemberItemVO):void {
        super.showData(param1);
        if (param1.squadID > 0) {
            this.squadIcon.show(param1.isOwnSquad, param1.squadID);
        }
        else {
            this.squadIcon.hide();
        }
        if (param1.falloutResourcePoints > 0) {
            this.modePointsLbl.text = param1.falloutResourcePoints.toString();
        }
        else {
            this.modePointsLbl.text = param1.flags.toString();
        }
    }
}
}
