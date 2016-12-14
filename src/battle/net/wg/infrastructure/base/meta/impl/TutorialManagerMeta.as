package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIModule;
import net.wg.infrastructure.exceptions.AbstractException;

public class TutorialManagerMeta extends BaseDAAPIModule {

    public var onComponentFound:Function;

    public var onComponentDisposed:Function;

    public var onTriggerActivated:Function;

    public var requestCriteriaValue:Function;

    private var _array:Array;

    public function TutorialManagerMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._array) {
            this._array.splice(0, this._array.length);
            this._array = null;
        }
        super.onDispose();
    }

    public function onComponentFoundS(param1:String):Array {
        App.utils.asserter.assertNotNull(this.onComponentFound, "onComponentFound" + Errors.CANT_NULL);
        return this.onComponentFound(param1);
    }

    public function onComponentDisposedS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onComponentDisposed, "onComponentDisposed" + Errors.CANT_NULL);
        this.onComponentDisposed(param1);
    }

    public function onTriggerActivatedS(param1:String, param2:String):void {
        App.utils.asserter.assertNotNull(this.onTriggerActivated, "onTriggerActivated" + Errors.CANT_NULL);
        this.onTriggerActivated(param1, param2);
    }

    public function requestCriteriaValueS(param1:String):void {
        App.utils.asserter.assertNotNull(this.requestCriteriaValue, "requestCriteriaValue" + Errors.CANT_NULL);
        this.requestCriteriaValue(param1);
    }

    public final function as_setTriggers(param1:String, param2:Array):void {
        var _loc3_:Array = this._array;
        this._array = param2;
        this.setTriggers(param1, this._array);
        if (_loc3_) {
            _loc3_.splice(0, _loc3_.length);
        }
    }

    protected function setTriggers(param1:String, param2:Array):void {
        var _loc3_:String = "as_setTriggers" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc3_);
        throw new AbstractException(_loc3_);
    }
}
}
