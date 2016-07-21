package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class ExchangeFreeToTankmanXpWindowMeta extends AbstractWindowView {

    public var apply:Function;

    public var onValueChanged:Function;

    public var calcValueRequest:Function;

    public function ExchangeFreeToTankmanXpWindowMeta() {
        super();
    }

    public function applyS():void {
        App.utils.asserter.assertNotNull(this.apply, "apply" + Errors.CANT_NULL);
        this.apply();
    }

    public function onValueChangedS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.onValueChanged, "onValueChanged" + Errors.CANT_NULL);
        this.onValueChanged(param1);
    }

    public function calcValueRequestS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.calcValueRequest, "calcValueRequest" + Errors.CANT_NULL);
        this.calcValueRequest(param1);
    }
}
}
