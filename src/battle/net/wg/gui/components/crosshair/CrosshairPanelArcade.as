package net.wg.gui.components.crosshair {
import flash.events.Event;
import flash.external.ExternalInterface;

public class CrosshairPanelArcade extends CrosshairPanelBase {

    private static const CASSETE_POSITION_ARCADE:Number = -1;

    private static const CASSETE_POSITION_SNIPER:Number = 13;

    private static const CASSETE_POSITION_PANZER:Number = -11;

    public function CrosshairPanelArcade() {
        super();
        addEventListener(Event.ENTER_FRAME, this.callExternalInterface);
    }

    override public function setNetType(param1:Number, param2:Number):void {
        super.setNetType(param1, param2);
        var _loc3_:Number = 0;
        switch (this.currentFrame) {
            case 1:
                _loc3_ = CASSETE_POSITION_ARCADE;
                break;
            case 2:
                _loc3_ = CASSETE_POSITION_SNIPER;
                break;
            case 3:
                _loc3_ = CASSETE_POSITION_PANZER;
        }
        cassette.y = _loc3_;
    }

    override protected function onPopulate():void {
        super.onPopulate();
        _fadingTargetWalker.setPosAsPercent(100);
        setDefaultTargetState();
        as_setAmmoStock(0, 0, true, "critical", false);
    }

    override protected function onDispose():void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        super.onDispose();
    }

    private function callExternalInterface(param1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        ExternalInterface.call("registerArcadeAimPanel");
    }
}
}
