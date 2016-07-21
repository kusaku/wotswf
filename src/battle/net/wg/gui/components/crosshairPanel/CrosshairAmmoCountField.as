package net.wg.gui.components.crosshairPanel {
import flash.text.TextField;

import net.wg.infrastructure.base.SimpleContainer;

public class CrosshairAmmoCountField extends SimpleContainer {

    private static const DATA_VALIDATION:String = "data";

    private static const STATE_VALIDATION:String = "state";

    public var ammoLowTextField:TextField = null;

    public var ammoNormalTextField:TextField = null;

    private var _currentTextField:TextField = null;

    private var _count:Number = -1;

    private var _isLow:Boolean = false;

    public function CrosshairAmmoCountField() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.ammoLowTextField.visible = false;
        this.ammoNormalTextField.visible = true;
    }

    override protected function onDispose():void {
        this._currentTextField = null;
        this.ammoLowTextField = null;
        this.ammoNormalTextField = null;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(STATE_VALIDATION)) {
            if (this._currentTextField) {
                this._currentTextField.visible = false;
            }
            this._currentTextField = !!this._isLow ? this.ammoLowTextField : this.ammoNormalTextField;
            this._currentTextField.visible = true;
            invalidate(DATA_VALIDATION);
        }
        if (isInvalid(DATA_VALIDATION)) {
            this._currentTextField.text = this._count.toString();
        }
    }

    public function setCount(param1:Number):void {
        if (this._count != param1) {
            this._count = param1;
            invalidate(DATA_VALIDATION);
        }
    }

    public function set isLow(param1:Boolean):void {
        this._isLow = param1;
        invalidate(STATE_VALIDATION);
    }
}
}
