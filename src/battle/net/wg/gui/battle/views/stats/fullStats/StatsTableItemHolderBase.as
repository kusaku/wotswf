package net.wg.gui.battle.views.stats.fullStats {
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.PlayerStatus;
import net.wg.gui.battle.battleloading.BattleLoadingHelper;
import net.wg.gui.battle.views.stats.StatsUserProps;
import net.wg.gui.battle.views.stats.fullStats.interfaces.IStatsTableItemHolderBase;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class StatsTableItemHolderBase implements IStatsTableItemHolderBase, IDisposable {

    protected var statsItem:StatsTableItemBase = null;

    protected var data:DAAPIVehicleInfoVO = null;

    protected var _isCurrPlayer:Boolean = false;

    private var _userProps:StatsUserProps = null;

    private var _isDisposed:Boolean = false;

    private var _isRenderingAvailable:Boolean;

    protected var _isRenderingRequired:Boolean;

    public function StatsTableItemHolderBase(param1:StatsTableItemBase) {
        super();
        this.statsItem = param1;
    }

    public function setDAAPIVehicleData(param1:DAAPIVehicleInfoVO):void {
        this.data = param1;
        if (this._isRenderingAvailable) {
            this.vehicleDataSync();
        }
        else {
            this._isRenderingRequired = true;
        }
    }

    public function get containsData():Boolean {
        return this.data != null;
    }

    public function get isSelected():Boolean {
        return !!this.data ? Boolean(PlayerStatus.isSelected(this.data.playerStatus)) : false;
    }

    public function updateColorBlind():void {
        if (this.containsData && this._isRenderingAvailable) {
            this.statsItem.updateColorBlind();
            this.updateVehicleType();
        }
    }

    public final function dispose():void {
        if (this._isDisposed && App.instance) {
            App.utils.asserter.assert(!this._isDisposed, "StatsItemHolder already disposed!");
        }
        this._isDisposed = true;
        this.onDispose();
    }

    protected function vehicleDataSync():void {
        if (this.data) {
            this.statsItem.setVehicleName(this.data.vehicleName);
            this.statsItem.setIsIGR(this.data.isIGR);
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
        this.statsItem.setIsDead(!this.data.isAlive());
        this.statsItem.setIsOffline(!this.data.isReady());
    }

    protected function applyPlayerStatus():void {
        var _loc1_:uint = this.data.playerStatus;
        this.statsItem.setIsTeamKiller(this.data.isTeamKiller());
        this.statsItem.setIsSquadPersonal(this.data.isSquadPersonal());
        this.statsItem.setIsSelected(PlayerStatus.isSelected(_loc1_));
    }

    protected function applyUserTags():void {
        this._isCurrPlayer = this.data.isCurrentPlayer;
        this.statsItem.setIsCurrentPlayer(this._isCurrPlayer);
    }

    protected final function updateUserProps():void {
        if (!this._userProps) {
            this._userProps = new StatsUserProps(this.data.playerName, this.data.clanAbbrev, this.data.region, 0, this.data.userTags);
        }
        else {
            this._userProps.userName = this.data.playerName;
            this._userProps.clanAbbrev = this.data.clanAbbrev;
            this._userProps.region = this.data.region;
            this._userProps.tags = this.data.userTags;
        }
        this.statsItem.setPlayerName(this._userProps);
    }

    protected function updateVehicleType():void {
        var _loc1_:String = BattleLoadingHelper.instance.getVehicleTypeIconId(this.data);
        if (_loc1_) {
            this.statsItem.setVehicleType(_loc1_);
        }
    }

    protected function onDispose():void {
        this.statsItem.dispose();
        if (this._userProps) {
            this._userProps.dispose();
            this._userProps = null;
        }
        this.statsItem = null;
        this.data = null;
    }

    public function get isRenderingAvailable():Boolean {
        return this._isRenderingAvailable;
    }

    public function set isRenderingAvailable(param1:Boolean):void {
        this._isRenderingAvailable = param1;
        if (param1 && this._isRenderingRequired) {
            this._isRenderingRequired = false;
            this.vehicleDataSync();
        }
    }
}
}
