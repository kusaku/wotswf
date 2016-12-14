package net.wg.gui.battle.falloutMultiteam.views.components.fullStats {
import flash.text.TextField;
import flash.utils.Dictionary;

import net.wg.data.VO.daapi.DAAPIFalloutVehicleStatsVO;
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.BattleAtlasItem;
import net.wg.gui.battle.views.stats.fullStats.StatsTableItemPositionController;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class FMStatsTableController implements IDisposable {

    private static const NUM_ITEMS:int = 18;

    private static const ITEM_HEIGHT:Number = 25;

    private var _table:FMStatsTable = null;

    private var _teamsController:FMStatsTeamsController = null;

    private var _items:Vector.<FMStatsItemHolder> = null;

    private var _positionControllers:Vector.<StatsTableItemPositionController> = null;

    private var _currOrder:Vector.<Number> = null;

    private var _teamScores:Dictionary = null;

    private var _teamsAvailable:Boolean = false;

    public function FMStatsTableController(param1:FMStatsTable) {
        super();
        this._table = param1;
        this._items = new Vector.<FMStatsItemHolder>();
        this._positionControllers = new Vector.<StatsTableItemPositionController>();
        this._currOrder = new Vector.<Number>();
        this._teamScores = new Dictionary();
        this.init();
        this.setNoTranslate();
    }

    public function setTeamsAvailable(param1:Boolean):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (this._teamsAvailable == param1) {
            return;
        }
        if (param1 && !this._teamsController) {
            this._teamsController = new FMStatsTeamsController(this._table.teamCollection, ITEM_HEIGHT);
            _loc2_ = this._items.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                if (this._items[_loc3_].containsData) {
                    this.addPlayerToTeamController(this._items[_loc3_]);
                    _loc3_++;
                    continue;
                }
                break;
            }
            this._teamsController.updateOrder(this._currOrder);
            this.updateTeamsScore();
            this.updateTeamsScoreVisibility();
        }
        this._teamsAvailable = param1;
    }

    public function setVehiclesStats(param1:Vector.<DAAPIFalloutVehicleStatsVO>):void {
        var _loc2_:FMStatsItemHolder = null;
        var _loc3_:DAAPIFalloutVehicleStatsVO = null;
        for each(_loc3_ in param1) {
            _loc2_ = this.getItemByVehicleID(_loc3_.vehicleID);
            if (_loc2_) {
                _loc2_.setVehicleStats(_loc3_);
            }
        }
        if (this._teamsAvailable) {
            this.updateTeamsScore();
            this.updateTeamsScoreVisibility();
        }
    }

    public function setVehiclesData(param1:Vector.<DAAPIVehicleInfoVO>):void {
        var _loc3_:FMStatsItemHolder = null;
        var _loc4_:DAAPIVehicleInfoVO = null;
        var _loc2_:int = param1.length;
        if (_loc2_ > NUM_ITEMS) {
            _loc2_ = NUM_ITEMS;
        }
        if (this._teamsAvailable && !this._teamsController) {
            this._teamsController = new FMStatsTeamsController(this._table.teamCollection, ITEM_HEIGHT);
        }
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_) {
            _loc3_ = this._items[_loc5_];
            _loc4_ = param1[_loc5_];
            _loc3_.setDAAPIVehicleData(_loc4_);
            this._currOrder[_loc5_] = _loc4_.vehicleID;
            if (this._teamsAvailable) {
                this.addPlayerToTeamController(_loc3_);
            }
            if (_loc3_.isSelected) {
                this.setSelectedItem(this._positionControllers[_loc5_].row);
            }
            _loc5_++;
        }
    }

    public function addVehiclesData(param1:Vector.<DAAPIVehicleInfoVO>):void {
        var _loc2_:FMStatsItemHolder = null;
        var _loc3_:DAAPIVehicleInfoVO = null;
        for each(_loc3_ in param1) {
            _loc2_ = this.getNextEmptyItem();
            _loc2_.setDAAPIVehicleData(_loc3_);
            this._currOrder.push(_loc3_.vehicleID);
            if (this._teamsAvailable) {
                this.addPlayerToTeamController(_loc2_);
            }
            if (_loc2_.isSelected) {
                this.setSelectedItem(this._positionControllers[this._currOrder.length - 1].row);
            }
        }
    }

    public function updateVehiclesData(param1:Vector.<DAAPIVehicleInfoVO>):void {
        var _loc2_:FMStatsItemHolder = null;
        var _loc3_:DAAPIVehicleInfoVO = null;
        for each(_loc3_ in param1) {
            _loc2_ = this.getItemByVehicleID(_loc3_.vehicleID);
            if (_loc2_ && _loc3_) {
                _loc2_.setDAAPIVehicleData(_loc3_);
            }
        }
    }

    public function setVehicleStatus(param1:Number, param2:uint):void {
    }

    public function setPlayerStatus(param1:Number, param2:uint):void {
    }

    public function setUserTags(param1:Number, param2:Array):void {
    }

    public function updateOrder(param1:Vector.<Number>):void {
        var _loc3_:StatsTableItemPositionController = null;
        if (!param1 || !this.checkIfOrderIsValid(this._currOrder, param1)) {
            return;
        }
        var _loc2_:int = param1.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc2_) {
            if (this._currOrder[_loc4_] != param1[_loc4_]) {
                _loc3_ = this.getPostionControllerByVehicleID(param1[_loc4_]);
                _loc3_.row = _loc4_;
                if (this.getItemByVehicleID(param1[_loc4_]).isSelected) {
                    this.setSelectedItem(_loc3_.row);
                }
                this._currOrder[_loc4_] = param1[_loc4_];
            }
            _loc4_++;
        }
        if (this._teamsAvailable) {
            this._teamsController.updateOrder(param1);
            this.updateTeamsScoreVisibility();
        }
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        var _loc2_:int = 0;
        if (this._teamsController) {
            this._teamsController.dispose();
            this._teamsController = null;
        }
        var _loc1_:int = this._items.length;
        _loc2_ = 0;
        while (_loc2_ < _loc1_) {
            this._items[_loc2_].dispose();
            this._items[_loc2_] = null;
            _loc2_++;
        }
        _loc2_ = 0;
        while (_loc2_ < _loc1_) {
            this._positionControllers[_loc2_].dispose();
            this._positionControllers[_loc2_] = null;
            _loc2_++;
        }
        this._currOrder.splice(0, this._currOrder.length);
        App.utils.data.cleanupDynamicObject(this._teamScores);
        this._table = null;
        this._items = null;
        this._positionControllers = null;
        this._currOrder = null;
        this._teamScores = null;
    }

    private function init():void {
        this._table.selfBg.visible = false;
        this._table.selfBg.imageName = BattleAtlasItem.FM_STATS_SELF_BG;
        var _loc1_:int = 0;
        while (_loc1_ < NUM_ITEMS) {
            this._items[_loc1_] = new FMStatsItemHolder(this.createStatsItem(_loc1_));
            this._positionControllers[_loc1_] = this.createPositionController(_loc1_);
            _loc1_++;
        }
    }

    private function createStatsItem(param1:int):FMStatsItem {
        return new FMStatsItem(this._table.playerNameCollection[param1], this._table.vehicleNameCollection[param1], this._table.fragsCollection[param1], this._table.vehicleTypeIconCollection[param1], this._table.deadBgCollection[param1], this._table.icoIGRCollection[param1], this._table.scoreCollection[param1], this._table.damageCollection[param1], this._table.deathsCollection[param1], this._table.specialPointsCollection[param1], this._table.teamScoreCollection[param1]);
    }

    private function createPositionController(param1:int):StatsTableItemPositionController {
        var _loc2_:StatsTableItemPositionController = new StatsTableItemPositionController(0, param1 * ITEM_HEIGHT, 0, param1, this._table.playerNameCollection[param1], this._table.vehicleNameCollection[param1], this._table.fragsCollection[param1], this._table.vehicleTypeIconCollection[param1], this._table.deadBgCollection[param1], this._table.scoreCollection[param1], this._table.damageCollection[param1], this._table.deathsCollection[param1], this._table.specialPointsCollection[param1], this._table.teamScoreCollection[param1]);
        _loc2_.setItemHeight(ITEM_HEIGHT);
        return _loc2_;
    }

    private function setSelectedItem(param1:int):void {
        this._table.selfBg.y = param1 * ITEM_HEIGHT;
        this._table.selfBg.visible = true;
    }

    private function getItemByVehicleID(param1:Number):FMStatsItemHolder {
        return null;
    }

    private function getNextEmptyItem():FMStatsItemHolder {
        var _loc1_:int = 0;
        while (_loc1_ < NUM_ITEMS) {
            if (!this._items[_loc1_].containsData) {
                return this._items[_loc1_];
            }
            _loc1_++;
        }
        return null;
    }

    private function getPostionControllerByVehicleID(param1:Number):StatsTableItemPositionController {
        return null;
    }

    private function setNoTranslate():void {
        this.setNoTranslateForCollection(this._table.damageCollection);
        this.setNoTranslateForCollection(this._table.deathsCollection);
        this.setNoTranslateForCollection(this._table.fragsCollection);
        this.setNoTranslateForCollection(this._table.playerNameCollection);
        this.setNoTranslateForCollection(this._table.scoreCollection);
        this.setNoTranslateForCollection(this._table.specialPointsCollection);
        this.setNoTranslateForCollection(this._table.teamScoreCollection);
        this.setNoTranslateForCollection(this._table.vehicleNameCollection);
    }

    private function setNoTranslateForCollection(param1:Vector.<TextField>):void {
        var _loc2_:TextField = null;
        for each(_loc2_ in param1) {
            TextFieldEx.setNoTranslate(_loc2_, true);
        }
    }

    private function checkIfOrderIsValid(param1:Vector.<Number>, param2:Vector.<Number>):Boolean {
        var _loc3_:int = param2.length;
        if (_loc3_ != param1.length) {
            return false;
        }
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            if (param1.indexOf(param2[_loc4_]) == -1) {
                return false;
            }
            _loc4_++;
        }
        return true;
    }

    private function updateTeamsScore():void {
        var _loc1_:FMStatsItemHolder = null;
        App.utils.data.cleanupDynamicObject(this._teamScores);
        for each(_loc1_ in this._items) {
            if (_loc1_.isInSquad) {
                if (this._teamScores[_loc1_.squadIndex] == undefined) {
                    this._teamScores[_loc1_.squadIndex] = 0;
                }
                this._teamScores[_loc1_.squadIndex] = this._teamScores[_loc1_.squadIndex] + _loc1_.score;
            }
        }
        for each(_loc1_ in this._items) {
            if (_loc1_.isInSquad) {
                _loc1_.teamScore = this._teamScores[_loc1_.squadIndex];
            }
        }
    }

    private function updateTeamsScoreVisibility():void {
        var _loc2_:int = 0;
        var _loc4_:FMStatsItemHolder = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc1_:Array = new Array();
        var _loc3_:int = this._positionControllers.length;
        _loc2_ = 0;
        while (_loc2_ < _loc3_) {
            _loc4_ = this._items[_loc2_];
            if (!_loc4_.containsData) {
                _loc3_ = _loc2_;
                break;
            }
            _loc5_ = _loc4_.squadIndex;
            _loc6_ = this._positionControllers[_loc2_].row;
            if (_loc1_[_loc5_] == undefined || _loc6_ < _loc1_[_loc5_]) {
                _loc1_[_loc5_] = _loc6_;
            }
            _loc2_++;
        }
        _loc2_ = 0;
        while (_loc2_ < _loc3_) {
            _loc4_ = this._items[_loc2_];
            _loc5_ = _loc4_.squadIndex;
            _loc6_ = this._positionControllers[_loc2_].row;
            _loc4_.setTeamScoreVisible(!_loc4_.isInSquad || _loc6_ == _loc1_[_loc5_] + 1);
            _loc2_++;
        }
    }

    private function addPlayerToTeamController(param1:FMStatsItemHolder):void {
    }
}
}
