package net.wg.gui.lobby.hangar.tcarousel.data {
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.components.controls.VO.SimpleRendererVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

import scaleform.clik.data.DataProvider;

public class FilterCarouseInitVO extends DAAPIDataClass {

    private static const NATIONS_TYPES:String = "nationsType";

    private static const VEHICLE_TYPES:String = "vehicleType";

    private static const SPECIAL_TYPES_LEFT:String = "specialTypeLeft";

    private static const SPECIAL_TYPES_RIGHT:String = "specialTypeRight";

    private static const LEVELS_TYPES:String = "levelsType";

    private static const RENT_CHECK_BOX:String = "rentCheckBox";

    public var titleLabel:String = "";

    public var nationLabel:String = "";

    public var vehicleTypeLabel:String = "";

    public var vehicleLevelLabel:String = "";

    public var vehicleEliteTypeLabel:String = "";

    public var btnDefaultLabel:String = "";

    public var nationTypeId:int = -1;

    public var vehicleTypeId:int = -1;

    public var specialTypesLeftId:int = -1;

    public var specialTypesRightId:int = -1;

    public var levelTypesId:int = -1;

    public var rentVehicleId:int = -1;

    public var hasRentedVehicles:Boolean = false;

    public var btnDefaultTooltip:String = "";

    private var _nationsTypes:DataProvider = null;

    private var _vehicleTypes:DataProvider = null;

    private var _levelsTypes:DataProvider = null;

    private var _specialTypesLeft:DataProvider = null;

    private var _specialTypesRight:DataProvider = null;

    private var _rentCheckBoxVO:CheckBoxRendererVO = null;

    public function FilterCarouseInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc4_:Object = null;
        var _loc5_:Object = null;
        var _loc6_:Object = null;
        var _loc3_:Object = null;
        if (param1 == NATIONS_TYPES) {
            this._nationsTypes = new DataProvider();
            for each(_loc4_ in param2) {
                this._nationsTypes.push(new SimpleRendererVO(_loc4_));
            }
            return false;
        }
        if (param1 == VEHICLE_TYPES) {
            this._vehicleTypes = new DataProvider();
            for each(_loc5_ in param2) {
                this._vehicleTypes.push(new SimpleRendererVO(_loc5_));
            }
            return false;
        }
        if (param1 == LEVELS_TYPES) {
            this._levelsTypes = new DataProvider();
            for each(_loc6_ in param2) {
                this._levelsTypes.push(new SimpleRendererVO(_loc6_));
            }
            return false;
        }
        if (param1 == SPECIAL_TYPES_LEFT) {
            this._specialTypesLeft = new DataProvider();
            for each(_loc3_ in param2) {
                this._specialTypesLeft.push(new CheckBoxRendererVO(_loc3_));
            }
            return false;
        }
        if (param1 == SPECIAL_TYPES_RIGHT) {
            this._specialTypesRight = new DataProvider();
            for each(_loc3_ in param2) {
                this._specialTypesRight.push(new CheckBoxRendererVO(_loc3_));
            }
            return false;
        }
        if (param1 == RENT_CHECK_BOX) {
            this._rentCheckBoxVO = new CheckBoxRendererVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._nationsTypes) {
            _loc1_.dispose();
        }
        for each(_loc1_ in this._vehicleTypes) {
            _loc1_.dispose();
        }
        for each(_loc1_ in this._levelsTypes) {
            _loc1_.dispose();
        }
        for each(_loc1_ in this._specialTypesLeft) {
            _loc1_.dispose();
        }
        for each(_loc1_ in this._specialTypesRight) {
            _loc1_.dispose();
        }
        this._nationsTypes.cleanUp();
        this._nationsTypes = null;
        this._vehicleTypes.cleanUp();
        this._vehicleTypes = null;
        this._specialTypesLeft.cleanUp();
        this._specialTypesLeft = null;
        this._specialTypesRight.cleanUp();
        this._specialTypesRight = null;
        this._levelsTypes.cleanUp();
        this._levelsTypes = null;
        if (this._rentCheckBoxVO != null) {
            this._rentCheckBoxVO.dispose();
            this._rentCheckBoxVO = null;
        }
        super.onDispose();
    }

    public function get vehicleTypes():DataProvider {
        return this._vehicleTypes;
    }

    public function get specialTypesLeft():DataProvider {
        return this._specialTypesLeft;
    }

    public function get specialTypesRight():DataProvider {
        return this._specialTypesRight;
    }

    public function get levelsTypes():DataProvider {
        return this._levelsTypes;
    }

    public function get nationTypes():DataProvider {
        return this._nationsTypes;
    }

    public function get rentCheckBoxVO():CheckBoxRendererVO {
        return this._rentCheckBoxVO;
    }
}
}
