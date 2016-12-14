package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.settings.DayOffPopoverVO;
import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortSettingsDayoffPopoverMeta extends PopoverWithDropdown {

    public var onApply:Function;

    private var _dayOffPopoverVO:DayOffPopoverVO;

    public function FortSettingsDayoffPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._dayOffPopoverVO) {
            this._dayOffPopoverVO.dispose();
            this._dayOffPopoverVO = null;
        }
        super.onDispose();
    }

    public function onApplyS(param1:int):void {
        App.utils.asserter.assertNotNull(this.onApply, "onApply" + Errors.CANT_NULL);
        this.onApply(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:DayOffPopoverVO = this._dayOffPopoverVO;
        this._dayOffPopoverVO = new DayOffPopoverVO(param1);
        this.setData(this._dayOffPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:DayOffPopoverVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
