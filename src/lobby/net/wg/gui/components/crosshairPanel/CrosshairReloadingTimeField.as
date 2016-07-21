package net.wg.gui.components.crosshairPanel {
import flash.external.ExternalInterface;
import flash.text.TextField;

import net.wg.data.constants.Values;
import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
import net.wg.infrastructure.base.SimpleContainer;

public class CrosshairReloadingTimeField extends SimpleContainer {

    private static const DATA_VALIDATION:String = "data";

    private static const ALPHA_VALIDATION:String = "alpha";

    private static const STATE_VALIDATION:String = "state";

    private static const FRACTIONAL_FORMAT_CMD:String = "WG.getFractionalFormat";

    public var timerProgressTextField:TextField = null;

    public var timerCompleteTextField:TextField = null;

    private var _currentTextField:TextField = null;

    private var _alpha:Number = 1;

    private var _time:Number = -1;

    private var _isInProgress:Boolean = false;

    public function CrosshairReloadingTimeField() {
        super();
    }

    override protected function configUI():void {
        super.configUI();
        this.timerProgressTextField.visible = false;
        this.timerCompleteTextField.visible = true;
    }

    override protected function onDispose():void {
        this._currentTextField = null;
        this.timerProgressTextField = null;
        this.timerCompleteTextField = null;
        super.onDispose();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(STATE_VALIDATION)) {
            if (this._currentTextField) {
                this._currentTextField.visible = false;
            }
            this._currentTextField = !!this._isInProgress ? this.timerProgressTextField : this.timerCompleteTextField;
            this._currentTextField.visible = true;
            invalidate(DATA_VALIDATION);
            invalidate(ALPHA_VALIDATION);
        }
        if (isInvalid(DATA_VALIDATION)) {
            if (this._time != Values.DEFAULT_INT) {
                this._currentTextField.text = ExternalInterface.call.apply(this, [FRACTIONAL_FORMAT_CMD, Number(this._time)]);
            }
        }
        if (isInvalid(ALPHA_VALIDATION)) {
            if (this._currentTextField) {
                this._currentTextField.alpha = this._alpha;
            }
        }
    }

    public function setAlpha(param1:Number):void {
        if (this._alpha != param1) {
            this._alpha = param1;
            invalidate(ALPHA_VALIDATION);
        }
    }

    public function updateTime(param1:Number):void {
        if (this._time != param1) {
            this._time = param1;
            invalidate(DATA_VALIDATION);
        }
    }

    public function setReloadingState(param1:String):void {
        this._isInProgress = !(param1 == CrosshairConsts.RELOADING_ENDED || param1 == CrosshairConsts.RELOADING_END);
        invalidate(STATE_VALIDATION);
    }
}
}
