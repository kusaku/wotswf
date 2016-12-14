package net.wg.gui.battle.falloutClassic.components.fullStats {
import net.wg.data.VO.daapi.DAAPIFalloutVehicleStatsVO;
import net.wg.data.VO.daapi.DAAPIVehiclesInteractiveStatsVO;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.falloutClassic.components.fullStats.tableItem.FCStatsItem;
import net.wg.gui.battle.falloutClassic.components.fullStats.tableItem.FCStatsItemHolder;
import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;

public class FCStatsTableController extends StatsTableControllerBase {

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

    override protected function setSelectedItem(param1:Boolean, param2:int):void {
        if (param1) {
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
        return null;
    }
}
}
