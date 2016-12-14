package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.BuildingModernizationVO;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortModernizationWindowMeta extends AbstractWindowView {

    public var applyAction:Function;

    public var openOrderDetailsWindow:Function;

    private var _buildingModernizationVO:BuildingModernizationVO;

    public function FortModernizationWindowMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._buildingModernizationVO) {
            this._buildingModernizationVO.dispose();
            this._buildingModernizationVO = null;
        }
        super.onDispose();
    }

    public function applyActionS():void {
        App.utils.asserter.assertNotNull(this.applyAction, "applyAction" + Errors.CANT_NULL);
        this.applyAction();
    }

    public function openOrderDetailsWindowS():void {
        App.utils.asserter.assertNotNull(this.openOrderDetailsWindow, "openOrderDetailsWindow" + Errors.CANT_NULL);
        this.openOrderDetailsWindow();
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:BuildingModernizationVO = this._buildingModernizationVO;
        this._buildingModernizationVO = new BuildingModernizationVO(param1);
        this.setData(this._buildingModernizationVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:BuildingModernizationVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
