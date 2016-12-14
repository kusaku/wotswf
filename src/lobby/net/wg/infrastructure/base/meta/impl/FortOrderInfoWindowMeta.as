package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.orderInfo.FortOrderInfoTitleVO;
import net.wg.gui.lobby.fortifications.data.orderInfo.FortOrderInfoWindowVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortOrderInfoWindowMeta extends AbstractWindowView {

    private var _fortOrderInfoTitleVO:FortOrderInfoTitleVO;

    private var _fortOrderInfoWindowVO:FortOrderInfoWindowVO;

    public function FortOrderInfoWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fortOrderInfoTitleVO) {
            this._fortOrderInfoTitleVO.dispose();
            this._fortOrderInfoTitleVO = null;
        }
        if (this._fortOrderInfoWindowVO) {
            this._fortOrderInfoWindowVO.dispose();
            this._fortOrderInfoWindowVO = null;
        }
        super.onDispose();
    }

    public final function as_setWindowData(param1:Object):void {
        var _loc2_:FortOrderInfoWindowVO = this._fortOrderInfoWindowVO;
        this._fortOrderInfoWindowVO = new FortOrderInfoWindowVO(param1);
        this.setWindowData(this._fortOrderInfoWindowVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setDynProperties(param1:Object):void {
        var _loc2_:FortOrderInfoTitleVO = this._fortOrderInfoTitleVO;
        this._fortOrderInfoTitleVO = new FortOrderInfoTitleVO(param1);
        this.setDynProperties(this._fortOrderInfoTitleVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setWindowData(param1:FortOrderInfoWindowVO):void {
        var _loc2_:String = "as_setWindowData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setDynProperties(param1:FortOrderInfoTitleVO):void {
        var _loc2_:String = "as_setDynProperties" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
