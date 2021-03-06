package net.wg.gui.components.controls {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

import net.wg.data.constants.SoundTypes;

import scaleform.clik.constants.InvalidationType;

public class DropDownListItemRendererSound extends SoundListItemRenderer {

    private static const TOOLTIP_FIELD:String = "tooltip";

    public var focusElement:MovieClip;

    private var _tooltip:String = null;

    public function DropDownListItemRendererSound() {
        super();
        soundType = SoundTypes.DROPDN_ITEM_RNDR;
    }

    override public function toString():String {
        return "[WG DropDownListItemRendererSound " + name + "]";
    }

    override protected function updateText():void {
        if (_label != null && textField != null) {
            textField.htmlText = _label;
        }
    }

    override protected function draw():void {
        var _loc1_:Point = null;
        if (isInvalid(InvalidationType.DATA)) {
            if (enabled) {
                _loc1_ = new Point(mouseX, mouseY);
                _loc1_ = this.localToGlobal(_loc1_);
                if (this.hitTestPoint(_loc1_.x, _loc1_.y, true)) {
                    setState("over");
                    dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                }
            }
        }
        super.draw();
    }

    override protected function configUI():void {
        if (this.focusElement) {
            focusIndicator = this.focusElement;
        }
        buttonMode = true;
        super.configUI();
    }

    override public function setData(param1:Object):void {
        if (_data == param1) {
            return;
        }
        App.toolTipMgr.hide();
        this._tooltip = !!param1.hasOwnProperty(TOOLTIP_FIELD) ? param1[TOOLTIP_FIELD] : null;
        this.data = param1;
    }

    override protected function handleMousePress(param1:MouseEvent):void {
        if (this._tooltip) {
            App.toolTipMgr.hide();
        }
        super.handleMousePress(param1);
    }

    override protected function handleMouseRollOver(param1:MouseEvent):void {
        if (this._tooltip) {
            App.toolTipMgr.showComplex(this._tooltip);
        }
        super.handleMouseRollOver(param1);
    }

    override protected function handleMouseRollOut(param1:MouseEvent):void {
        if (this._tooltip) {
            App.toolTipMgr.hide();
        }
        super.handleMouseRollOut(param1);
    }
}
}
