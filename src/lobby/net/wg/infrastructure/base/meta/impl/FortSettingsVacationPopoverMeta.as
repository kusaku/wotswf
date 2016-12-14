package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.fortifications.data.settings.VacationPopoverVO;
import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
import net.wg.infrastructure.exceptions.AbstractException;

public class FortSettingsVacationPopoverMeta extends PopoverWithDropdown {

    public var onApply:Function;

    private var _vacationPopoverVO:VacationPopoverVO;

    private var _vacationPopoverVO1:VacationPopoverVO;

    public function FortSettingsVacationPopoverMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._vacationPopoverVO) {
            this._vacationPopoverVO.dispose();
            this._vacationPopoverVO = null;
        }
        if (this._vacationPopoverVO1) {
            this._vacationPopoverVO1.dispose();
            this._vacationPopoverVO1 = null;
        }
        super.onDispose();
    }

    public function onApplyS(param1:VacationPopoverVO):void {
        App.utils.asserter.assertNotNull(this.onApply, "onApply" + Errors.CANT_NULL);
        this.onApply(param1);
    }

    public final function as_setTexts(param1:Object):void {
        var _loc2_:VacationPopoverVO = this._vacationPopoverVO;
        this._vacationPopoverVO = new VacationPopoverVO(param1);
        this.setTexts(this._vacationPopoverVO);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:VacationPopoverVO = this._vacationPopoverVO1;
        this._vacationPopoverVO1 = new VacationPopoverVO(param1);
        this.setData(this._vacationPopoverVO1);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setTexts(param1:VacationPopoverVO):void {
        var _loc2_:String = "as_setTexts" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }

    protected function setData(param1:VacationPopoverVO):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
