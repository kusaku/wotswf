package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.store.data.StoreViewInitVO;
import net.wg.infrastructure.base.AbstractView;
import net.wg.infrastructure.exceptions.AbstractException;

public class StoreViewMeta extends AbstractView {

    public var onClose:Function;

    public var onTabChange:Function;

    private var _storeViewInitVO:StoreViewInitVO;

    public function StoreViewMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._storeViewInitVO) {
            this._storeViewInitVO.dispose();
            this._storeViewInitVO = null;
        }
        super.onDispose();
    }

    public function onCloseS():void {
        App.utils.asserter.assertNotNull(this.onClose, "onClose" + Errors.CANT_NULL);
        this.onClose();
    }

    public function onTabChangeS(param1:String):void {
        App.utils.asserter.assertNotNull(this.onTabChange, "onTabChange" + Errors.CANT_NULL);
        this.onTabChange(param1);
    }

    public final function as_init(param1:Object):void {
        var _loc2_:StoreViewInitVO = this._storeViewInitVO;
        this._storeViewInitVO = new StoreViewInitVO(param1);
        this.init(this._storeViewInitVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function init(param1:StoreViewInitVO):void {
        var _loc2_:String = "as_init" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
