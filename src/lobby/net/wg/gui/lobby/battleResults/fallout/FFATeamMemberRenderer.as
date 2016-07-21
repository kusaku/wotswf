package net.wg.gui.lobby.battleResults.fallout {
import flash.text.TextField;

import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;

public class FFATeamMemberRenderer extends FalloutTeamMemberItemRendererBase {

    public var flagsLbl:TextField = null;

    public function FFATeamMemberRenderer() {
        super();
    }

    override protected function onDispose():void {
        this.flagsLbl = null;
        super.onDispose();
    }

    override protected function showData(param1:TeamMemberItemVO):void {
        super.showData(param1);
        this.flagsLbl.text = param1.flags.toString();
    }
}
}
