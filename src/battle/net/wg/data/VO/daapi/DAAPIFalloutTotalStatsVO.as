package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIFalloutTotalStatsVO extends DAAPIDataClass {

    public var leftWinPoints:int = -1;

    public var rightWinPoints:int = -1;

    public var personalWinPoints:int = -1;

    public var leftLabel:String = "";

    public var rightLabel:String = "";

    public function DAAPIFalloutTotalStatsVO(param1:Object) {
        super(param1);
    }
}
}
