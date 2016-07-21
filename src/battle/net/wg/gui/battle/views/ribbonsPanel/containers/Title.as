package net.wg.gui.battle.views.ribbonsPanel.containers {
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class Title extends Sprite implements IDisposable {

    public var tf:TextField = null;

    public function Title() {
        super();
        TextFieldEx.setNoTranslate(this.tf, true);
    }

    public function dispose():void {
        this.tf = null;
    }
}
}
