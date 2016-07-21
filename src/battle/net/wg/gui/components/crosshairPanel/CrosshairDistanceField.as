package net.wg.gui.components.crosshairPanel {
import flash.text.TextField;

import net.wg.infrastructure.base.SimpleContainer;

public class CrosshairDistanceField extends SimpleContainer {

    private static const DATA_VALIDATION:String = "data";

    public var distanceTF:TextField = null;

    private var _distance:String = "";

    public function CrosshairDistanceField() {
        super();
    }

    override protected function onDispose():void {
        this.distanceTF = null;
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(DATA_VALIDATION)) {
            this.distanceTF.text = this._distance;
        }
    }

    public function setDistance(param1:String):void {
        if (this._distance != param1) {
            this._distance = param1;
            invalidate(DATA_VALIDATION);
        }
    }
}
}
