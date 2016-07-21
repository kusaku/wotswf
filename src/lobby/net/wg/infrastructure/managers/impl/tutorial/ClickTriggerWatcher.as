package net.wg.infrastructure.managers.impl.tutorial {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

class ClickTriggerWatcher extends AbstractTriggerWatcher {

    function ClickTriggerWatcher(param1:String, param2:String) {
        super(param1, param2);
    }

    override public function start(param1:DisplayObject):void {
        super.start(param1);
        param1.addEventListener(MouseEvent.CLICK, this.onTargetClickHandler, false, int.MAX_VALUE);
    }

    override public function stop():void {
        target.removeEventListener(MouseEvent.CLICK, this.onTargetClickHandler);
        super.stop();
    }

    private function onTargetClickHandler(param1:MouseEvent):void {
        dispatchTriggerEvent();
    }
}
}
