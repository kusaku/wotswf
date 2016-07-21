package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FormationAppointmentVO extends DAAPIDataClass {

    public var memberType:int = -1;

    public var canPromoted:Boolean = false;

    public var canDemoted:Boolean = false;

    public var promoteBtnIcon:String = "";

    public var officerIcon:String = "";

    public var demoteBtnIcon:String = "";

    public var ownerIcon:String = "";

    public var ownerIconTooltip:String = "";

    public var officerIconTooltip:String = "";

    public var promoteBtnTooltip:String = "";

    public var demoteBtnTooltip:String = "";

    public function FormationAppointmentVO(param1:Object) {
        super(param1);
    }
}
}
