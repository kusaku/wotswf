package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationProfileButtonInfoVO extends DAAPIDataClass {

    public var buttonLabel:String = "";

    public var statusLbl:String = "";

    public var isTooltipStatus:Boolean = false;

    public var tooltipStatus:String = "";

    public var tooltipHeader:String = "";

    public var tooltipBody:String = "";

    public var enabled:Boolean = false;

    public var action:String = "";

    public function StaticFormationProfileButtonInfoVO(param1:Object) {
        super(param1);
    }
}
}
