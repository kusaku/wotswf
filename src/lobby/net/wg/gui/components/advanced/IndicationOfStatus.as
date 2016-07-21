package net.wg.gui.components.advanced {
import scaleform.clik.constants.InvalidationType;
import scaleform.clik.core.UIComponent;

public class IndicationOfStatus extends UIComponent {

    public static var STATUS_NORMAL:String = "normal";

    public static var STATUS_CANCELED:String = "canceled";

    public static var STATUS_READY:String = "ready";

    public static var STATUS_IN_BATTLE:String = "inBattle";

    public static var STATUS_LOCKED:String = "locked";

    private var _status:String;

    public function IndicationOfStatus() {
        this._status = STATUS_NORMAL;
        super();
    }

    override protected function configUI():void {
        super.configUI();
    }

    override protected function draw():void {
        super.draw();
        if (isInvalid(InvalidationType.DATA)) {
            gotoAndStop(this._status);
            if (_baseDisposed) {
                return;
            }
        }
    }

    public function set status(param1:String):void {
        if (!_labelHash[param1]) {
            DebugUtils.LOG_WARNING(this, "LABEL NAME IS INVALID:", param1);
            return;
        }
        this._status = param1;
        invalidateData();
    }

    public function get status():String {
        return this._status;
    }
}
}
