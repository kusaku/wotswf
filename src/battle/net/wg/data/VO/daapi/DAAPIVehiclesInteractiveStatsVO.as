package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIVehiclesInteractiveStatsVO extends DAAPIDataClass {

    public var leftVehicleStats:Vector.<DAAPIFalloutVehicleStatsVO> = null;

    public var rightVehicleStats:Vector.<DAAPIFalloutVehicleStatsVO> = null;

    public var leftItemsIDs:Vector.<Number> = null;

    public var rightItemsIDs:Vector.<Number> = null;

    public var totalStats:DAAPIFalloutTotalStatsVO = null;

    private const COND_LEFT_FIELD_NAME:String = "leftItems";

    private const COND_RIGHT_FIELD_NAME:String = "rightItems";

    private const TOTAL_STATS_FIELD_NAME:String = "totalStats";

    private const LEFT_ITEMS_IDS_FIELD_NAME:String = "leftItemsIDs";

    private const RIGHT_ITEMS_IDS_FIELD_NAME:String = "rightItemsIDs";

    public function DAAPIVehiclesInteractiveStatsVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case this.LEFT_ITEMS_IDS_FIELD_NAME:
                if (param2) {
                    this.leftItemsIDs = App.utils.data.convertNumberArrayToVector(param1, param2);
                }
                return false;
            case this.RIGHT_ITEMS_IDS_FIELD_NAME:
                if (param2) {
                    this.rightItemsIDs = App.utils.data.convertNumberArrayToVector(param1, param2);
                }
                return false;
            case this.COND_LEFT_FIELD_NAME:
                this.leftVehicleStats = Vector.<DAAPIFalloutVehicleStatsVO>(App.utils.data.convertVOArrayToVector(param1, param2, DAAPIFalloutVehicleStatsVO));
                return false;
            case this.COND_RIGHT_FIELD_NAME:
                this.rightVehicleStats = Vector.<DAAPIFalloutVehicleStatsVO>(App.utils.data.convertVOArrayToVector(param1, param2, DAAPIFalloutVehicleStatsVO));
                return false;
            case this.TOTAL_STATS_FIELD_NAME:
                this.totalStats = new DAAPIFalloutTotalStatsVO(param2);
                return false;
            default:
                return super.onDataWrite(param1, param2);
        }
    }

    override protected function onDispose():void {
        var _loc1_:DAAPIFalloutVehicleStatsVO = null;
        if (this.leftVehicleStats) {
            for each(_loc1_ in this.leftVehicleStats) {
                _loc1_.dispose();
            }
            this.leftVehicleStats.fixed = false;
            this.leftVehicleStats.splice(0, this.leftVehicleStats.length);
            this.leftVehicleStats = null;
        }
        if (this.rightVehicleStats) {
            for each(_loc1_ in this.rightVehicleStats) {
                _loc1_.dispose();
            }
            this.rightVehicleStats.fixed = false;
            this.rightVehicleStats.splice(0, this.rightVehicleStats.length);
            this.rightVehicleStats = null;
        }
        if (this.leftItemsIDs) {
            this.leftItemsIDs = null;
        }
        if (this.rightItemsIDs) {
            this.rightItemsIDs = null;
        }
        if (this.totalStats) {
            this.totalStats.dispose();
            this.totalStats = null;
        }
        super.onDispose();
    }
}
}
