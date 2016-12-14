package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.components.controls.VO.ActionPriceVO;
import net.wg.gui.lobby.dialogs.IconDialog;
import net.wg.infrastructure.exceptions.AbstractException;

public class IconPriceDialogMeta extends IconDialog {

    private var _actionPriceVO:ActionPriceVO;

    public function IconPriceDialogMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._actionPriceVO) {
            this._actionPriceVO.dispose();
            this._actionPriceVO = null;
        }
        super.onDispose();
    }

    public final function as_setMessagePrice(param1:Number, param2:String, param3:Object):void {
        var _loc4_:ActionPriceVO = this._actionPriceVO;
        this._actionPriceVO = !!param3 ? new ActionPriceVO(param3) : null;
        this.setMessagePrice(param1, param2, this._actionPriceVO);
        if (_loc4_) {
            _loc4_.dispose();
        }
    }

    protected function setMessagePrice(param1:Number, param2:String, param3:ActionPriceVO):void {
        var _loc4_:String = "as_setMessagePrice" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc4_);
        throw new AbstractException(_loc4_);
    }
}
}
