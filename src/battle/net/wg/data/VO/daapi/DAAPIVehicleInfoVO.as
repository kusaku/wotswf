package net.wg.data.VO.daapi {
import net.wg.data.constants.BattleAtlasItem;
import net.wg.data.constants.PlayerStatus;
import net.wg.data.constants.VehicleStatus;
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIVehicleInfoVO extends DAAPIDataClass {

    public static const DEFAULT_SQUAD_IDX:int = 0;

    public var accountDBID:Number = 0;

    public var isSpeaking:Boolean = false;

    public var prebattleID:Number = 0;

    public var playerStatus:uint = 0;

    public var playerName:String = "";

    public var playerFullName:String = "";

    public var userTags:Array = null;

    public var vehicleID:Number = 0;

    public var vehicleAction:uint = 0;

    public var vehicleIcon:String = "";

    public var vehicleIconName:String = "";

    public var vehicleName:String = "";

    public var vehicleLevel:int = -1;

    public var vehicleType:String = "";

    public var vehicleStatus:uint = 0;

    public var isVehiclePremiumIgr:Boolean = false;

    public var isObserver:Boolean = false;

    public var frags:int;

    public var region:String = "";

    public var isPlayerTeam:Boolean = false;

    public var squadIndex:uint = 0;

    public var invitationStatus:uint = 0;

    public var teamColor:String = "";

    public var clanAbbrev:String = "";

    public var isCurrentPlayer:Boolean = false;

    public var selfBgSource:String;

    public var isCurrentSquad:Boolean = false;

    public function DAAPIVehicleInfoVO(param1:Object = null) {
        super(param1);
    }

    override public function toString():String {
        return "[DAAPIVehicleInfoVO: vehicleID = " + this.vehicleID + ", playerFullName = " + this.playerFullName + " vehicleStatus = " + this.vehicleStatus + "] " + this.playerStatus;
    }

    override protected function onDispose():void {
        if (this.userTags) {
            this.userTags.splice(0, this.userTags.length);
            this.userTags = null;
        }
        super.onDispose();
    }

    public function isAlive():Boolean {
        return (this.vehicleStatus & VehicleStatus.IS_ALIVE) > 0;
    }

    public function isNotAvailable():Boolean {
        return (this.vehicleStatus & VehicleStatus.NOT_AVAILABLE) > 0;
    }

    public function isReady():Boolean {
        return (this.vehicleStatus & VehicleStatus.IS_READY) > 0;
    }

    public function isSquadMan():Boolean {
        return (this.playerStatus & PlayerStatus.IS_SQUAD_MAN) > 0;
    }

    public function isSquadPersonal():Boolean {
        return (this.playerStatus & PlayerStatus.IS_SQUAD_PERSONAL) > 0;
    }

    public function isTeamKiller():Boolean {
        return (this.playerStatus & PlayerStatus.IS_TEAM_KILLER) > 0;
    }

    public function get isIGR():Boolean {
        return this.isVehiclePremiumIgr && this.vehicleType && this.vehicleType != BattleAtlasItem.VEHICLE_TYPE_UNKNOWN;
    }
}
}
