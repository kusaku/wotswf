package net.wg.gui.components.crosshair {
import flash.events.Event;
import flash.external.ExternalInterface;
import flash.text.TextField;

public class CrosshairPanelStrategic extends CrosshairPanelBase {

    public var distanceLbl:TextField;

    public function CrosshairPanelStrategic() {
        super();
        addEventListener(Event.ENTER_FRAME, this.callExternalInterface);
    }

    override public function as_updateDistance(param1:Number):void {
        this.distanceLbl.text = param1 + "m";
    }

    override protected function onPopulate():void {
        super.onPopulate();
        this.setDefaultDistanceState();
        as_setAmmoStock(0, 0, true, "critical", false);
    }

    override protected function onDispose():void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        super.onDispose();
    }

    private function setDefaultDistanceState():void {
        this.distanceLbl.text = "";
    }

    private function callExternalInterface(param1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.callExternalInterface);
        ExternalInterface.call("registerStrategicAimPanel");
    }
}
}
