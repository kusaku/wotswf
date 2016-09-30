package net.wg.gui.lobby.hangar.vehicleParameters.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;

public class VehParamVO extends DAAPIDataClass {

    private static const INDICATOR_VO:String = "indicatorVO";

    public var state:String = "";

    public var titleText:String = "";

    public var valueText:String = "";

    public var iconSource:String = "";

    public var indicatorVO:StatusDeltaIndicatorVO = null;

    public var paramID:String = "";

    public var isEnabled:Boolean = false;

    public var isOpen:Boolean = false;

    public var tooltip:String = "";

    public var buffIconSrc:String = "";

    public function VehParamVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == INDICATOR_VO) {
            this.indicatorVO = new StatusDeltaIndicatorVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.indicatorVO != null) {
            this.indicatorVO.dispose();
            this.indicatorVO = null;
        }
        super.onDispose();
    }
}
}
