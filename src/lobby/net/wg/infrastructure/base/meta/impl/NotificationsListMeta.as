package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.SmartPopOverView;

public class NotificationsListMeta extends SmartPopOverView {

    public var onClickAction:Function;

    public var getMessageActualTime:Function;

    public function NotificationsListMeta() {
        super();
    }

    public function onClickActionS(param1:uint, param2:Number, param3:String):void {
        App.utils.asserter.assertNotNull(this.onClickAction, "onClickAction" + Errors.CANT_NULL);
        this.onClickAction(param1, param2, param3);
    }

    public function getMessageActualTimeS(param1:Number):String {
        App.utils.asserter.assertNotNull(this.getMessageActualTime, "getMessageActualTime" + Errors.CANT_NULL);
        return this.getMessageActualTime(param1);
    }
}
}
