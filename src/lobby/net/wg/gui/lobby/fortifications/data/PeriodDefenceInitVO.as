package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class PeriodDefenceInitVO extends DAAPIDataClass {

    public var windowLbl:String = "";

    public var headerLbl:String = "";

    public var peripheryLbl:String = "";

    public var peripheryDescr:String = "";

    public var hourDefenceLbl:String = "";

    public var hourDefenceDescr:String = "";

    public var holidayLbl:String = "";

    public var holidayDescr:String = "";

    public var acceptBtn:String = "";

    public var cancelBtn:String = "";

    public var acceptBtnEnabledTooltip:String = "";

    public var acceptBtnDisabledTooltip:String = "";

    public var cancelBtnTooltip:String = "";

    public function PeriodDefenceInitVO(param1:Object) {
        super(param1);
    }
}
}
