package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;

public class ConsumablesPanelMeta extends BattleDisplayable {

    public var onClickedToSlot:Function;

    public var onPopUpClosed:Function;

    public function ConsumablesPanelMeta() {
        super();
    }

    public function onClickedToSlotS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onClickedToSlot, "onClickedToSlot" + Errors.CANT_NULL);
        this.onClickedToSlot(param1);
    }

    public function onPopUpClosedS():void {
        App.utils.asserter.assertNotNull(this.onPopUpClosed, "onPopUpClosed" + Errors.CANT_NULL);
        this.onPopUpClosed();
    }
}
}
