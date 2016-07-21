package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIModule;

public class TutorialManagerMeta extends BaseDAAPIModule {

    public var onComponentFound:Function;

    public var onComponentDisposed:Function;

    public var onTriggerActivated:Function;

    public var requestCriteriaValue:Function;

    public function TutorialManagerMeta() {
        super();
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
}
}
