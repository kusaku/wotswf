package net.wg.infrastructure.base.meta.impl {
import net.wg.data.VO.DialogSettingsVO;
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.ConfirmOrderVO;
import net.wg.infrastructure.base.AbstractConfirmItemDialog;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortOrderConfirmationWindowMeta extends AbstractConfirmItemDialog {

    public var submit:Function;

    public var getTimeStr:Function;

    private var _dialogSettingsVO:DialogSettingsVO;

    private var _confirmOrderVO:ConfirmOrderVO;

    public function FortOrderConfirmationWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._dialogSettingsVO) {
            this._dialogSettingsVO.dispose();
            this._dialogSettingsVO = null;
        }
        if (this._confirmOrderVO) {
            this._confirmOrderVO.dispose();
            this._confirmOrderVO = null;
        }
        super.onDispose();
    }

    public function submitS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.submit, "submit" + Errors.CANT_NULL);
        this.submit(param1);
    }

    public function getTimeStrS(param1:Number):String {
        App.utils.asserter.assertNotNull(this.getTimeStr, "getTimeStr" + Errors.CANT_NULL);
        return this.getTimeStr(param1);
    }

    public function as_setData(param1:Object):void {
        if (this._confirmOrderVO) {
            this._confirmOrderVO.dispose();
        }
        this._confirmOrderVO = new ConfirmOrderVO(param1);
        this.setData(this._confirmOrderVO);
    }

    public function as_setSettings(param1:Object):void {
        if (this._dialogSettingsVO) {
            this._dialogSettingsVO.dispose();
        }
        this._dialogSettingsVO = new DialogSettingsVO(param1);
        this.setSettings(this._dialogSettingsVO);
    }

    protected function setData(param1:ConfirmOrderVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setSettings(param1:DialogSettingsVO):void {
        var _loc2_:String = "as_setSettings" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
