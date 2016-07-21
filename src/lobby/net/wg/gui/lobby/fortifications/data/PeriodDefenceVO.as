package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class PeriodDefenceVO extends DAAPIDataClass {

    public var peripherySelectedID:int = -1;

    public var holidaySelectedID:int = -1;

    public var hour:int = -1;

    public var minutes:int = -1;

    public var isTwelveHoursFormat:Boolean = false;

    public var isWrongLocalTime:Boolean = false;

    public var skipValues:Array;

    public var peripheryData:Array = null;

    public var holidayData:Array = null;

    public function PeriodDefenceVO(param1:Object) {
        this.skipValues = [];
        super(param1);
    }

    override protected function onDispose():void {
        this.skipValues.splice(0, this.skipValues.length);
        this.skipValues = null;
        this.peripheryData.splice(0, this.peripheryData.length);
        this.peripheryData = null;
        this.holidayData.splice(0, this.holidayData.length);
        this.holidayData = null;
        super.onDispose();
    }
}
}
