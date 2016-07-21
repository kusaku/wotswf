package net.wg.gui.notification {
import flash.events.Event;

import net.wg.gui.components.controls.ScrollingListPx;
import net.wg.gui.notification.events.NotificationListEvent;
import net.wg.gui.notification.vo.NotificationInfoVO;

import scaleform.clik.data.DataProvider;
import scaleform.clik.interfaces.IListItemRenderer;

public class NotificationsList extends ScrollingListPx {

    public static const PENDING_DATA_INV:String = "pendingDataInv";

    public static const RENDERERS_CHANGE_HEIGHT:String = "renderersChangeHeight";

    private var _pendingDataList:Array;

    public function NotificationsList() {
        this._pendingDataList = [];
        super();
    }

    override protected function onDispose():void {
        this._pendingDataList.splice(0, this._pendingDataList.length);
        this._pendingDataList = null;
        if (_dataProvider) {
            _dataProvider.removeEventListener(Event.CHANGE, handleDataChange);
        }
        super.onDispose();
    }

    public function appendData(param1:NotificationInfoVO):void {
        this._pendingDataList.push(param1);
        invalidate(PENDING_DATA_INV);
    }

    public function updateData(param1:NotificationInfoVO):void {
        var _loc5_:int = 0;
        var _loc2_:uint = _dataProvider.length;
        var _loc3_:NotificationInfoVO = null;
        var _loc4_:int = -1;
        _loc5_ = 0;
        while (_loc5_ < _loc2_) {
            _loc3_ = NotificationInfoVO(_dataProvider[_loc5_]);
            if (param1.isEquals(_loc3_)) {
                _dataProvider[_loc5_] = param1;
                _loc4_ = _loc5_;
            }
            _loc5_++;
        }
        if (_loc4_ > -1) {
            invalidate();
        }
    }

    override protected function draw():void {
        var _loc1_:Boolean = false;
        var _loc2_:uint = 0;
        var _loc3_:uint = 0;
        var _loc4_:IListItemRenderer = null;
        var _loc5_:int = 0;
        super.draw();
        if (isInvalid(PENDING_DATA_INV)) {
            _loc1_ = scrollPosition == 0 || scrollPosition == maxScroll;
            if (!dataProvider) {
                dataProvider = new DataProvider([]);
            }
            _loc2_ = 0;
            while (this._pendingDataList.length > 0) {
                _dataProvider.removeEventListener(Event.CHANGE, handleDataChange);
                _loc2_ = DataProvider(_dataProvider).push(this._pendingDataList.shift());
                createRendererByDataIndex(_loc2_ - 1);
                _dataProvider.addEventListener(Event.CHANGE, handleDataChange, false, 0, true);
            }
            if (_loc1_) {
                scrollPosition = maxScroll;
            }
            container.y = -(scrollStepFactor * _scrollPosition);
            scrollBar.setScrollProperties(scrollPageSize, 0, maxScroll);
            scrollBar.position = scrollPosition;
            scrollBar.trackScrollPageSize = scrollPageSize;
            scrollBar.visible = maxScroll > 0;
            dispatchEvent(new NotificationListEvent(NotificationListEvent.UPDATE_INDEXES, _dataProvider.length));
        }
        if (isInvalid(RENDERERS_CHANGE_HEIGHT)) {
            totalHeight = 0;
            _loc3_ = _renderers.length;
            _loc5_ = 0;
            while (_loc5_ < _loc3_) {
                _loc4_ = _renderers[_loc5_];
                _loc4_.y = totalHeight;
                totalHeight = totalHeight + ((_loc4_.height | 0) + padding);
                _loc5_++;
            }
        }
    }

    override protected function drawRenderers(param1:Number):void {
        super.drawRenderers(param1);
        if (totalHeight > maskObject.height) {
            scrollPosition = maxScroll;
        }
        dispatchEvent(new NotificationListEvent(NotificationListEvent.UPDATE_INDEXES, _dataProvider.length));
    }

    override protected function createRenderer(param1:uint):IListItemRenderer {
        var _loc2_:IListItemRenderer = super.createRenderer(param1);
        if (_loc2_ != null) {
            _loc2_.addEventListener(Event.RESIZE, this.onRendererResizeHandler);
        }
        return _loc2_;
    }

    override protected function cleanUpRenderer(param1:IListItemRenderer):void {
        param1.removeEventListener(Event.RESIZE, this.onRendererResizeHandler);
        super.cleanUpRenderer(param1);
    }

    private function onRendererResizeHandler(param1:Event):void {
        invalidate(RENDERERS_CHANGE_HEIGHT);
    }
}
}
