package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.IDAAPIModule;

public class BaseDAAPIComponentMeta extends UIComponentEx {

    public var registerFlashComponent:Function;

    public var isFlashComponentRegistered:Function;

    public var unregisterFlashComponent:Function;

    public function BaseDAAPIComponentMeta() {
        super();
    }

    public function registerFlashComponentS(param1:IDAAPIModule, param2:String):void {
        App.utils.asserter.assertNotNull(this.registerFlashComponent, "registerFlashComponent" + Errors.CANT_NULL);
        this.registerFlashComponent(param1, param2);
    }

    public function isFlashComponentRegisteredS(param1:String):Boolean {
        App.utils.asserter.assertNotNull(this.isFlashComponentRegistered, "isFlashComponentRegistered" + Errors.CANT_NULL);
        return this.isFlashComponentRegistered(param1);
    }

    public function unregisterFlashComponentS(param1:String):void {
        App.utils.asserter.assertNotNull(this.unregisterFlashComponent, "unregisterFlashComponent" + Errors.CANT_NULL);
        this.unregisterFlashComponent(param1);
    }
}
}
