package net.wg.gui.battle.views.destroyTimers.components {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class DestroyTimerContainer extends Sprite implements IDisposable {

    public var progressBar:MovieClip = null;

    public var iconSpr:Sprite = null;

    public var textField:TextField = null;

    public function DestroyTimerContainer() {
        super();
        TextFieldEx.setNoTranslate(this.textField, true);
    }

    public function dispose():void {
        this.progressBar = null;
        this.iconSpr = null;
        this.textField = null;
    }
}
}
