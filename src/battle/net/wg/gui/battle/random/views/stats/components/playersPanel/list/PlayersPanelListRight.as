package net.wg.gui.battle.random.views.stats.components.playersPanel.list {
public class PlayersPanelListRight extends PlayersPanelList {

    private static const LINKAGE:String = "PlayersPanelListItemRightUI";

    public var inviteReceivedIndicator:InviteReceivedIndicator;

    public function PlayersPanelListRight() {
        super();
    }

    override protected function get itemLinkage():String {
        return LINKAGE;
    }

    override protected function get inviteIndicator():InviteReceivedIndicator {
        return this.inviteReceivedIndicator;
    }

    override protected function get isRightAligned():Boolean {
        return true;
    }

    override protected function onDispose():void {
        this.inviteReceivedIndicator.dispose();
        this.inviteReceivedIndicator = null;
        super.onDispose();
    }
}
}
