package net.wg.data.constants {
public class BattleAtlasItem {

    public static const ICO_IGR:String = "icoIGR";

    public static const SQUAD_INVITE_SENT:String = "squad_inviteSent";

    public static const SQUAD_INVITE_RECEIVED_FROM_SQUAD:String = "squad_inviteReceivedFromSquad";

    public static const SQUAD_INVITE_RECEIVED:String = "squad_inviteReceived";

    public static const SQUAD_INVITE_DISABLED:String = "squad_inviteDisabled";

    public static const SQUAD_NO_SOUND:String = "squad_noSound";

    public static const STATS_MUTE:String = "stats_mute";

    public static const PLAYERS_PANEL_SELF_BG:String = "playersPanel_selfBg";

    public static const PLAYERS_PANEL_BG:String = "playersPanel_bg";

    public static const PLAYERS_PANEL_DEAD_BG:String = "playersPanel_deadBg";

    public static const PLAYERS_PANEL_SWITCH_BG:String = "playersPanelSwitch_bg";

    public static const PLAYERS_PANEL_SWITCH_BT_FULL:String = "playersPanelSwitchBt_full";

    public static const PLAYERS_PANEL_SWITCH_BT_MEDIUM:String = "playersPanelSwitchBt_medium";

    public static const PLAYERS_PANEL_SWITCH_BT_LONG:String = "playersPanelSwitchBt_long";

    public static const PLAYERS_PANEL_SWITCH_BT_HIDDEN:String = "playersPanelSwitchBt_hidden";

    public static const PLAYERS_PANEL_SWITCH_BT_SHORT:String = "playersPanelSwitchBt_short";

    public static const FULL_STATS_PLAYER_STATUS_IN_BATTLE:String = "fullStatsPlayerStatus_inBattle";

    public static const FULL_STATS_PLAYER_STATUS_KILLED:String = "fullStatsPlayerStatus_killed";

    public static const FULL_STATS_PLAYER_STATUS_OFFLINE:String = "fullStatsPlayerStatus_offline";

    public static const FULL_STATS_SELF_BG:String = "fullStats_selfBg";

    public static const FULL_STATS_DEAD_BG:String = "fullStats_deadBg";

    public static const FC_STATS_SELF_BG:String = "FC_fullStats_selfBg";

    public static const FC_STATS_DEAD_BG:String = "FC_fullStats_deadBg";

    public static const FM_STATS_TEAM_BG:String = "FM_fullStatsTeam_bg";

    public static const FM_STATS_TEAM_PLAYER_ICON:String = "FM_fullStatsTeam_playerIcon";

    public static const FM_STATS_TEAM_CURRENT_PLAYER_ICON:String = "FM_fullStatsTeam_currentPlayerIcon";

    public static const FM_STATS_TEAM_CURRENT_PLAYER_BLIND:String = "FM_fullStatsTeam_currentPlayerBlind";

    public static const FM_STATS_TEAM_SQUAD_ICON:String = "FM_fullStatsTeam_squadIcon";

    public static const FM_STATS_TEAM_CURRENT_SQUAD_ICON_BLIND:String = "FM_fullStatsTeam_currentSquadIconBlind";

    public static const FM_STATS_TEAM_CURRENT_SQUAD_ICON:String = "FM_fullStatsTeam_currentSquadIcon";

    public static const FM_STATS_SELF_BG:String = "FM_fullStats_selfBg";

    public static const VEHICLE_TYPE_UNKNOWN:String = "unknown";

    public static const FALLOUT_SCORE_PANEL_ARROW:String = "FalloutScorePanelArrow";

    public static const FALLOUT_SCORE_PANEL_DIVIDER:String = "falloutScorePanelDivider";

    public static const POSTMORTEM_GAS_INFO_BG:String = "postmortemGasInfo_bg";

    public static const POSTMORTEM_GAS_INFO_DEAD_ICON:String = "postmortemGasInfo_deadIcon";

    public static const POSTMORTEM_TIPS_BG:String = "postmortemTips_bg";

    public static const CRUISE:String = "Cruise_";

    public static const PNG_EXT:String = "";

    private static const VEHICLE_LEVEL_KEY:String = "level";

    private static const SQUAD_SILVER_KEY:String = "squad_silver_";

    private static const SQUAD_GOLD_KEY:String = "squad_gold_";

    private static const VEHICLE_ACTION_PREFIX:String = "vehicleActionMarker_";

    private static const FULL_STATS_VEHICLE_TYPE_PREFIX:String = "fullStatsVehicleType_";

    public function BattleAtlasItem() {
        super();
    }

    public static function getVehicleLevelName(param1:int):String {
        return VEHICLE_LEVEL_KEY + param1;
    }

    public static function getSquadIconName(param1:Boolean, param2:int):String {
        return (!!param1 ? SQUAD_GOLD_KEY : SQUAD_SILVER_KEY) + param2;
    }

    public static function getVehicleActionName(param1:String):String {
        return VEHICLE_ACTION_PREFIX + param1;
    }

    public static function getVehicleIconName(param1:String):String {
        return param1;
    }

    public static function getFullStatsVehicleTypeName(param1:String, param2:String):String {
        return FULL_STATS_VEHICLE_TYPE_PREFIX + param1 + "_" + param2;
    }
}
}
