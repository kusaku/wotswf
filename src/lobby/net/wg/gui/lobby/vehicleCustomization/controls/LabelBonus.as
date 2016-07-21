package net.wg.gui.lobby.vehicleCustomization.controls {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.infrastructure.interfaces.entity.IDisposable;

public class LabelBonus extends MovieClip implements IDisposable {

    private static const GREEN:String = "green";

    private static const RED:String = "red";

    private static const WHITE:String = "white";

    public var text:TextField = null;

    private var _color:String = "";

    private var _label:String = "";

    public function LabelBonus() {
        super();
    }

    public function dispose():void {
        this.text = null;
    }

    public function glowGreen():void {
        this.setColor(GREEN);
    }

    public function glowRed():void {
        this.setColor(RED);
    }

    public function glowWhite():void {
        this.setColor(WHITE);
    }

    public function glow(param1:String):void {
        switch (param1) {
            case GREEN:
                this.glowGreen();
                break;
            case RED:
                this.glowRed();
                break;
            case WHITE:
                this.glowWhite();
        }
    }

    private function setColor(param1:String):void {
        if (this._color != param1) {
            this._color = param1;
            gotoAndStop(this._color);
            this.setLabel();
        }
    }

    private function setLabel():void {
        this.text.htmlText = this._label;
        this.text.autoSize = TextFieldAutoSize.LEFT;
    }

    public function get label():String {
        return this._label;
    }

    public function set label(param1:String):void {
        this._label = param1;
        this.setLabel();
    }
}
}
