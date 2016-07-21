package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class BuildingModernizationVO extends DAAPIDataClass {

    public static const BEFORE_UPGRADE:String = "beforeUpgradeData";

    public static const AFTER_UPGRADE:String = "afterUpgradeData";

    public var intBuildingID:int = -1;

    public var btnToolTip:String = "";

    public var canUpgrade:Boolean = true;

    public var condition:String = "";

    public var costUpgrade:String = "";

    public var costValue:String = "";

    public var conditionIcon:String = "";

    private var _beforeUpgradeData:ModernizationCmpVO = null;

    private var _afterUpgradeData:ModernizationCmpVO = null;

    public function BuildingModernizationVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == BEFORE_UPGRADE) {
            this._beforeUpgradeData = new ModernizationCmpVO(param2);
            return false;
        }
        if (param1 == AFTER_UPGRADE) {
            this._afterUpgradeData = new ModernizationCmpVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this._beforeUpgradeData.dispose();
        this._beforeUpgradeData = null;
        this._afterUpgradeData.dispose();
        this._beforeUpgradeData = null;
        super.onDispose();
    }

    public function get beforeUpgradeData():ModernizationCmpVO {
        return this._beforeUpgradeData;
    }

    public function get afterUpgradeData():ModernizationCmpVO {
        return this._afterUpgradeData;
    }
}
}
