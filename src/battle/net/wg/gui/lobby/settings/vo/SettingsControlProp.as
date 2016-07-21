package net.wg.gui.lobby.settings.vo {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class SettingsControlProp implements IDisposable {

    public static const EXTRA_DATA_LBL:String = "extraData";

    public static const ADVANCED_LBL:String = "advanced";

    public static const OPTIONS_LBL:String = "options";

    public static const DEFAULT_LBL:String = "default";

    public var defaultValue = null;

    public var options:Array = null;

    public var type:String = null;

    public var hasLabel:Boolean = false;

    public var hasValue:Boolean = false;

    public var isDependOn:String = null;

    public var readOnly:Boolean = false;

    public var advanced:Boolean = false;

    public var extraData:Object = null;

    public var prevVal = null;

    public var changedVal = null;

    public var isDataAsSelectedIndex:Boolean = false;

    private var _current = null;

    public function SettingsControlProp(param1:* = null, param2:Array = null, param3:String = null, param4:Boolean = false, param5:Boolean = false, param6:String = null, param7:Boolean = false, param8:Boolean = false, param9:* = null, param10:Boolean = false, param11:* = null, param12:Object = null) {
        super();
        this.current = param1;
        this.options = !!param2 ? param2 : [];
        this.type = param3;
        this.hasLabel = param4;
        this.hasValue = param5;
        this.isDependOn = param6;
        this.readOnly = param7;
        this.advanced = param8;
        this.prevVal = param9;
        this.changedVal = param1;
        this.isDataAsSelectedIndex = param10;
        this.extraData = param12;
        this.defaultValue = param11;
    }

    public function clone():SettingsControlProp {
        return new SettingsControlProp(this.current, this.options, this.type, this.hasLabel, this.hasValue, this.isDependOn, this.readOnly, this.advanced, this.prevVal, this.isDataAsSelectedIndex, this.defaultValue, this.extraData);
    }

    public function dispose():void {
        if (this.options != null) {
            this.options.splice(0, this.options.length);
            this.options = null;
        }
        if (this.extraData != null) {
            this.extraData = App.utils.data.cleanupDynamicObject(this.extraData);
        }
    }

    public function traceValues():void {
    }

    public function get current():* {
        return this._current;
    }

    public function set current(param1:*):void {
        this.changedVal = param1;
        if (this._current === param1) {
            return;
        }
        this._current = param1;
    }
}
}
