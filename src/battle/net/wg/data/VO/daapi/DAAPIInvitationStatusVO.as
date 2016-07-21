package net.wg.data.VO.daapi {
import net.wg.data.daapi.base.DAAPIDataClass;

public class DAAPIInvitationStatusVO extends DAAPIDataClass {

    public var vehicleID:Number = -1;

    public var status:uint = 0;

    public var isEnemy:Boolean = false;

    public function DAAPIInvitationStatusVO(param1:Object) {
        super(param1);
    }
}
}
