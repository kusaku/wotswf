package net.wg.gui.battle.views.stats.fullStats {
import flash.text.TextField;

import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.data.constants.Errors;
import net.wg.infrastructure.exceptions.AbstractException;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.gfx.TextFieldEx;

public class StatsTableControllerBase implements IDisposable {

    protected static const NUM_ITEM_ROWS:int = 15;

    protected static const NUM_ITEM_COLUMNS:int = 2;

    protected var items:Vector.<StatsTableItemHolderBase> = null;

    protected var positionControllers:Vector.<StatsTableItemPositionController> = null;

    protected var leftOrder:Vector.<Number> = null;

    protected var rightOrder:Vector.<Number> = null;

    public function StatsTableControllerBase() {
        super();
        this.items = new Vector.<StatsTableItemHolderBase>(NUM_ITEM_ROWS * NUM_ITEM_COLUMNS);
        this.positionControllers = new Vector.<StatsTableItemPositionController>();
        this.leftOrder = new Vector.<Number>();
        this.rightOrder = new Vector.<Number>();
    }

    public function setTeamData(param1:Vector.<DAAPIVehicleInfoVO>, param2:Boolean):void {
        var _loc5_:int = 0;
        var _loc6_:StatsTableItemHolderBase = null;
        var _loc9_:StatsTableItemPositionController = null;
        var _loc3_:int = param1.length;
        if (_loc3_ > NUM_ITEM_ROWS) {
            _loc3_ = NUM_ITEM_ROWS;
        }
        var _loc4_:Vector.<Number> = !!param2 ? this.rightOrder : this.leftOrder;
        var _loc7_:DAAPIVehicleInfoVO = null;
        var _loc8_:int = 0;
        while (_loc8_ < _loc3_) {
            _loc5_ = !!param2 ? int(NUM_ITEM_ROWS + _loc8_) : int(_loc8_);
            _loc6_ = this.items[_loc5_];
            _loc7_ = param1[_loc8_];
            _loc6_.setDAAPIVehicleData(_loc7_);
            _loc4_[_loc8_] = _loc7_.vehicleID;
            if (_loc6_.isSelected) {
                _loc9_ = this.positionControllers[_loc5_];
                this.setSelectedItem(_loc9_.colunm, _loc9_.row);
            }
            this.onItemDataSet(_loc6_, param2);
            _loc8_++;
        }
    }

    public function addVehiclesData(param1:Vector.<DAAPIVehicleInfoVO>, param2:Boolean):void {
        var _loc3_:StatsTableItemHolderBase = null;
        var _loc4_:StatsTableItemPositionController = null;
        var _loc5_:DAAPIVehicleInfoVO = null;
        var _loc6_:Vector.<Number> = null;
        for each(_loc5_ in param1) {
            _loc3_ = this.getNextEmptyItem(param2);
            if (!(!_loc3_ || !_loc5_)) {
                _loc3_.setDAAPIVehicleData(_loc5_);
                _loc6_ = !!param2 ? this.rightOrder : this.leftOrder;
                _loc6_.push(_loc5_.vehicleID);
                if (_loc3_.isSelected) {
                    _loc4_ = this.positionControllers[_loc6_.length - 1];
                    this.setSelectedItem(_loc4_.colunm, _loc4_.row);
                }
                this.onItemDataSet(_loc3_, param2);
            }
        }
    }

    public function updateVehiclesData(param1:Vector.<DAAPIVehicleInfoVO>):void {
        var _loc2_:StatsTableItemHolderBase = null;
        var _loc3_:DAAPIVehicleInfoVO = null;
        for each(_loc3_ in param1) {
            _loc2_ = this.getItemByVehicleID(_loc3_.vehicleID);
            if (_loc2_ && _loc3_) {
                _loc2_.setDAAPIVehicleData(_loc3_);
            }
        }
    }

    public function setVehicleStatus(param1:Number, param2:uint):void {
        var _loc3_:StatsTableItemHolderBase = this.getItemByVehicleID(param1);
        if (_loc3_) {
            _loc3_.setVehicleStatus(param2);
        }
    }

    public function setPlayerStatus(param1:Number, param2:uint):void {
        var _loc4_:StatsTableItemPositionController = null;
        var _loc5_:StatsTableItemHolderBase = null;
        var _loc3_:int = this.items.length;
        var _loc6_:int = 0;
        while (_loc6_ < _loc3_) {
            _loc5_ = this.items[_loc6_];
            if (_loc5_.vehicleID == param1) {
                _loc5_.setPlayerStatus(param2);
                if (_loc5_.isSelected) {
                    _loc4_ = this.positionControllers[_loc6_];
                    this.setSelectedItem(_loc4_.colunm, _loc4_.row);
                }
                break;
            }
            _loc6_++;
        }
    }

    public function setUserTags(param1:Number, param2:Array):void {
        var _loc3_:StatsTableItemHolderBase = this.getItemByVehicleID(param1);
        if (_loc3_) {
            _loc3_.setUserTags(param2);
        }
    }

    public function updateOrder(param1:Vector.<Number>, param2:Boolean):void {
        var _loc6_:StatsTableItemPositionController = null;
        var _loc7_:StatsTableItemHolderBase = null;
        var _loc9_:Number = NaN;
        var _loc3_:Vector.<Number> = !!param2 ? this.rightOrder : this.leftOrder;
        if (!param1 || !this.checkIfOrderIsValid(_loc3_, param1)) {
            return;
        }
        var _loc4_:int = param1.length;
        var _loc5_:int = 0;
        var _loc8_:int = -1;
        var _loc10_:int = 0;
        while (_loc10_ < _loc4_) {
            _loc9_ = param1[_loc10_];
            if (_loc9_ != _loc3_[_loc10_]) {
                _loc5_ = !!param2 ? int(NUM_ITEM_ROWS + _loc10_) : int(_loc10_);
                _loc8_ = this.getItemIndexByVehicleID(_loc9_);
                if (_loc8_ != -1) {
                    _loc7_ = this.items[_loc8_];
                    if (_loc7_.containsData) {
                        _loc6_ = this.positionControllers[_loc8_];
                        _loc6_.row = _loc10_;
                        if (_loc7_.isSelected) {
                            this.setSelectedItem(_loc6_.colunm, _loc6_.row);
                        }
                    }
                }
                _loc3_[_loc10_] = _loc9_;
            }
            _loc10_++;
        }
    }

    public function updateColorBlind():void {
        var _loc1_:StatsTableItemHolderBase = null;
        for each(_loc1_ in this.items) {
            if (_loc1_.containsData) {
                _loc1_.updateColorBlind();
            }
        }
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function createItemHolder(param1:int, param2:int):StatsTableItemHolderBase {
        throw new AbstractException(Errors.ABSTRACT_INVOKE);
    }

    protected function createPositionController(param1:int, param2:int):StatsTableItemPositionController {
        throw new AbstractException(Errors.ABSTRACT_INVOKE);
    }

    protected function setSelectedItem(param1:int, param2:int):void {
    }

    protected function onDispose():void {
        var _loc2_:int = 0;
        var _loc1_:int = this.items.length;
        _loc2_ = 0;
        while (_loc2_ < _loc1_) {
            this.items[_loc2_].dispose();
            this.items[_loc2_] = null;
            _loc2_++;
        }
        _loc1_ = this.positionControllers.length;
        _loc2_ = 0;
        while (_loc2_ < _loc1_) {
            this.positionControllers[_loc2_].dispose();
            this.positionControllers[_loc2_] = null;
            _loc2_++;
        }
        this.leftOrder.splice(0, this.leftOrder.length);
        this.rightOrder.splice(0, this.rightOrder.length);
        this.items = null;
        this.leftOrder = null;
        this.rightOrder = null;
        this.positionControllers = null;
    }

    protected function onItemDataSet(param1:StatsTableItemHolderBase, param2:Boolean):void {
    }

    protected final function getItemByVehicleID(param1:Number):StatsTableItemHolderBase {
        var _loc2_:StatsTableItemHolderBase = null;
        for each(_loc2_ in this.items) {
            if (_loc2_.vehicleID == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    protected final function setNoTranslateForCollection(param1:Vector.<TextField>):void {
        var _loc2_:TextField = null;
        for each(_loc2_ in param1) {
            TextFieldEx.setNoTranslate(_loc2_, true);
        }
    }

    protected function init():void {
        var _loc2_:StatsTableItemHolderBase = null;
        var _loc4_:int = 0;
        var _loc1_:int = 0;
        var _loc3_:int = 0;
        while (_loc3_ < NUM_ITEM_COLUMNS) {
            _loc4_ = 0;
            while (_loc4_ < NUM_ITEM_ROWS) {
                _loc2_ = this.createItemHolder(_loc3_, _loc4_);
                this.items[_loc1_] = _loc2_;
                this.positionControllers[_loc1_] = this.createPositionController(_loc3_, _loc4_);
                _loc1_++;
                _loc4_++;
            }
            _loc3_++;
        }
    }

    private function getNextEmptyItem(param1:Boolean):StatsTableItemHolderBase {
        var _loc2_:int = !!param1 ? int(NUM_ITEM_ROWS) : 0;
        var _loc3_:int = _loc2_ + NUM_ITEM_ROWS;
        while (_loc2_ < _loc3_) {
            if (!this.items[_loc2_].containsData) {
                return this.items[_loc2_];
            }
            _loc2_++;
        }
        return null;
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

    private function getItemIndexByVehicleID(param1:Number):int {
        var _loc2_:int = this.items.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            if (param1 == this.items[_loc3_].vehicleID) {
                return _loc3_;
            }
            _loc3_++;
        }
        return -1;
    }
}
}
