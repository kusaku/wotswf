package net.wg.gui.lobby.referralSystem {
import net.wg.data.VO.UserVO;
import net.wg.data.daapi.base.DAAPIDataClass;

public class ReferralsTableRendererVO extends DAAPIDataClass {

    private static const REFERRAL_VO:String = "referralVO";

    public var isEmpty:Boolean = true;

    public var btnEnabled:Boolean = true;

    public var referralNo:String = "";

    public var isOnline:Boolean = false;

    public var exp:String = "";

    public var multiplier:String = "";

    public var multiplierTooltip:String = "";

    public var btnTooltip:String = "";

    public var referralVO:UserVO = null;

    public function ReferralsTableRendererVO(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == REFERRAL_VO && param2 != null) {
            this.referralVO = new UserVO(param2);
            return false;
        }
        return true;
    }

    override protected function onDispose():void {
        this.referralVO.dispose();
        this.referralVO = null;
        super.onDispose();
    }
}
}
