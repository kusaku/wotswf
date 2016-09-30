package net.wg.data.constants {
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;

public class Currencies extends CURRENCIES_CONSTANTS {

    public static const TEXT_COLORS:Object = {
        "credits": CREDITS_COLOR,
        "gold": GOLD_COLOR,
        "disabled": DISABLED_COLOR,
        "error": ERROR_COLOR
    };

    public static const GOLD_COLOR:Number = 16761699;

    public static const CREDITS_COLOR:Number = 13556185;

    public static const DISABLED_COLOR:Number = 5197640;

    public static const ERROR_COLOR:Number = 16711680;

    public static const CREDITS_INDEX:Number = 0;

    public static const GOLD_INDEX:Number = 1;

    public static const NAME_FROM_INDEX:Array = [CREDITS, GOLD];

    public static const INDEX_FROM_NAME:Object = {
        "credits": CREDITS_INDEX,
        "gold": GOLD_INDEX
    };

    public function Currencies() {
        super();
    }
}
}
