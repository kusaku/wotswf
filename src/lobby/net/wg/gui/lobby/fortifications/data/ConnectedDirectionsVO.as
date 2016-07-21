package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ConnectedDirectionsVO extends DAAPIDataClass {

    private static const FIELD_LEFT_DIRECTION:String = "leftDirection";

    private static const FIELD_RIGHT_DIRECTION:String = "rightDirection";

    public var connectionIcon:String = "";

    public var connectionIconTooltip:String = "";

    private var _leftDirection:DirectionVO;

    private var _rightDirection:DirectionVO;

    public function ConnectedDirectionsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == FIELD_LEFT_DIRECTION) {
            this._leftDirection = new DirectionVO(param2);
            return false;
        }
        if (param1 == FIELD_RIGHT_DIRECTION) {
            this._rightDirection = new DirectionVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this._leftDirection) {
            this._leftDirection.dispose();
            this._leftDirection = null;
        }
        if (this._rightDirection) {
            this._rightDirection.dispose();
            this._rightDirection = null;
        }
        super.onDispose();
    }

    public function get leftDirection():DirectionVO {
        return this._leftDirection;
    }

    public function get rightDirection():DirectionVO {
        return this._rightDirection;
    }
}
}
