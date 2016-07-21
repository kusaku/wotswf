package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class SimpleWindowMeta extends AbstractWindowView {

    public var onBtnClick:Function;

    public function SimpleWindowMeta() {
        super();
    }

    public function onBtnClickS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onBtnClick, "onBtnClick" + Errors.CANT_NULL);
        this.onBtnClick(param1);
    }
}
}
