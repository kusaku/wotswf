package net.wg.gui.lobby.fortifications.data {
import net.wg.data.constants.generated.FORTIFICATION_ALIASES;

public class FortBuildingConstants {

    public static const TROWEL_STATE:String = "trowel_state";

    public static const BUILD_FOUNDATION_STATE:String = "buildFoundation_state";

    public static const DEFAULT_FOUNDATION_STATE:String = "defaultFoundation_state";

    public static const CRASHABLE_BUILDINGS:Array = [FORTIFICATION_ALIASES.FORT_BASE_BUILDING];

    public static var BUILD_CODE_TO_NAME_MAP:Object = {};

    public static const BASE_BUILDING:String = "base_building";

    public static const CRASH_POSTFIX:String = "_crash";

    public static const FORT_UNKNOWN:String = "unknown";

    {
        BUILD_CODE_TO_NAME_MAP[FORTIFICATION_ALIASES.STATE_TROWEL] = TROWEL_STATE;
        BUILD_CODE_TO_NAME_MAP[FORTIFICATION_ALIASES.STATE_FOUNDATION] = BUILD_FOUNDATION_STATE;
        BUILD_CODE_TO_NAME_MAP[FORTIFICATION_ALIASES.STATE_FOUNDATION_DEF] = DEFAULT_FOUNDATION_STATE;
        BUILD_CODE_TO_NAME_MAP[FORTIFICATION_ALIASES.STATE_BUILDING] = DEFAULT_FOUNDATION_STATE;
    }

    public function FortBuildingConstants() {
        super();
    }
}
}
