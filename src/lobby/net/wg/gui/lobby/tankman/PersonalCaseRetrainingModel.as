package net.wg.gui.lobby.tankman {
import net.wg.data.constants.VehicleTypes;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class PersonalCaseRetrainingModel implements IDisposable {

    public var credits:Number;

    public var gold:Number;

    public var tankmanCost:Array;

    public var vehicles:Array;

    public var lightTanks:Array;

    public var mediumTanks:Array;

    public var heavyTanks:Array;

    public var AT_SPG:Array;

    public var SPG:Array;

    public var testData:PersonalCaseModel = null;

    public var testStats:Object = null;

    public var currentVehicle:PersonalCaseCurrentVehicle = null;

    public var nativeVehicle:Object = null;

    public var tankmanID:int;

    public var nationID:int;

    public var specializationLevel:Number;

    public var action:Array;

    public function PersonalCaseRetrainingModel(param1:Object) {
        var _loc5_:Object = null;
        this.lightTanks = [];
        this.mediumTanks = [];
        this.heavyTanks = [];
        this.AT_SPG = [];
        this.SPG = [];
        super();
        this.credits = param1.money[0];
        this.gold = param1.money[1];
        this.tankmanCost = param1.tankmanCost;
        this.vehicles = param1.vehicles;
        this.action = param1.action;
        var _loc2_:Array = param1.vehicles;
        var _loc3_:int = _loc2_.length;
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = _loc2_[_loc4_];
            switch (_loc5_.vehicleType) {
                case VehicleTypes.LIGHT_TANK:
                    this.lightTanks.push(_loc5_);
                    break;
                case VehicleTypes.MEDIUM_TANK:
                    this.mediumTanks.push(_loc5_);
                    break;
                case VehicleTypes.HEAVY_TANK:
                    this.heavyTanks.push(_loc5_);
                    break;
                case VehicleTypes.AT_SPG:
                    this.AT_SPG.push(_loc5_);
                    break;
                case VehicleTypes.SPG:
                    this.SPG.push(_loc5_);
                    break;
                default:
                    DebugUtils.LOG_DEBUG("ERROR unknown tank type");
            }
            _loc4_++;
        }
    }

    public function setTestData(param1:PersonalCaseModel):void {
        this.testData = param1;
        this.nationID = param1.nationID;
        this.tankmanID = param1.inventoryID;
        this.currentVehicle = param1.currentVehicle;
        this.nativeVehicle = param1.nativeVehicle;
        this.specializationLevel = param1.specializationLevel;
    }

    public function dispose():void {
        this.tankmanCost.splice(0);
        this.tankmanCost = null;
        this.vehicles.splice(0);
        this.vehicles = null;
        this.lightTanks.splice(0);
        this.lightTanks = null;
        this.mediumTanks.splice(0);
        this.mediumTanks = null;
        this.heavyTanks.splice(0);
        this.heavyTanks = null;
        this.AT_SPG.splice(0);
        this.AT_SPG = null;
        this.SPG.splice(0);
        this.SPG = null;
        this.action.splice(0);
        this.action = null;
        this.testData = null;
        this.testStats = null;
        this.currentVehicle = null;
        this.nativeVehicle = null;
    }
}
}
