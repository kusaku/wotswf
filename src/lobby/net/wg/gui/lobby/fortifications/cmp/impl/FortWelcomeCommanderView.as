package net.wg.gui.lobby.fortifications.cmp.impl {
import flash.display.InteractiveObject;
import flash.display.MovieClip;

import net.wg.infrastructure.base.UIComponentEx;
import net.wg.infrastructure.interfaces.entity.IFocusContainer;

import scaleform.clik.constants.InvalidationType;

public class FortWelcomeCommanderView extends UIComponentEx implements IFocusContainer {

    public var background:MovieClip = null;

    public var content:FortWelcomeCommanderContent = null;

    public function FortWelcomeCommanderView() {
        super();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.SIZE)) {
            this.content.x = _width - this.content.width >> 1;
            this.content.y = _height - this.content.height >> 1;
            this.background.width = _width;
            this.background.height = _height;
        }
    }

    override protected function onDispose():void {
        this.background = null;
        this.content.dispose();
        this.content = null;
        super.onDispose();
    }

    public function getComponentForFocus():InteractiveObject {
        return this.content.getComponentForFocus();
    }
}
}
