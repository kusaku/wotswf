package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;

public class MinimapMeta extends BattleDisplayable {

    public var setAttentionToCell:Function;

    public function MinimapMeta() {
        super();
    }

    public function setAttentionToCellS(param1:Number, param2:Number, param3:Boolean):void {
        App.utils.asserter.assertNotNull(this.setAttentionToCell, "setAttentionToCell" + Errors.CANT_NULL);
        this.setAttentionToCell(param1, param2, param3);
    }
}
}
