package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class TrainingRoomMeta extends AbstractView {

    public var showTrainingSettings:Function;

    public var selectCommonVoiceChat:Function;

    public var selectObserver:Function;

    public var startTraining:Function;

    public var swapTeams:Function;

    public var changeTeam:Function;

    public var closeTrainingRoom:Function;

    public var showPrebattleInvitationsForm:Function;

    public var onEscape:Function;

    public var canSendInvite:Function;

    public var canChangeSetting:Function;

    public var canChangePlayerTeam:Function;

    public var canStartBattle:Function;

    public var canAssignToTeam:Function;

    public var canDestroyRoom:Function;

    public var getPlayerTeam:Function;

    public function TrainingRoomMeta() {
        super();
    }

    public function showTrainingSettingsS():void {
        App.utils.asserter.assertNotNull(this.showTrainingSettings, "showTrainingSettings" + Errors.CANT_NULL);
        this.showTrainingSettings();
    }

    public function selectCommonVoiceChatS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.selectCommonVoiceChat, "selectCommonVoiceChat" + Errors.CANT_NULL);
        this.selectCommonVoiceChat(param1);
    }

    public function selectObserverS(param1:Boolean):void {
        App.utils.asserter.assertNotNull(this.selectObserver, "selectObserver" + Errors.CANT_NULL);
        this.selectObserver(param1);
    }

    public function startTrainingS():void {
        App.utils.asserter.assertNotNull(this.startTraining, "startTraining" + Errors.CANT_NULL);
        this.startTraining();
    }

    public function swapTeamsS():void {
        App.utils.asserter.assertNotNull(this.swapTeams, "swapTeams" + Errors.CANT_NULL);
        this.swapTeams();
    }

    public function changeTeamS(param1:Number, param2:Number):void {
        App.utils.asserter.assertNotNull(this.changeTeam, "changeTeam" + Errors.CANT_NULL);
        this.changeTeam(param1, param2);
    }

    public function closeTrainingRoomS():void {
        App.utils.asserter.assertNotNull(this.closeTrainingRoom, "closeTrainingRoom" + Errors.CANT_NULL);
        this.closeTrainingRoom();
    }

    public function showPrebattleInvitationsFormS():void {
        App.utils.asserter.assertNotNull(this.showPrebattleInvitationsForm, "showPrebattleInvitationsForm" + Errors.CANT_NULL);
        this.showPrebattleInvitationsForm();
    }

    public function onEscapeS():void {
        App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + Errors.CANT_NULL);
        this.onEscape();
    }

    public function canSendInviteS():Boolean {
        App.utils.asserter.assertNotNull(this.canSendInvite, "canSendInvite" + Errors.CANT_NULL);
        return this.canSendInvite();
    }

    public function canChangeSettingS():Boolean {
        App.utils.asserter.assertNotNull(this.canChangeSetting, "canChangeSetting" + Errors.CANT_NULL);
        return this.canChangeSetting();
    }

    public function canChangePlayerTeamS():Boolean {
        App.utils.asserter.assertNotNull(this.canChangePlayerTeam, "canChangePlayerTeam" + Errors.CANT_NULL);
        return this.canChangePlayerTeam();
    }

    public function canStartBattleS():Boolean {
        App.utils.asserter.assertNotNull(this.canStartBattle, "canStartBattle" + Errors.CANT_NULL);
        return this.canStartBattle();
    }

    public function canAssignToTeamS(param1:int):Boolean {
        App.utils.asserter.assertNotNull(this.canAssignToTeam, "canAssignToTeam" + Errors.CANT_NULL);
        return this.canAssignToTeam(param1);
    }

    public function canDestroyRoomS():Boolean {
        App.utils.asserter.assertNotNull(this.canDestroyRoom, "canDestroyRoom" + Errors.CANT_NULL);
        return this.canDestroyRoom();
    }

    public function getPlayerTeamS(param1:int):int {
        App.utils.asserter.assertNotNull(this.getPlayerTeam, "getPlayerTeam" + Errors.CANT_NULL);
        return this.getPlayerTeam(param1);
    }
}
}
