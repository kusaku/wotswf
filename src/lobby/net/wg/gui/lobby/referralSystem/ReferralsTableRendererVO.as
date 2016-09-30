package net.wg.gui.lobby.referralSystem {
import net.wg.data.VO.UserVO;
import net.wg.data.daapi.base.DAAPIDataClass;
import net.wg.gui.messenger.data.ContactItemVO;

public class ReferralsTableRendererVO extends DAAPIDataClass {

    private static const REFERRAL_VO:String = "referralVO";

    private static const CONTACT_DATA_VO:String = "contactData";

    public var isEmpty:Boolean = true;

    public var btnEnabled:Boolean = true;

    public var referralNo:String = "";

    public var exp:String = "";

    public var multiplier:String = "";

    public var multiplierTooltip:String = "";

    public var btnTooltip:String = "";

    public var referralVO:UserVO = null;

    public var contactDataVO:ContactItemVO = null;

    public function ReferralsTableRendererVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == REFERRAL_VO && param2 != null) {
            this.referralVO = new UserVO(param2);
            return false;
        }
        if (param1 == CONTACT_DATA_VO && param2 != null) {
            this.contactDataVO = new ContactItemVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        this.referralVO.dispose();
        this.referralVO = null;
        this.contactDataVO.dispose();
        this.contactDataVO = null;
        super.onDispose();
    }
}
}
