package net.wg.gui.lobby.header {
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.Aliases;
import net.wg.data.constants.ColorSchemeNames;
import net.wg.data.constants.Linkages;
import net.wg.data.constants.Values;
import net.wg.gui.components.controls.UserNameField;
import net.wg.gui.components.controls.events.SlotsPanelEvent;
import net.wg.gui.components.interfaces.ISeparatorAsset;
import net.wg.gui.components.popOvers.PopOverConst;
import net.wg.gui.interfaces.IButtonIconLoader;
import net.wg.gui.lobby.components.BoostersPanel;
import net.wg.gui.lobby.components.events.BoosterPanelEvent;
import net.wg.gui.lobby.header.events.AccountPopoverEvent;
import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;
import net.wg.gui.lobby.header.vo.AccountPopoverBlockVO;
import net.wg.gui.lobby.header.vo.AccountPopoverMainVO;
import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
import net.wg.infrastructure.base.meta.IAccountPopoverMeta;
import net.wg.infrastructure.base.meta.impl.AccountPopoverMeta;

import org.idmedia.as3commons.util.StringUtils;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.events.ButtonEvent;

public class AccountPopover extends AccountPopoverMeta implements IAccountPopoverMeta {

    private static const BLOCK_MARGIN:int = 18;

    private static const UPDATE_CLAN_DATA:String = "updateClanData";

    private static const UPDATE_CREW_DATA:String = "updateCrewData";

    private static const UPDATE_MAIN_DATA:String = "updateMainData";

    private static const UPDATE_CLAN_EMBLEM:String = "updateClanEmblem";

    private static const UPDATE_CREW_EMBLEM:String = "updateCrewEmblem";

    private static const DEFAULT_SEPARATOR_Y_POSITION:int = 54;

    private static const DEFAULT_BOOSTER_BLOCK_Y_POSITION:int = 63;

    private static const DEFAULT_BOOSTER_PANEL_Y_POSITION:int = 89;

    private static const ADDITIONAL_HEADER_PADDING_BY_Y:int = 25;

    private static const ADDITIONAL_PADDING_AFTER_CLAN_BLOCK:int = 20;

    public var separator:ISeparatorAsset = null;

    public var userName:UserNameField = null;

    public var clanInviteTF:TextField = null;

    public var boostersPanel:BoostersPanel = null;

    public var inviteBtn:IButtonIconLoader = null;

    public var boostersBlockTitleTF:TextField = null;

    public var boosterBack:Sprite;

    public var clanInfo:IAccountClanPopOverBlock = null;

    public var crewInfo:IAccountClanPopOverBlock = null;

    public var referralInfo:AccountPopoverReferralBlock = null;

    private var _clanData:AccountClanPopoverBlockVO = null;

    private var _crewData:AccountPopoverBlockVO = null;

    private var _clanEmblemId:String = "";

    private var _crewEmblemId:String = "";

    private var _referralData:AccountPopoverReferralBlockVO = null;

    private var _mainData:AccountPopoverMainVO = null;

    public function AccountPopover() {
        super();
        this.separator.setCenterAsset(Linkages.TOOLTIP_SEPARATOR_UI);
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.addEventListener(Event.RESIZE, this.onResizeHandler);
        this.clanInviteTF.visible = false;
        this.inviteBtn.addEventListener(ButtonEvent.PRESS, this.onInviteBtnPressHandler);
        this.inviteBtn.mouseEnabledOnDisabled = true;
        this.inviteBtn.visible = false;
        this.clanInfo.addEventListener(AccountPopoverEvent.CLICK_ON_MAIN_BUTTON, this.onClanInfoClickOnMainButtonHandler);
        this.clanInfo.addEventListener(AccountPopoverEvent.OPEN_CLAN_RESEARCH, this.onClanInfoOpenClanResearchHandler);
        this.clanInfo.addEventListener(AccountPopoverEvent.OPEN_REQUEST_INVITE, this.onClanInfoOpenRequestInviteHandler);
        this.clanInfo.addEventListener(Event.RESIZE, this.onResizeHandler);
        this.crewInfo.addEventListener(AccountPopoverEvent.CLICK_ON_MAIN_BUTTON, this.onCrewInfoClickOnMainButtonHandler);
        this.crewInfo.addEventListener(Event.RESIZE, this.onResizeHandler);
        this.referralInfo.addEventListener(AccountPopoverEvent.OPEN_REFERRAL_MANAGEMENT, this.onReferralInfoOpenReferralManagementHandler);
        this.boostersBlockTitleTF.addEventListener(MouseEvent.ROLL_OVER, this.onBoostersTitleRollOverHandler);
        this.boostersBlockTitleTF.addEventListener(MouseEvent.ROLL_OUT, this.onBoostersTitleRollOutHandler);
        this.separator.y = DEFAULT_SEPARATOR_Y_POSITION;
        this.boostersBlockTitleTF.y = DEFAULT_BOOSTER_BLOCK_Y_POSITION;
        this.boostersPanel.y = DEFAULT_BOOSTER_PANEL_Y_POSITION;
    }

    override protected function configUI():void {
        super.configUI();
        registerFlashComponentS(this.boostersPanel, Aliases.BOOSTERS_PANEL);
        this.boostersPanel.addEventListener(SlotsPanelEvent.NEED_REPOSITION, this.onBoostersPanelNeedRepositionHandler);
        this.boostersPanel.addEventListener(BoosterPanelEvent.SLOT_SELECTED, this.onBoostersPanelSlotSelectedHandler);
    }

    override protected function initLayout():void {
        popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
        super.initLayout();
    }

    override protected function draw():void {
        super.draw();
        if (this._mainData != null && isInvalid(UPDATE_MAIN_DATA)) {
            this.updateData();
        }
        if (this._clanData != null && isInvalid(UPDATE_CLAN_DATA)) {
            if (this._clanData.isClanFeaturesEnabled || this._clanData.isInClan) {
                this.clanInfo.setData(this._clanData);
                this.clanInfo.visible = true;
            }
            else {
                this._clanData = null;
                this.clanInfo.visible = false;
            }
        }
        if (this._crewData != null && isInvalid(UPDATE_CREW_DATA)) {
            this.crewInfo.setData(this._crewData);
            this.crewInfo.visible = true;
        }
        if (this._clanEmblemId != Values.EMPTY_STR && isInvalid(UPDATE_CLAN_EMBLEM)) {
            this.clanInfo.setEmblem(this._clanEmblemId);
        }
        if (this._crewEmblemId != Values.EMPTY_STR && isInvalid(UPDATE_CREW_EMBLEM)) {
            this.crewInfo.setEmblem(this._crewEmblemId);
        }
        if (isInvalid(InvalidationType.SIZE)) {
            this.updateSize();
        }
    }

    override protected function onInitModalFocus(param1:InteractiveObject):void {
        super.onInitModalFocus(param1);
        setFocus(this);
    }

    override protected function onDispose():void {
        this.removeEventListener(Event.RESIZE, this.onResizeHandler);
        this.separator.dispose();
        this.separator = null;
        this.inviteBtn.removeEventListener(ButtonEvent.PRESS, this.onInviteBtnPressHandler);
        this.inviteBtn.dispose();
        this.inviteBtn = null;
        this.clanInviteTF = null;
        this.boostersPanel.removeEventListener(SlotsPanelEvent.NEED_REPOSITION, this.onBoostersPanelNeedRepositionHandler);
        this.boostersPanel.removeEventListener(BoosterPanelEvent.SLOT_SELECTED, this.onBoostersPanelSlotSelectedHandler);
        this.clanInfo.removeEventListener(AccountPopoverEvent.CLICK_ON_MAIN_BUTTON, this.onClanInfoClickOnMainButtonHandler);
        this.clanInfo.removeEventListener(AccountPopoverEvent.OPEN_CLAN_RESEARCH, this.onClanInfoOpenClanResearchHandler);
        this.clanInfo.removeEventListener(AccountPopoverEvent.OPEN_REQUEST_INVITE, this.onClanInfoOpenRequestInviteHandler);
        this.clanInfo.removeEventListener(Event.RESIZE, this.onResizeHandler);
        this.crewInfo.removeEventListener(AccountPopoverEvent.CLICK_ON_MAIN_BUTTON, this.onCrewInfoClickOnMainButtonHandler);
        this.crewInfo.removeEventListener(Event.RESIZE, this.onResizeHandler);
        this.referralInfo.removeEventListener(AccountPopoverEvent.OPEN_REFERRAL_MANAGEMENT, this.onReferralInfoOpenReferralManagementHandler);
        this.boostersBlockTitleTF.removeEventListener(MouseEvent.ROLL_OVER, this.onBoostersTitleRollOverHandler);
        this.boostersBlockTitleTF.removeEventListener(MouseEvent.ROLL_OUT, this.onBoostersTitleRollOutHandler);
        this._mainData = null;
        this._clanData = null;
        this._crewData = null;
        this._referralData = null;
        this.userName.dispose();
        this.userName = null;
        this.clanInfo.dispose();
        this.clanInfo = null;
        this.crewInfo.dispose();
        this.crewInfo = null;
        this.referralInfo.dispose();
        this.referralInfo = null;
        this.boostersPanel = null;
        this.boostersBlockTitleTF = null;
        this.boosterBack = null;
        super.onDispose();
    }

    override protected function setClanData(param1:AccountClanPopoverBlockVO):void {
        this._clanData = param1;
        invalidate(UPDATE_CLAN_DATA);
        invalidateSize();
    }

    override protected function setCrewData(param1:AccountPopoverBlockVO):void {
        this._crewData = param1;
        invalidate(UPDATE_CREW_DATA);
    }

    override protected function setReferralData(param1:AccountPopoverReferralBlockVO):void {
        this._referralData = param1;
        invalidateData();
    }

    override protected function setData(param1:AccountPopoverMainVO):void {
        this._mainData = param1;
        invalidate(UPDATE_MAIN_DATA);
    }

    public function as_setClanEmblem(param1:String):void {
        if (this._clanEmblemId == param1) {
            return;
        }
        this._clanEmblemId = param1;
        invalidate(UPDATE_CLAN_EMBLEM);
    }

    public function as_setCrewEmblem(param1:String):void {
        if (this._crewEmblemId == param1 || StringUtils.isEmpty(param1)) {
            return;
        }
        this._crewEmblemId = param1;
        invalidate(UPDATE_CREW_EMBLEM);
    }

    private function updateSize():void {
        var _loc1_:int = !this._mainData.isInClan ? int(ADDITIONAL_HEADER_PADDING_BY_Y) : 0;
        this.separator.y = DEFAULT_SEPARATOR_Y_POSITION + _loc1_;
        this.boostersBlockTitleTF.y = DEFAULT_BOOSTER_BLOCK_Y_POSITION + _loc1_;
        this.boostersPanel.y = DEFAULT_BOOSTER_PANEL_Y_POSITION + _loc1_;
        var _loc2_:Number = this.boostersPanel.y + this.boostersPanel.actualHeight + BLOCK_MARGIN;
        if (this._clanData) {
            this.clanInfo.y = _loc2_ ^ 0;
            _loc2_ = _loc2_ + (this.clanInfo.height + BLOCK_MARGIN + ADDITIONAL_PADDING_AFTER_CLAN_BLOCK);
        }
        else {
            this.clanInfo.y = 0;
            this.clanInfo.visible = false;
        }
        if (this._crewData) {
            this.crewInfo.y = _loc2_ ^ 0;
            _loc2_ = _loc2_ + (this.crewInfo.height + BLOCK_MARGIN);
        }
        else {
            this.crewInfo.y = 0;
            this.crewInfo.visible = false;
        }
        if (this._referralData) {
            this.referralInfo.setData(this._referralData);
            this.referralInfo.visible = true;
            this.referralInfo.y = _loc2_ ^ 0;
            _loc2_ = _loc2_ + (this.referralInfo.height + (BLOCK_MARGIN << 1));
        }
        else {
            this.referralInfo.y = 0;
            this.referralInfo.visible = false;
        }
        this.boostersPanel.x = width - this.boostersPanel.width >> 1;
        this.boosterBack.x = 0;
        this.boosterBack.y = this.separator.y + this.separator.height | 0;
        this.boosterBack.width = width;
        _loc2_ = _loc2_ ^ 0;
        var _loc3_:Number = _loc2_;
        if (this.clanInfo.visible) {
            _loc3_ = this.clanInfo.y;
        }
        else if (this.crewInfo.visible) {
            _loc3_ = this.crewInfo.y;
        }
        else if (this.referralInfo.visible) {
            _loc3_ = this.referralInfo.y;
        }
        this.boosterBack.height = _loc3_ - this.boosterBack.y | 0;
        this.height = _loc2_;
        popoverLayout.invokeLayout();
    }

    private function updateData():void {
        var _loc1_:Boolean = this._mainData.isInClan;
        this.clanInviteTF.visible = this.inviteBtn.visible = this.clanInviteTF.visible = !_loc1_;
        if (!_loc1_) {
            this.clanInviteTF.text = MENU.HEADER_ACCOUNT_POPOVER_CLAN_CLANINVITE;
            this.inviteBtn.iconSource = this._mainData.openInviteBtnIcon;
            this.inviteBtn.tooltip = this._mainData.inviteBtnTooltip;
            this.inviteBtn.enabled = this._mainData.inviteBtnEnabled;
        }
        this.boostersBlockTitleTF.htmlText = this._mainData.boostersBlockTitle;
        this.userName.textColor = !!this._mainData.isTeamKiller ? Number(App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAMKILLER).rgb) : Number(UserNameField.DEF_USER_NAME_COLOR);
        this.userName.userVO = this._mainData.userData;
    }

    private function onInviteBtnPressHandler(param1:ButtonEvent):void {
        openInviteWindowS();
    }

    private function onClanInfoOpenRequestInviteHandler(param1:AccountPopoverEvent):void {
        openRequestWindowS();
    }

    private function onClanInfoOpenClanResearchHandler(param1:AccountPopoverEvent):void {
        openClanResearchS();
    }

    private function onCrewInfoClickOnMainButtonHandler(param1:AccountPopoverEvent):void {
        openCrewStatisticS();
    }

    private function onClanInfoClickOnMainButtonHandler(param1:AccountPopoverEvent):void {
        openClanStatisticS();
    }

    private function onBoostersPanelNeedRepositionHandler(param1:SlotsPanelEvent):void {
        invalidateSize();
    }

    private function onBoostersPanelSlotSelectedHandler(param1:BoosterPanelEvent):void {
        openBoostersWindowS(param1.data.id);
    }

    private function onResizeHandler(param1:Event):void {
        invalidateSize();
    }

    private function onReferralInfoOpenReferralManagementHandler(param1:AccountPopoverEvent):void {
        openReferralManagementS();
    }

    private function onBoostersTitleRollOverHandler(param1:MouseEvent):void {
        if (StringUtils.isNotEmpty(this._mainData.boostersBlockTitleTooltip)) {
            App.toolTipMgr.showComplex(this._mainData.boostersBlockTitleTooltip, null);
        }
    }

    private function onBoostersTitleRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
