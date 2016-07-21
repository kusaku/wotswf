package net.wg.gui.notification {
import flash.display.MovieClip;

import net.wg.data.constants.Values;
import net.wg.gui.components.controls.ScrollBar;
import net.wg.gui.components.popOvers.PopOver;
import net.wg.gui.notification.events.ServiceMessageEvent;
import net.wg.gui.notification.vo.NotificationInfoVO;
import net.wg.infrastructure.base.meta.INotificationsListMeta;
import net.wg.infrastructure.base.meta.impl.NotificationsListMeta;
import net.wg.infrastructure.interfaces.IWrapper;

import scaleform.clik.data.DataProvider;

public class NotificationListView extends NotificationsListMeta implements INotificationsListMeta {

    public var list:NotificationsList;

    public var background:MovieClip;

    public var bottomLip:MovieClip;

    public var scrollBar:ScrollBar;

    public var rendererTemplate:ServiceMessageItemRenderer;

    private var TIME_UPDATE_INTERVAL:uint = 300000.0;

    public function NotificationListView() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        hitArea = this.background;
        this.bottomLip.mouseChildren = false;
        this.bottomLip.mouseEnabled = false;
        this.list.addEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED, this.messageButtonClickHandler, false, 0, true);
        this.list.addEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED, this.messageLinkClickHandler, false, 0, true);
        if (this.rendererTemplate) {
            if (this.rendererTemplate.parent) {
                this.rendererTemplate.parent.removeChild(this.rendererTemplate);
                this.rendererTemplate = null;
            }
        }
        App.utils.scheduler.scheduleTask(this.updateTimestamps, this.TIME_UPDATE_INTERVAL);
    }

    override protected function onDispose():void {
        App.utils.scheduler.cancelTask(this.updateTimestamps);
        this.list.removeEventListener(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED, this.messageButtonClickHandler);
        this.list.removeEventListener(ServiceMessageEvent.MESSAGE_LINK_CLICKED, this.messageLinkClickHandler);
        this.list.dispose();
        this.list = null;
        this.background = null;
        this.bottomLip = null;
        this.scrollBar = null;
        super.onDispose();
    }

    public function as_appendMessage(param1:Object):void {
        var _loc2_:NotificationInfoVO = new NotificationInfoVO(param1);
        this.updateTimestamp(_loc2_);
        this.list.appendData(_loc2_);
    }

    public function as_setInitData(param1:Object):void {
        var _loc2_:String = "scrollStepFactor";
        if (param1.hasOwnProperty(_loc2_)) {
            this.list.scrollStepFactor = param1[_loc2_];
        }
    }

    public function as_setMessagesList(param1:Array):void {
        var _loc5_:NotificationInfoVO = null;
        if (param1 == null) {
            return;
        }
        var _loc2_:Array = [];
        var _loc3_:uint = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = new NotificationInfoVO(param1[_loc4_]);
            this.updateTimestamp(_loc5_);
            _loc2_.push(_loc5_);
            _loc4_++;
        }
        this.list.dataProvider = new DataProvider(_loc2_);
    }

    public function as_updateMessage(param1:Object):void {
        var _loc2_:NotificationInfoVO = new NotificationInfoVO(param1);
        this.updateTimestamp(_loc2_);
        this.list.updateData(_loc2_);
    }

    private function updateTimestamps():void {
        var _loc1_:NotificationInfoVO = null;
        App.utils.scheduler.cancelTask(this.updateTimestamps);
        if (this.list.dataProvider) {
            for each(_loc1_ in this.list.dataProvider) {
                this.updateTimestamp(_loc1_);
            }
            this.list.invalidateData();
        }
        App.utils.scheduler.scheduleTask(this.updateTimestamps, this.TIME_UPDATE_INTERVAL);
    }

    private function updateTimestamp(param1:NotificationInfoVO):void {
        var _loc2_:Number = param1.messageVO.timestamp;
        if (_loc2_ != Values.DEFAULT_INT) {
            param1.messageVO.timestampStr = getMessageActualTimeS(_loc2_);
        }
    }

    override public function set wrapper(param1:IWrapper):void {
        super.wrapper = param1;
        PopOver(wrapper).title = App.utils.locale.makeString(MESSENGER.LISTVIEW_TITLE);
    }

    override public function get width():Number {
        return this.background.width;
    }

    override public function get height():Number {
        return this.background.height;
    }

    private function messageButtonClickHandler(param1:ServiceMessageEvent):void {
        param1.stopImmediatePropagation();
        onClickActionS(param1.typeID, param1.entityID, param1.action);
        App.popoverMgr.hide();
    }

    private function messageLinkClickHandler(param1:ServiceMessageEvent):void {
        param1.stopImmediatePropagation();
        onClickActionS(param1.typeID, param1.entityID, param1.action);
    }
}
}