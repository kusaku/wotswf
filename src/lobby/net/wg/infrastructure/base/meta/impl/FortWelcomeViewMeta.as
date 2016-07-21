package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class FortWelcomeViewMeta extends BaseDAAPIComponent {

    public var onViewReady:Function;

    public function FortWelcomeViewMeta() {
        super();
    }

    public function onViewReadyS():void {
        App.utils.asserter.assertNotNull(this.onViewReady, "onViewReady" + Errors.CANT_NULL);
        this.onViewReady();
    }
}
}
