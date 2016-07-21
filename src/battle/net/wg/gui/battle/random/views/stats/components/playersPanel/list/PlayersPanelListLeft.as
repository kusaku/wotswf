package net.wg.gui.battle.random.views.stats.components.playersPanel.list {
public class PlayersPanelListLeft extends PlayersPanelList {

    private static const LINKAGE:String = "PlayersPanelListItemLeftUI";

    public var inviteReceivedIndicator:InviteReceivedIndicator;

    public function PlayersPanelListLeft() {
        super();
    }

    override protected function get itemLinkage():String {
        return LINKAGE;
    }

    override protected function get inviteIndicator():InviteReceivedIndicator {
        return this.inviteReceivedIndicator;
    }

    override protected function get isRightAligned():Boolean {
        return false;
    }

    override protected function onDispose():void {
        this.inviteReceivedIndicator.dispose();
        this.inviteReceivedIndicator = null;
        super.onDispose();
    }
}
}
