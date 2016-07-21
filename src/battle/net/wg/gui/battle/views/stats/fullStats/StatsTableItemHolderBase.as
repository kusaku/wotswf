package net.wg.gui.battle.views.stats.fullStats {
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.PlayerStatus;
import net.wg.data.constants.UserTags;
import net.wg.data.constants.VehicleStatus;
import net.wg.gui.battle.views.stats.StatsUserProps;
import net.wg.gui.battle.views.stats.fullStats.interfaces.IStatsTableItemHolderBase;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StatsTableItemHolderBase implements IStatsTableItemHolderBase, IDisposable {

    private static const VEHICLE_TYPE_UNKNOWN:String = "unknown";

    protected var statsItem:StatsTableItemBase = null;

    protected var getVehicleData:DAAPIVehicleInfoVO = null;

    protected var _isCurrPlayer:Boolean = false;

    private var _userProps:StatsUserProps = null;

    private var _isDisposed:Boolean = false;

    public function StatsTableItemHolderBase(param1:StatsTableItemBase) {
        super();
        this.statsItem = param1;
    }

    public function setDAAPIVehicleData(param1:DAAPIVehicleInfoVO):void {
        this.getVehicleData = param1.clone();
        this.vehicleDataSync();
    }

    public function get vehicleID():Number {
        return !!this.getVehicleData ? Number(this.getVehicleData.vehicleID) : Number(NaN);
    }

    public function get accountID():Number {
        return !!this.getVehicleData ? Number(this.getVehicleData.accountDBID) : Number(NaN);
    }

    public function get containsData():Boolean {
        return this.getVehicleData != null;
    }

    public function get isCurrentPlayer():Boolean {
        return this._isCurrPlayer;
    }

    public function get isSelected():Boolean {
        return !!this.getVehicleData ? Boolean(PlayerStatus.isSelected(this.getVehicleData.playerStatus)) : false;
    }

    public function setVehicleStatus(param1:uint):void {
        if (!this.containsData) {
            return;
        }
        this.getVehicleData.vehicleStatus = param1;
        this.applyVehicleStatus();
    }

    public function setPlayerStatus(param1:uint):void {
        if (!this.containsData) {
            return;
        }
        this.getVehicleData.playerStatus = param1;
        this.applyPlayerStatus();
    }

    public function setUserTags(param1:Array):void {
        if (!this.containsData) {
            return;
        }
        this.getVehicleData.userTags = param1;
        this.applyUserTags();
        this.updateUserProps();
    }

    public function updateColorBlind():void {
        if (this.containsData) {
            this.statsItem.updateColorBlind();
            this.updateVehicleType();
        }
    }

    public final function dispose():void {
        if (App.instance) {
            App.utils.asserter.assert(!this._isDisposed, "StatsItemHolder already disposed!");
        }
        this._isDisposed = true;
        this.onDispose();
    }

    protected function vehicleDataSync():void {
        if (this.getVehicleData) {
            this.statsItem.setVehicleName(this.getVehicleData.vehicleName);
            this.statsItem.setIsIGR(this.getVehicleData.isVehiclePremiumIgr && this.getVehicleData.vehicleType && this.getVehicleData.vehicleType != VEHICLE_TYPE_UNKNOWN);
            this.updateVehicleType();
            this.applyVehicleStatus();
            this.applyPlayerStatus();
            this.applyUserTags();
            this.updateUserProps();
        }
        else {
            this.statsItem.reset();
        }
    }

    protected function applyVehicleStatus():void {
        var _loc1_:uint = this.getVehicleData.vehicleStatus;
        this.statsItem.setIsDead(!VehicleStatus.isAlive(_loc1_));
        this.statsItem.setIsOffline(!VehicleStatus.isReady(_loc1_));
    }

    protected function applyPlayerStatus():void {
        var _loc1_:uint = this.getVehicleData.playerStatus;
        this.statsItem.setIsTeamKiller(PlayerStatus.isTeamKiller(_loc1_));
        this.statsItem.setIsSquadPersonal(PlayerStatus.isSquadPersonal(_loc1_));
        this.statsItem.setIsSelected(PlayerStatus.isSelected(_loc1_));
    }

    protected function applyUserTags():void {
        var _loc1_:Array = this.getVehicleData.userTags;
        if (_loc1_) {
            this._isCurrPlayer = UserTags.isCurrentPlayer(_loc1_);
            this.statsItem.setIsCurrentPlayer(this._isCurrPlayer);
        }
        else {
            this._isCurrPlayer = false;
        }
    }

    protected final function updateUserProps():void {
        if (!this._userProps) {
            this._userProps = new StatsUserProps(this.getVehicleData.playerName, this.getVehicleData.clanAbbrev, this.getVehicleData.region, 0, this.getVehicleData.userTags);
        }
        else {
            this._userProps.userName = this.getVehicleData.playerName;
            this._userProps.clanAbbrev = this.getVehicleData.clanAbbrev;
            this._userProps.region = this.getVehicleData.region;
            this._userProps.tags = this.getVehicleData.userTags;
        }
        if (this._userProps.isChanged) {
            this._userProps.applyChanges();
            this.statsItem.setPlayerName(this._userProps);
        }
    }

    protected function updateVehicleType():void {
        var _loc1_:String = App.colorSchemeMgr.getAliasColor(this.getVehicleData.teamColor);
        if (_loc1_ && this.getVehicleData.vehicleType && this.getVehicleData.vehicleType != VEHICLE_TYPE_UNKNOWN) {
            this.statsItem.setVehicleType(_loc1_, this.getVehicleData.vehicleType);
        }
    }

    protected function onDispose():void {
        this.statsItem.dispose();
        if (this._userProps) {
            this._userProps.dispose();
        }
        if (this.getVehicleData) {
            this.getVehicleData.dispose();
        }
        this.statsItem = null;
        this._userProps = null;
        this.getVehicleData = null;
    }
}
}
