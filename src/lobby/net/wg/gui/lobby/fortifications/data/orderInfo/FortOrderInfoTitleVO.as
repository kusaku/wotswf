package net.wg.gui.lobby.fortifications.data.orderInfo {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortOrderInfoTitleVO extends DAAPIDataClass {

    private static const ORDER_PARAMS:String = "orderParams";

    public var level:int = -1;

    public var orderIcon:String = "";

    public var orderTitle:String = "";

    public var orderLevel:String = "";

    public var orderParams:Vector.<OrderParamsVO> = null;

    public function FortOrderInfoTitleVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:Object = null;
        var _loc5_:OrderParamsVO = null;
        if (param1 == ORDER_PARAMS && param2 != null) {
            _loc3_ = param2 as Array;
            this.orderParams = new Vector.<OrderParamsVO>(0);
            for each(_loc4_ in _loc3_) {
                _loc5_ = new OrderParamsVO(_loc4_);
                this.orderParams.push(_loc5_);
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:OrderParamsVO = null;
        for each(_loc1_ in this.orderParams) {
            _loc1_.dispose();
            _loc1_ = null;
        }
        this.orderParams.splice(0, this.orderParams.length);
        this.orderParams = null;
        super.onDispose();
    }
}
}
