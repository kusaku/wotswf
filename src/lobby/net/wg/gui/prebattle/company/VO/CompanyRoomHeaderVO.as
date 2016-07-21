package net.wg.gui.prebattle.company.VO {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.interfaces.IDAAPIDataClass;
import net.wg.infrastructure.interfaces.entity.IDisposable;

public class CompanyRoomHeaderVO extends CompanyRoomHeaderBaseVO {

    private static const VEHICLES_TYPE:String = "vehiclesType";

    public var vehiclesType:Vector.<IDAAPIDataClass> = null;

    public var minMax:String = "";

    public function CompanyRoomHeaderVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        if (param1 == VEHICLES_TYPE && param2 != null) {
            this.vehiclesType = new Vector.<IDAAPIDataClass>(0);
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_, " vehiclesType value Object :" + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_) {
                this.vehiclesType.push(new CompanyHeaderClassLimitsVO(_loc4_));
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:IDisposable = null;
        for each(_loc1_ in this.vehiclesType) {
            _loc1_.dispose();
        }
        this.vehiclesType.splice(0, this.vehiclesType.length);
        this.vehiclesType = null;
        super.onDispose();
    }
}
}
