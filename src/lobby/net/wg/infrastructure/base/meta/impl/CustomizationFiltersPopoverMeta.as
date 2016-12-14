package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
import net.wg.gui.lobby.vehicleCustomization.data.FiltersPopoverVO;
import net.wg.gui.lobby.vehicleCustomization.data.FiltersStateVO;
import net.wg.infrastructure.exceptions.AbstractException;

public class CustomizationFiltersPopoverMeta extends PopoverWithDropdown {

    public var changeFilter:Function;

    public var setDefaultFilter:Function;

    private var _filtersPopoverVO:FiltersPopoverVO;

    private var _filtersStateVO:FiltersStateVO;

    public function CustomizationFiltersPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._filtersPopoverVO) {
            this._filtersPopoverVO.dispose();
            this._filtersPopoverVO = null;
        }
        if (this._filtersStateVO) {
            this._filtersStateVO.dispose();
            this._filtersStateVO = null;
        }
        super.onDispose();
    }

    public function changeFilterS(param1:int, param2:int):void {
        App.utils.asserter.assertNotNull(this.changeFilter, "changeFilter" + Errors.CANT_NULL);
        this.changeFilter(param1, param2);
    }

    public function setDefaultFilterS():void {
        App.utils.asserter.assertNotNull(this.setDefaultFilter, "setDefaultFilter" + Errors.CANT_NULL);
        this.setDefaultFilter();
    }

    public final function as_setInitData(param1:Object):void {
        var _loc2_:FiltersPopoverVO = this._filtersPopoverVO;
        this._filtersPopoverVO = new FiltersPopoverVO(param1);
        this.setInitData(this._filtersPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setState(param1:Object):void {
        var _loc2_:FiltersStateVO = this._filtersStateVO;
        this._filtersStateVO = new FiltersStateVO(param1);
        this.setState(this._filtersStateVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setInitData(param1:FiltersPopoverVO):void {
        var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setState(param1:FiltersStateVO):void {
        var _loc2_:String = "as_setState" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
