package net.wg.gui.lobby.battleResults.fallout {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.ColorSchemeNames;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.lobby.battleResults.components.TeamMemberRendererBase;
import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;

public class FalloutTeamMemberItemRendererBase extends TeamMemberRendererBase {

    public var selfBg:MovieClip = null;

    public var playerName:UserNameField = null;

    public var scoreLbl:TextField = null;

    public var fragsLbl:TextField = null;

    public var damageLbl:TextField = null;

    public var xpLbl:TextField = null;

    public var deathsLbl:TextField = null;

    public var deadBg:Sprite = null;

    public var xpIcon:Sprite = null;

    public var fakeFocusIndicator:MovieClip = null;

    public function FalloutTeamMemberItemRendererBase() {
        super();
    }

    override protected function onDispose():void {
        this.selfBg = null;
        this.playerName.dispose();
        this.playerName = null;
        this.scoreLbl = null;
        this.damageLbl = null;
        this.fragsLbl = null;
        this.xpLbl = null;
        this.deathsLbl = null;
        this.xpIcon = null;
        this.fakeFocusIndicator = null;
        super.onDispose();
    }

    override protected function showData(param1:TeamMemberItemVO):void {
        this.selfBg.visible = param1.isSelf;
        this.playerName.userVO = param1.userVO;
        this.playerName.textColor = App.colorSchemeMgr.getScheme(!!param1.isOwnSquad ? ColorSchemeNames.SELECTED : ColorSchemeNames.NORMAL).rgb;
        this.xpLbl.text = App.utils.locale.integer(param1.xp - param1.achievementXP);
        this.scoreLbl.text = param1.victoryScore.toString();
        this.fragsLbl.visible = param1.kills > 0;
        if (this.fragsLbl.visible) {
            this.fragsLbl.text = param1.kills.toString();
            if (param1.tkills > 0) {
                this.fragsLbl.textColor = getColorForAlias(ColorSchemeNames.TEAMKILLER, DEFAULT_TEAM_KILLER_COLOR);
            }
        }
        this.damageLbl.text = "0";
        if (param1.damageDealt > 0) {
            this.damageLbl.text = App.utils.locale.integer(param1.damageDealt);
        }
        this.xpLbl.text = App.utils.locale.integer(param1.xp - param1.achievementXP);
        this.deathsLbl.htmlText = param1.deathsStr;
        this.deadBg.visible = param1.deathReason > -1;
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        super.handleMouseRollOver(param1);
        this.fakeFocusIndicator.gotoAndPlay("over");
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        super.handleMouseRollOut(param1);
        this.fakeFocusIndicator.gotoAndPlay("out");
    }
}
}
