package net.wg.gui.battle.falloutClassic.components.fullStats {
import net.wg.data.VO.daapi.DAAPIFalloutVehicleStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInteractiveStatsVO;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.falloutClassic.components.fullStats.tableItem.FCStatsItem;
import net.wg.gui.battle.falloutClassic.components.fullStats.tableItem.FCStatsItemHolder;
import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemPositionController;

public class FCStatsTableController extends StatsTableControllerBase {

    private static const RIGHT_COLUMN:int = 1;

    private static const ITEM_ALLY_X:Number = 0;

    private static const ITEM_ENEMY_X:Number = 513;

    private static const ITEM_HEIGHT:Number = 25;

    private var _table:FCStatsTable = null;

    public function FCStatsTableController(param1:FCStatsTable) {
        super();
        this._table = param1;
        this._table.selfBgLeft.visible = false;
        this._table.selfBgLeft.imageName = BattleAtlasItem.FC_STATS_SELF_BG;
        this._table.selfBgRight.visible = false;
        this._table.selfBgRight.imageName = BattleAtlasItem.FC_STATS_SELF_BG;
        init();
        this.setNoTranslate();
    }

    public function setVehiclesStats(param1:DAAPIVehiclesInteractiveStatsVO):void {
        var _loc2_:DAAPIFalloutVehicleStatsVO = null;
        var _loc3_:FCStatsItemHolder = null;
        for each(_loc2_ in param1.leftVehicleStats) {
            _loc3_ = this.getHolder(_loc2_.vehicleID);
            if (_loc3_) {
                _loc3_.setVehicleStats(_loc2_);
            }
        }
        for each(_loc2_ in param1.rightVehicleStats) {
            _loc3_ = this.getHolder(_loc2_.vehicleID);
            if (_loc3_) {
                _loc3_.setVehicleStats(_loc2_);
            }
        }
    }

    override protected function createItemHolder(param1:int, param2:int):StatsTableItemHolderBase {
        return new FCStatsItemHolder(this.createStatsItem(param1, param2));
    }

    override protected function createPositionController(param1:int, param2:int):StatsTableItemPositionController {
        var _loc3_:int = param1 * NUM_ITEM_ROWS + param2;
        var _loc4_:Number = param2 == RIGHT_COLUMN ? Number(ITEM_ENEMY_X) : Number(ITEM_ALLY_X);
        var _loc5_:Number = param2 * ITEM_HEIGHT;
        var _loc6_:StatsTableItemPositionController = new StatsTableItemPositionController(_loc4_, _loc5_, param1, param2, this._table.playerNameCollection[_loc3_], this._table.vehicleNameCollection[_loc3_], this._table.fragsCollection[_loc3_], this._table.deadBgCollection[_loc3_], this._table.scoreCollection[_loc3_], this._table.specialPointsCollection[_loc3_], this._table.damageCollection[_loc3_], this._table.deathsCollection[_loc3_], this._table.squadCollection[_loc3_], this._table.hitCollection[_loc3_]);
        _loc6_.setItemHeight(ITEM_HEIGHT);
        return _loc6_;
    }

    override protected function setSelectedItem(param1:int, param2:int):void {
        if (param1 == RIGHT_COLUMN) {
            this._table.selfBgRight.y = param2 * ITEM_HEIGHT;
            this._table.selfBgRight.visible = true;
            this._table.selfBgLeft.visible = false;
        }
        else {
            this._table.selfBgLeft.y = param2 * ITEM_HEIGHT;
            this._table.selfBgLeft.visible = true;
            this._table.selfBgRight.visible = false;
        }
    }

    override protected function onDispose():void {
        this._table = null;
        super.onDispose();
    }

    private function createStatsItem(param1:int, param2:int):FCStatsItem {
        var _loc3_:int = param1 * NUM_ITEM_ROWS + param2;
        return new FCStatsItem(this._table.playerNameCollection[_loc3_], this._table.vehicleNameCollection[_loc3_], this._table.fragsCollection[_loc3_], this._table.vehicleTypeCollection[_loc3_], this._table.deadBgCollection[_loc3_], this._table.icoIGRCollection[_loc3_], this._table.scoreCollection[_loc3_], this._table.damageCollection[_loc3_], this._table.deathsCollection[_loc3_], this._table.specialPointsCollection[_loc3_]);
    }

    private function setNoTranslate():void {
        setNoTranslateForCollection(this._table.damageCollection);
        setNoTranslateForCollection(this._table.deathsCollection);
        setNoTranslateForCollection(this._table.fragsCollection);
        setNoTranslateForCollection(this._table.playerNameCollection);
        setNoTranslateForCollection(this._table.scoreCollection);
        setNoTranslateForCollection(this._table.specialPointsCollection);
    }

    private function getHolder(param1:Number):FCStatsItemHolder {
        return getItemByVehicleID(param1) as FCStatsItemHolder;
    }
}
}
