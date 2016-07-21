package net.wg.gui.prebattle.battleSession {
import net.wg.gui.lobby.battleResults.components.MedalsList;

public class FlagsList extends MedalsList {

    public function FlagsList() {
        super();
    }

    override protected function showToolTipByItemData(param1:Object):void {
        App.toolTipMgr.show(param1.tooltip);
    }
}
}
