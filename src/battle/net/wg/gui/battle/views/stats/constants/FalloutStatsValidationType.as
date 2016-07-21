package net.wg.gui.battle.views.stats.constants {
public class FalloutStatsValidationType {

    public static const SCORE:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 1;

    public static const SPECIAL_POINTS:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 2;

    public static const DAMAGE:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 3;

    public static const DEATHS:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 4;

    public static const TEAM_SCORE:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 5;

    public static const RESPAWN_STATE:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 6;

    public function FalloutStatsValidationType() {
        super();
    }
}
}
