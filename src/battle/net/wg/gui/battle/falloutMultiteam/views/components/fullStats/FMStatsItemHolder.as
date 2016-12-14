package net.wg.gui.battle.falloutMultiteam.views.components.fullStats {
import net.wg.data.VO.daapi.DAAPIFalloutVehicleStatsVO;
import net.wg.data.constants.VehicleStatus;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;

public class FMStatsItemHolder extends StatsTableItemHolderBase {

    private var _vehicleStatsData:DAAPIFalloutVehicleStatsVO = null;

    private var _teamScore:int;

    public function FMStatsItemHolder(param1:FMStatsItem) {
        super(param1);
    }

    public function setVehicleStats(param1:DAAPIFalloutVehicleStatsVO):void {
        this.getStatsItem.setScore(param1.winPoints);
        this.getStatsItem.setFrags(param1.frags);
        this.getStatsItem.setDeaths(param1.deaths);
        this.getStatsItem.setDamage(param1.damage);
        this.getStatsItem.setSpecialPoints(param1.specialPoints);
        this._vehicleStatsData = param1;
    }

    public function get teamScore():int {
        return this._teamScore;
    }

    public function set teamScore(param1:int):void {
        if (this._teamScore == param1) {
            return;
        }
        this.getStatsItem.setTeamScore(param1);
        this._teamScore = param1;
    }

    public function get score():int {
        return !!this._vehicleStatsData ? int(this._vehicleStatsData.winPoints) : 0;
    }

    public function get isInSquad():Boolean {
        return !!data ? Boolean(data.isSquadMan()) : false;
    }

    public function get squadIndex():int {
        return !!this.isInSquad ? int(data.squadIndex) : 0;
    }

    public function get isSquadPersonal():Boolean {
        return !!this.isInSquad ? Boolean(data.isSquadPersonal()) : false;
    }

    public function setTeamScoreVisible(param1:Boolean):void {
        this.getStatsItem.setTeamScoreVisible(param1);
    }

    override protected function applyVehicleStatus():void {
        super.applyPlayerStatus();
        this.getStatsItem.setIsRespawnDisabled(VehicleStatus.isStopRespawn(data.vehicleStatus));
    }

    override protected function onDispose():void {
        if (this._vehicleStatsData) {
            this._vehicleStatsData.dispose();
            this._vehicleStatsData = null;
        }
        super.onDispose();
    }

    private function get getStatsItem():FMStatsItem {
        return FMStatsItem(statsItem);
    }
}
}
