package net.wg.gui.lobby.fortifications.data.settings {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortSettingsBlockVO extends DAAPIDataClass {

    public var blockBtnEnabled:Boolean = true;

    public var blockBtnToolTip:String = "";

    public var daysBeforeVacation:int = -1;

    public var blockCondition:String = "";

    public var alertMessage:String = "";

    public var blockDescr:String = "";

    public var descriptionTooltip:String = "";

    public function FortSettingsBlockVO(param1:Object) {
        super(param1);
    }
}
}
