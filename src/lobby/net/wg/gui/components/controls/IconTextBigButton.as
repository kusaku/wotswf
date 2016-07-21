package net.wg.gui.components.controls {
import flash.text.TextField;

import net.wg.data.constants.Values;

import scaleform.clik.utils.Constraints;

public class IconTextBigButton extends SoundButtonEx {

    public var textFieldWithoutIcon:TextField = null;

    private var _htmlIconStr:String = "";

    public function IconTextBigButton() {
        super();
    }

    override protected function onDispose():void {
        this.textFieldWithoutIcon = null;
        super.onDispose();
    }

    override protected function updateAfterStateChange():void {
        super.updateAfterStateChange();
        if (!initialized) {
            return;
        }
        if (constraints != null && !constraintsDisabled && this.textFieldWithoutIcon != null) {
            constraints.updateElement("textFieldWithoutIcon", this.textFieldWithoutIcon);
        }
    }

    override protected function configUI():void {
        super.configUI();
        if (!constraintsDisabled) {
            if (this.textFieldWithoutIcon != null) {
                constraints.addElement("textFieldWithoutIcon", this.textFieldWithoutIcon, Constraints.ALL);
            }
        }
        if (this.textFieldWithoutIcon) {
            this.textFieldWithoutIcon.mouseEnabled = false;
        }
    }

    override protected function updateText():void {
        this.textFieldWithoutIcon.visible = this.htmlIconStr == Values.EMPTY_STR;
        textField.visible = !this.textFieldWithoutIcon.visible;
        if (textField.visible) {
            textField.htmlText = this.htmlIconStr + _label;
        }
        else {
            this.textFieldWithoutIcon.htmlText = _label;
        }
    }

    override public function set label(param1:String):void {
        param1 = App.utils.locale.makeString(param1);
        super.label = param1;
    }

    public function get htmlIconStr():String {
        return this._htmlIconStr;
    }

    public function set htmlIconStr(param1:String):void {
        this._htmlIconStr = param1;
        invalidateData();
    }
}
}
