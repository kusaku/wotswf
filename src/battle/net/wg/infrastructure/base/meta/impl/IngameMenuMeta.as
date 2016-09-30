package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class IngameMenuMeta extends AbstractWindowView {

    public var quitBattleClick:Function;

    public var settingsClick:Function;

    public var helpClick:Function;

    public var cancelClick:Function;

    public var onCounterNeedUpdate:Function;

    public function IngameMenuMeta() {
        super();
    }

    public function quitBattleClickS():void {
        App.utils.asserter.assertNotNull(this.quitBattleClick, "quitBattleClick" + Errors.CANT_NULL);
        this.quitBattleClick();
    }

    public function settingsClickS():void {
        App.utils.asserter.assertNotNull(this.settingsClick, "settingsClick" + Errors.CANT_NULL);
        this.settingsClick();
    }

    public function helpClickS():void {
        App.utils.asserter.assertNotNull(this.helpClick, "helpClick" + Errors.CANT_NULL);
        this.helpClick();
    }

    public function cancelClickS():void {
        App.utils.asserter.assertNotNull(this.cancelClick, "cancelClick" + Errors.CANT_NULL);
        this.cancelClick();
    }

    public function onCounterNeedUpdateS():void {
        App.utils.asserter.assertNotNull(this.onCounterNeedUpdate, "onCounterNeedUpdate" + Errors.CANT_NULL);
        this.onCounterNeedUpdate();
    }
}
}
