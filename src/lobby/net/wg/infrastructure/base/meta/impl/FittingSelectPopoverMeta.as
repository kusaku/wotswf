package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverVO;
import net.wg.infrastructure.base.SmartPopOverView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FittingSelectPopoverMeta extends SmartPopOverView {

    public var setVehicleModule:Function;

    public var showModuleInfo:Function;

    private var _fittingSelectPopoverVO:FittingSelectPopoverVO;

    public function FittingSelectPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._fittingSelectPopoverVO) {
            this._fittingSelectPopoverVO.dispose();
            this._fittingSelectPopoverVO = null;
        }
        super.onDispose();
    }

    public function setVehicleModuleS(param1:Number, param2:Number, param3:Boolean):void {
        App.utils.asserter.assertNotNull(this.setVehicleModule, "setVehicleModule" + Errors.CANT_NULL);
        this.setVehicleModule(param1, param2, param3);
    }

    public function showModuleInfoS(param1:String):void {
        App.utils.asserter.assertNotNull(this.showModuleInfo, "showModuleInfo" + Errors.CANT_NULL);
        this.showModuleInfo(param1);
    }

    public function as_update(param1:Object):void {
        if (this._fittingSelectPopoverVO) {
            this._fittingSelectPopoverVO.dispose();
        }
        this._fittingSelectPopoverVO = new FittingSelectPopoverVO(param1);
        this.update(this._fittingSelectPopoverVO);
    }

    protected function update(param1:FittingSelectPopoverVO):void {
        var _loc2_:String = "as_update" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
