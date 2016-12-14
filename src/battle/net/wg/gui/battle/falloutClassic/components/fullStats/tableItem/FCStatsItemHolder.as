package net.wg.gui.battle.falloutClassic.components.fullStats.tableItem {
import net.wg.data.VO.daapi.DAAPIFalloutVehicleStatsVO;
import net.wg.data.constants.VehicleStatus;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;

public class FCStatsItemHolder extends StatsTableItemHolderBase {

    public function FCStatsItemHolder(param1:FCStatsItem) {
        super(param1);
    }

    public function setVehicleStats(param1:DAAPIFalloutVehicleStatsVO):void {
        this.getStatsItem.setScore(param1.winPoints);
        this.getStatsItem.setFrags(param1.frags);
        this.getStatsItem.setDeaths(param1.deaths);
        this.getStatsItem.setDamage(param1.damage);
        this.getStatsItem.setSpecialPoints(param1.specialPoints);
    }

    override protected function applyVehicleStatus():void {
        super.applyPlayerStatus();
        this.getStatsItem.setIsRespawnDisabled(VehicleStatus.isStopRespawn(data.vehicleStatus));
    }

    private function get getStatsItem():FCStatsItem {
        return FCStatsItem(statsItem);
    }
}
}
