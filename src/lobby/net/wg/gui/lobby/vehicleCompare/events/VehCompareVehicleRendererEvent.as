package net.wg.gui.lobby.vehicleCompare.events {
import flash.events.Event;

public class VehCompareVehicleRendererEvent extends Event {

    public static const GO_TO_PREVIEW_CLICK:String = "GoToPreviewClick";

    public static const GO_TO_HANGAR_CLICK:String = "GoToHangarClick";

    public static const MODULES_CLICK:String = "ModulesClick";

    public static const REMOVE_CLICK:String = "RemoveClick";

    public static const RIGHT_CLICK:String = "RRightClick";

    public static const CREW_LEVEL_CHANGED:String = "CrewLevelChanged";

    private var _vehId:int = -1;

    private var _crewLevelId:int = -1;

    private var _index:int = -1;

    public function VehCompareVehicleRendererEvent(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false) {
        super(param2, param3, param4);
        this._vehId = param1;
    }

    public function get vehId():int {
        return this._vehId;
    }

    public function get crewLevelId():int {
        return this._crewLevelId;
    }

    public function set crewLevelId(param1:int):void {
        this._crewLevelId = param1;
    }

    public function get index():int {
        return this._index;
    }

    public function set index(param1:int):void {
        this._index = param1;
    }
}
}
