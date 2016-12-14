package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.profile.ProfileMenuInfoVO;
import net.wg.infrastructure.base.BaseDAAPIComponent;
import net.wg.infrastructure.exceptions.AbstractException;

public class ProfileTabNavigatorMeta extends BaseDAAPIComponent {

    private var _profileMenuInfoVO:ProfileMenuInfoVO;

    public function ProfileTabNavigatorMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._profileMenuInfoVO) {
            this._profileMenuInfoVO.dispose();
            this._profileMenuInfoVO = null;
        }
        super.onDispose();
    }

    public final function as_setInitData(param1:Object):void {
        var _loc2_:ProfileMenuInfoVO = this._profileMenuInfoVO;
        this._profileMenuInfoVO = new ProfileMenuInfoVO(param1);
        this.setInitData(this._profileMenuInfoVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setInitData(param1:ProfileMenuInfoVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
