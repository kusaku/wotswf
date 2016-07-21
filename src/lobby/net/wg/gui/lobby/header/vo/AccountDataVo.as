package net.wg.gui.lobby.header.vo {
import net.wg.data.VO.UserVO;
import net.wg.data.daapi.base.DAAPIDataClass;

public class AccountDataVo extends DAAPIDataClass implements IHBC_VO {

    private static const USER:String = "userVO";

    public var userVO:UserVO = null;

    public var isTeamKiller:Boolean = false;

    public var clanEmblemId:String = "";

    public var hasNew:Boolean = false;

    public var hasActiveBooster:Boolean = false;

    public var hasAvailableBoosters:Boolean = false;

    public var boosterIcon:String = "";

    public var boosterBg:String = "";

    public var boosterText:String = "";

    private var _tooltip:String = "";

    private var _tooltipType:String = "";

    public function AccountDataVo(param1:Object) {
        super(param1);
    }

    override protected function onDataWrite(param1:String, param2:Object):Boolean {
        if (param1 == USER) {
            this.userVO = new UserVO(param2);
            return false;
        }
        return super.onDataWrite(param1, param2);
    }

    override protected function onDispose():void {
        if (this.userVO != null) {
            this.userVO.dispose();
            this.userVO = null;
        }
        super.onDispose();
    }

    public function get tooltip():String {
        return this._tooltip;
    }

    public function set tooltip(param1:String):void {
        this._tooltip = param1;
    }

    public function get tooltipType():String {
        return this._tooltipType;
    }

    public function set tooltipType(param1:String):void {
        this._tooltipType = param1;
    }
}
}
