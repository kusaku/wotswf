package net.wg.gui.lobby.fortifications.data {
import net.wg.data.constants.Errors;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.fortBase.IBuildingVO;
import net.wg.gui.fortBase.IBuildingsComponentVO;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class BuildingsComponentVO extends DAAPIDataClass implements IBuildingsComponentVO {

    private static const BUILDING_DATA:String = "buildingData";

    private var _buildingData:Vector.<IBuildingVO> = null;

    private var _canAddBuilding:Boolean = false;

    public function BuildingsComponentVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == BUILDING_DATA) {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, BUILDING_DATA + Errors.INVALID_TYPE + Array);
            this._buildingData = new Vector.<IBuildingVO>();
            for each(_loc4_ in _loc3_) {
                this._buildingData.push(new BuildingVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this._buildingData) {
            _loc1_.dispose();
        }
        this._buildingData.splice(0, this._buildingData.length);
        this._buildingData = null;
        super.onDispose();
    }

    public function get canAddBuilding():Boolean {
        return this._canAddBuilding;
    }

    public function set canAddBuilding(param1:Boolean):void {
        this._canAddBuilding = param1;
    }

    public function get buildingData():Vector.<IBuildingVO> {
        return this._buildingData;
    }

    public function set buildingData(param1:Vector.<IBuildingVO>):void {
        this._buildingData = param1;
    }
}
}
