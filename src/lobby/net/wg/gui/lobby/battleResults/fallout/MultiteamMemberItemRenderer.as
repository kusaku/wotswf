package net.wg.gui.lobby.battleResults.fallout {
import flash.display.DisplayObject;
import flash.text.TextField;

import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;

public class MultiteamMemberItemRenderer extends FalloutTeamMemberItemRendererBase {

    public var teamDivider:DisplayObject = null;

    public var squadIcon:DisplayObject = null;

    public var mySquadIcon:DisplayObject = null;

    public var playerIcon:DisplayObject = null;

    public var myPlayerIcon:DisplayObject = null;

    public var flagsLbl:TextField = null;

    public var squadIdLbl:TextField;

    public var teamScore:TextField;

    public function MultiteamMemberItemRenderer() {
        super();
    }

    override protected function onDispose():void {
        this.teamDivider = null;
        this.squadIcon = null;
        this.mySquadIcon = null;
        this.playerIcon = null;
        this.myPlayerIcon = null;
        this.flagsLbl = null;
        this.squadIdLbl = null;
        this.teamScore = null;
        super.onDispose();
    }

    override protected function showData(param1:TeamMemberItemVO):void {
        super.showData(param1);
        this.teamDivider.visible = param1.showTeamDivider;
        var _loc2_:* = param1.squadID > 0;
        this.squadIcon.visible = param1.showTeamInfo && _loc2_ && !param1.isOwnSquad;
        this.mySquadIcon.visible = param1.showTeamInfo && _loc2_ && param1.isOwnSquad;
        this.squadIdLbl.visible = param1.showTeamInfo && _loc2_;
        if (this.squadIdLbl.visible) {
            this.squadIdLbl.text = param1.squadID.toString();
        }
        this.playerIcon.visible = param1.showTeamInfo && !_loc2_ && !param1.isSelf;
        this.myPlayerIcon.visible = param1.showTeamInfo && !_loc2_ && param1.isSelf;
        this.teamScore.visible = param1.showTeamInfo;
        if (this.teamScore.visible) {
            this.teamScore.text = param1.teamScore.toString();
        }
        this.flagsLbl.text = param1.flags.toString();
    }
}
}
