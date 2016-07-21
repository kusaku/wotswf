package net.wg.infrastructure.helpers.statisticsDataController {
import flash.display.DisplayObjectContainer;

import net.wg.data.VO.daapi.DAAPIVehiclesInteractiveStatsVO;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;

public class FalloutStatisticsDataController extends BattleStatisticDataController {

    public function FalloutStatisticsDataController(param1:DisplayObjectContainer) {
        super(param1);
    }

    override protected function getVehiclesStatsVO(param1:Object):IDAAPIDataClass {
        return new DAAPIVehiclesInteractiveStatsVO(param1);
    }
}
}
