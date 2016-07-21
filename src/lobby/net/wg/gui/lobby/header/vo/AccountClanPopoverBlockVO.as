package net.wg.gui.lobby.header.vo {
public class AccountClanPopoverBlockVO extends AccountPopoverBlockVO {

    public var clansResearchBtnYposition:int = -1;

    public var textFieldPositionYposition:int = -1;

    public var inviteBtnIcon:String = "";

    public var clanResearchIcon:String = "";

    public var clanResearchTFText:String = "";

    public var isOpenInviteBtnVisible:Boolean = true;

    public var isOpenInviteBtnEnabled:Boolean = false;

    public var isSearchClanBtnVisible:Boolean = true;

    public var isSearchClanBtnEnabled:Boolean = false;

    public var searchClanTooltip:String = "";

    public var requestInviteBtnTooltip:String = "";

    public var isClanFeaturesEnabled:Boolean = true;

    public var isInClan:Boolean = true;

    public function AccountClanPopoverBlockVO(param1:Object) {
        super(param1);
    }
}
}
