package net.wg.gui.battle.falloutClassic.views {
import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.gui.battle.falloutClassic.components.fullStats.FCFullStats;
import net.wg.gui.battle.views.BaseFalloutPage;

public class FalloutClassicPage extends BaseFalloutPage {

    public var stats:FCFullStats = null;

    public function FalloutClassicPage() {
        super();
    }

    override public function updateStage(param1:Number, param2:Number):void {
        super.updateStage(param1, param2);
        this.stats.updateStageSize(param1, param2);
    }

    override protected function initializeStatisticsController():void {
        super.initializeStatisticsController();
        battleStatisticDataController.registerComponentController(this.stats);
    }

    override protected function onPopulate():void {
        registerComponent(this.stats, BATTLE_VIEW_ALIASES.FALLOUT_CLASSIC_STATS);
        super.onPopulate();
    }

    override protected function onDispose():void {
        this.stats = null;
        super.onDispose();
    }
}
}
