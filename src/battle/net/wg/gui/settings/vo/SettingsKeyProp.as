package net.wg.gui.settings.vo {
import net.wg.gui.settings.config.SettingsConfigHelper;
import net.wg.utils.ILocale;

public class SettingsKeyProp {

    public var id:String = null;

    public var header:Boolean = false;

    public var label:String = null;

    public var command:String = null;

    public var key:Number = NaN;

    public var keyDefault:Number = NaN;

    public var keysRang:Array;

    public var showUnderline:Boolean = false;

    public var rendererYOffset:Number = 0;

    public function SettingsKeyProp(param1:String, param2:Boolean, param3:String, param4:String = null, param5:Number = NaN, param6:Number = NaN, param7:Array = null, param8:Boolean = false, param9:Number = 0) {
        var _loc11_:int = 0;
        var _loc12_:ILocale = null;
        var _loc13_:uint = 0;
        var _loc14_:String = null;
        var _loc15_:String = null;
        super();
        this.id = param1;
        this.header = param2;
        this.keysRang = !!SettingsConfigHelper.KEY_RANGE.hasOwnProperty(param1) ? SettingsConfigHelper.KEY_RANGE[param1] : SettingsConfigHelper.KEY_RANGE["defaultRange"];
        var _loc10_:String = null;
        _loc10_ = null;
        if (param7) {
            _loc11_ = param7.length;
            if (_loc11_) {
                _loc10_ = "";
                _loc12_ = App.utils.locale;
                _loc13_ = 0;
                while (_loc13_ < _loc11_) {
                    _loc14_ = _loc12_.makeString(param7[_loc13_].hasOwnProperty("header") && param7[_loc13_]["header"] != undefined ? param7[_loc13_]["header"] : "");
                    _loc15_ = _loc12_.makeString(param7[_loc13_].hasOwnProperty("label") && param7[_loc13_]["label"] != undefined ? param7[_loc13_]["label"] : "");
                    _loc10_ = _loc10_ + (_loc14_ + " <font size=\"11\" color=\"#615f4f\">" + _loc15_ + "</font><br/>");
                    _loc13_++;
                }
            }
        }
        if (_loc10_) {
            this.label = _loc10_;
        }
        else {
            this.label = App.utils.locale.makeString(!!this.header ? SETTINGS.keyboard_keysblocks_group(param3) : SETTINGS.keyboard_keysblocks_command(param3));
        }
        this.command = param4;
        this.key = param5;
        this.keyDefault = param6;
        this.showUnderline = param8;
        this.rendererYOffset = param9;
    }

    public function getObject():Object {
        return {
            "id": this.id,
            "header": this.header,
            "label": this.label,
            "command": this.command,
            "key": this.key,
            "keyDefault": this.keyDefault,
            "keysRang": this.keysRang,
            "showUnderline": this.showUnderline,
            "rendererYOffset": this.rendererYOffset
        };
    }
}
}