package net.wg.gui.lobby.fortifications.data.demountBuilding {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortDemountBuildingVO extends DAAPIDataClass {

    public var headerQuestion:String = "";

    public var applyButtonLbl:String = "";

    public var cancelButtonLbl:String = "";

    public var bodyText:String = "";

    public var windowTitle:String = "";

    public function FortDemountBuildingVO(param1:Object) {
        super(param1);
    }
}
}
