package net.wg.gui.lobby.profile.pages.technique {
import net.wg.gui.lobby.components.DetailedStatisticsGroupEx;
import net.wg.gui.lobby.components.DetailedStatisticsUnit;

public class TechDetailedUnitGroup extends DetailedStatisticsGroupEx {

    private static const UNIT_WIDTH:int = 350;

    public function TechDetailedUnitGroup() {
        super();
    }

    override protected function adjustUnitAt(param1:int):DetailedStatisticsUnit {
        var _loc2_:DetailedStatisticsUnit = super.adjustUnitAt(param1);
        _loc2_.width = UNIT_WIDTH;
        return _loc2_;
    }
}
}
