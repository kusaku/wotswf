package net.wg.gui.battle.views.destroyTimers {
import net.wg.data.constants.Linkages;
import net.wg.infrastructure.base.meta.IFalloutDestroyTimersPanelMeta;
import net.wg.infrastructure.base.meta.impl.FalloutDestroyTimersPanelMeta;

public class FalloutDestroyTimersPanel extends FalloutDestroyTimersPanelMeta implements IFalloutDestroyTimersPanelMeta {

    public function FalloutDestroyTimersPanel() {
        super();
    }

    override protected function getTimersIcons():Vector.<String> {
        var _loc1_:Vector.<String> = super.getTimersIcons();
        _loc1_.push(Linkages.GAS_DRAFT_ICON);
        return _loc1_;
    }
}
}
