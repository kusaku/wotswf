package net.wg.gui.battle.random.views.stats.components.playersPanel.list {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.components.BattleAtlasSprite;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class InviteReceivedIndicator extends Sprite implements IDisposable {

    public var inviteTF:TextField;

    public var inviteIcon:BattleAtlasSprite;

    public function InviteReceivedIndicator() {
        super();
        this.inviteTF.text = INGAME_GUI.DYNAMICSQUAD_INVITE;
        this.inviteIcon.imageName = BattleAtlasItem.SQUAD_INVITE_RECEIVED;
    }

    public function dispose():void {
        this.inviteTF = null;
        this.inviteIcon = null;
    }
}
}
