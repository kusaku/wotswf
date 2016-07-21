package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;

public class RadialMenuMeta extends BattleDisplayable {

    public var onSelect:Function;

    public var onAction:Function;

    public function RadialMenuMeta() {
        super();
    }

    public function onSelectS():void {
        App.utils.asserter.assertNotNull(this.onSelect, "onSelect" + Errors.CANT_NULL);
        this.onSelect();
    }

    public function onActionS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onAction, "onAction" + Errors.CANT_NULL);
        this.onAction(param1);
    }
}
}
