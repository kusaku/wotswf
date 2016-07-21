package net.wg.gui.lobby.hangar.tcarousel.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FiltersStateVO extends DAAPIDataClass {

    private static const NATION_TYPES_SELECTED:String = "nationTypeSelected";

    private static const VEHICLE_TYPES_SELECTED:String = "vehicleTypeSelected";

    private static const SPECIAL_TYPES_LEFT_SELECTED:String = "specialTypeLeftSelected";

    private static const SPECIAL_TYPES_RIGHT_SELECTED:String = "specialTypeRightSelected";

    private static const LEVELS_TYPES_SELECTED:String = "levelsTypeSelected";

    public var rentSelected:Boolean = false;

    public var rentEnabled:Boolean = false;

    private var _nationTypeSelected:Vector.<Boolean> = null;

    private var _vehicleTypeSelected:Vector.<Boolean> = null;

    private var _specialTypeLeftSelected:Vector.<Boolean> = null;

    private var _specialTypeRightSelected:Vector.<Boolean> = null;

    private var _levelsTypeSelected:Vector.<Boolean> = null;

    public function FiltersStateVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Boolean = false;
        if (param1 == NATION_TYPES_SELECTED) {
            this._nationTypeSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2) {
                this._nationTypeSelected.push(_loc3_);
            }
            return false;
        }
        if (param1 == VEHICLE_TYPES_SELECTED) {
            this._vehicleTypeSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2) {
                this._vehicleTypeSelected.push(_loc3_);
            }
            return false;
        }
        if (param1 == SPECIAL_TYPES_LEFT_SELECTED) {
            this._specialTypeLeftSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2) {
                this._specialTypeLeftSelected.push(_loc3_);
            }
            return false;
        }
        if (param1 == SPECIAL_TYPES_RIGHT_SELECTED) {
            this._specialTypeRightSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2) {
                this._specialTypeRightSelected.push(_loc3_);
            }
            return false;
        }
        if (param1 == LEVELS_TYPES_SELECTED) {
            this._levelsTypeSelected = new Vector.<Boolean>();
            for each(_loc3_ in param2) {
                this._levelsTypeSelected.push(_loc3_);
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        this._nationTypeSelected.splice(0, this._nationTypeSelected.length);
        this._nationTypeSelected = null;
        this._vehicleTypeSelected.splice(0, this._vehicleTypeSelected.length);
        this._vehicleTypeSelected = null;
        this._specialTypeLeftSelected.splice(0, this._specialTypeLeftSelected.length);
        this._specialTypeLeftSelected = null;
        this._specialTypeRightSelected.splice(0, this._specialTypeRightSelected.length);
        this._specialTypeRightSelected = null;
        this._levelsTypeSelected.splice(0, this._levelsTypeSelected.length);
        this._levelsTypeSelected = null;
        super.onDispose();
    }

    public function get nationTypeSelected():Vector.<Boolean> {
        return this._nationTypeSelected;
    }

    public function get vehicleTypeSelected():Vector.<Boolean> {
        return this._vehicleTypeSelected;
    }

    public function get specialTypeLeftSelected():Vector.<Boolean> {
        return this._specialTypeLeftSelected;
    }

    public function get specialTypeRightSelected():Vector.<Boolean> {
        return this._specialTypeRightSelected;
    }

    public function get levelsTypeSelected():Vector.<Boolean> {
        return this._levelsTypeSelected;
    }
}
}
