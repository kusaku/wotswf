package net.wg.data.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class RefSysReferralsIntroVO extends DAAPIDataClass {

    public var titleTF:String = "";

    public var bodyTF:String = "";

    public var squadTF:String = "";

    public function RefSysReferralsIntroVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.titleTF = null;
        this.bodyTF = null;
        this.squadTF = null;
        super.onDispose();
    }
}
}
