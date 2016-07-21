package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ModernizationCmpVO extends DAAPIDataClass {

    private static const BUILDING_INDICATORS:String = "buildingIndicators";

    private static const DEFRES_INFO:String = "defResInfo";

    public var buildingLevel:int = -1;

    public var buildingIcon:String = "";

    public var buildingIndicators:BuildingIndicatorsVO = null;

    public var defResInfo:OrderInfoVO = null;

    public var titleText:String = "";

    public function ModernizationCmpVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == BUILDING_INDICATORS) {
            this.buildingIndicators = new BuildingIndicatorsVO(param2);
            return false;
        }
        if (param1 == DEFRES_INFO) {
            this.defResInfo = new OrderInfoVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this.buildingIndicators.dispose();
        this.buildingIndicators = null;
        this.defResInfo.dispose();
        this.defResInfo = null;
        super.onDispose();
    }
}
}
