package net.wg.gui.lobby.settings.vo.config {
import net.wg.gui.lobby.settings.config.ControlsFactory;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;
import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;

public class GameSettingsDataVo extends SettingsDataVo {

    public var enableOlFilter:SettingsControlProp = null;

    public var enableSpamFilter:SettingsControlProp = null;

    public var showDateMessage:SettingsControlProp = null;

    public var showTimeMessage:SettingsControlProp = null;

    public var invitesFromFriendsOnly:SettingsControlProp = null;

    public var receiveFriendshipRequest:SettingsControlProp = null;

    public var receiveInvitesInBattle:SettingsControlProp = null;

    public var chatContactsListOnly:SettingsControlProp = null;

    public var dynamicCamera:SettingsControlProp = null;

    public var horStabilizationSnp:SettingsControlProp = null;

    public var disableBattleChat:SettingsControlProp = null;

    public var ppShowLevels:SettingsControlProp = null;

    public var gameplay_ctf:SettingsControlProp = null;

    public var gameplay_domination:SettingsControlProp = null;

    public var gameplay_assault:SettingsControlProp = null;

    public var minimapAlpha:SettingsControlProp = null;

    public var enablePostMortemEffect:SettingsControlProp = null;

    public var enablePostMortemDelay:SettingsControlProp = null;

    public var enableOpticalSnpEffect:SettingsControlProp = null;

    public var replayEnabled:SettingsControlProp = null;

    public var useServerAim:SettingsControlProp = null;

    public var showVehiclesCounter:SettingsControlProp = null;

    public var showMarksOnGun:SettingsControlProp = null;

    public var showVehModelsOnMap:SettingsControlProp = null;

    public var minimapViewRange:SettingsControlProp = null;

    public var minimapMaxViewRange:SettingsControlProp = null;

    public var increasedZoom:SettingsControlProp = null;

    public var sniperModeByShift:SettingsControlProp = null;

    public var minimapDrawRange:SettingsControlProp = null;

    public var showVectorOnMap:SettingsControlProp = null;

    public var showSectorOnMap:SettingsControlProp = null;

    public var showBattleEfficiencyRibbons:SettingsControlProp = null;

    public var battleLoadingInfo:SettingsControlProp = null;

    public var receiveClanInvitesNotifications:SettingsControlProp = null;

    public var simplifiedTTC:SettingsControlProp = null;

    public function GameSettingsDataVo() {
        super({
            "enableOlFilter": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableSpamFilter": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showDateMessage": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showTimeMessage": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "invitesFromFriendsOnly": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "receiveFriendshipRequest": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "receiveInvitesInBattle": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "chatContactsListOnly": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "dynamicCamera": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "horStabilizationSnp": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "disableBattleChat": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "receiveClanInvitesNotifications": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "sniperModeByShift": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "increasedZoom": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "ppShowLevels": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "gameplay_ctf": createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build(),
            "gameplay_domination": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "gameplay_assault": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapAlpha": createControl(ControlsFactory.TYPE_SLIDER).build(),
            "enablePostMortemEffect": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enablePostMortemDelay": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableOpticalSnpEffect": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "replayEnabled": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "useServerAim": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showVehiclesCounter": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showMarksOnGun": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapViewRange": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapMaxViewRange": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapDrawRange": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showVehModelsOnMap": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "showVectorOnMap": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showSectorOnMap": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showBattleEfficiencyRibbons": createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleLoadingInfo": createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "simplifiedTTC": createControl(ControlsFactory.TYPE_CHECKBOX).build()
        });
    }

    override protected function onDispose():void {
        this.enableOlFilter.dispose();
        this.enableOlFilter = null;
        this.enableSpamFilter.dispose();
        this.enableSpamFilter = null;
        this.showDateMessage.dispose();
        this.showDateMessage = null;
        this.showTimeMessage.dispose();
        this.showTimeMessage = null;
        this.invitesFromFriendsOnly.dispose();
        this.invitesFromFriendsOnly = null;
        this.receiveFriendshipRequest.dispose();
        this.receiveFriendshipRequest = null;
        this.receiveInvitesInBattle.dispose();
        this.receiveInvitesInBattle = null;
        this.chatContactsListOnly.dispose();
        this.chatContactsListOnly = null;
        this.dynamicCamera.dispose();
        this.dynamicCamera = null;
        this.horStabilizationSnp.dispose();
        this.horStabilizationSnp = null;
        this.disableBattleChat.dispose();
        this.disableBattleChat = null;
        this.ppShowLevels.dispose();
        this.ppShowLevels = null;
        this.gameplay_ctf.dispose();
        this.gameplay_ctf = null;
        this.gameplay_domination.dispose();
        this.gameplay_domination = null;
        this.gameplay_assault.dispose();
        this.gameplay_assault = null;
        this.minimapAlpha.dispose();
        this.minimapAlpha = null;
        this.enablePostMortemEffect.dispose();
        this.enablePostMortemEffect = null;
        this.enablePostMortemDelay.dispose();
        this.enablePostMortemDelay = null;
        this.enableOpticalSnpEffect.dispose();
        this.enableOpticalSnpEffect = null;
        this.replayEnabled.dispose();
        this.replayEnabled = null;
        this.useServerAim.dispose();
        this.useServerAim = null;
        this.showVehiclesCounter.dispose();
        this.showVehiclesCounter = null;
        this.showMarksOnGun.dispose();
        this.showMarksOnGun = null;
        this.showVehModelsOnMap.dispose();
        this.showVehModelsOnMap = null;
        this.showVectorOnMap.dispose();
        this.showVectorOnMap = null;
        this.showSectorOnMap.dispose();
        this.showSectorOnMap = null;
        this.minimapViewRange.dispose();
        this.minimapViewRange = null;
        this.minimapMaxViewRange.dispose();
        this.minimapMaxViewRange = null;
        this.minimapDrawRange.dispose();
        this.minimapDrawRange = null;
        this.increasedZoom.dispose();
        this.increasedZoom = null;
        this.sniperModeByShift.dispose();
        this.sniperModeByShift = null;
        this.showBattleEfficiencyRibbons.dispose();
        this.showBattleEfficiencyRibbons = null;
        this.battleLoadingInfo.dispose();
        this.battleLoadingInfo = null;
        this.receiveClanInvitesNotifications.dispose();
        this.receiveClanInvitesNotifications = null;
        this.simplifiedTTC = null;
        super.onDispose();
    }
}
}
