package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIModule;

public class ContainerManagerMeta extends BaseDAAPIModule {

    public var isModalViewsIsExists:Function;

    public var canCancelPreviousLoading:Function;

    public function ContainerManagerMeta() {
        super();
    }

    public function isModalViewsIsExistsS():Boolean {
        App.utils.asserter.assertNotNull(this.isModalViewsIsExists, "isModalViewsIsExists" + Errors.CANT_NULL);
        return this.isModalViewsIsExists();
    }

    public function canCancelPreviousLoadingS(param1:String):Boolean {
        App.utils.asserter.assertNotNull(this.canCancelPreviousLoading, "canCancelPreviousLoading" + Errors.CANT_NULL);
        return this.canCancelPreviousLoading(param1);
    }
}
}
