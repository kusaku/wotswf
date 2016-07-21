package net.wg.gui.cyberSport.staticFormation.data {
import flash.utils.Dictionary;

import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationProfileWindowVO extends DAAPIDataClass {

    private static const SITE_MAP:String = "stateMap";

    public var stateBar:Array;

    public var stateMap:Array = null;

    public var stateMapView:Dictionary = null;

    public function StaticFormationProfileWindowVO(param1:Object) {
        this.stateBar = [];
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        var _loc3_:Array = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        if (param1 == SITE_MAP && param2 != null) {
            this.stateMapView = new Dictionary();
            _loc3_ = param2 as Array;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                this.stateMapView[_loc3_[_loc5_][0]] = _loc3_[_loc5_][1];
                _loc5_++;
            }
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        var _loc1_:* = null;
        this.stateBar.splice(0, this.stateBar.length);
        this.stateBar = null;
        if (this.stateMap) {
            this.stateMap.splice(0, this.stateMap.length);
            this.stateMap = null;
        }
        if (this.stateMapView) {
            for (_loc1_ in this.stateMapView) {
                delete this.stateMapView[_loc1_];
            }
            this.stateMapView = null;
        }
        super.onDispose();
    }
}
}
