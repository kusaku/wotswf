package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.tankman.vo.RoleChangeVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class RoleChangeMeta extends AbstractWindowView {

    public var onVehicleSelected:Function;

    public var changeRole:Function;

    private var _roleChangeVO:RoleChangeVO;

    public function RoleChangeMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._roleChangeVO) {
            this._roleChangeVO.dispose();
            this._roleChangeVO = null;
        }
        super.onDispose();
    }

    public function onVehicleSelectedS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onVehicleSelected, "onVehicleSelected" + Errors.CANT_NULL);
        this.onVehicleSelected(param1);
    }

    public function changeRoleS(param1:String, param2:int):void {
        App.utils.asserter.assertNotNull(this.changeRole, "changeRole" + Errors.CANT_NULL);
        this.changeRole(param1, param2);
    }

    public function as_setCommonData(param1:Object):void {
        if (this._roleChangeVO) {
            this._roleChangeVO.dispose();
        }
        this._roleChangeVO = new RoleChangeVO(param1);
        this.setCommonData(this._roleChangeVO);
    }

    protected function setCommonData(param1:RoleChangeVO):void {
        var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
