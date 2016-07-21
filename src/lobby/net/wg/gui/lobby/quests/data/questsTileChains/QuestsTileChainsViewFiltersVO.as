package net.wg.gui.lobby.quests.data.questsTileChains {
import net.wg.data.daapi.base.DAAPIDataClass;

public class QuestsTileChainsViewFiltersVO extends DAAPIDataClass {

    public var filtersLabel:String = "";

    public var vehicleTypeFilterData:Array = null;

    public var showVehicleTypeFilterData:Boolean = true;

    public var taskTypeFilterData:Array = null;

    public var defVehicleType:int = -1;

    public var defTaskType:int = -1;

    public function QuestsTileChainsViewFiltersVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.vehicleTypeFilterData.splice(0, this.vehicleTypeFilterData.length);
        this.vehicleTypeFilterData = null;
        this.taskTypeFilterData.splice(0, this.taskTypeFilterData.length);
        this.taskTypeFilterData = null;
        super.onDispose();
    }
}
}
