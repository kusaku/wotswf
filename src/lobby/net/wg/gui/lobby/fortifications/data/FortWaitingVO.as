package net.wg.gui.lobby.fortifications.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class FortWaitingVO extends DAAPIDataClass {

    public var isShowWaiting:Boolean = false;

    public var waitingLbl:String = "";

    public function FortWaitingVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.waitingLbl = null;
        super.onDispose();
    }
}
}
