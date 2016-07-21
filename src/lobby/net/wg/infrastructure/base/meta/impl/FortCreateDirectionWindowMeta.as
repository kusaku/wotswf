package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class FortCreateDirectionWindowMeta extends AbstractWindowView {

    public var openNewDirection:Function;

    public var closeDirection:Function;

    public function FortCreateDirectionWindowMeta() {
        super();
    }

    public function openNewDirectionS():void {
        App.utils.asserter.assertNotNull(this.openNewDirection, "openNewDirection" + Errors.CANT_NULL);
        this.openNewDirection();
    }

    public function closeDirectionS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.closeDirection, "closeDirection" + Errors.CANT_NULL);
        this.closeDirection(param1);
    }
}
}
