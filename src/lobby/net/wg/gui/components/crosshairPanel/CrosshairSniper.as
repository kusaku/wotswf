package net.wg.gui.components.crosshairPanel {
import flash.text.TextField;

public class CrosshairSniper extends CrosshairBase {

    private static const ZOOM_VALIDATION:String = "zoom";

    public var zoomTF:TextField = null;

    protected var _zoomIndicatorAlphaValue:Number = 1;

    private var _zoomStr:String = "";

    public function CrosshairSniper() {
        super();
    }

    override public function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number):void {
        this._zoomIndicatorAlphaValue = param7;
        super.setComponentsAlpha(param1, param2, param3, param4, param5, param6, param7);
    }

    override public function setZoom(param1:String):void {
        this._zoomStr = param1;
        invalidate(ZOOM_VALIDATION);
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(ZOOM_VALIDATION)) {
            this.zoomTF.text = this._zoomStr;
        }
        if (isInvalid(ALPHA_VALIDATION)) {
            this.zoomTF.alpha = this._zoomIndicatorAlphaValue;
        }
    }

    override protected function onDispose():void {
        this.zoomTF = null;
        super.onDispose();
    }
}
}
