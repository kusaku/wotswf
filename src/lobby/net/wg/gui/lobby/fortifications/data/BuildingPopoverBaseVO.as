package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class BuildingPopoverBaseVO extends DAAPIDataClass {

    public var buildingType:String = "";

    public var isVisibleDemountBtn:Boolean = false;

    public function BuildingPopoverBaseVO(param1:Object) {
        super(param1);
    }
}
}
