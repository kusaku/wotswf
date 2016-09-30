package net.wg.infrastructure.managers.counter {
import net.wg.data.constants.Linkages;
import net.wg.utils.ICounterProps;

public class CounterProps implements ICounterProps {

    public static const DEFAULT_LINKAGE:String = Linkages.COUNTER_UI;

    public static const DEFAULT_OFFSET_X:int = 2;

    public static const DEFAULT_OFFSET_Y:int = 2;

    public static const DEFAULT_TF_PADDING:int = 15;

    public static const DEFAULT_PROPS:CounterProps = new CounterProps();

    private var _offsetX:int = 0;

    private var _offsetY:int = 0;

    private var _addToTop:Boolean = true;

    private var _linkage:String = null;

    private var _horizontalAlign:String = null;

    private var _tfPadding:int = 0;

    public function CounterProps(param1:int = 2, param2:int = 2, param3:String = "left", param4:Boolean = true, param5:String = "CounterUI", param6:int = 15) {
        super();
        this._offsetX = param1;
        this._offsetY = param2;
        this._addToTop = param4;
        this._linkage = param5;
        this._tfPadding = param6;
        this._horizontalAlign = param3;
    }

    public function get offsetX():int {
        return this._offsetX;
    }

    public function get offsetY():int {
        return this._offsetY;
    }

    public function get tfPadding():int {
        return this._tfPadding;
    }

    public function get addToTop():Boolean {
        return this._addToTop;
    }

    public function get linkage():String {
        return this._linkage;
    }

    public function get horizontalAlign():String {
        return this._horizontalAlign;
    }
}
}
