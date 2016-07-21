package net.wg.gui.components.advanced.vo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StatusDeltaIndicatorVO extends DAAPIDataClass {

    public var value:int = -1;

    public var delta:int = 0;

    public var maxValue:int = -1;

    public var minValue:int = -1;

    public var markerValue:int = -1;

    public var useAnim:Boolean = true;

    public function StatusDeltaIndicatorVO(param1:Object) {
        super(param1);
    }
}
}
