package net.wg.gui.battle.random.views.stats.components.playersPanel.constants {
import net.wg.data.constants.InvalidationType;

public class PlayersPanelInvalidationType {

    public static const PLAYER_NAME_FULL_WIDTH:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

    public static const VEHILCE_NAME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

    public static const FRAGS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

    public static const MUTE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;

    public static const IS_SPEAKING:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;

    public static const SELECTED:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;

    public static const ALIVE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 7;

    public static const PLAYER_SCHEME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 8;

    public static const IGR_CHANGED:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 9;

    public function PlayersPanelInvalidationType() {
        super();
    }
}
}
