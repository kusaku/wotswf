package net.wg.gui.lobby.store.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StoreViewInitVO extends DAAPIDataClass {

    private static const BUTTON_BAR_DATA_PROP:String = "buttonBarData";

    public var currentViewIdx:int = -1;

    public var buttonBarData:Array = null;

    public function StoreViewInitVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:* = null;
        var _loc4_:Array = null;
        var _loc5_:int = 0;
        var _loc6_:int = 0;
        var _loc7_:Object = null;
        if (param1 == BUTTON_BAR_DATA_PROP) {
            _loc3_ = param1 + " must be an Array";
            App.utils.asserter.assert(param2 is Array, _loc3_);
            _loc4_ = new Array();
            _loc5_ = param2.length;
            _loc6_ = 0;
            while (_loc6_ < _loc5_) {
                _loc7_ = param2[_loc6_];
                _loc4_.push(new ButtonBarVO(_loc7_));
                _loc6_++;
            }
            this.buttonBarData = _loc4_;
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc3_:ButtonBarVO = null;
        var _loc1_:int = this.buttonBarData.length;
        var _loc2_:int = 0;
        while (_loc2_ < _loc1_) {
            _loc3_ = this.buttonBarData[_loc2_];
            _loc3_.dispose();
            _loc2_++;
        }
        this.buttonBarData.splice(0, this.buttonBarData.length);
        this.buttonBarData = null;
        super.onDispose();
    }
}
}
