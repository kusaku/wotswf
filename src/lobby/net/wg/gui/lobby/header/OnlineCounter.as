package net.wg.gui.lobby.header {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import net.wg.gui.components.advanced.InviteIndicator;
import net.wg.infrastructure.base.UIComponentEx;

public class OnlineCounter extends UIComponentEx {

    private static const WAITING_OFFSET:int = 10;

    public var clusterOnlineCounter:TextField;

    public var clusterWaiting:InviteIndicator;

    public var regionOnlineCounter:TextField;

    public var bgOnlineCounter:Sprite;

    public var hitMc:Sprite;

    private var _tooltipOnlineCounter:String = "";

    public function OnlineCounter() {
        super();
    }

    public function initVisible(param1:Boolean):void {
        this.bgOnlineCounter.visible = param1;
        this.clusterOnlineCounter.visible = param1;
        this.clusterWaiting.visible = param1;
        this.regionOnlineCounter.visible = param1;
        this.animationWaiting(param1);
    }

    override protected function initialize():void {
        super.initialize();
        this.hitMc.visible = false;
        hitArea = this.hitMc;
    }

    override protected function configUI():void {
        super.configUI();
        this.clusterOnlineCounter.mouseEnabled = false;
        this.regionOnlineCounter.mouseEnabled = false;
        this.bgOnlineCounter.mouseEnabled = false;
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
    }

    override protected function onDispose():void {
        removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
        removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
        this.clusterWaiting.dispose();
        this.clusterWaiting = null;
        this.clusterOnlineCounter = null;
        this.regionOnlineCounter = null;
        this.bgOnlineCounter = null;
        this.hitMc = null;
        super.onDispose();
    }

    public function updateCount(param1:String, param2:String, param3:String, param4:Boolean):void {
        this._tooltipOnlineCounter = param3;
        this.clusterOnlineCounter.htmlText = param1;
        this.clusterWaiting.visible = !param4;
        this.regionOnlineCounter.htmlText = param2;
        this.animationWaiting(!param4);
        if (!param4) {
            this.clusterWaiting.x = this.clusterOnlineCounter.textWidth + WAITING_OFFSET;
        }
        var _loc5_:Number = Math.max(this.clusterOnlineCounter.textWidth, this.regionOnlineCounter.textWidth);
        var _loc6_:Number = _loc5_ + this.clusterWaiting.width + WAITING_OFFSET | 0;
        if (_loc6_ != this.hitMc.width) {
            this.hitMc.width = _loc6_;
        }
    }

    private function animationWaiting(param1:Boolean):void {
        if (param1) {
            this.clusterWaiting.play();
        }
        else {
            this.clusterWaiting.stop();
        }
    }

    private function onMouseOverHandler(param1:MouseEvent):void {
        App.toolTipMgr.showComplex(this._tooltipOnlineCounter);
    }

    private function onMouseOutHandler(param1:MouseEvent):void {
        App.toolTipMgr.hide();
    }
}
}
