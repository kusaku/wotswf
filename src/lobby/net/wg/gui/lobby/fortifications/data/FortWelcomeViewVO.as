package net.wg.gui.lobby.fortifications.data {
import net.wg.gui.lobby.fortifications.data.base.BaseFortificationVO;
import net.wg.gui.lobby.fortifications.interfaces.IFortWelcomeViewVO;

public class FortWelcomeViewVO extends BaseFortificationVO implements IFortWelcomeViewVO {

    private var _canRoleCreateFortRest:Boolean = false;

    private var _canCreateFortLim:Boolean = false;

    private var _joinClanAvailable:Boolean = false;

    private var _clanSearchAvailable:Boolean = false;

    public function FortWelcomeViewVO(param1:Object) {
        super(param1);
    }

    public function canCreateFort():Boolean {
        return this.canRoleCreateFortRest && this.canCreateFortLim;
    }

    public function get canRoleCreateFortRest():Boolean {
        return this._canRoleCreateFortRest;
    }

    public function set canRoleCreateFortRest(param1:Boolean):void {
        this._canRoleCreateFortRest = param1;
    }

    public function get canCreateFortLim():Boolean {
        return this._canCreateFortLim;
    }

    public function set canCreateFortLim(param1:Boolean):void {
        this._canCreateFortLim = param1;
    }

    public function get joinClanAvailable():Boolean {
        return this._joinClanAvailable;
    }

    public function set joinClanAvailable(param1:Boolean):void {
        this._joinClanAvailable = param1;
    }

    public function get clanSearchAvailable():Boolean {
        return this._clanSearchAvailable;
    }

    public function set clanSearchAvailable(param1:Boolean):void {
        this._clanSearchAvailable = param1;
    }
}
}
