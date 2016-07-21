package net.wg.gui.battle.falloutMultiteam.views {
import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
import net.wg.gui.battle.falloutMultiteam.views.components.fullStats.FMFullStats;
import net.wg.gui.battle.views.BaseFalloutPage;

public class FalloutMultiteamPage extends BaseFalloutPage {

    public var stats:FMFullStats = null;

    public function FalloutMultiteamPage() {
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
        registerComponent(this.stats, BATTLE_VIEW_ALIASES.FALLOUT_MULTITEAM_STATS);
        super.onPopulate();
    }

    override protected function onDispose():void {
        this.stats = null;
        super.onDispose();
    }
}
}
