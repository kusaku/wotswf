package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.notification.vo.LayoutInfoVO;
import net.wg.gui.notification.vo.PopUpNotificationInfoVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class NotificationPopUpViewerMeta extends BaseDAAPIComponent {

    public var setListClear:Function;

    public var onMessageHided:Function;

    public var onClickAction:Function;

    public var getMessageActualTime:Function;

    private var _layoutInfoVO:LayoutInfoVO;

    public function NotificationPopUpViewerMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._layoutInfoVO) {
            this._layoutInfoVO.dispose();
            this._layoutInfoVO = null;
        }
        super.onDispose();
    }

    public function setListClearS():void {
        App.utils.asserter.assertNotNull(this.setListClear, "setListClear" + Errors.CANT_NULL);
        this.setListClear();
    }

    public function onMessageHidedS(param1:Boolean, param2:Boolean):void {
        App.utils.asserter.assertNotNull(this.onMessageHided, "onMessageHided" + Errors.CANT_NULL);
        this.onMessageHided(param1, param2);
    }

    public function onClickActionS(param1:uint, param2:Number, param3:String):void {
        App.utils.asserter.assertNotNull(this.onClickAction, "onClickAction" + Errors.CANT_NULL);
        this.onClickAction(param1, param2, param3);
    }

    public function getMessageActualTimeS(param1:Number):String {
        App.utils.asserter.assertNotNull(this.getMessageActualTime, "getMessageActualTime" + Errors.CANT_NULL);
        return this.getMessageActualTime(param1);
    }

    public function as_appendMessage(param1:Object):void {
        this.appendMessage(new PopUpNotificationInfoVO(param1));
    }

    public function as_updateMessage(param1:Object):void {
        this.updateMessage(new PopUpNotificationInfoVO(param1));
    }

    public function as_layoutInfo(param1:Object):void {
        if (this._layoutInfoVO) {
            this._layoutInfoVO.dispose();
        }
        this._layoutInfoVO = new LayoutInfoVO(param1);
        this.layoutInfo(this._layoutInfoVO);
    }

    protected function appendMessage(param1:PopUpNotificationInfoVO):void {
        var _loc2_:String = "as_appendMessage" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateMessage(param1:PopUpNotificationInfoVO):void {
        var _loc2_:String = "as_updateMessage" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function layoutInfo(param1:LayoutInfoVO):void {
        var _loc2_:String = "as_layoutInfo" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
