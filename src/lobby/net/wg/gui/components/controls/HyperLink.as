package net.wg.gui.components.controls {
import flash.text.TextFieldAutoSize;

import scaleform.clik.controls.Button;

public class HyperLink extends Button {

    private var _forceFocusView:Boolean = false;

    public function HyperLink() {
        super();
    }

    override protected function configUI():void {
        constraintsDisabled = true;
        preventAutosizing = true;
        super.configUI();
        mouseChildren = true;
        textField.mouseEnabled = true;
        App.utils.styleSheetManager.setLinkStyle(textField);
    }

    override protected function changeFocus():void {
        if (!enabled) {
            return;
        }
        this.forceFocusView = _focused > 0;
        if (_pressedByKeyboard && !_focused) {
            _pressedByKeyboard = false;
        }
    }

    override protected function updateText():void {
        var _loc1_:String = null;
        if (label != null && textField != null) {
            textField.text = label;
            _loc1_ = textField.text;
            if (this._forceFocusView) {
                _loc1_ = App.utils.styleSheetManager.setForceFocusedStyle(_loc1_);
            }
            textField.htmlText = "<a href=\'event:hyperLink\'>" + _loc1_ + "</a>";
            textField.width = textField.textWidth + 4 | 0;
            textField.autoSize = TextFieldAutoSize.LEFT;
            this.updatePosition();
        }
    }

    private function updatePosition():void {
        if (autoSize == TextFieldAutoSize.CENTER) {
            textField.x = -textField.width >> 1;
        }
        else if (autoSize == TextFieldAutoSize.RIGHT) {
            textField.x = -textField.width;
        }
    }

    override public function set autoSize(param1:String):void {
        super.autoSize = param1;
        this.updatePosition();
    }

    public function get forceFocusView():Boolean {
        return this._forceFocusView;
    }

    public function set forceFocusView(param1:Boolean):void {
        this._forceFocusView = param1;
        this.updateText();
    }
}
}
