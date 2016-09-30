package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractView;

public class AcademyViewMeta extends AbstractView {

    public var closeView:Function;

    public function AcademyViewMeta() {
        super();
    }

    public function closeViewS():void {
        App.utils.asserter.assertNotNull(this.closeView, "closeView" + Errors.CANT_NULL);
        this.closeView();
    }
}
}
