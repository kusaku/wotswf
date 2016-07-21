package net.wg.gui.lobby.fortifications.cmp.main.impl {
import flash.display.DisplayObject;
import flash.text.TextField;

import net.wg.infrastructure.base.UIComponentEx;

public class VignetteYellow extends UIComponentEx {

    public var bg:DisplayObject;

    public var descrText:TextField = null;

    public function VignetteYellow() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function onDispose():void {
        this.descrText = null;
        this.bg = null;
        super.onDispose();
    }
}
}
