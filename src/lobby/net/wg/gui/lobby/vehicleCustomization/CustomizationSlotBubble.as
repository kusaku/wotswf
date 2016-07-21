package net.wg.gui.lobby.vehicleCustomization {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.infrastructure.base.UIComponentEx;

public class CustomizationSlotBubble extends UIComponentEx {

    public var bubbleText:TextField = null;

    private var _isWasOccupied:Boolean = false;

    public function CustomizationSlotBubble() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.bubbleText.autoSize = TextFieldAutoSize.CENTER;
    }

    public function getText():String {
        return this.bubbleText.htmlText;
    }

    public function set text(param1:String):void {
        this.bubbleText.htmlText = param1;
    }

    public function get isWasOccupied():Boolean {
        return this._isWasOccupied;
    }

    public function set isWasOccupied(param1:Boolean):void {
        this._isWasOccupied = param1;
    }
}
}
