package net.wg.gui.battle.random.views.stats.components.playersPanel.list {
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.InvitationStatus;
import net.wg.data.constants.PlayerStatus;
import net.wg.data.constants.UserTags;
import net.wg.gui.battle.random.views.stats.components.playersPanel.interfaces.IPlayersPanelListItemHolder;
import net.wg.gui.battle.views.stats.StatsUserProps;
import net.wg.gui.battle.views.stats.constants.DynamicSquadState;

public class PlayersPanelListItemHolder implements IPlayersPanelListItemHolder {

    public var accDBID:Number = NaN;

    private var _listItem:PlayersPanelListItem = null;

    private var _vehicleData:DAAPIVehicleInfoVO = null;

    private var _frags:int = 0;

    private var _userProps:StatsUserProps = null;

    private var _isCurrPlayer:Boolean = false;

    private var _isInviteReceived:Boolean = false;

    private var _isDisposed:Boolean = false;

    public function PlayersPanelListItemHolder(param1:PlayersPanelListItem) {
        super();
        this._listItem = param1;
    }

    public final function dispose():void {
        if (App.instance) {
            App.utils.asserter.assert(!this._isDisposed, "StatsItemHolder already disposed!");
        }
        this._isDisposed = true;
        if (this._listItem) {
            this._listItem = null;
        }
        if (this._userProps) {
            this._userProps.dispose();
            this._userProps = null;
        }
        if (this._vehicleData) {
            this._vehicleData.dispose();
            this._vehicleData = null;
        }
    }

    public function setFrags(param1:int):void {
        if (this._frags == param1) {
            return;
        }
        this._frags = param1;
        this.applyFragsData();
    }

    public function setInvitationStatus(param1:uint):void {
        if (!this._vehicleData || this._vehicleData.invitationStatus == param1) {
            return;
        }
        this._vehicleData.invitationStatus = param1;
        this.updateInviteStatus();
        this.updateDynamicSquadState();
    }

    public function setPlayerStatus(param1:int):void {
        if (!this._vehicleData || this._vehicleData.playerStatus == param1) {
            return;
        }
        this._vehicleData.playerStatus = param1;
        this.applyPlayerStatus();
        this.updateDynamicSquadState();
    }

    public function setUserTags(param1:Array):void {
        if (!this._vehicleData || this._vehicleData.userTags == param1) {
            return;
        }
        this._vehicleData.userTags = param1;
        this.applyUserTags();
        this.updateUserProps();
        this.updateDynamicSquadState();
    }

    public function setVehicleData(param1:DAAPIVehicleInfoVO):void {
        this._vehicleData = param1.clone();
        this.accDBID = this._vehicleData.accountDBID;
        this.applyVehicleData();
    }

    public function setVehicleStatus(param1:int):void {
        if (!this._vehicleData || this._vehicleData.vehicleStatus == param1) {
            return;
        }
        this._vehicleData.vehicleStatus = param1;
        this.applyVehicleStatus();
    }

    private function applyVehicleData():void {
        this._listItem.setIsIGR(this._vehicleData.isIGR);
        this._listItem.setVehicleLevel(this._vehicleData.vehicleLevel);
        this._listItem.setVehicleIcon(this._vehicleData.vehicleIconName);
        this._listItem.setVehicleName(this._vehicleData.vehicleName);
        this._listItem.dynamicSquad.setUID(this._vehicleData.accountDBID);
        if (this._vehicleData.vehicleAction) {
            this._listItem.setVehicleAction(this._vehicleData.vehicleAction);
        }
        this.applyVehicleStatus();
        this.applyPlayerStatus();
        this.applyUserTags();
        this.updateInviteStatus();
        this.updateDynamicSquadState();
        this.updateUserProps();
        if (this._isCurrPlayer && this._vehicleData.isAlive()) {
            this._listItem.setIsSelected(true);
        }
    }

    private function applyUserTags():void {
        var _loc1_:Array = this._vehicleData.userTags;
        if (!_loc1_) {
            return;
        }
        this._listItem.setIsMute(UserTags.isMuted(_loc1_));
        this._listItem.isIgnoredTmp(UserTags.isIgnored(_loc1_));
        this._isCurrPlayer = this._vehicleData.isCurrentPlayer;
        this._listItem.setIsCurrentPlayer(this._isCurrPlayer);
    }

    private function applyFragsData():void {
        this._listItem.setFrags(this._frags);
    }

    private function applyPlayerStatus():void {
        var _loc1_:uint = this._vehicleData.playerStatus;
        this._listItem.setSquad(this._vehicleData.isSquadPersonal(), this._vehicleData.squadIndex);
        this._listItem.setIsTeamKiller(this._vehicleData.isTeamKiller());
        this._listItem.setSquadNoSound(PlayerStatus.isVoipDisabled(_loc1_));
        this._listItem.setIsSelected(PlayerStatus.isSelected(_loc1_));
    }

    private function applyVehicleStatus():void {
        this._listItem.setIsAlive(this._vehicleData.isAlive());
        this._listItem.setIsOffline(!this._vehicleData.isReady());
    }

    private function updateUserProps():void {
        if (!this._userProps) {
            this._userProps = new StatsUserProps(this._vehicleData.playerName, this._vehicleData.clanAbbrev, this._vehicleData.region, 0, this._vehicleData.userTags);
        }
        else {
            this._userProps.userName = this._vehicleData.playerName;
            this._userProps.clanAbbrev = this._vehicleData.clanAbbrev;
            this._userProps.region = this._vehicleData.region;
            this._userProps.tags = this._vehicleData.userTags;
        }
        if (this._userProps.isChanged) {
            this._userProps.applyChanges();
            this._listItem.setPlayerNameProps(this._userProps);
        }
    }

    private function updateDynamicSquadState():void {
        var _loc1_:Boolean = this._vehicleData.userTags && UserTags.isIgnored(this._vehicleData.userTags);
        var _loc2_:Boolean = this._vehicleData.isSquadMan();
        var _loc3_:uint = DynamicSquadState.getState(this._vehicleData.invitationStatus, this._vehicleData.isCurrentPlayer, _loc2_, _loc1_);
        this._listItem.setSquadState(_loc3_);
    }

    private function updateInviteStatus():void {
        this._isInviteReceived = InvitationStatus.isOnlyReceived(this._vehicleData.invitationStatus);
    }

    public function get listItem():PlayersPanelListItem {
        return this._listItem;
    }

    public function get playerStatus():uint {
        return this._vehicleData.playerStatus;
    }

    public function get vehicleID():Number {
        return !!this._vehicleData ? Number(this._vehicleData.vehicleID) : Number(NaN);
    }

    public function get accountDBID():Number {
        return !!this._vehicleData ? Number(this._vehicleData.accountDBID) : Number(NaN);
    }

    public function get isInviteReceived():Boolean {
        return this._isInviteReceived;
    }

    public function get isCurrentPlayer():Boolean {
        return this._isCurrPlayer;
    }
}
}
