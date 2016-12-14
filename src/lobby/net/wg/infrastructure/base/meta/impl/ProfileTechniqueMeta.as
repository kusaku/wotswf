package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.profile.pages.ProfileSection;
import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class ProfileTechniqueMeta extends ProfileSection {

    private var _profileVehicleDossierVO:ProfileVehicleDossierVO;

    public function ProfileTechniqueMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._profileVehicleDossierVO) {
            this._profileVehicleDossierVO.dispose();
            this._profileVehicleDossierVO = null;
        }
        super.onDispose();
    }

    public final function as_responseVehicleDossier(param1:Object):void {
        var _loc2_:ProfileVehicleDossierVO = this._profileVehicleDossierVO;
        this._profileVehicleDossierVO = new ProfileVehicleDossierVO(param1);
        this.responseVehicleDossier(this._profileVehicleDossierVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function responseVehicleDossier(param1:ProfileVehicleDossierVO):void {
        var _loc2_:String = "as_responseVehicleDossier" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
