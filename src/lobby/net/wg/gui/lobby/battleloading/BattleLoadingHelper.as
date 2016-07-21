package net.wg.gui.lobby.battleloading {
import net.wg.data.constants.Linkages;
import net.wg.gui.components.controls.ReadOnlyScrollingList;
import net.wg.gui.lobby.battleloading.constants.VehicleStatusSchemes;
import net.wg.gui.lobby.battleloading.vo.LoadingFormDisplayDataVO;
import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;

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

    private static const EMPTY_STR:String = "";

    private static const UNDERLINE_STR:String = "_";

    public function BattleLoadingHelper() {
        super();
    }

    public static function get instance():BattleLoadingHelper {
        if (_instance == null) {
            _instance = new BattleLoadingHelper();
        }
        return _instance;
    }

    public function configureLists(param1:ReadOnlyScrollingList, param2:ReadOnlyScrollingList, param3:LoadingFormDisplayDataVO):void {
        this.configureList(param1, App.utils.classFactory.getClass(param3.leftRendererId), param3.leftListLeft);
        this.configureList(param2, App.utils.classFactory.getClass(param3.rightRendererId), param3.rightListLeft);
    }

    public function getColorSchemeName(param1:VehicleInfoVO, param2:Boolean):String {
        var _loc3_:String = null;
        if (param1.isFallout) {
            _loc3_ = this.getFalloutColorSchemeName(param1, param2);
        }
        else {
            _loc3_ = this.getRandomColorSchemeName(param1, param2);
        }
        _loc3_ = _loc3_ + (!param1.isCurrentPlayer && (!param1.isAlive() || !param1.isReady()) ? VehicleStatusSchemes.OFFLINE_POSTFIX : EMPTY_STR);
        return _loc3_;
    }

    public function getLoadingFormDisplayData(param1:String):LoadingFormDisplayDataVO {
        var _loc2_:LoadingFormDisplayDataVO = new LoadingFormDisplayDataVO();
        if (param1 == SETTING_TEXT) {
            _loc2_.leftRendererId = Linkages.LEFT_ITEM_RENDERER_TABLE;
            _loc2_.rightRendererId = Linkages.RIGHT_ITEM_RENDERER_TABLE;
            _loc2_.leftListLeft = TEAM1_LIST_TABLE_LEFT;
            _loc2_.rightListLeft = TEAM2_LIST_TABLE_LEFT;
            _loc2_.leftTeamTitleLeft = TEAM1_TEXT_TABLE_LEFT;
            _loc2_.rightTeamTitleLeft = TEAM2_TEXT_TABLE_LEFT;
            _loc2_.tipTitleTop = TIP_TITLE_TABLE_TOP;
            _loc2_.tipBodyTop = TIP_BODY_TABLE_TOP;
            _loc2_.showTableBackground = true;
            _loc2_.showTipsBackground = false;
            _loc2_.selfBgSource = RES_ICONS.MAPS_ICONS_BATTLELOADING_SELFTABLEBACKGROUND;
        }
        else {
            _loc2_.leftRendererId = Linkages.LEFT_ITEM_RENDERER_TIPS;
            _loc2_.rightRendererId = Linkages.RIGHT_ITEM_RENDERER_TIPS;
            _loc2_.leftListLeft = TEAM1_LIST_TIPS_LEFT;
            _loc2_.rightListLeft = TEAM2_LIST_TIPS_LEFT;
            _loc2_.leftTeamTitleLeft = TEAM1_TEXT_TIPS_LEFT;
            _loc2_.rightTeamTitleLeft = TEAM2_TEXT_TIPS_LEFT;
            _loc2_.tipTitleTop = TIP_TITLE_TIPS_TOP;
            _loc2_.tipBodyTop = TIP_BODY_TIPS_TOP;
            _loc2_.showTableBackground = false;
            _loc2_.showTipsBackground = true;
            _loc2_.selfBgSource = RES_ICONS.MAPS_ICONS_BATTLELOADING_SELFTIPSBACKGROUND;
        }
        return _loc2_;
    }

    public function getVehicleTypeIconId(param1:VehicleInfoVO):String {
        return param1.teamColor + UNDERLINE_STR + param1.vehicleType;
    }

    private function configureList(param1:ReadOnlyScrollingList, param2:Class, param3:int):void {
        param1.itemRenderer = param2;
        param1.x = param3;
    }

    private function getFalloutColorSchemeName(param1:VehicleInfoVO, param2:Boolean):String {
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

    private function getRandomColorSchemeName(param1:VehicleInfoVO, param2:Boolean):String {
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
