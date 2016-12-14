package net.wg.gui.lobby.christmas.controls {
import flash.display.DisplayObject;

import net.wg.gui.lobby.components.HeaderBackground;

import scaleform.clik.constants.InvalidationType;

public class ChristmasHeaderBackground extends HeaderBackground {

    public var progressBarBack:DisplayObject = null;

    public function ChristmasHeaderBackground() {
        super();
    }

    override protected function onDispose():void {
        this.progressBarBack = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.progressBarBack.x = width - this.progressBarBack.width >> 1;
        }
    }
}
}
