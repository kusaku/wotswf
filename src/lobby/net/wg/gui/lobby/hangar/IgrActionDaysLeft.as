package net.wg.gui.lobby.hangar {
import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.wg.data.constants.Values;

import scaleform.clik.core.UIComponent;

public class IgrActionDaysLeft extends UIComponent {

    public var background:MovieClip = null;

    public var text:TextField = null;

    public function IgrActionDaysLeft() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        mouseEnabled = false;
        this.background.mouseChildren = false;
        this.background.mouseEnabled = false;
        this.text.autoSize = TextFieldAutoSize.CENTER;
    }

    public function updateText(param1:String):void {
        this.text.htmlText = param1;
        this.visible = param1 != null && param1 != Values.EMPTY_STR;
    }
}
}
