package net.wg.gui.messenger.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.BaseDAAPIComponent;

public class BaseContactViewMeta extends BaseDAAPIComponent {

    public var onOk:Function;

    public var onCancel:Function;

    public function BaseContactViewMeta() {
        super();
    }

    public function onOkS(param1:Object):void {
        App.utils.asserter.assertNotNull(this.onOk, "onOk" + Errors.CANT_NULL);
        this.onOk(param1);
    }

    public function onCancelS():void {
        App.utils.asserter.assertNotNull(this.onCancel, "onCancel" + Errors.CANT_NULL);
        this.onCancel();
    }
}
}
