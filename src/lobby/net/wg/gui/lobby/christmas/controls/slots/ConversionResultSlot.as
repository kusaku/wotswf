package net.wg.gui.lobby.christmas.controls.slots {
import net.wg.gui.lobby.christmas.data.slots.SlotVO;
import net.wg.gui.lobby.christmas.event.ChristmasConversionEvent;
import net.wg.gui.lobby.christmas.interfaces.IChristmasAnimationItem;

public class ConversionResultSlot extends ChristmasSlot {

    public var animationItem:IChristmasAnimationItem = null;

    public function ConversionResultSlot() {
        super();
        stop();
    }

    override public function setData(param1:SlotVO):void {
        super.setData(param1);
        if (param1 != null) {
            if (param1.showAnimation) {
                this.animationItem.setData(param1);
                gotoAndPlay(1);
                addFrameScript(totalFrames - 1, this.onEndAnimationHandler);
            }
            else {
                gotoAndStop(1);
            }
        }
    }

    override protected function onDispose():void {
        stop();
        this.animationItem.dispose();
        this.animationItem = null;
        super.onDispose();
    }

    private function onEndAnimationHandler():void {
        dispatchEvent(new ChristmasConversionEvent(ChristmasConversionEvent.ANIMATION_COMPLETE, true));
    }
}
}
