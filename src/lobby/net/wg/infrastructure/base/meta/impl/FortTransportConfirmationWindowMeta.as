package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.TransportingVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortTransportConfirmationWindowMeta extends AbstractWindowView {

    public var onCancel:Function;

    public var onTransporting:Function;

    private var _transportingVO:TransportingVO;

    public function FortTransportConfirmationWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._transportingVO) {
            this._transportingVO.dispose();
            this._transportingVO = null;
        }
        super.onDispose();
    }

    public function onCancelS():void {
        App.utils.asserter.assertNotNull(this.onCancel, "onCancel" + Errors.CANT_NULL);
        this.onCancel();
    }

    public function onTransportingS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.onTransporting, "onTransporting" + Errors.CANT_NULL);
        this.onTransporting(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:TransportingVO = this._transportingVO;
        this._transportingVO = new TransportingVO(param1);
        this.setData(this._transportingVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:TransportingVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
