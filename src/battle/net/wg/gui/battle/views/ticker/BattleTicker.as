package net.wg.gui.battle.views.ticker {
import net.wg.gui.battle.components.interfaces.IBattleDisplayable;
import net.wg.gui.components.common.ticker.Ticker;

public class BattleTicker extends Ticker implements IBattleDisplayable {

    public function BattleTicker() {
        super();
        _isBattle = true;
    }

    public function setCompVisible(param1:Boolean):void {
        visible = param1;
    }
}
}
