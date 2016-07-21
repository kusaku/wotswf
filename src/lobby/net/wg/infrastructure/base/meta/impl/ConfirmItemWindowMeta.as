package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.DialogSettingsVO;
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractConfirmItemDialog;
import net.wg.infrastructure.exceptions.AbstractException;

public class ConfirmItemWindowMeta extends AbstractConfirmItemDialog {

    public var submit:Function;

    private var _dialogSettingsVO:DialogSettingsVO;

    public function ConfirmItemWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._dialogSettingsVO) {
            this._dialogSettingsVO.dispose();
            this._dialogSettingsVO = null;
        }
        super.onDispose();
    }

    public function submitS(param1:Number, param2:String):void {
        App.utils.asserter.assertNotNull(this.submit, "submit" + Errors.CANT_NULL);
        this.submit(param1, param2);
    }

    public function as_setSettings(param1:Object):void {
        if (this._dialogSettingsVO) {
            this._dialogSettingsVO.dispose();
        }
        this._dialogSettingsVO = new DialogSettingsVO(param1);
        this.setSettings(this._dialogSettingsVO);
    }

    protected function setSettings(param1:DialogSettingsVO):void {
        var _loc2_:String = "as_setSettings" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
