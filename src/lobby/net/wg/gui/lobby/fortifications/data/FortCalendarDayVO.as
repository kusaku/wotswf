package net.wg.gui.lobby.fortifications.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.interfaces.ICalendarDayVO;

public class FortCalendarDayVO extends DAAPIDataClass implements ICalendarDayVO {

    private static const RAW_DATE_FIELD:String = "rawDate";

    public var rawDate:Number = NaN;

    private var _available:Boolean = true;

    private var _tooltipHeader:String = "";

    private var _tooltipBody:String = "";

    private var _iconSource:String = "";

    private var parsedDate:Date;

    public function FortCalendarDayVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Number = NaN;
        if (param1 == RAW_DATE_FIELD) {
            _loc3_ = Number(param2);
            App.utils.asserter.assert(!isNaN(_loc3_), "time" + Errors.CANT_NAN);
            this.parsedDate = App.utils.dateTime.fromPyTimestamp(_loc3_);
        }
        return true;
    }

    public function get date():Date {
        return this.parsedDate;
    }

    public function get available():Boolean {
        return this._available;
    }

    public function set available(param1:Boolean):void {
        this._available = param1;
    }

    public function get tooltipHeader():String {
        return this._tooltipHeader;
    }

    public function set tooltipHeader(param1:String):void {
        this._tooltipHeader = param1;
    }

    public function get tooltipBody():String {
        return this._tooltipBody;
    }

    public function set tooltipBody(param1:String):void {
        this._tooltipBody = param1;
    }

    public function get iconSource():String {
        return this._iconSource;
    }

    public function set iconSource(param1:String):void {
        this._iconSource = param1;
    }
}
}
