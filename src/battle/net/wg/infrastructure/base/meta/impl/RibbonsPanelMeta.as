package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;

public class RibbonsPanelMeta extends BattleDisplayable {

    public var onShow:Function;

    public var onChange:Function;

    public var onIncCount:Function;

    public var onHide:Function;

    public function RibbonsPanelMeta() {
        super();
    }

    public function onShowS():void {
        App.utils.asserter.assertNotNull(this.onShow, "onShow" + Errors.CANT_NULL);
        this.onShow();
    }

    public function onChangeS():void {
        App.utils.asserter.assertNotNull(this.onChange, "onChange" + Errors.CANT_NULL);
        this.onChange();
    }

    public function onIncCountS():void {
        App.utils.asserter.assertNotNull(this.onIncCount, "onIncCount" + Errors.CANT_NULL);
        this.onIncCount();
    }

    public function onHideS():void {
        App.utils.asserter.assertNotNull(this.onHide, "onHide" + Errors.CANT_NULL);
        this.onHide();
    }
}
}
