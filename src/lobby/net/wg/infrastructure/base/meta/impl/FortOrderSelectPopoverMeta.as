package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.OrderSelectPopoverVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortOrderSelectPopoverMeta extends SmartPopOverView {

    public var addOrder:Function;

    public var removeOrder:Function;

    private var _orderSelectPopoverVO:OrderSelectPopoverVO;

    public function FortOrderSelectPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._orderSelectPopoverVO) {
            this._orderSelectPopoverVO.dispose();
            this._orderSelectPopoverVO = null;
        }
        super.onDispose();
    }

    public function addOrderS(param1:int):void {
        App.utils.asserter.assertNotNull(this.addOrder, "addOrder" + Errors.CANT_NULL);
        this.addOrder(param1);
    }

    public function removeOrderS(param1:int):void {
        App.utils.asserter.assertNotNull(this.removeOrder, "removeOrder" + Errors.CANT_NULL);
        this.removeOrder(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:OrderSelectPopoverVO = this._orderSelectPopoverVO;
        this._orderSelectPopoverVO = new OrderSelectPopoverVO(param1);
        this.setData(this._orderSelectPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:OrderSelectPopoverVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
