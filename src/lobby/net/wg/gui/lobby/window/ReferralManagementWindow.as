package net.wg.gui.lobby.window {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.Linkages;
import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.ComplexProgressIndicator;
import net.wg.gui.components.advanced.vo.ComplexProgressIndicatorVO;
import net.wg.gui.components.controls.HyperLink;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.SortableTable;
import net.wg.gui.components.controls.SoundButtonEx;
import net.wg.gui.lobby.referralSystem.AwardReceivedBlock;
import net.wg.gui.lobby.referralSystem.ReferralManagementEvent;
import net.wg.gui.lobby.referralSystem.data.AwardDataDataVO;
import net.wg.infrastructure.base.meta.IReferralManagementWindowMeta;
import net.wg.infrastructure.base.meta.impl.ReferralManagementWindowMeta;

import scaleform.clik.data.DataProvider;
import scaleform.clik.events.ButtonEvent;
import scaleform.gfx.TextFieldEx;

public class ReferralManagementWindow extends ReferralManagementWindowMeta implements IReferralManagementWindowMeta {

    private static const INFO_ICON_VERTICAL_OFFSET:int = 10;

    public var infoHeaderTF:TextField = null;

    public var descriptionTF:TextField = null;

    public var invitedPlayersTF:TextField = null;

    public var invitesManagementLink:HyperLink = null;

    public var closeButton:SoundButtonEx = null;

    public var referralsTable:SortableTable = null;

    public var descriptionInfoIcon:InfoIcon = null;

    public var progressIndicator:ComplexProgressIndicator;

    public var awardReceivedBlock:AwardReceivedBlock;

    public var progressAlertTF:TextField = null;

    public function ReferralManagementWindow() {
        super();
        this.progressIndicator.visible = false;
        this.awardReceivedBlock.visible = false;
        this.progressAlertTF.visible = false;
        isModal = false;
        canClose = true;
        isCentered = true;
    }

    override protected function configUI():void {
        super.configUI();
        TextFieldEx.setVerticalAlign(this.infoHeaderTF, TextFieldEx.VALIGN_CENTER);
        this.closeButton.addEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.invitesManagementLink.addEventListener(ButtonEvent.CLICK, this.onInvitesManagementLinkClickHandler);
        this.descriptionInfoIcon.addEventListener(MouseEvent.ROLL_OVER, this.onDescriptionInfoIconRollOverHandler);
        this.descriptionInfoIcon.addEventListener(MouseEvent.ROLL_OUT, this.onDescriptionInfoIconRollOutHandler);
        this.referralsTable.addEventListener(ReferralManagementEvent.CREATE_SQUAD_BTN_CLICK, this.onReferralsTableCreateSquadBtnClickHandler);
    }

    override protected function onDispose():void {
        this.closeButton.removeEventListener(ButtonEvent.CLICK, this.onCloseButtonClickHandler);
        this.invitesManagementLink.removeEventListener(ButtonEvent.CLICK, this.onInvitesManagementLinkClickHandler);
        this.descriptionInfoIcon.removeEventListener(MouseEvent.ROLL_OVER, this.onDescriptionInfoIconRollOverHandler);
        this.descriptionInfoIcon.removeEventListener(MouseEvent.ROLL_OUT, this.onDescriptionInfoIconRollOutHandler);
        this.referralsTable.removeEventListener(ReferralManagementEvent.CREATE_SQUAD_BTN_CLICK, this.onReferralsTableCreateSquadBtnClickHandler);
        this.infoHeaderTF = null;
        this.descriptionTF = null;
        this.invitedPlayersTF = null;
        this.progressAlertTF = null;
        this.closeButton.dispose();
        this.closeButton = null;
        this.referralsTable.dispose();
        this.referralsTable = null;
        this.descriptionInfoIcon.dispose();
        this.descriptionInfoIcon = null;
        this.invitesManagementLink.dispose();
        this.invitesManagementLink = null;
        this.progressIndicator.dispose();
        this.progressIndicator = null;
        this.awardReceivedBlock.dispose();
        this.awardReceivedBlock = null;
        super.onDispose();
    }

    override protected function onPopulate():void {
        super.onPopulate();
        window.useBottomBtns = true;
        App.utils.commons.initTabIndex(new <InteractiveObject>[this.closeButton, window.getCloseBtn()]);
    }

    override protected function setData(param1:RefManagementWindowVO):void {
        window.title = param1.windowTitle;
        this.infoHeaderTF.htmlText = param1.infoHeaderText;
        this.descriptionTF.htmlText = param1.descriptionText;
        this.invitedPlayersTF.htmlText = param1.invitedPlayersText;
        this.invitesManagementLink.label = param1.invitesManagementLinkText;
        this.closeButton.label = param1.closeBtnLabel;
        App.utils.commons.moveDsiplObjToEndOfText(this.descriptionInfoIcon, this.descriptionTF, 0, INFO_ICON_VERTICAL_OFFSET);
        this.referralsTable.headerDP = new DataProvider(App.utils.data.vectorToArray(param1.tableHeader));
    }

    override protected function setAwardDataData(param1:AwardDataDataVO):void {
        this.awardReceivedBlock.model = param1;
        this.progressIndicator.visible = false;
        this.progressAlertTF.visible = false;
        this.awardReceivedBlock.visible = true;
    }

    override protected function setProgressData(param1:ComplexProgressIndicatorVO):void {
        param1.rendererClassLinkage = Linkages.PROGRESS_STEP_RENDERER;
        this.progressIndicator.model = param1;
        this.progressIndicator.visible = true;
        this.progressAlertTF.visible = false;
        this.awardReceivedBlock.visible = false;
    }

    public function as_setTableData(param1:Array):void {
        this.referralsTable.listDP = new DataProvider(param1);
    }

    public function as_showAlert(param1:String):void {
        this.progressIndicator.visible = false;
        this.awardReceivedBlock.visible = false;
        this.progressAlertTF.htmlText = param1;
        this.progressAlertTF.visible = true;
    }

    private function onCloseButtonClickHandler(param1:ButtonEvent):void {
        onWindowCloseS();
    }

    private function onInvitesManagementLinkClickHandler(param1:ButtonEvent):void {
        onInvitesManagementLinkClickS();
    }

    private function onDescriptionInfoIconRollOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.REF_SYS_DESCRIPTION, null);
    }

    private function onDescriptionInfoIconRollOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onReferralsTableCreateSquadBtnClickHandler(param1:ReferralManagementEvent):void {
        inviteIntoSquadS(param1.referralID);
    }
}
}
