package net.wg.gui.lobby.battleloading.data {
import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;

public class TeamVehiclesDataProvider extends EnemyVehiclesDataProvider {

    private var _playerVehicleID:Number = 0;

    private var _prebattleID:Number = 0;

    private var _selfBgSource:String;

    public function TeamVehiclesDataProvider(param1:Number = 0, param2:Number = 0, param3:Array = null) {
        this._playerVehicleID = param1;
        this._prebattleID = param2;
        super(param3);
    }

    override protected function makeVO(param1:Object):VehicleInfoVO {
        var _loc2_:VehicleInfoVO = super.makeVO(param1);
        _loc2_.isPlayerTeam = true;
        if (this._playerVehicleID && this._playerVehicleID == _loc2_.vehicleID) {
            _loc2_.isCurrentPlayer = true;
            _loc2_.selfBgSource = this._selfBgSource;
        }
        if (this._prebattleID && this._prebattleID == _loc2_.prebattleID) {
            _loc2_.isCurrentSquad = true;
        }
        return _loc2_;
    }

    public function setPlayerVehicleID(param1:Number):void {
        this._playerVehicleID = param1;
    }

    public function setPrebattleID(param1:Number):void {
        this._prebattleID = param1;
    }

    public function setSelfBgSource(param1:String):void {
        this._selfBgSource = param1;
    }
}
}
