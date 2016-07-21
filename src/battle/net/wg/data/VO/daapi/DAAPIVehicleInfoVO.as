package net.wg.data.VO.daapi {
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

    public var vehicleGuiName:String = "";

    public var vehicleLevel:int = -1;

    public var vehicleType:String = "";

    public var vehicleStatus:uint = 0;

    public var isVehiclePremiumIgr:Boolean = false;

    public var isObserver:Boolean = false;

    public var region:String = "";

    public var isPlayerTeam:Boolean = false;

    public var squadIndex:uint = 0;

    public var invitationStatus:uint = 0;

    public var teamColor:String = "";

    public var clanAbbrev:String = "";

    public function DAAPIVehicleInfoVO(param1:Object) {
        super(param1);
    }

    override public function toString():String {
        return "[VehicleInfoVO: vehicleID = " + this.vehicleID + ", playerFullName = " + this.playerFullName + " vehicleStatus = " + this.vehicleStatus + "]" + this.playerStatus;
    }

    public function clone():DAAPIVehicleInfoVO {
        var _loc1_:DAAPIVehicleInfoVO = new DAAPIVehicleInfoVO({});
        _loc1_.accountDBID = this.accountDBID;
        _loc1_.isSpeaking = this.isSpeaking;
        _loc1_.prebattleID = this.prebattleID;
        _loc1_.playerStatus = this.playerStatus;
        _loc1_.playerName = this.playerName;
        _loc1_.playerFullName = this.playerFullName;
        if (this.userTags) {
            _loc1_.userTags = this.userTags.concat();
        }
        _loc1_.vehicleID = this.vehicleID;
        _loc1_.vehicleAction = this.vehicleAction;
        _loc1_.vehicleIcon = this.vehicleIcon;
        _loc1_.vehicleIconName = this.vehicleIconName;
        _loc1_.vehicleName = this.vehicleName;
        _loc1_.vehicleGuiName = this.vehicleGuiName;
        _loc1_.vehicleLevel = this.vehicleLevel;
        _loc1_.vehicleType = this.vehicleType;
        _loc1_.vehicleStatus = this.vehicleStatus;
        _loc1_.isVehiclePremiumIgr = this.isVehiclePremiumIgr;
        _loc1_.isObserver = this.isObserver;
        _loc1_.region = this.region;
        _loc1_.isPlayerTeam = this.isPlayerTeam;
        _loc1_.squadIndex = this.squadIndex;
        _loc1_.invitationStatus = this.invitationStatus;
        _loc1_.teamColor = this.teamColor;
        _loc1_.clanAbbrev = this.clanAbbrev;
        return _loc1_;
    }

    override protected function onDispose():void {
        if (this.userTags) {
            this.userTags.splice(0, this.userTags.length);
            this.userTags = null;
        }
        super.onDispose();
    }
}
}
