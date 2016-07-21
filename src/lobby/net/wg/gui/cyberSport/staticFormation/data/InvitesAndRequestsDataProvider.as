package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.SortableDAAPIDataProvider;

public class InvitesAndRequestsDataProvider extends SortableDAAPIDataProvider {

    public function InvitesAndRequestsDataProvider() {
        super();
    }

    override public function requestItemAt(param1:uint, param2:Function = null):Object {
        var _loc3_:Object = requestItemAtHandler(param1);
        var _loc4_:InvitesAndRequestsItemVO = _loc3_ != null ? new InvitesAndRequestsItemVO(_loc3_) : null;
        if (param2 != null) {
            param2(_loc4_);
        }
        return _loc4_;
    }

    override public function requestItemRange(param1:int, param2:int, param3:Function = null):Array {
        var _loc6_:Object = null;
        if (!Boolean(requestItemRangeHandler)) {
            return [];
        }
        var _loc4_:Array = requestItemRangeHandler(param1, param2);
        var _loc5_:Array = [];
        for each(_loc6_ in _loc4_) {
            _loc5_.push(new InvitesAndRequestsItemVO(_loc6_));
        }
        if (param3 != null) {
            param3(_loc5_);
        }
        return _loc5_;
    }
}
}
