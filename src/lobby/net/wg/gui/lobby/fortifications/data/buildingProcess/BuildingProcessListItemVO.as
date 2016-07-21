package net.wg.gui.lobby.fortifications.data.buildingProcess {
import net.wg.data.daapi.base.DAAPIDataClass;

public class BuildingProcessListItemVO extends DAAPIDataClass {

    public var buildingID:String = "";

    public var buildingName:String = "";

    public var buildingIcon:String = "";

    public var shortDescr:String = "";

    public var statusLbl:String = "";

    public var buildingStatus:int = -1;

    public var isNewItem:Boolean = false;

    public function BuildingProcessListItemVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.buildingID = null;
        this.buildingName = null;
        this.shortDescr = null;
        this.statusLbl = null;
        this.buildingIcon = null;
        super.onDispose();
    }
}
}
