package net.wg.gui.lobby.sellDialog.VO {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.ActionPriceVO;

public class SellDialogVO extends DAAPIDataClass {

    private static const SELL_VEHICLE_VO_LABEL:String = "sellVehicleVO";

    private static const OPTIONAL_DEVICES_ON_VEHICLE_LABEL:String = "optionalDevicesOnVehicle";

    private static const SHELLS_ON_VEHICLE_LABEL:String = "shellsOnVehicle";

    private static const EQUIPMENTS_ON_VEHICLE_LABEL:String = "equipmentsOnVehicle";

    private static const MODULES_IN_INVENTORY_LABEL:String = "modulesInInventory";

    private static const SHELLS_IN_INVENTORY_LABEL:String = "shellsInInventory";

    private static const REMOVE_ACTION_PRICE_LABEL:String = "removeActionPrice";

    public var sellVehicleVO:SellVehicleVo = null;

    public var optionalDevicesOnVehicle:Vector.<SellOnVehicleOptionalDeviceVo> = null;

    public var shellsOnVehicle:Vector.<SellOnVehicleShellVo> = null;

    public var equipmentsOnVehicle:Vector.<SellOnVehicleEquipmentVo> = null;

    public var modulesInInventory:Vector.<SellInInventoryModuleVo> = null;

    public var shellsInInventory:Vector.<SellInInventoryShellVo> = null;

    public var removeActionPrice:ActionPriceVO = null;

    public var removePrice:Number = -1;

    public var accountGold:Number = -1;

    public var isSlidingComponentOpened:Boolean = false;

    public function SellDialogVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == SELL_VEHICLE_VO_LABEL) {
            this.sellVehicleVO = new SellVehicleVo(param2);
            return false;
        }
        if (param1 == OPTIONAL_DEVICES_ON_VEHICLE_LABEL) {
            this.optionalDevicesOnVehicle = Vector.<SellOnVehicleOptionalDeviceVo>(App.utils.data.convertVOArrayToVector(param1, param2, SellOnVehicleOptionalDeviceVo));
            return false;
        }
        if (param1 == SHELLS_ON_VEHICLE_LABEL) {
            this.shellsOnVehicle = Vector.<SellOnVehicleShellVo>(App.utils.data.convertVOArrayToVector(param1, param2, SellOnVehicleShellVo));
            return false;
        }
        if (param1 == EQUIPMENTS_ON_VEHICLE_LABEL) {
            this.equipmentsOnVehicle = Vector.<SellOnVehicleEquipmentVo>(App.utils.data.convertVOArrayToVector(param1, param2, SellOnVehicleEquipmentVo));
            return false;
        }
        if (param1 == MODULES_IN_INVENTORY_LABEL) {
            this.modulesInInventory = Vector.<SellInInventoryModuleVo>(App.utils.data.convertVOArrayToVector(param1, param2, SellInInventoryModuleVo));
            return false;
        }
        if (param1 == SHELLS_IN_INVENTORY_LABEL) {
            this.shellsInInventory = Vector.<SellInInventoryShellVo>(App.utils.data.convertVOArrayToVector(param1, param2, SellInInventoryShellVo));
            return false;
        }
        if (param1 == REMOVE_ACTION_PRICE_LABEL && param2 != null) {
            this.removeActionPrice = new ActionPriceVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:SellOnVehicleOptionalDeviceVo = null;
        var _loc2_:SellOnVehicleShellVo = null;
        var _loc3_:SellOnVehicleEquipmentVo = null;
        var _loc4_:SellInInventoryModuleVo = null;
        var _loc5_:SellInInventoryShellVo = null;
        this.sellVehicleVO.dispose();
        this.sellVehicleVO = null;
        if (this.removeActionPrice != null) {
            this.removeActionPrice.dispose();
            this.removeActionPrice = null;
        }
        for each(_loc1_ in this.optionalDevicesOnVehicle) {
            _loc1_.dispose();
        }
        this.optionalDevicesOnVehicle.splice(0, this.optionalDevicesOnVehicle.length);
        this.optionalDevicesOnVehicle = null;
        for each(_loc2_ in this.shellsOnVehicle) {
            _loc2_.dispose();
        }
        this.shellsOnVehicle.splice(0, this.shellsOnVehicle.length);
        this.shellsOnVehicle = null;
        for each(_loc3_ in this.equipmentsOnVehicle) {
            _loc3_.dispose();
        }
        this.equipmentsOnVehicle.splice(0, this.equipmentsOnVehicle.length);
        this.equipmentsOnVehicle = null;
        for each(_loc4_ in this.modulesInInventory) {
            _loc4_.dispose();
        }
        this.modulesInInventory.splice(0, this.modulesInInventory.length);
        this.modulesInInventory = null;
        for each(_loc5_ in this.shellsInInventory) {
            _loc5_.dispose();
        }
        this.shellsInInventory.splice(0, this.shellsInInventory.length);
        this.shellsInInventory = null;
        super.onDispose();
    }
}
}
