package net.wg.gui.lobby.battleResults.data {
import net.wg.data.VO.UserVO;
import net.wg.data.daapi.base.DAAPIDataClass;

public class TeamMemberItemVO extends DAAPIDataClass {

    private static var STAT_VALUES:String = "statValues";

    private static var VEHICLES:String = "vehicles";

    private static var USER_VO:String = "userVO";

    private static var ACHIEVEMENTS:String = "achievements";

    public var isSelf:Boolean;

    public var playerId:Number;

    public var userName:String = "";

    public var playerName:String = "";

    public var isTeamKiller:Boolean;

    public var deathReason:int;

    public var isOwnSquad:Boolean;

    public var showTeamDivider:Boolean;

    public var showTeamInfo:Boolean;

    public var playerNamePosition:Boolean;

    public var showResources:Boolean;

    public var resourceCount:int = -1;

    public var tankIcon:String = "";

    public var vehicleName:String = "";

    public var xp:int;

    public var achievementXP:int;

    public var xpSort:int;

    public var damageDealt:int;

    public var squadID:int;

    public var prebattleID:int;

    public var vehicleSort:int;

    public var kills:int;

    public var tkills:int;

    public var realKills:int;

    public var vehicleId:int;

    public var medalsCount:int;

    public var victoryScore:int;

    public var teamScore:int;

    public var flags:int;

    public var falloutResourcePoints:int;

    public var deaths:int;

    public var deathsStr:String = "";

    public var vehicleFullName:String = "";

    public var vehicleStateStr:String = "";

    public var isPrematureLeave:Boolean;

    public var killerID:int;

    public var killerNameStr:String = "";

    public var killerClanNameStr:String = "";

    public var killerRegionNameStr:String = "";

    public var vehicleStatePrefixStr:String = "";

    public var vehicleStateSuffixStr:String = "";

    public var killerFullNameStr:String = "";

    public var vehicleCD:Number = -1;

    public var userVO:UserVO;

    public var statValues:Vector.<Vector.<StatItemVO>>;

    public var vehicles:Array;

    public var achievements:Array;

    public function TeamMemberItemVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        switch (param1) {
            case STAT_VALUES:
                App.utils.asserter.assert(param2 is Array, "Field \'" + param1 + "\' is expected to be array");
                this.fillStatValues(param2 as Array);
                return false;
            case VEHICLES:
                App.utils.asserter.assert(param2 is Array, "Field \'" + param1 + "\' is expected to be array");
                this.fillVehicles(param2 as Array);
                return false;
            case USER_VO:
                this.userVO = new UserVO(param2);
                return false;
            case ACHIEVEMENTS:
                App.utils.asserter.assert(param2 is Array, "Field \'" + param1 + "\' is expected to be array");
                this.fillAchievements(param2 as Array);
                return false;
            default:
                return super.onDataRead(param1, param2);
        }
    }

    override protected function onDispose():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:Vector.<StatItemVO> = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        if (this.statValues != null) {
            _loc1_ = this.statValues.length;
            _loc2_ = 0;
            while (_loc2_ < this.statValues.length) {
                _loc3_ = this.statValues[_loc2_];
                _loc4_ = _loc3_.length;
                _loc5_ = 0;
                while (_loc5_ < _loc4_) {
                    _loc3_[_loc5_].dispose();
                    _loc5_++;
                }
                _loc3_.splice(0, _loc4_);
                _loc2_++;
            }
            this.statValues.splice(0, _loc1_);
            this.statValues = null;
        }
        if (this.vehicles != null) {
            App.utils.commons.releaseReferences(this.vehicles);
            this.vehicles = null;
        }
        if (this.achievements != null) {
            this.achievements.splice(0);
            this.achievements = null;
        }
        this.userVO.dispose();
        this.userVO = null;
        super.onDispose();
    }

    private function fillVehicles(param1:Array):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        if (param1 != null) {
            this.vehicles = [];
            _loc2_ = param1.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this.vehicles.push(new VehicleItemVO(param1[_loc3_]));
                _loc3_++;
            }
        }
    }

    private function fillStatValues(param1:Array):void {
        var _loc2_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:Array = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        if (param1) {
            _loc2_ = param1.length;
            this.statValues = new Vector.<Vector.<StatItemVO>>(_loc2_);
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = param1[_loc3_];
                _loc5_ = _loc4_.length;
                this.statValues[_loc3_] = new Vector.<StatItemVO>(_loc5_);
                _loc6_ = 0;
                while (_loc6_ < _loc5_) {
                    this.statValues[_loc3_][_loc6_] = new StatItemVO(_loc4_[_loc6_]);
                    _loc6_++;
                }
                _loc3_++;
            }
        }
    }

    private function fillAchievements(param1:Array):void {
        var _loc2_:uint = 0;
        var _loc3_:int = 0;
        if (param1) {
            this.achievements = [];
            _loc2_ = param1.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this.achievements.push(new BattleResultsMedalsListVO(param1[_loc3_]));
                _loc3_++;
            }
        }
    }
}
}
