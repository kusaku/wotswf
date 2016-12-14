package net.wg.gui.lobby.header {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.header.events.AccountPopoverEvent;
import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;

import scaleform.clik.events.ButtonEvent;

public class AccountClanPopoverBlock extends AccountPopoverBlockBase implements IAccountClanPopOverBlock {

    private static const ADDITIONAL_TF_PADDING:int = 2;

    private static const ADDITIONAL_BLOCK_HEIGHT:int = 17;

    public var clanResearchTF:TextField = null;

    public var requestInviteBtn:IButtonIconLoader = null;

    public var searchClansBtn:IButtonIconLoader = null;

    private var _clansResearchBtnYposition:int = -1;

    private var _textFieldPositionYposition:int = -1;

    private var _isSearchClanBtnVisible:Boolean = true;

    private var _clanName:String = null;

    public function AccountClanPopoverBlock() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.requestInviteBtn.mouseEnabledOnDisabled = true;
        this.requestInviteBtn.addEventListener(ButtonEvent.CLICK, this.onRequestInviteBtnClickHandler);
        this.searchClansBtn.mouseEnabledOnDisabled = true;
        this.searchClansBtn.addEventListener(ButtonEvent.CLICK, this.onSearchClansBtnClickHandler);
        textFieldName.addEventListener(MouseEvent.ROLL_OVER, this.onTextFieldNameRollOverHandler);
        textFieldName.addEventListener(MouseEvent.ROLL_OUT, this.onTextFieldNameRollOutHandler);
    }

    override protected function onDispose():void {
        this.clanResearchTF = null;
        this.requestInviteBtn.removeEventListener(ButtonEvent.CLICK, this.onRequestInviteBtnClickHandler);
        this.requestInviteBtn.dispose();
        this.requestInviteBtn = null;
        this.searchClansBtn.removeEventListener(ButtonEvent.CLICK, this.onSearchClansBtnClickHandler);
        this.searchClansBtn.dispose();
        this.searchClansBtn = null;
        textFieldName.removeEventListener(MouseEvent.ROLL_OVER, this.onTextFieldNameRollOverHandler);
        textFieldName.removeEventListener(MouseEvent.ROLL_OUT, this.onTextFieldNameRollOutHandler);
        super.onDispose();
    }

    override protected function updateSize():void {
        textFieldPosition.y = this._textFieldPositionYposition;
        this.searchClansBtn.y = this._clansResearchBtnYposition;
        this.clanResearchTF.y = this.searchClansBtn.y + ADDITIONAL_TF_PADDING;
        this.requestInviteBtn.y = doActionBtn.y;
        if (this._isSearchClanBtnVisible) {
            this.height = this.searchClansBtn.y + this.searchClansBtn.actualHeight - ADDITIONAL_BLOCK_HEIGHT ^ 0;
        }
        else {
            this.height = this.requestInviteBtn.y + this.requestInviteBtn.actualHeight - ADDITIONAL_BLOCK_HEIGHT ^ 0;
        }
    }

    override protected function setTextFieldNameText(param1:String):void {
        commons.truncateTextFieldText(textFieldName, param1);
        this._clanName = param1;
    }

    override protected function applyData():void {
        super.applyData();
        var _loc1_:AccountClanPopoverBlockVO = AccountClanPopoverBlockVO(data);
        this._clansResearchBtnYposition = _loc1_.clansResearchBtnYposition;
        this._textFieldPositionYposition = _loc1_.textFieldPositionYposition;
        this._isSearchClanBtnVisible = _loc1_.isSearchClanBtnVisible;
        this.clanResearchTF.visible = this._isSearchClanBtnVisible;
        this.searchClansBtn.visible = this._isSearchClanBtnVisible;
        var _loc2_:Boolean = _loc1_.isOpenInviteBtnVisible;
        this.requestInviteBtn.visible = _loc2_;
        if (_loc2_) {
            this.requestInviteBtn.enabled = _loc1_.isOpenInviteBtnEnabled;
            this.requestInviteBtn.iconSource = _loc1_.inviteBtnIcon;
            this.requestInviteBtn.tooltip = _loc1_.requestInviteBtnTooltip;
        }
        this.searchClansBtn.enabled = _loc1_.isSearchClanBtnEnabled;
        this.searchClansBtn.tooltip = _loc1_.searchClanTooltip;
        this.searchClansBtn.iconSource = _loc1_.clanResearchIcon;
        this.clanResearchTF.text = _loc1_.clanResearchTFText;
        textFieldName.mouseEnabled = textFieldName.text != this._clanName;
    }

    private function onRequestInviteBtnClickHandler(param1:ButtonEvent):void {
        dispatchAccountPopoverEvent(AccountPopoverEvent.OPEN_REQUEST_INVITE);
    }

    private function onSearchClansBtnClickHandler(param1:ButtonEvent):void {
        dispatchAccountPopoverEvent(AccountPopoverEvent.OPEN_CLAN_RESEARCH);
    }

    private function onTextFieldNameRollOverHandler(param1:MouseEvent):void {
        if (this._clanName) {
            App.toolTipMgr.show(this._clanName);
        }
    }

    private function onTextFieldNameRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
