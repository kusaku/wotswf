package net.wg.gui.components.controls {
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import net.wg.data.constants.ComponentState;
import net.wg.data.constants.Linkages;

import scaleform.clik.constants.InvalidationType;
import scaleform.clik.controls.Label;
import scaleform.clik.core.UIComponent;

public class LabelControl extends Label {

    public var hitMc:Sprite = null;

    protected var _textAlign:String = "none";

    private var _tooltip:String = "";

    private const INFO_INV:String = "infoInv";

    private var _infoIcoType:String = "";

    private var _infoIco:InfoIcon = null;

    protected var _owner:UIComponent = null;

    public function LabelControl() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.hitArea = this.hitMc;
        textField.mouseEnabled = false;
    }

    override protected function onDispose():void {
        if (this._infoIco) {
            this.removeInfoIco();
        }
        this.hitMc = null;
        this._owner = null;
        super.onDispose();
    }

    public function set textAlign(param1:String):void {
        if (this._textAlign == param1) {
            return;
        }
        this._textAlign = param1;
        invalidateData();
    }

    public function get textAlign():String {
        return this._textAlign;
    }

    override protected function updateText():void {
        var _loc1_:TextFormat = null;
        super.updateText();
        if (_text != null && textField != null) {
            _loc1_ = textField.getTextFormat();
            _loc1_.align = this._textAlign;
            textField.setTextFormat(_loc1_);
            textField.alpha = state == ComponentState.DISABLED ? Number(0.5) : Number(1);
        }
    }

    public function set toolTip(param1:String):void {
        if (param1 && param1 != this._tooltip) {
            this._tooltip = param1;
            invalidate(this.INFO_INV);
        }
    }

    public function get toolTip():String {
        return this._tooltip;
    }

    public function set infoIcoType(param1:String):void {
        if (param1 == this._infoIcoType) {
            return;
        }
        this._infoIcoType = param1;
        invalidate(this.INFO_INV);
    }

    public function get infoIcoType():String {
        return this._infoIcoType;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(this.INFO_INV)) {
            if (this._infoIcoType != "" && this._tooltip != "") {
                if (!this._infoIco) {
                    this.createInfoIco();
                }
                this._infoIco.tooltip = this._tooltip;
                this._infoIco.icoType = this._infoIcoType;
                this.repositionInfoIcon();
            }
            else {
                this.removeInfoIco();
            }
        }
        if (isInvalid(InvalidationType.SIZE)) {
            setActualSize(_width, _height);
            if (!constraintsDisabled) {
                constraints.update(_width, _height);
            }
            this.updateHitArea();
        }
    }

    private function updateHitArea():void {
        var _loc1_:Number = NaN;
        if (this.hitMc && textField) {
            _loc1_ = textField.textWidth * textField.scaleX;
            this.hitMc.x = this.textAlign == TextFieldAutoSize.LEFT || this.textAlign == TextFieldAutoSize.NONE ? Number(textField.x) : Number(textField.x + textField.width - _loc1_);
            this.hitMc.width = _loc1_;
        }
    }

    private function createInfoIco():void {
        if (!this.owner && parent) {
            this.owner = parent as UIComponent;
        }
        this._infoIco = InfoIcon(App.utils.classFactory.getComponent(Linkages.INFO_ICON_UI, InfoIcon));
        this.owner.addChild(this._infoIco);
    }

    private function removeInfoIco():void {
        if (this._infoIco) {
            this._infoIco.dispose();
            this.owner.removeChild(this._infoIco);
            this._infoIco = null;
        }
    }

    private function repositionInfoIcon():void {
        if (this._infoIco) {
            this._infoIco.x = this.x + textField.x + textField.textWidth + InfoIcon.LABEL_MARGIN | 0;
            this._infoIco.y = this.y + (textField.y + textField.height >> 1) - 1;
        }
    }

    public function get owner():UIComponent {
        return this._owner;
    }

    public function set owner(param1:UIComponent):void {
        this._owner = param1;
    }
}
}
