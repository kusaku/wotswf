package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.LoadViewVO;
import net.wg.infrastructure.base.BaseDAAPIModule;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.IView;

public class LoaderManagerMeta extends BaseDAAPIModule {

    public var viewLoaded:Function;

    public var viewLoadError:Function;

    public var viewInitializationError:Function;

    public function LoaderManagerMeta() {
        super();
    }

    public function viewLoadedS(param1:String, param2:IView):void {
        App.utils.asserter.assertNotNull(this.viewLoaded, "viewLoaded" + Errors.CANT_NULL);
        this.viewLoaded(param1, param2);
    }

    public function viewLoadErrorS(param1:String, param2:String, param3:String):void {
        App.utils.asserter.assertNotNull(this.viewLoadError, "viewLoadError" + Errors.CANT_NULL);
        this.viewLoadError(param1, param2, param3);
    }

    public function viewInitializationErrorS(param1:String, param2:String):void {
        App.utils.asserter.assertNotNull(this.viewInitializationError, "viewInitializationError" + Errors.CANT_NULL);
        this.viewInitializationError(param1, param2);
    }

    public function as_loadView(param1:Object):void {
        this.loadView(new LoadViewVO(param1));
    }

    protected function loadView(param1:LoadViewVO):void {
        var _loc2_:String = "as_loadView" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
