package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class DemonstratorWindowMeta extends AbstractWindowView {

    public var onMapSelected:Function;

    public function DemonstratorWindowMeta() {
        super();
    }

    public function onMapSelectedS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onMapSelected, "onMapSelected" + Errors.CANT_NULL);
        this.onMapSelected(param1);
    }
}
}
