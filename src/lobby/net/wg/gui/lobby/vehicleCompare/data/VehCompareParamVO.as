package net.wg.gui.lobby.vehicleCompare.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;

public class VehCompareParamVO extends DAAPIDataClass {

    private static const INDICATOR_VO:String = "indicatorVO";

    public var state:String = "";

    public var titleText:String = "";

    public var iconSource:String = "";

    public var paramID:String = "";

    public var isEnabled:Boolean = false;

    public var tooltip:String = "";

    public var isSelected:Boolean = false;

    public var isOpen:Boolean = true;

    private var _indicatorVO:StatusDeltaIndicatorVO = null;

    public function VehCompareParamVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == INDICATOR_VO) {
            this._indicatorVO = new StatusDeltaIndicatorVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this._indicatorVO != null) {
            this._indicatorVO.dispose();
            this._indicatorVO = null;
        }
        super.onDispose();
    }

    public function set indicatorVO(param1:StatusDeltaIndicatorVO):void {
        this._indicatorVO = param1;
    }
}
}
