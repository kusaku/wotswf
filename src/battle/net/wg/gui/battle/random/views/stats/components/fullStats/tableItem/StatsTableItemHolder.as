package net.wg.gui.battle.random.views.stats.components.fullStats.tableItem {
import net.wg.data.constants.PlayerStatus;
import net.wg.data.constants.UserTags;
import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;

public class StatsTableItemHolder extends StatsTableItemHolderBase {

    private var _squadItem:DynamicSquadCtrl = null;

    private var _isEnemy:Boolean = false;

    public function StatsTableItemHolder(param1:StatsTableItem, param2:DynamicSquadCtrl, param3:Boolean) {
        super(param1);
        this._squadItem = param2;
        this._isEnemy = param3;
    }

    public function setFrags(param1:int):void {
        this.getStatsItem.setFrags(param1);
    }

    public function get squadItem():DynamicSquadCtrl {
        return this._squadItem;
    }

    public function get isEnemy():Boolean {
        return this._isEnemy;
    }

    public function setIsInviteShown(param1:Boolean):void {
        this._squadItem.setIsInviteShown(param1);
    }

    public function setIsInteractive(param1:Boolean):void {
        this._squadItem.setIsInteractive(param1);
    }

    override public function setPlayerStatus(param1:uint):void {
        super.setPlayerStatus(param1);
        this.updateDynamicSquadState();
    }

    public function setInvitationStatus(param1:uint):void {
        if (!containsData) {
            return;
        }
        getVehicleData.invitationStatus = param1;
        this.updateDynamicSquadState();
    }

    override public function setUserTags(param1:Array):void {
        super.setUserTags(param1);
        this.updateDynamicSquadState();
    }

    public function setSpeaking(param1:Boolean):void {
        this.getStatsItem.setIsSpeaking(param1);
    }

    override protected function onDispose():void {
        this._squadItem.dispose();
        this._squadItem = null;
        super.onDispose();
    }

    override protected function vehicleDataSync():void {
        var _loc1_:Number = NaN;
        super.vehicleDataSync();
        if (getVehicleData) {
            this.getStatsItem.setVehicleLevel(getVehicleData.vehicleLevel);
            this.getStatsItem.setVehicleIcon(getVehicleData.vehicleIconName);
            _loc1_ = getVehicleData.vehicleAction;
            if (isNaN(_loc1_) || !_loc1_) {
                this.getStatsItem.clearVehicleAction();
            }
            else {
                this.getStatsItem.setVehicleAction(VehicleActions.getActionName(getVehicleData.vehicleAction));
            }
            this._squadItem.setIsEnemy(this._isEnemy);
            this._squadItem.uid = getVehicleData.accountDBID;
            this.updateDynamicSquadState();
        }
        else {
            this._squadItem.reset();
        }
    }

    override protected function applyUserTags():void {
        var _loc1_:Array = getVehicleData.userTags;
        if (!_loc1_) {
            return;
        }
        super.applyUserTags();
        this.getStatsItem.setIsMute(UserTags.isMuted(_loc1_));
        if (_isCurrPlayer) {
            this._squadItem.setState(DynamicSquadState.NONE);
        }
    }

    override protected function applyPlayerStatus():void {
        super.applyPlayerStatus();
        var _loc1_:uint = getVehicleData.playerStatus;
        this._squadItem.setSquadIndex(getVehicleData.squadIndex, PlayerStatus.isSquadPersonal(_loc1_));
        this._squadItem.setNoSound(PlayerStatus.isVoipDisabled(_loc1_));
    }

    private function updateDynamicSquadState():void {
        var _loc1_:Boolean = getVehicleData.userTags && UserTags.isIgnored(getVehicleData.userTags);
        var _loc2_:Boolean = PlayerStatus.isSquadMan(getVehicleData.playerStatus);
        var _loc3_:uint = DynamicSquadState.getState(getVehicleData.invitationStatus, _isCurrPlayer, _loc2_, _loc1_);
        this._squadItem.setState(_loc3_);
    }

    private function get getStatsItem():StatsTableItem {
        return StatsTableItem(statsItem);
    }
}
}
