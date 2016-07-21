package net.wg.gui.lobby.header.vo {
import net.wg.data.VO.UserVO;

public class HBC_AccountDataVo extends HBC_AbstractVO {

    public var userVO:UserVO = null;

    public var isTeamKiller:Boolean = false;

    public var clanEmblemId:String = "";

    public var hasNew:Boolean = false;

    public var hasActiveBooster:Boolean = false;

    public var hasAvailableBoosters:Boolean = false;

    public var boosterIcon:String = "";

    public var boosterBg:String = "";

    public var boosterText:String = "";

    public function HBC_AccountDataVo() {
        super();
    }

    override public function dispose():void {
        this.userVO.dispose();
        this.userVO = null;
        super.dispose();
    }
}
}
