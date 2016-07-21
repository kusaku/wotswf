package net.wg.gui.lobby.settings {
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
import net.wg.gui.components.advanced.FieldSet;
import net.wg.gui.components.controls.CheckBox;
import net.wg.gui.components.controls.DropdownMenu;
import net.wg.gui.components.controls.InfoIcon;
import net.wg.gui.components.controls.LabelControl;
import net.wg.gui.components.controls.Slider;
import net.wg.infrastructure.base.UIComponentEx;

public class GameSettingsContent extends UIComponentEx {

    private static const MINIMAP_CIRCLE_INFO_LEFT_PADDING:int = 3;

    public var fieldSetChat:FieldSet = null;

    public var fieldSetBattlePanel:FieldSet = null;

    public var fieldSetBattleTypes:FieldSet = null;

    public var enableOlFilterCheckbox:CheckBox = null;

    public var enableSpamFilterCheckbox:CheckBox = null;

    public var showDateMessageCheckbox:CheckBox = null;

    public var showTimeMessageCheckbox:CheckBox = null;

    public var invitesFromFriendsOnlyCheckbox:CheckBox = null;

    public var receiveClanInvitesNotificationsCheckbox:CheckBox = null;

    public var receiveInvitesInBattleCheckbox:CheckBox = null;

    public var receiveFriendshipRequestCheckbox:CheckBox = null;

    public var chatContactsListOnlyCheckbox:CheckBox = null;

    public var disableBattleChatCheckbox:CheckBox = null;

    public var ppShowLevelsCheckbox:CheckBox = null;

    public var gameplay_ctfCheckbox:CheckBox = null;

    public var gameplay_dominationCheckbox:CheckBox = null;

    public var gameplay_assaultCheckbox:CheckBox = null;

    public var battleLoadingInfoLabelControl:LabelControl = null;

    public var battleLoadingInfoDropDown:DropdownMenu = null;

    public var minimapAlphaSliderLabel:TextField = null;

    public var minimapAlphaSlider:Slider = null;

    public var enableOpticalSnpEffectCheckbox:CheckBox = null;

    public var enablePostMortemEffectCheckbox:CheckBox = null;

    public var enablePostMortemDelayCheckbox:CheckBox = null;

    public var dynamicCameraCheckbox:CheckBox = null;

    public var horStabilizationSnpCheckbox:CheckBox = null;

    public var increasedZoomCheckbox:CheckBox = null;

    public var sniperModeByShiftCheckbox:CheckBox = null;

    public var replayEnabledLabel:TextField = null;

    public var replayEnabledDropDown:DropdownMenu = null;

    public var useServerAimCheckbox:CheckBox = null;

    public var showVehiclesCounterCheckbox:CheckBox = null;

    public var showMarksOnGunCheckbox:CheckBox = null;

    public var showVectorOnMapCheckbox:CheckBox = null;

    public var showSectorOnMapCheckbox:CheckBox = null;

    public var showVehModelsOnMapLabel:LabelControl = null;

    public var showVehModelsOnMapDropDown:DropdownMenu = null;

    public var minimapViewRangeCheckbox:CheckBox = null;

    public var minimapMaxViewRangeCheckbox:CheckBox = null;

    public var minimapDrawRangeCheckbox:CheckBox = null;

    public var minimapCirclesInfo:InfoIcon = null;

    public var fieldSetMinimap:FieldSet = null;

    public var showBattleEfficiencyRibbonsCheckbox:CheckBox = null;

    public var simplifiedTTCCheckbox:CheckBox = null;

    public function GameSettingsContent() {
        super();
    }

    override protected function configUI():void {
        this.fieldSetChat.label = SETTINGS.GAME_FIELDSET_HEADERCHAT;
        this.fieldSetBattlePanel.label = SETTINGS.GAME_BATTLEPANELSETTINGS;
        this.fieldSetBattleTypes.label = SETTINGS.GAME_FIELDSET_HEADERGAMEPLAY;
        this.fieldSetMinimap.label = SETTINGS.GAME_MINIMAPGROUPTITLE;
        var _loc1_:TextField = this.fieldSetMinimap.textField;
        this.minimapCirclesInfo.x = this.fieldSetMinimap.x + _loc1_.x + _loc1_.textWidth + MINIMAP_CIRCLE_INFO_LEFT_PADDING;
        this.minimapCirclesInfo.addEventListener(MouseEvent.MOUSE_OVER, this.onMinimapCirclesInfoMouseOverHandler);
        this.minimapCirclesInfo.addEventListener(MouseEvent.MOUSE_OUT, this.onMinimapCirclesInfoMouseOutHandler);
        this.enableOlFilterCheckbox.label = SETTINGS.CHAT_CENSORSHIPMESSAGES;
        this.enableSpamFilterCheckbox.label = SETTINGS.CHAT_REMOVESPAM;
        this.showDateMessageCheckbox.label = SETTINGS.CHAT_SHOWDATEMESSAGE;
        this.showTimeMessageCheckbox.label = SETTINGS.CHAT_SHOWTIMEMESSAGE;
        this.invitesFromFriendsOnlyCheckbox.label = SETTINGS.CHAT_INVITESFROMFRIENDSONLY;
        this.receiveClanInvitesNotificationsCheckbox.label = SETTINGS.CHAT_RECEIVECLANINVITESNOTIFICATIONS;
        this.receiveInvitesInBattleCheckbox.label = SETTINGS.CHAT_RECEIVEINVITESINBATTLE;
        this.receiveInvitesInBattleCheckbox.toolTip = TOOLTIPS.RECEIVEINVITESINBATTLE;
        this.receiveInvitesInBattleCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.receiveFriendshipRequestCheckbox.label = SETTINGS.CHAT_RECEIVEFRIENDSHIPREQUEST;
        this.receiveFriendshipRequestCheckbox.toolTip = TOOLTIPS.RECEIVEFRIENDSHIPREQUEST;
        this.receiveFriendshipRequestCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.chatContactsListOnlyCheckbox.label = SETTINGS.CHAT_CHATCONTACTSLISTONLY;
        this.chatContactsListOnlyCheckbox.toolTip = TOOLTIPS.CHATCONTACTSLISTONLY;
        this.chatContactsListOnlyCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.disableBattleChatCheckbox.label = SETTINGS.CHAT_DISABLEBATTLECHAT;
        this.disableBattleChatCheckbox.toolTip = TOOLTIPS.TURNOFFCOMBATCHAT;
        this.disableBattleChatCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.ppShowLevelsCheckbox.label = SETTINGS.GAME_PPSHOWLEVELS;
        this.gameplay_ctfCheckbox.label = SETTINGS.GAMEPLAY_CTF;
        this.gameplay_dominationCheckbox.label = SETTINGS.GAMEPLAY_DOMINATION;
        this.gameplay_assaultCheckbox.label = SETTINGS.GAMEPLAY_ASSAULT;
        this.battleLoadingInfoLabelControl.text = SETTINGS.GAME_BATTLELOADINGINFO;
        this.battleLoadingInfoLabelControl.toolTip = TOOLTIPS.BATTLELOADINGINFO;
        this.battleLoadingInfoLabelControl.infoIcoType = InfoIcon.TYPE_INFO;
        this.minimapAlphaSliderLabel.text = SETTINGS.MINIMAP_LABELS_ALPHA;
        this.enableOpticalSnpEffectCheckbox.label = SETTINGS.GAME_ENABLEOPTICALSNPEFFECT;
        this.enablePostMortemEffectCheckbox.label = SETTINGS.GAME_ENABLEMORTALPOSTEFFECT;
        this.enablePostMortemDelayCheckbox.label = SETTINGS.GAME_ENABLEDELAYPOSTEFFECT;
        this.dynamicCameraCheckbox.label = SETTINGS.GAME_DYNAMICCAMERA;
        this.horStabilizationSnpCheckbox.label = SETTINGS.GAME_HORSTABILIZATIONSNP;
        this.sniperModeByShiftCheckbox.label = SETTINGS.GAME_SNIPERMODEBYSHIFT;
        this.increasedZoomCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.replayEnabledLabel.text = SETTINGS.GAME_REPLAYENABLED;
        this.useServerAimCheckbox.label = SETTINGS.CURSOR_SERVERAIM;
        this.showVehiclesCounterCheckbox.label = SETTINGS.GAME_SHOWVEHICLESCOUNTER;
        this.showMarksOnGunCheckbox.label = SETTINGS.GAME_SHOWMARKSONGUN;
        this.showMarksOnGunCheckbox.toolTip = TOOLTIPS.SHOWMARKSONGUN;
        this.showMarksOnGunCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.minimapViewRangeCheckbox.label = SETTINGS.GAME_MINIMAPVIEWRANGE;
        this.minimapMaxViewRangeCheckbox.label = SETTINGS.GAME_MINIMAPMAXVIEWRANGE;
        this.minimapDrawRangeCheckbox.label = SETTINGS.GAME_MINIMAPDRAWRANGE;
        this.showVectorOnMapCheckbox.label = SETTINGS.GAME_SHOWVECTORONMAP;
        this.showVectorOnMapCheckbox.toolTip = TOOLTIPS.SHOWVECTORONMAP;
        this.showVectorOnMapCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.showSectorOnMapCheckbox.label = SETTINGS.GAME_SHOWSECTORONMAP;
        this.showSectorOnMapCheckbox.toolTip = TOOLTIPS.SHOWSECTORONMAP;
        this.showSectorOnMapCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.showVehModelsOnMapLabel.text = SETTINGS.GAME_SHOWVEHMODELSONMAP;
        this.showVehModelsOnMapLabel.toolTip = TOOLTIPS.SHOWVEHMODELSONMAP;
        this.showVehModelsOnMapLabel.infoIcoType = InfoIcon.TYPE_INFO;
        this.showBattleEfficiencyRibbonsCheckbox.label = SETTINGS.GAME_SHOWBATTLEEFFICIENCYRIBBONS;
        this.showBattleEfficiencyRibbonsCheckbox.toolTip = TOOLTIPS.SHOWBATTLEEFFICIENCYRIBBONS;
        this.showBattleEfficiencyRibbonsCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        this.simplifiedTTCCheckbox.label = SETTINGS.GAME_SHOWSIMPLIFIEDVEHPARAMS;
        this.simplifiedTTCCheckbox.toolTip = TOOLTIPS.SHOWSIMPLIFIEDVEHPARAMS;
        this.simplifiedTTCCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
        super.configUI();
    }

    override protected function onDispose():void {
        this.fieldSetChat.dispose();
        this.fieldSetChat = null;
        this.fieldSetBattlePanel.dispose();
        this.fieldSetBattlePanel = null;
        this.fieldSetBattleTypes.dispose();
        this.fieldSetBattleTypes = null;
        this.fieldSetMinimap.dispose();
        this.fieldSetMinimap = null;
        this.minimapCirclesInfo.removeEventListener(MouseEvent.MOUSE_OVER, this.onMinimapCirclesInfoMouseOverHandler);
        this.minimapCirclesInfo.removeEventListener(MouseEvent.MOUSE_OUT, this.onMinimapCirclesInfoMouseOutHandler);
        this.minimapCirclesInfo.dispose();
        this.minimapCirclesInfo = null;
        this.enableOlFilterCheckbox.dispose();
        this.enableOlFilterCheckbox = null;
        this.enableSpamFilterCheckbox.dispose();
        this.enableSpamFilterCheckbox = null;
        this.showDateMessageCheckbox.dispose();
        this.showDateMessageCheckbox = null;
        this.showTimeMessageCheckbox.dispose();
        this.showTimeMessageCheckbox = null;
        this.invitesFromFriendsOnlyCheckbox.dispose();
        this.invitesFromFriendsOnlyCheckbox = null;
        this.receiveClanInvitesNotificationsCheckbox.dispose();
        this.receiveClanInvitesNotificationsCheckbox = null;
        this.receiveInvitesInBattleCheckbox.dispose();
        this.receiveInvitesInBattleCheckbox = null;
        this.receiveFriendshipRequestCheckbox.dispose();
        this.receiveFriendshipRequestCheckbox = null;
        this.chatContactsListOnlyCheckbox.dispose();
        this.chatContactsListOnlyCheckbox = null;
        this.disableBattleChatCheckbox.dispose();
        this.disableBattleChatCheckbox = null;
        this.ppShowLevelsCheckbox.dispose();
        this.ppShowLevelsCheckbox = null;
        this.gameplay_ctfCheckbox.dispose();
        this.gameplay_ctfCheckbox = null;
        this.gameplay_dominationCheckbox.dispose();
        this.gameplay_dominationCheckbox = null;
        this.gameplay_assaultCheckbox.dispose();
        this.gameplay_assaultCheckbox = null;
        this.battleLoadingInfoLabelControl.dispose();
        this.battleLoadingInfoLabelControl = null;
        this.battleLoadingInfoDropDown.dispose();
        this.battleLoadingInfoDropDown = null;
        this.minimapAlphaSliderLabel = null;
        this.minimapAlphaSlider.dispose();
        this.minimapAlphaSlider = null;
        this.enableOpticalSnpEffectCheckbox.dispose();
        this.enableOpticalSnpEffectCheckbox = null;
        this.enablePostMortemEffectCheckbox.dispose();
        this.enablePostMortemEffectCheckbox = null;
        this.enablePostMortemDelayCheckbox.dispose();
        this.enablePostMortemDelayCheckbox = null;
        this.dynamicCameraCheckbox.dispose();
        this.dynamicCameraCheckbox = null;
        this.horStabilizationSnpCheckbox.dispose();
        this.horStabilizationSnpCheckbox = null;
        this.increasedZoomCheckbox.dispose();
        this.increasedZoomCheckbox = null;
        this.sniperModeByShiftCheckbox.dispose();
        this.sniperModeByShiftCheckbox = null;
        this.replayEnabledLabel = null;
        this.replayEnabledDropDown.dispose();
        this.replayEnabledDropDown = null;
        this.useServerAimCheckbox.dispose();
        this.useServerAimCheckbox = null;
        this.showVehiclesCounterCheckbox.dispose();
        this.showVehiclesCounterCheckbox = null;
        this.showMarksOnGunCheckbox.dispose();
        this.showMarksOnGunCheckbox = null;
        this.showVectorOnMapCheckbox.dispose();
        this.showVectorOnMapCheckbox = null;
        this.showSectorOnMapCheckbox.dispose();
        this.showSectorOnMapCheckbox = null;
        this.showVehModelsOnMapLabel.dispose();
        this.showVehModelsOnMapLabel = null;
        this.showVehModelsOnMapDropDown.dispose();
        this.showVehModelsOnMapDropDown = null;
        this.minimapViewRangeCheckbox.dispose();
        this.minimapViewRangeCheckbox = null;
        this.minimapMaxViewRangeCheckbox.dispose();
        this.minimapMaxViewRangeCheckbox = null;
        this.minimapDrawRangeCheckbox.dispose();
        this.minimapDrawRangeCheckbox = null;
        this.showBattleEfficiencyRibbonsCheckbox.dispose();
        this.showBattleEfficiencyRibbonsCheckbox = null;
        this.simplifiedTTCCheckbox.dispose();
        this.simplifiedTTCCheckbox = null;
        super.onDispose();
    }

    private function onMinimapCirclesInfoMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }

    private function onMinimapCirclesInfoMouseOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SETTINGS_MINIMAP_CIRCLES, null);
    }
}
}
