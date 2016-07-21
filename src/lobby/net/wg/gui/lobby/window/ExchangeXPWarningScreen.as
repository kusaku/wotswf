package net.wg.gui.lobby.window {
import flash.text.TextField;

import scaleform.clik.core.UIComponent;

public class ExchangeXPWarningScreen extends UIComponent {

    public static const TEXT_INVALID:String = "textInvalid";

    public var textField:TextField;

    private var _text:String = "";

    public function ExchangeXPWarningScreen() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.textField.multiline = true;
    }

    public function set text(param1:String):void {
        this._text = param1;
        invalidate(TEXT_INVALID);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(TEXT_INVALID)) {
            this.textField.text = this._text;
        }
    }
}
}
