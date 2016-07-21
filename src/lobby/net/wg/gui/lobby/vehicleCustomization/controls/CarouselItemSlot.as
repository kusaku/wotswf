package net.wg.gui.lobby.vehicleCustomization.controls {
import flash.display.MovieClip;

import net.wg.gui.components.controls.SoundButtonEx;

public class CarouselItemSlot extends SoundButtonEx {

    public var glowOrange:MovieClip = null;

    public function CarouselItemSlot() {
        super();
    }

    override protected function onDispose():void {
        this.glowOrange = null;
        super.onDispose();
    }

    override protected function setState(param1:String):void {
        super.setState(param1);
        validateNow();
    }
}
}
