package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.window.BaseExchangeWindow;
import net.wg.gui.lobby.window.ExchangeXPWindowVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class ExchangeXpWindowMeta extends BaseExchangeWindow {

    private var _exchangeXPWindowVO:ExchangeXPWindowVO;

    public function ExchangeXpWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._exchangeXPWindowVO) {
            this._exchangeXPWindowVO.dispose();
            this._exchangeXPWindowVO = null;
        }
        super.onDispose();
    }

    public function as_vehiclesDataChanged(param1:Object):void {
        if (this._exchangeXPWindowVO) {
            this._exchangeXPWindowVO.dispose();
        }
        this._exchangeXPWindowVO = new ExchangeXPWindowVO(param1);
        this.vehiclesDataChanged(this._exchangeXPWindowVO);
    }

    protected function vehiclesDataChanged(param1:ExchangeXPWindowVO):void {
        var _loc2_:String = "as_vehiclesDataChanged" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
