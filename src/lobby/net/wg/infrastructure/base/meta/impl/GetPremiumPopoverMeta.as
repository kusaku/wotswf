package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.SmartPopOverView;

public class GetPremiumPopoverMeta extends SmartPopOverView {

    public var onActionBtnClick:Function;

    public function GetPremiumPopoverMeta() {
        super();
    }

    public function onActionBtnClickS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onActionBtnClick, "onActionBtnClick" + Errors.CANT_NULL);
        this.onActionBtnClick(param1);
    }
}
}
