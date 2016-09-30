package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.battle.components.BattleDisplayable;

public class RibbonsPanelMeta extends BattleDisplayable {

    public var onShow:Function;

    public var onChange:Function;

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

    public function onHideS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onHide, "onHide" + Errors.CANT_NULL);
        this.onHide(param1);
    }
}
}
