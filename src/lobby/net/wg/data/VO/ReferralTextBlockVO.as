package net.wg.data.VO {
import net.wg.data.daapi.base.DAAPIDataClass;

public class ReferralTextBlockVO extends DAAPIDataClass {

    public var iconSource:String = "";

    public var titleTF:String = "";

    public var bodyTF:String = "";

    public var showLinkBtn:Boolean = false;

    public function ReferralTextBlockVO(param1:Object) {
        super(param1);
    }

    override protected function onDispose():void {
        this.iconSource = null;
        this.titleTF = null;
        this.bodyTF = null;
        super.onDispose();
    }
}
}
