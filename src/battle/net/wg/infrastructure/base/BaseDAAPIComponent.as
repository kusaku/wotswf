package net.wg.infrastructure.base {
import net.wg.infrastructure.base.meta.impl.BaseDAAPIComponentMeta;
import net.wg.infrastructure.events.LifeCycleEvent;
import net.wg.infrastructure.exceptions.base.WGGUIException;
import net.wg.infrastructure.interfaces.IBaseDAAPIComponent;
import net.wg.infrastructure.interfaces.IDAAPIModule;

public class BaseDAAPIComponent extends BaseDAAPIComponentMeta implements IBaseDAAPIComponent {

    private var _disposed:Boolean = false;

    private var _isDAAPIInited:Boolean = false;

    public function BaseDAAPIComponent() {
        super();
    }

    public final function as_populate():void {
        try {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
            this._isDAAPIInited = true;
            this.onPopulate();
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
            return;
        }
        catch (error:WGGUIException) {
            DebugUtils.LOG_WARNING(error.getStackTrace());
            return;
        }
        catch (error:Error) {
            DebugUtils.LOG_ERROR(error.getStackTrace());
            return;
        }
    }

    public final function as_dispose():void {
        try {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            dispose();
            this._disposed = true;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
            return;
        }
        catch (error:WGGUIException) {
            DebugUtils.LOG_WARNING(error.getStackTrace());
            return;
        }
        catch (error:Error) {
            DebugUtils.LOG_ERROR(error.getStackTrace());
            return;
        }
    }

    public function get disposed():Boolean {
        return this._disposed;
    }

    protected function onPopulate():void {
    }

    public function get isDAAPIInited():Boolean {
        return this._isDAAPIInited;
    }

    protected function getComponentVo(param1:String, param2:IDAAPIModule):Object {
        return {
            "alias": param1,
            "component": param2
        };
    }
}
}
