package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.TrainingRoomInfoVO;
import net.wg.data.VO.TrainingRoomTeamVO;
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

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

    private var _array:Array;

    private var _array1:Array;

    private var _array2:Array;

    private var _trainingRoomInfoVO:TrainingRoomInfoVO;

    private var _trainingRoomTeamVO:TrainingRoomTeamVO;

    private var _trainingRoomTeamVO1:TrainingRoomTeamVO;

    private var _trainingRoomTeamVO2:TrainingRoomTeamVO;

    public function TrainingRoomMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        if (this._array1) {
            this._array1.splice(0, this._array1.length);
            this._array1 = null;
        }
        if (this._array2) {
            this._array2.splice(0, this._array2.length);
            this._array2 = null;
        }
        if (this._trainingRoomInfoVO) {
            this._trainingRoomInfoVO.dispose();
            this._trainingRoomInfoVO = null;
        }
        if (this._trainingRoomTeamVO) {
            this._trainingRoomTeamVO.dispose();
            this._trainingRoomTeamVO = null;
        }
        if (this._trainingRoomTeamVO1) {
            this._trainingRoomTeamVO1.dispose();
            this._trainingRoomTeamVO1 = null;
        }
        if (this._trainingRoomTeamVO2) {
            this._trainingRoomTeamVO2.dispose();
            this._trainingRoomTeamVO2 = null;
        }
        super.onDispose();
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

    public final function as_setTeam1(param1:Object):void {
        var _loc2_:TrainingRoomTeamVO = this._trainingRoomTeamVO;
        this._trainingRoomTeamVO = new TrainingRoomTeamVO(param1);
        this.setTeam1(this._trainingRoomTeamVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setTeam2(param1:Object):void {
        var _loc2_:TrainingRoomTeamVO = this._trainingRoomTeamVO1;
        this._trainingRoomTeamVO1 = new TrainingRoomTeamVO(param1);
        this.setTeam2(this._trainingRoomTeamVO1);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setOther(param1:Object):void {
        var _loc2_:TrainingRoomTeamVO = this._trainingRoomTeamVO2;
        this._trainingRoomTeamVO2 = new TrainingRoomTeamVO(param1);
        this.setOther(this._trainingRoomTeamVO2);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setInfo(param1:Object):void {
        var _loc2_:TrainingRoomInfoVO = this._trainingRoomInfoVO;
        this._trainingRoomInfoVO = new TrainingRoomInfoVO(param1);
        this.setInfo(this._trainingRoomInfoVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setPlayerTagsInTeam1(param1:Number, param2:Array):void {
        var _loc3_:Array = this._array;
        this._array = param2;
        this.setPlayerTagsInTeam1(param1, this._array);
        if (_loc3_) {
            _loc3_.splice(0, _loc3_.length);
        }
    }

    public final function as_setPlayerTagsInTeam2(param1:Number, param2:Array):void {
        var _loc3_:Array = this._array1;
        this._array1 = param2;
        this.setPlayerTagsInTeam2(param1, this._array1);
        if (_loc3_) {
            _loc3_.splice(0, _loc3_.length);
        }
    }

    public final function as_setPlayerTagsInOther(param1:Number, param2:Array):void {
        var _loc3_:Array = this._array2;
        this._array2 = param2;
        this.setPlayerTagsInOther(param1, this._array2);
        if (_loc3_) {
            _loc3_.splice(0, _loc3_.length);
        }
    }

    protected function setTeam1(param1:TrainingRoomTeamVO):void {
        var _loc2_:String = "as_setTeam1" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setTeam2(param1:TrainingRoomTeamVO):void {
        var _loc2_:String = "as_setTeam2" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setOther(param1:TrainingRoomTeamVO):void {
        var _loc2_:String = "as_setOther" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setInfo(param1:TrainingRoomInfoVO):void {
        var _loc2_:String = "as_setInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setPlayerTagsInTeam1(param1:Number, param2:Array):void {
        var _loc3_:String = "as_setPlayerTagsInTeam1" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function setPlayerTagsInTeam2(param1:Number, param2:Array):void {
        var _loc3_:String = "as_setPlayerTagsInTeam2" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }

    protected function setPlayerTagsInOther(param1:Number, param2:Array):void {
        var _loc3_:String = "as_setPlayerTagsInOther" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
