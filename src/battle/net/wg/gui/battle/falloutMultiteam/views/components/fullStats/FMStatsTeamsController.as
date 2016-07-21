package net.wg.gui.battle.falloutMultiteam.views.components.fullStats {
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class FMStatsTeamsController implements IDisposable {

    private var _teams:Vector.<FMStatsTeam> = null;

    private var _itemHeight:int = 0;

    public function FMStatsTeamsController(param1:Vector.<FMStatsTeam>, param2:int = 0) {
        super();
        this._teams = param1;
        this._itemHeight = param2;
    }

    public function addPlayer(param1:Number, param2:Boolean, param3:int = 0):void {
        var _loc4_:FMStatsTeam = null;
        _loc4_ = !!param3 ? this.getTeamBySquad(param3) : null;
        if (!_loc4_) {
            _loc4_ = this.getNextEmptyTeam();
            if (!_loc4_) {
                return;
            }
            _loc4_.y = this.getPlayersCount() * this._itemHeight;
            _loc4_.init(param2, param3);
        }
        _loc4_.addMember(param1);
    }

    public function updateOrder(param1:Vector.<Number>):void {
        var _loc3_:FMStatsTeam = null;
        var _loc2_:int = param1.length;
        var _loc4_:Vector.<FMStatsTeam> = new Vector.<FMStatsTeam>();
        var _loc5_:int = 0;
        while (_loc5_ < _loc2_) {
            _loc3_ = this.getTeamByVehicleID(param1[_loc5_]);
            if (!(!_loc3_ || _loc4_.indexOf(_loc3_) != -1)) {
                _loc3_.y = this._itemHeight * _loc5_;
                _loc4_.push(_loc3_);
            }
            _loc5_++;
        }
        _loc4_.length = 0;
    }

    public final function dispose():void {
        this.onDispose();
    }

    protected function onDispose():void {
        this._teams.splice(0, this._teams.length);
        this._teams = null;
    }

    private function getPlayersCount():int {
        var _loc2_:FMStatsTeam = null;
        var _loc1_:int = 0;
        for each(_loc2_ in this._teams) {
            if (!_loc2_.initialized) {
                break;
            }
            _loc1_ = _loc1_ + _loc2_.membersCount;
        }
        return _loc1_;
    }

    private function getTeamBySquad(param1:int):FMStatsTeam {
        var _loc2_:FMStatsTeam = null;
        for each(_loc2_ in this._teams) {
            if (!_loc2_.initialized) {
                break;
            }
            if (_loc2_.squadIndex == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    private function getNextEmptyTeam():FMStatsTeam {
        var _loc1_:FMStatsTeam = null;
        for each(_loc1_ in this._teams) {
            if (!_loc1_.initialized) {
                return _loc1_;
            }
        }
        return null;
    }

    private function getTeamByVehicleID(param1:Number):FMStatsTeam {
        var _loc2_:FMStatsTeam = null;
        for each(_loc2_ in this._teams) {
            if (!_loc2_.initialized) {
                break;
            }
            if (_loc2_.containsMember(param1)) {
                return _loc2_;
            }
        }
        return null;
    }
}
}
