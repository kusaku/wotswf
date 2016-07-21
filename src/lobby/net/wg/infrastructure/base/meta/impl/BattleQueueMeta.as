package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class BattleQueueMeta extends AbstractView {

    public var startClick:Function;

    public var exitClick:Function;

    public var onEscape:Function;

    public function BattleQueueMeta() {
        super();
    }

    public function startClickS():void {
        App.utils.asserter.assertNotNull(this.startClick, "startClick" + Errors.CANT_NULL);
        this.startClick();
    }

    public function exitClickS():void {
        App.utils.asserter.assertNotNull(this.exitClick, "exitClick" + Errors.CANT_NULL);
        this.exitClick();
    }

    public function onEscapeS():void {
        App.utils.asserter.assertNotNull(this.onEscape, "onEscape" + Errors.CANT_NULL);
        this.onEscape();
    }
}
}
