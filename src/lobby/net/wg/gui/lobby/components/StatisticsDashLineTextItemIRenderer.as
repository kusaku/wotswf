package net.wg.gui.lobby.components {
import net.wg.gui.lobby.components.data.DetailedStatisticsLabelDataVO;
import net.wg.gui.lobby.components.data.TruncateDetailedStatisticsLabelDataVO;
import net.wg.infrastructure.interfaces.entity.IUpdatable;

public class StatisticsDashLineTextItemIRenderer extends ProfileDashLineTextItem implements IUpdatable {

    public function StatisticsDashLineTextItemIRenderer() {
        super();
    }

    public function update(param1:Object):void {
        var _loc2_:DetailedStatisticsLabelDataVO = DetailedStatisticsLabelDataVO(param1);
        if (_loc2_) {
            if (_loc2_ is TruncateDetailedStatisticsLabelDataVO) {
                useTruncateValues(TruncateDetailedStatisticsLabelDataVO(_loc2_).truncateVo);
                this.value = String(_loc2_.data);
            }
            else {
                receiveAndSetValue(_loc2_.data, 15131353);
            }
            label = _loc2_.label;
            tooltip = _loc2_.tooltip;
            toolTipParams = _loc2_.tooltipDataVO;
            visible = true;
        }
        else {
            visible = false;
        }
    }
}
}
