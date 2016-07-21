package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class SimpleDialogMeta extends AbstractWindowView {

    public var onButtonClick:Function;

    public function SimpleDialogMeta() {
        super();
    }

    public function onButtonClickS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onButtonClick, "onButtonClick" + Errors.CANT_NULL);
        this.onButtonClick(param1);
    }
}
}
