package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIVehicleUserTagsVO extends DAAPIDataClass {

    public var isEnemy:Boolean = false;

    public var userTags:Array = null;

    public var vehicleID:Number = -1;

    public function DAAPIVehicleUserTagsVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        if (this.userTags) {
            this.userTags.splice(0, this.userTags.length);
            this.userTags = null;
        }
        super.onDispose();
    }

    public function clone():DAAPIVehicleUserTagsVO {
        var _loc1_:DAAPIVehicleUserTagsVO = new DAAPIVehicleUserTagsVO({});
        _loc1_.isEnemy = this.isEnemy;
        _loc1_.userTags = this.userTags;
        _loc1_.vehicleID = this.vehicleID;
        return _loc1_;
    }
}
}
