package net.wg.gui.battle.battleloading {
import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
import net.wg.gui.battle.battleloading.constants.VehicleStatusSchemes;

public class BattleLoadingHelper {

    private static var _instance:BattleLoadingHelper = null;

    public static const SETTING_TEXT:String = "textTip";

    public static const TIP_TITLE_TABLE_TOP:int = 536;

    public static const TIP_BODY_TABLE_TOP:int = 562;

    private static const TIP_TITLE_TIPS_TOP:int = 366;

    private static const TIP_BODY_TIPS_TOP:int = 397;

    private static const TEAM1_TEXT_TABLE_LEFT:int = -412;

    private static const TEAM2_TEXT_TABLE_LEFT:int = 204;

    private static const TEAM1_TEXT_TIPS_LEFT:int = -472;

    private static const TEAM2_TEXT_TIPS_LEFT:int = 268;

    private static const TEAM1_LIST_TABLE_LEFT:int = -459;

    private static const TEAM2_LIST_TABLE_LEFT:int = 2;

    private static const TEAM1_LIST_TIPS_LEFT:int = -506;

    private static const TEAM2_LIST_TIPS_LEFT:int = 217;

    private static const VEHICLE_TYPE_UNKNOWN:String = "unknown";

    private static const DASH:String = "_";

    public function BattleLoadingHelper() {
        super();
    }

    public static function get instance():BattleLoadingHelper {
        if (_instance == null) {
            _instance = new BattleLoadingHelper();
        }
        return _instance;
    }

    public function getColorSchemeName(param1:DAAPIVehicleInfoVO, param2:Boolean):String {
        var _loc3_:String = this.getRandomColorSchemeName(param1, param2);
        _loc3_ = _loc3_ + (!param1.isCurrentPlayer && (!param1.isAlive() || !param1.isReady()) ? VehicleStatusSchemes.OFFLINE_POSTFIX : "");
        return _loc3_;
    }

    public function getVehicleTypeIconId(param1:DAAPIVehicleInfoVO):String {
        var _loc2_:String = App.colorSchemeMgr.getAliasColor(param1.teamColor);
        if (_loc2_ && param1.vehicleType && param1.vehicleType != VEHICLE_TYPE_UNKNOWN) {
            return _loc2_ + DASH + param1.vehicleType;
        }
        return null;
    }

    private function getFalloutColorSchemeName(param1:DAAPIVehicleInfoVO, param2:Boolean):String {
        var _loc3_:String = null;
        if (param1.isTeamKiller()) {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER : VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER_DEAD;
        }
        else if (param1.isCurrentPlayer) {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_PLAYER : VehicleStatusSchemes.COLOR_SCHEME_PLAYER_DEAD;
        }
        else if (param1.isCurrentSquad) {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_SQUAD : VehicleStatusSchemes.COLOR_SCHEME_SQUAD_DEAD;
        }
        else {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_NORMAL : VehicleStatusSchemes.COLOR_SCHEME_NORMAL_DEAD;
        }
        return _loc3_;
    }

    private function getRandomColorSchemeName(param1:DAAPIVehicleInfoVO, param2:Boolean):String {
        var _loc3_:String = null;
        if (param1.isCurrentPlayer) {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_PLAYER : VehicleStatusSchemes.COLOR_SCHEME_PLAYER_DEAD;
        }
        else if (param1.isCurrentSquad) {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_SQUAD : VehicleStatusSchemes.COLOR_SCHEME_SQUAD_DEAD;
        }
        else if (param1.isTeamKiller()) {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER : VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER_DEAD;
        }
        else {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_NORMAL : VehicleStatusSchemes.COLOR_SCHEME_NORMAL_DEAD;
        }
        return _loc3_;
    }
}
}
