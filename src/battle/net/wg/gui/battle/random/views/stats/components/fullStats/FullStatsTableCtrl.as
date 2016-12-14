package net.wg.gui.battle.random.views.stats.components.fullStats {
import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.battleloading.data.EnemyVehiclesDataProvider;
import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItem;
import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItemHolder;
import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
import net.wg.infrastructure.base.meta.impl.FullStatsMeta;

public class FullStatsTableCtrl extends StatsTableControllerBase implements ISquadHandler {

    private static const RIGHT_COLUMN:int = 1;

    private static const SQUAD_BT_LEFT_X:Number = 2;

    private static const SQUAD_BT_RIGHT_X:Number = 987;

    private static const ITEM_HEIGHT:Number = 25;

    private var _table:FullStatsTable = null;

    private var _squadHandler:FullStatsMeta = null;

    private var _isAllyInviteShown:Boolean = false;

    private var _isEnemyInviteShown:Boolean = false;

    private var _isAllyInteractive:Boolean = false;

    private var _isEnemyInteractive:Boolean = false;

    public function FullStatsTableCtrl(param1:FullStatsTable, param2:FullStatsMeta) {
        super();
        this._table = param1;
        this._squadHandler = param2;
        init();
        this.initCommonItems();
        this.setNoTranslate();
    }

    public function setVehiclesStats(param1:Vector.<DAAPIVehicleStatsVO>, param2:Vector.<DAAPIVehicleStatsVO>):void {
        var _loc3_:EnemyVehiclesDataProvider = _teamDP;
        if (_loc3_.updateFrags(param1)) {
            _loc3_.invalidate();
        }
        _loc3_ = _enemyDP;
        if (_loc3_.updateFrags(param2)) {
            _loc3_.invalidate();
        }
    }

    public function setIsInviteShown(param1:Boolean, param2:Boolean):void {
        var _loc3_:int = 0;
        if (this._isAllyInviteShown != param1) {
            _loc3_ = 0;
            while (_loc3_ < NUM_ITEM_ROWS) {
                this.setItemInviteShown(false, _loc3_, param1);
                _loc3_++;
            }
            this._isAllyInviteShown = param1;
        }
        if (this._isEnemyInviteShown != param2) {
            _loc3_ = 0;
            while (_loc3_ < NUM_ITEM_ROWS) {
                this.setItemInviteShown(true, _loc3_, param2);
                _loc3_++;
            }
            this._isEnemyInviteShown = param2;
        }
    }

    public function setInteractive(param1:Boolean, param2:Boolean):void {
        var _loc3_:int = 0;
        if (this._isAllyInteractive != param1) {
            _loc3_ = 0;
            while (_loc3_ < NUM_ITEM_ROWS) {
                this.setItemInteractive(false, _loc3_, param1);
                _loc3_++;
            }
            this._isAllyInteractive = param1;
        }
        if (this._isEnemyInteractive != param2) {
            _loc3_ = 0;
            while (_loc3_ < NUM_ITEM_ROWS) {
                this.setItemInteractive(true, _loc3_, param2);
                _loc3_++;
            }
            this._isEnemyInteractive = param2;
        }
    }

    public function updateInvitationsStatuses(param1:Boolean, param2:Vector.<DAAPIInvitationStatusVO>):void {
        var _loc3_:EnemyVehiclesDataProvider = !!param1 ? _enemyDP : _teamDP;
        if (_loc3_.updateInvitationsStatuses(param2)) {
            _loc3_.invalidate();
        }
    }

    public function setSpeaking(param1:Number, param2:Boolean):void {
        if (_teamDP.setSpeaking(param1, param2)) {
            _teamDP.invalidate();
        }
        else if (_enemyDP.setSpeaking(param1, param2)) {
            _enemyDP.invalidate();
        }
    }

    public function onAcceptSquad(param1:DynamicSquadCtrl):void {
        this._squadHandler.acceptSquadS(param1.uid);
    }

    public function onAddToSquad(param1:DynamicSquadCtrl):void {
        this._squadHandler.addToSquadS(param1.uid);
    }

    public function onSquadBtVisibleChange(param1:DynamicSquadCtrl):void {
        var _loc3_:Boolean = false;
        var _loc2_:int = -1;
        var _loc4_:int = 0;
        while (_loc4_ < NUM_ITEM_ROWS) {
            if (this.getHolderByIndex(false, _loc4_).squadItem == param1) {
                _loc2_ = _loc4_;
                break;
            }
            if (this.getHolderByIndex(true, _loc4_).squadItem == param1) {
                _loc2_ = _loc4_;
                _loc3_ = true;
                break;
            }
            _loc4_++;
        }
        if (_loc2_ != -1) {
            if (param1.isAcceptBtAvailable) {
                this._table.squadAcceptBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
                this._table.squadAcceptBt.y = _loc2_ * ITEM_HEIGHT;
                this._table.squadAcceptBt.visible = true;
            }
            else {
                this._table.squadAcceptBt.visible = false;
            }
            if (param1.isAddBtAvailable) {
                this._table.squadAddBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
                this._table.squadAddBt.y = _loc2_ * ITEM_HEIGHT;
                this._table.squadAddBt.visible = true;
            }
            else {
                this._table.squadAddBt.visible = false;
            }
        }
    }

    override protected function createItemHolder(param1:int, param2:int):StatsTableItemHolderBase {
        var _loc3_:StatsTableItem = this.createPlayerStatsItem(param1, param2);
        var _loc4_:DynamicSquadCtrl = this.createSquadItem(param1, param2);
        _loc4_.addActionHandler(this);
        return new StatsTableItemHolder(_loc3_, _loc4_, param1 == RIGHT_COLUMN);
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
        this._squadHandler = null;
        super.onDispose();
    }

    override protected function onItemDataSet(param1:StatsTableItemHolderBase, param2:Boolean):void {
        var _loc3_:StatsTableItemHolder = param1 as StatsTableItemHolder;
        if (_loc3_) {
            _loc3_.setIsInviteShown(!!param2 ? Boolean(this._isEnemyInviteShown) : Boolean(this._isAllyInviteShown));
            _loc3_.setIsInteractive(!!param2 ? Boolean(this._isEnemyInteractive) : Boolean(this._isAllyInteractive));
        }
    }

    private function createPlayerStatsItem(param1:int, param2:int):StatsTableItem {
        var _loc3_:int = param1 * NUM_ITEM_ROWS + param2;
        return new StatsTableItem(this._table.playerNameCollection[_loc3_], this._table.vehicleNameCollection[_loc3_], this._table.fragsCollection[_loc3_], this._table.deadBgCollection[_loc3_], this._table.vehicleTypeCollection[_loc3_], this._table.icoIGRCollection[_loc3_], this._table.vehicleIconCollection[_loc3_], this._table.vehicleLevelCollection[_loc3_], this._table.muteCollection[_loc3_], this._table.disableCommunicationCollection[_loc3_], this._table.speakAnimationCollection[_loc3_], this._table.vehicleActionMarkerCollection[_loc3_], this._table.playerStatusCollection[_loc3_]);
    }

    private function createSquadItem(param1:int, param2:int):DynamicSquadCtrl {
        var _loc3_:int = param1 * NUM_ITEM_ROWS + param2;
        return new DynamicSquadCtrl(this._table.squadStatusCollection[_loc3_], this._table.squadCollection[_loc3_], this._table.squadAcceptBt, this._table.squadAddBt, this._table.hitCollection[_loc3_], this._table.noSoundCollection[_loc3_]);
    }

    private function initCommonItems():void {
        this._table.selfBgLeft.visible = false;
        this._table.selfBgLeft.imageName = BattleAtlasItem.FULL_STATS_SELF_BG;
        this._table.selfBgRight.visible = false;
        this._table.selfBgRight.imageName = BattleAtlasItem.FULL_STATS_SELF_BG;
    }

    private function setNoTranslate():void {
        setNoTranslateForCollection(this._table.playerNameCollection);
        setNoTranslateForCollection(this._table.vehicleNameCollection);
        setNoTranslateForCollection(this._table.fragsCollection);
    }

    private function getHolderByIndex(param1:Boolean, param2:int):StatsTableItemHolder {
        return (!!param1 ? _enemyRenderers[param2] : _allyRenderers[param2]) as StatsTableItemHolder;
    }

    private function setItemInviteShown(param1:Boolean, param2:int, param3:Boolean):void {
        var _loc4_:StatsTableItemHolder = this.getHolderByIndex(param1, param2);
        if (_loc4_.containsData) {
            _loc4_.setIsInviteShown(param3);
        }
    }

    private function setItemInteractive(param1:Boolean, param2:int, param3:Boolean):void {
        var _loc4_:StatsTableItemHolder = this.getHolderByIndex(param1, param2);
        if (_loc4_.containsData) {
            _loc4_.setIsInteractive(param3);
        }
    }
}
}
