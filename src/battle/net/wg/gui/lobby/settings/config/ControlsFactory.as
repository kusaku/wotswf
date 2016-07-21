package net.wg.gui.lobby.settings.config {
import net.wg.data.constants.Values;
import net.wg.gui.lobby.settings.vo.SettingsControlProp;

public class ControlsFactory {

    public static var TYPE_CHECKBOX:String = "Checkbox";

    public static var TYPE_SLIDER:String = "Slider";

    public static var TYPE_STEP_SLIDER:String = "StepSlider";

    public static var TYPE_RANGE_SLIDER:String = "RangeSlider";

    public static var TYPE_DROPDOWN:String = "DropDown";

    public static var TYPE_BUTTON_BAR:String = "ButtonBar";

    public static var TYPE_LABEL:String = "Label";

    public static var TYPE_VALUE:String = "Value";

    public static var TYPE_KEYINPUT:String = "KeyInput";

    private static var _instance:ControlsFactory = null;

    private var _currentVal = null;

    private var _optionsVal:Array = null;

    private var _typeVal:String = "";

    private var _hasLabelVal:Boolean = false;

    private var _hasValueVal:Boolean = false;

    private var _isDependOnVal:String = null;

    private var _readOnlyVal:Boolean = false;

    private var _advancedVal:Boolean = false;

    private var _prevValVal = null;

    private var _isDataAsSelectedIndexVal:Boolean = false;

    private var _defaultVal = null;

    public function ControlsFactory(param1:PrivateClass) {
        super();
    }

    public static function get instance():ControlsFactory {
        if (_instance == null) {
            _instance = new ControlsFactory(new PrivateClass());
        }
        return _instance;
    }

    public function advanced(param1:Boolean):ControlsFactory {
        this._advancedVal = param1;
        return this;
    }

    public function build():SettingsControlProp {
        App.utils.asserter.assert(this._typeVal != Values.EMPTY_STR, "ControlFactory: type of new control is empty.");
        var _loc1_:SettingsControlProp = null;
        _loc1_ = new SettingsControlProp(this._currentVal, this._optionsVal, this._typeVal, this._hasLabelVal, this._hasValueVal, this._isDependOnVal, this._readOnlyVal, this._advancedVal, this._prevValVal, this._isDataAsSelectedIndexVal, this._defaultVal);
        this.refresh();
        return _loc1_;
    }

    public function createControl(param1:String):ControlsFactory {
        this._typeVal = param1;
        return this;
    }

    public function current(param1:*):ControlsFactory {
        this._currentVal = param1;
        return this;
    }

    public function defaultVal(param1:*):ControlsFactory {
        this._defaultVal = param1;
        return this;
    }

    public function hasLabel(param1:Boolean):ControlsFactory {
        this._hasLabelVal = param1;
        return this;
    }

    public function hasValue(param1:Boolean):ControlsFactory {
        this._hasValueVal = param1;
        return this;
    }

    public function isDataAsSelectedIndex(param1:Boolean):ControlsFactory {
        this._isDataAsSelectedIndexVal = param1;
        return this;
    }

    public function isDependOn(param1:String):ControlsFactory {
        this._isDependOnVal = param1;
        return this;
    }

    public function options(param1:Array):ControlsFactory {
        this._optionsVal = param1;
        return this;
    }

    public function prevVal(param1:*):ControlsFactory {
        this._prevValVal = param1;
        return this;
    }

    public function readOnly(param1:Boolean):ControlsFactory {
        this._readOnlyVal = param1;
        return this;
    }

    public function type(param1:String):ControlsFactory {
        this._typeVal = param1;
        return this;
    }

    private function refresh():void {
        this._currentVal = null;
        App.utils.data.cleanupDynamicObject(this._optionsVal);
        this._optionsVal = null;
        this._typeVal = Values.EMPTY_STR;
        this._hasLabelVal = false;
        this._hasValueVal = false;
        this._isDependOnVal = null;
        this._readOnlyVal = false;
        this._advancedVal = false;
        this._prevValVal = null;
        this._isDataAsSelectedIndexVal = false;
        this._defaultVal = null;
    }
}
}

class PrivateClass {

    function PrivateClass() {
        super();
    }
}
