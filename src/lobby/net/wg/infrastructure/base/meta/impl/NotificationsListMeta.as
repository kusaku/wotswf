package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.notification.vo.NotificationInfoVO;
import net.wg.gui.notification.vo.NotificationMessagesListVO;
import net.wg.gui.notification.vo.NotificationViewInitVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class NotificationsListMeta extends SmartPopOverView {

    public var onClickAction:Function;

    public var getMessageActualTime:Function;

    public var onGroupChange:Function;

    private var _notificationInfoVO1:NotificationInfoVO;

    private var _notificationInfoVO:NotificationInfoVO;

    private var _notificationMessagesListVO:NotificationMessagesListVO;

    private var _notificationViewInitVO:NotificationViewInitVO;

    public function NotificationsListMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._notificationInfoVO1) {
            this._notificationInfoVO1.dispose();
            this._notificationInfoVO1 = null;
        }
        if (this._notificationInfoVO) {
            this._notificationInfoVO.dispose();
            this._notificationInfoVO = null;
        }
        if (this._notificationMessagesListVO) {
            this._notificationMessagesListVO.dispose();
            this._notificationMessagesListVO = null;
        }
        if (this._notificationViewInitVO) {
            this._notificationViewInitVO.dispose();
            this._notificationViewInitVO = null;
        }
        super.onDispose();
    }

    public function onClickActionS(param1:uint, param2:Number, param3:String):void {
        App.utils.asserter.assertNotNull(this.onClickAction, "onClickAction" + Errors.CANT_NULL);
        this.onClickAction(param1, param2, param3);
    }

    public function getMessageActualTimeS(param1:Number):String {
        App.utils.asserter.assertNotNull(this.getMessageActualTime, "getMessageActualTime" + Errors.CANT_NULL);
        return this.getMessageActualTime(param1);
    }

    public function onGroupChangeS(param1:uint):void {
        App.utils.asserter.assertNotNull(this.onGroupChange, "onGroupChange" + Errors.CANT_NULL);
        this.onGroupChange(param1);
    }

    public function as_setInitData(param1:Object):void {
        if (this._notificationViewInitVO) {
            this._notificationViewInitVO.dispose();
        }
        this._notificationViewInitVO = new NotificationViewInitVO(param1);
        this.setInitData(this._notificationViewInitVO);
    }

    public function as_setMessagesList(param1:Object):void {
        if (this._notificationMessagesListVO) {
            this._notificationMessagesListVO.dispose();
        }
        this._notificationMessagesListVO = new NotificationMessagesListVO(param1);
        this.setMessagesList(this._notificationMessagesListVO);
    }

    public function as_appendMessage(param1:Object):void {
        if (this._notificationInfoVO) {
            this._notificationInfoVO.dispose();
        }
        this._notificationInfoVO = new NotificationInfoVO(param1);
        this.appendMessage(this._notificationInfoVO);
    }

    public function as_updateMessage(param1:Object):void {
        if (this._notificationInfoVO1) {
            this._notificationInfoVO1.dispose();
        }
        this._notificationInfoVO1 = new NotificationInfoVO(param1);
        this.updateMessage(this._notificationInfoVO1);
    }

    protected function setInitData(param1:NotificationViewInitVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setMessagesList(param1:NotificationMessagesListVO):void {
        var _loc2_:String = "as_setMessagesList" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function appendMessage(param1:NotificationInfoVO):void {
        var _loc2_:String = "as_appendMessage" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function updateMessage(param1:NotificationInfoVO):void {
        var _loc2_:String = "as_updateMessage" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
