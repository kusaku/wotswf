package net.wg.data.constants {
public class Currencies {

    public static const GOLD:String = "gold";

    public static const CREDITS:String = "credits";

    public static const DISABLED:String = "disabled";

    public static const ERROR:String = "error";

    public static const TEXT_COLORS:Object = {
        "credits": CREDITS_COLOR,
        "gold": GOLD_COLOR,
        "disabled": 5197640,
        "error": 16711680
    };

    public static const GOLD_COLOR:Number = 16761699;

    public static const CREDITS_COLOR:Number = 13556185;

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
