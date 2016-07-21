package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.OrderPopoverVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortOrderPopoverMeta extends SmartPopOverView {

    public var requestForCreateOrder:Function;

    public var requestForUseOrder:Function;

    public var getLeftTime:Function;

    public var getLeftTimeStr:Function;

    public var getLeftTimeTooltip:Function;

    public var openQuest:Function;

    public var openOrderDetailsWindow:Function;

    private var _orderPopoverVO:OrderPopoverVO;

    public function FortOrderPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._orderPopoverVO) {
            this._orderPopoverVO.dispose();
            this._orderPopoverVO = null;
        }
        super.onDispose();
    }

    public function requestForCreateOrderS():void {
        App.utils.asserter.assertNotNull(this.requestForCreateOrder, "requestForCreateOrder" + Errors.CANT_NULL);
        this.requestForCreateOrder();
    }

    public function requestForUseOrderS():void {
        App.utils.asserter.assertNotNull(this.requestForUseOrder, "requestForUseOrder" + Errors.CANT_NULL);
        this.requestForUseOrder();
    }

    public function getLeftTimeS():Number {
        App.utils.asserter.assertNotNull(this.getLeftTime, "getLeftTime" + Errors.CANT_NULL);
        return this.getLeftTime();
    }

    public function getLeftTimeStrS():String {
        App.utils.asserter.assertNotNull(this.getLeftTimeStr, "getLeftTimeStr" + Errors.CANT_NULL);
        return this.getLeftTimeStr();
    }

    public function getLeftTimeTooltipS():String {
        App.utils.asserter.assertNotNull(this.getLeftTimeTooltip, "getLeftTimeTooltip" + Errors.CANT_NULL);
        return this.getLeftTimeTooltip();
    }

    public function openQuestS(param1:String):void {
        App.utils.asserter.assertNotNull(this.openQuest, "openQuest" + Errors.CANT_NULL);
        this.openQuest(param1);
    }

    public function openOrderDetailsWindowS():void {
        App.utils.asserter.assertNotNull(this.openOrderDetailsWindow, "openOrderDetailsWindow" + Errors.CANT_NULL);
        this.openOrderDetailsWindow();
    }

    public function as_setInitData(param1:Object):void {
        if (this._orderPopoverVO) {
            this._orderPopoverVO.dispose();
        }
        this._orderPopoverVO = new OrderPopoverVO(param1);
        this.setInitData(this._orderPopoverVO);
    }

    protected function setInitData(param1:OrderPopoverVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
