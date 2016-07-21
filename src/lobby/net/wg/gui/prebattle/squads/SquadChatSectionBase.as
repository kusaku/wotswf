package net.wg.gui.prebattle.squads {
import flash.display.InteractiveObject;

import net.wg.gui.rally.views.room.BaseChatSection;

public class SquadChatSectionBase extends BaseChatSection {

    public function SquadChatSectionBase() {
        super();
    }

    override public function getComponentForFocus():InteractiveObject {
        return channelComponent.getComponentForFocus();
    }

    override protected function getHeader():String {
        return MESSENGER.DIALOGS_SQUADCHANNEL_CHATNAME;
    }

    override public function get chatSubmitBtnTooltip():String {
        return TOOLTIPS.SQUADWINDOW_BUTTONS_SENDMESSAGE;
    }
}
}
